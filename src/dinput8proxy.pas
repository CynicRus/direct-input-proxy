unit dinput8proxy;

{$mode objfpc}{$H+}
{$define dbg}
interface

uses
  Classes, SysUtils, Windows, DirectInput,DInputDevice8Proxy{$ifdef dbg}, logstuff{$endif};
type

  { TDirectInput8Proxy }

  TDirectInput8Proxy= class (TInterfacedObject,IDirectInput8)
  private
    ptrInput: IDirectInput8;
   public
      constructor Create(Input: IDirectInput8);
      function QueryInterface(constref riid: TGuid; out ppvObj): HResult; stdcall;
      function _AddRef: LongInt; stdcall;
      function _Release: LongInt; stdcall;
      function CreateDevice(const rguid: TGUID; out lplpDirectInputDevice: IDirectInputDevice8; pUnkOuter: IUnknown): HResult; stdcall;
      function EnumDevices(dwDevType: DWORD; lpCallback: TDIEnumDevicesCallback; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
      function GetDeviceStatus(const rguidInstance: TGUID): HResult; stdcall;
      function RunControlPanel(hwndOwner: HWND; dwFlags: DWORD): HResult; stdcall;
      function Initialize(hinst: THandle; dwVersion: DWORD): HResult; stdcall;
      function FindDevice(const rguidClass: TGUID; ptszName: PAnsiChar; out pguidInstance: TGUID): HResult; stdcall;
      function EnumDevicesBySemantics(ptszUserName: PAnsiChar; const lpdiActionFormat: TDIActionFormat; lpCallback: TDIEnumDevicesBySemanticsCallback; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
      function ConfigureDevices(lpdiCallback: TDIConfigureDevicesCallback; const lpdiCDParams: TDIConfigureDevicesParamsA; dwFlags: DWORD; pvRefData: Pointer): HResult; stdcall;
   end;
implementation

{ TDirectInput8Proxy }

constructor TDirectInput8Proxy.Create(Input: IDirectInput8);
begin
  Log('info','TDirectInput8Proxy.BeforeCreate');
  self.ptrInput := IDirectInput8(Input);
  Log('info','TDirectInput8Proxy.AfterCreate');
end;

function TDirectInput8Proxy.QueryInterface(constref riid: TGuid; out ppvObj
  ): HResult; stdcall;
type
  PPointer = ^Pointer;
begin
  result := ptrInput.QueryInterface(riid, ppvObj);
  if (Result = S_OK) then
    PPointer(ppvObj)^ := @self
  else
    PPointer(ppvObj)^ := nil;
end;

function TDirectInput8Proxy._AddRef: LongInt; stdcall;
begin
  result := ptrInput._AddRef;
end;

function TDirectInput8Proxy._Release: LongInt; stdcall;
begin
  result := ptrInput._Release;
end;

function TDirectInput8Proxy.CreateDevice(const rguid: TGUID; out
  lplpDirectInputDevice: IDirectInputDevice8; pUnkOuter: IUnknown): HResult;
  stdcall;
begin
  {$ifdef dbg}
   if IsEqualGUID(rguid,GUID_SysMouse) then
    Log('info','hooked mouse!') else
   if IsEqualGUID(rguid,GUID_SysKeyboard) then
    Log('info','hooked keyboard!') else
   if IsEqualGUID(rguid,GUID_Joystick) then
    Log('info','hooked joystick!') else
    Log('info','unknown guid :' + GUIDToString(rguid));
  {$endif}
  result:=IDirectInput8(ptrInput).CreateDevice(rguid,lplpDirectInputDevice,pUnkOuter);
  if (Result = S_OK) then
  begin
    lplpDirectInputDevice := IDirectInputDevice8(TDirectInput8DeviceProxy.Create(lplpDirectInputDevice));
  end else
    lplpDirectInputDevice:= nil;
end;

function TDirectInput8Proxy.EnumDevices(dwDevType: DWORD;
  lpCallback: TDIEnumDevicesCallback; pvRef: Pointer; dwFlags: DWORD): HResult;
  stdcall;
begin
  result := ptrInput.EnumDevices(dwDevType,lpCallback,pvRef,dwFlags);
end;

function TDirectInput8Proxy.GetDeviceStatus(const rguidInstance: TGUID): HResult;
  stdcall;
begin
  result := ptrInput.GetDeviceStatus(rguidInstance);
end;

function TDirectInput8Proxy.RunControlPanel(hwndOwner: HWND; dwFlags: DWORD
  ): HResult; stdcall;
begin
  result := ptrInput.RunControlPanel(hwndOwner,dwFlags);
end;

function TDirectInput8Proxy.Initialize(hinst: THandle; dwVersion: DWORD): HResult;
  stdcall;
begin
  result := ptrInput.Initialize(hinst,dwVersion);
end;

function TDirectInput8Proxy.FindDevice(const rguidClass: TGUID; ptszName: PAnsiChar;
  out pguidInstance: TGUID): HResult; stdcall;
begin
  result := ptrInput.FindDevice(rguidClass,ptszName,pguidInstance);
end;

function TDirectInput8Proxy.EnumDevicesBySemantics(ptszUserName: PAnsiChar;
  const lpdiActionFormat: TDIActionFormat;
  lpCallback: TDIEnumDevicesBySemanticsCallback; pvRef: Pointer; dwFlags: DWORD
  ): HResult; stdcall;
begin
  result := ptrInput.EnumDevicesBySemantics(ptszUserName,lpdiActionFormat,lpCallback,pvRef,dwFlags);
end;

function TDirectInput8Proxy.ConfigureDevices(
  lpdiCallback: TDIConfigureDevicesCallback;
  const lpdiCDParams: TDIConfigureDevicesParamsA; dwFlags: DWORD;
  pvRefData: Pointer): HResult; stdcall;
begin
  result := ptrInput.ConfigureDevices(lpdiCallback,lpdiCDParams,dwFlags,pvRefData);
end;

end.

