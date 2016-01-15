unit logstuff;

{$mode objfpc}{$H+}

interface

uses Windows, SysUtils, Classes, DateUtils;

type

  TLogItem = class
  private
    FSection: string;
    FDateTime: TDateTime;
    FText: string;
  public
    constructor Create(const aSection, aText: string);
    destructor Destroy; override;

    property DateTime: TDateTime read FDateTime write FDateTime;
    property Section: string read FSection write FSection;
    property Text: string read FText write FText;
  end;

  TLogCharset = (lcAnsi, lcUnicode, lcUTF8);

  TLog = class(TThread)
  private
    FItems: TList;
    FCritical: TRTLCriticalSection;
    FFileName: string;
    FWriteTime: Boolean;
    FCharset: TLogCharset;
    procedure Lock;
    procedure UnLock;
  protected
    procedure Execute; override;
  public
    constructor Create(const aFileName: AnsiString = '');
    destructor Destroy; override;
    procedure Flush;
    procedure Add(const Section, Text: string); overload;
    procedure Add(const Text: string); overload;

    property FileName: string read FFileName;
    property WriteTime: Boolean read FWriteTime write FWriteTime;
    property Charset: TLogCharset read FCharset write FCharset;
  end;

var

  Logger: TLog = nil;

procedure Log(const Section, Text: string); overload;
procedure Log(const Text: string); overload;

implementation

procedure Log(const Section, Text: string);
begin
  if Logger <> nil then
    Logger.Add(Section, Text);
end;

procedure Log(const Text: string);
begin
  if Logger <> nil then
    Logger.Add(Text);
end;

{ TLogItem }

constructor TLogItem.Create(const aSection, aText: string);
begin
  DateTime := Now;
  Section := aSection;
  Text := aText;
end;

destructor TLogItem.Destroy;
begin

  inherited;
end;

{ TLog }

constructor TLog.Create(const aFileName: AnsiString);
begin
  FreeOnTerminate := False;
  if aFileName = '' then
    FFileName := ExtractFilePath(ParamStr(0)) + 'Log.log'
  else
    FFileName := aFileName;
  WriteTime := True;
  Charset := lcUTF8;
  InitializeCriticalSection(FCritical);
  FItems := TList.Create;

  inherited Create(False);
end;

destructor TLog.Destroy;
begin
  Terminate;
  WaitFor;
  Flush;
  FItems.Free;
  DeleteCriticalSection(FCritical);
  inherited;
end;

procedure TLog.Add(const Section, Text: string);
var
  Li: TLogItem;
begin
  Lock;
  try
  Li := TLogItem.Create(Section, Text);
  FItems.Add(Li);
  finally
    UnLock;
  end;
end;

procedure TLog.Add(const Text: string);
begin
  Add('', Text);
end;

procedure TLog.Execute;
var
  I: Integer;
begin
  repeat
    Flush;

    for I := 1 to 20 do
      if not Terminated then
        Sleep(100);
  until Terminated;
end;

procedure TLog.Flush;
var
  Stm: TFileStream;
  Str: string;
  S: AnsiString;
  Ws: WideString;
  I, BufSize: Integer;
  Li: TLogItem;
  Buf: Pointer;
begin
  Stm := nil;
  try
    if FItems.Count = 0 then Exit;

    try
      Stm := TFileStream.Create(FileName, fmOpenReadWrite or fmShareDenyNone);
    except
      Stm := TFileStream.Create(FileName, fmCreate or fmShareDenyNone);
    end;
    Stm.Position := Stm.Size;

    for I := 0 to FITems.Count - 1 do
    begin
      Li := TLogItem(FITems[I]);
      if WriteTime then
        Str := FormatDateTime('[yyy-mm-dd hh:nn:ss.zzz] ', Li.DateTime)
      else
        Str := '';

      if Length(Li.Section) > 0 then
        Str := Str + '(' + Li.Section + ') ';

      Str := Str + Li.Text + #13#10;

      case Charset of
        lcAnsi:
          begin
            BufSize := Length(Str);
            if SizeOf(Char) = 1 then
              Buf := @Str[1]
            else
            begin
              S := Str;
              Buf := @S[1];
            end;
          end;
        lcUnicode:
          begin
            BufSize := Length(Str) * 2;
            if SizeOf(Char) = 2 then
              Buf := @Str[1]
            else
            begin
              Ws := Str;
              Buf := @Ws[1];
            end;
          end;
        lcUTF8:
          begin
            S := UTF8Encode(Str);
            Buf := @S[1];
            BufSize := Length(S);
          end;
      end;

      if BufSize > 0 then
        Stm.Write(Buf^, BufSize);
    end;
  finally
    for I := 0 to FITems.Count - 1 do
      TLogItem(FITems[i]).Free;
    FItems.Clear;
    if Stm <> nil then
      Stm.Free;
  end;
end;

procedure TLog.Lock;
begin
  EnterCriticalSection(FCritical);
end;

procedure TLog.UnLock;
begin
  LeaveCriticalSection(FCritical);
end;

initialization

  Logger := TLog.Create;

finalization

  if Logger <> nil then
    FreeAndNil(Logger);

end.

