unit directinputhook;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Windows,DynLibs, DirectInput, DInput8Proxy,{DDetours,}logstuff;

type
  TDInput8_DLL = record
    dll: HModule;
    DirectInput8Create: pointer;
    DllCanUnloadNow: pointer;
    DllGetClassObject: pointer;
    DllRegisterServer: pointer;
    DllUnregisterServer: pointer;
  end;
var
     OriginalDI: HModule;
     DInput8: TDInput8_DLL;
    // fptr : Function(hinst: THandle; dwVersion: DWORD; const riiltf: TGUID; out ppvOut{: Pointer}; punkOuter: IUnknown): HResult; stdcall; = nil;

function Initialize(): Boolean;
function DeInitialize(): Boolean;
Function DirectInput8Create(hinst: THandle; dwVersion: DWORD; const riidltf: TGUID; out ppvOut{: Pointer}; punkOuter: IUnknown): HResult; stdcall;
procedure DllCanUnloadNow;stdcall;
procedure DllGetClassObject;stdcall;
procedure DllRegisterServer;stdcall;
procedure DllUnRegisterServer;stdcall;

implementation
 uses DI_Utils;
function ArrayToString(const a: array of Char): string;
begin
  if Length(a)>0 then
    SetString(Result, PChar(@a[0]), Length(a))
  else
    Result := '';
end;

Function Initialize(): Boolean;
var
  Root: Array of Char;
  //Attributes: Integer;
begin
  //Attributes := 0;
  SetLength(Root, MAX_PATH);
  GetSystemDirectoryA(@Root[0], MAX_PATH);
  StrCat(@Root[0], '\dinput8.dll');
  Log('info',format('Root = %s',[ArrayToString(Root)]));
  OriginalDI := LoadLibraryA(@Root[0]);
  DisableThreadLibraryCalls( OriginalDI );
  Log('info','dinput8.dll loaded');
  if (OriginalDI <> NilHandle) then
  begin
    Log('info','OriginalDI <> NilHandle');
    dinput8.DirectInput8Create := GetProcAddress(OriginalDI, 'DirectInput8Create');
    dinput8.DllCanUnloadNow := GetProcAddress(OriginalDI, 'DllCanUnloadNow');
    dinput8.DllGetClassObject := GetProcAddress(OriginalDI, 'DllGetClassObject');
    dinput8.DllRegisterServer := GetProcAddress(OriginalDI, 'DllRegisterServer');
    dinput8.DllUnRegisterServer := GetProcAddress(OriginalDI, 'DllUnregisterServer');
    Log('info','Before console stuff');
    Log('info','dinput8.dll succesfully loaded');
  end else
    begin
      Log('info','dinput8.dll error loading...');
      Result := False;
    end;
  Result := True;
end;

Function DeInitialize(): Boolean;
begin
  if (OriginalDi <> NilHandle) then
  begin
    FreeLibrary(OriginalDi);
    OriginalDi := NilHandle;
    Result := True;
  end else
    Result := False;
end;

Function DirectInput8Create(hinst: THandle; dwVersion: DWORD; const riidltf: TGUID; out ppvOut{: Pointer}; punkOuter: IUnknown): HResult; stdcall;
type
  fptr = Function(hinst: THandle; dwVersion: DWORD; const riiltf: TGUID; out ppvOut{: Pointer}; punkOuter: IUnknown): HResult; stdcall;
  PPointer = ^Pointer;
var
  res: Hresult;
  F: fptr;
begin
  f:= fptr(dinput8.DirectInput8Create);
  res := f(hinst,dwVersion,riidltf,ppvout,punkOuter);
  if res = S_OK then
   IDirectInput8(ppvOut) := IDirectInput8(TDirectInput8Proxy.Create(IDirectInput8(ppvOut)))
  else
   PPointer(ppvOut)^ := nil;
  result:=res;
end;

procedure DllCanUnloadNow;stdcall;Assembler; NoStackFrame;
  {$ASMMODE INTEL}
asm
  jmp [dinput8.DllCanUnloadNow]
end;

procedure DllGetClassObject;stdcall;Assembler; NoStackFrame;
  {$ASMMODE INTEL}
asm
  jmp [dinput8.DllGetClassObject]
end;
procedure DllRegisterServer;stdcall;Assembler; NoStackFrame;
  {$ASMMODE INTEL}
asm
  jmp [dinput8.DllRegisterServer]
end;
procedure DllUnRegisterServer;stdcall;Assembler; NoStackFrame;
  {$ASMMODE INTEL}
asm
  jmp [dinput8.DllUnRegisterServer]
end;
end.

