unit uiostuff;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Windows;
type
TInputType = (itUndefined = -1,itKeyboard = 0,itMouse = 1, itJoystick = 2);
TIOItem = class
  private
  FIsDown: boolean;
  FKey: Byte;//contain VK_ key code
  FStartTime: Integer;
  FTTL: integer;
  FIOType: TInputType;
  procedure Clear;
  procedure SetFKey(AValue: byte);
  procedure SetIOType(AValue: TInputType);
  procedure SetIsDown(AValue: boolean);
  procedure SetStartTime(AValue: integer);
  procedure SetTTL(AValue: integer);
  public
  Constructor Create;
  property IsDown: boolean read FIsDown write SetIsDown;
  property Key: byte read FKey write SetFKey;
  property StartTime: integer read FStartTime write SetStartTime;
  property TTL: integer read FTTL write SetTTL;
  property IOType: TInputType read FIOType write SetIOType;
  procedure Save(const Writer: TWriter);
  procedure Load(const Reader: TReader);
end;

{ TIOItemList }

TIOItemList = class
private
  FIOItems: TList;
  function GetCount: Integer;
  function GeTIOItem(Index: Integer): TIOItem;
  function IndexOf(aItem: TIOItem): Integer;overload;
  function IndexOf(aKey: byte): integer;overload;
  procedure SaveToStream(Stream: TStream);
  procedure LoadFromStream(Stream: TStream);
public
  constructor Create;
  destructor Destroy; override;
  procedure Clear;
  procedure Add(aIOItem: TIOItem);
  procedure Assign(Src: TIOItemList);
  procedure Delete(Index: Integer); overload;
  procedure Delete(aItem: TIOItem); overload;
  function ItemByVKey(aKey: Byte): TIOItem;
  property Count: Integer read GetCount;
  property IOItem[Index: Integer]: TIOItem read GeTIOItem; default;
end;

{ TIOManager }

TIOManager = class(TIOItemList)
  public
    procedure KeyDown(const KeyCode: byte; const PressedTime: integer);overload;
    procedure KeyDown(const KeyCode: Byte);overload;
    procedure KeyUp(const KeyCode: byte);
    procedure MouseClick(const MouseButton: integer);
    procedure MouseDown(const MouseButton: integer; const PressedTime: integer);
    procedure MouseUp(const MouseButton: integer);
    procedure SetMousePos(const x,y: integer);overload;
    procedure SetMousePos(const x,y,z: integer);overload;

    function FilterKeys(const FilterType: TInputType;OnlyPressed:boolean = true): TIOItemList;
end;


const
  ErrItemNotFound = 'Item not found!';
implementation

{ TIOManager }

procedure TIOManager.KeyDown(const KeyCode: byte; const PressedTime: integer);
var
  Item: TIOItem;
begin
  Item := nil;
  try
  Item := ItemByVKey(KeyCode);
  if Item <> nil then
    begin
      Item.IsDown:= true;
      Item.TTL:=PressedTime;
    end else
    begin
     Item := TIOItem.Create;
     Item.Key:=KeyCode;
     Item.TTL:=PressedTime;
     Item.IsDown:=True;
     Item.IOType:=itKeyboard;
     Add(Item);
    end;
  except
    On E: Exception do
     raise;
  end;
end;

procedure TIOManager.KeyDown(const KeyCode: Byte);
begin
 KeyDown(KeyCode,-1);
end;

procedure TIOManager.KeyUp(const KeyCode: byte);
var
  Item: TIOItem;
begin
  Item := nil;
  try
  Item := ItemByVKey(KeyCode);
  if Item <> nil then
      Item.IsDown:= false;
   except
    On E: Exception do
     raise;
  end;
end;

procedure TIOManager.MouseClick(const MouseButton: integer);
begin

end;

procedure TIOManager.MouseDown(const MouseButton: integer;
  const PressedTime: integer);
begin

end;

procedure TIOManager.MouseUp(const MouseButton: integer);
begin

end;

procedure TIOManager.SetMousePos(const x, y: integer);
begin

end;

procedure TIOManager.SetMousePos(const x, y, z: integer);
begin

end;

function TIOManager.FilterKeys(const FilterType: TInputType;
  OnlyPressed: boolean): TIOItemList;
var
  List: TIOItemList;
  Item: TIOItem;
  i: integer;
begin
 List:= TIOItemList.Create;
 try
  for i:=0 to FIOItems.Count - 1 do
    begin
      Item := IOItem[i];
      if Item.IOType = FilterType then
        begin
          if not OnlyPressed then
            Add(Item)
          else
            if Item.IsDown = OnlyPressed then
              Add(Item);
        end;
    end;
 finally
   result:=List;
 end;
end;

{ TIOItem }

procedure TIOItem.Clear;
begin
  Key:=0;
  IsDown:=False;
  StartTime:=GetTickCount();
  TTL:=-1;
  IOType:= itUndefined;
end;

procedure TIOItem.SetFKey(AValue: byte);
begin
  if FKey=AValue then Exit;
   FKey:=AValue;
end;

procedure TIOItem.SetIOType(AValue: TInputType);
begin
  if FIOType=AValue then Exit;
  FIOType:=AValue;
end;

procedure TIOItem.SetIsDown(AValue: boolean);
begin
  if FIsDown=AValue then Exit;
  FIsDown:=AValue;
end;

procedure TIOItem.SetStartTime(AValue: integer);
begin
  if FStartTime=AValue then Exit;
  FStartTime:=AValue;
end;

procedure TIOItem.SetTTL(AValue: integer);
begin
  if FTTL=AValue then Exit;
  FTTL:=AValue;
end;

constructor TIOItem.Create;
begin
  Clear;
end;

procedure TIOItem.Save(const Writer: TWriter);
begin
   writer.WriteChar(Char(key));
   writer.WriteBoolean(IsDown);
   writer.WriteInteger(starttime);
   writer.WriteInteger(TTL);
   writer.WriteInteger(Integer(IOType));
end;

procedure TIOItem.Load(const Reader: TReader);
begin
  Key := Byte(reader.ReadChar);
  IsDown := reader.ReadBoolean;
  StartTime := reader.ReadInteger;
  TTL := reader.ReadInteger;
  IOType := TInputType(reader.ReadInteger);
end;
{ TIOItemList }

constructor TIOItemList.Create;
begin
  FIOItems := TList.Create;
end;

procedure TIOItemList.Delete(Index: Integer);
begin
  if (Index < 0) or (Index >= Count) then
    raise Exception.Create(ErrItemNotFound);

  TIOItem(FIOItems[Index]).Free;
  FIOItems.Delete(Index);
end;

procedure TIOItemList.Delete(aItem: TIOItem);
begin
  Delete(IndexOf(aItem));
end;

function TIOItemList.ItemByVKey(aKey: Byte): TIOItem;
begin
  result := IOItem[IndexOf(aKey)];
end;

procedure TIOItemList.SaveToStream(Stream: TStream);
var
  writer: TWriter;
  I: Integer;
begin
  writer := TWriter.Create(Stream, 4096);
  try
    writer.WriteListBegin;
    for i := 0 to FIOItems.count - 1 do
      TIOItem(FIOItems[i]).Save(writer);
    writer.WriteListEnd;
  finally
    writer.free
  end;
end;

procedure TIOItemList.LoadFromStream(Stream: TStream);
var
  reader: TReader;
  obj: TIOItem;
begin
  reader := TReader.Create(Stream, 4096);
  try
    reader.ReadListBegin;
    while not reader.EndOfList do
    begin
      obj := TIOItem.Create;
      try
        obj.Load(reader);
        Add(obj);
      except
        obj.Free;
        raise
      end;
    end;
    reader.ReadListEnd;
  finally
    reader.free
  end;
end;

destructor TIOItemList.Destroy;
begin
  Clear;
  FIOItems.Free;
  inherited;
end;

procedure TIOItemList.Add(aIOItem: TIOItem);
begin
  FIOItems.Add(aIOItem)
end;

procedure TIOItemList.Assign(Src: TIOItemList);
var
  I: Integer;
begin
  Clear;
  for I := 0 to Src.Count - 1 do
    Add(Src[I]);
end;

procedure TIOItemList.Clear;
var
  I: Integer;
begin
  for I := 0 to FIOItems.Count - 1 do
    IOItem[I].Free;
  FIOItems.Clear;
end;



function TIOItemList.GetCount: Integer;
begin
  Result := FIOItems.Count;
end;

function TIOItemList.GeTIOItem(Index: Integer): TIOItem;
begin
  if (Index >= 0) and (Index < Count) then
    Result := TIOItem(FIOItems[Index])
  else
    Result := nil;
end;

function TIOItemList.IndexOf(aItem: TIOItem): Integer;
begin
 Result := FIOItems.IndexOf(aItem);
end;

function TIOItemList.IndexOf(aKey: byte): integer;
var
  I: Integer;
begin
 result := -1;
  for I := 0 to FIOItems.Count - 1 do
    begin
    if IOItem[I].Key = aKey then
      begin
        result:= i;
        break;
      end;
    end;
end;
end.

