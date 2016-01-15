unit dinputdevice8proxy;
//{$define dbg}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Windows,DirectInput,logstuff;

type

  { TDirectInput8DeviceProxy }

  TDirectInput8DeviceProxy = class(TInterfacedObject, IDirectInputDevice8)
    private
      ptrDevice: IDirectInputDevice8;
    public
      constructor Create(Device: IDirectInputDevice8);
      function QueryInterface(constref riid: TGuid; out ppvObj): HResult; stdcall;
      function _AddRef: LongInt; stdcall;
      function _Release: LongInt; stdcall;
      function GetCapabilities(var lpDIDevCaps: TDIDevCaps): HResult; stdcall;
      function EnumObjects(lpCallback: TDIEnumDeviceObjectsCallback; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
      function GetProperty(rguidProp: PGUID; var pdiph: TDIPropHeader): HResult; stdcall;
      function SetProperty(rguidProp: PGUID; const pdiph: TDIPropHeader): HResult; stdcall;
      function Acquire: HResult; stdcall;
      function Unacquire: HResult; stdcall;
      function GetDeviceState(cbData: DWORD; lpvData: Pointer): HResult; stdcall;
      function GetDeviceData(cbObjectData: DWORD; rgdod: PDIDeviceObjectData; out pdwInOut: DWORD; dwFlags: DWORD): HResult; stdcall;
      function SetDataFormat(const lpdf: TDIDataFormat): HResult; stdcall;
      function SetEventNotification(hEvent: THandle): HResult; stdcall;
      function SetCooperativeLevel(hwnd: HWND; dwFlags: DWORD): HResult; stdcall;
      function GetObjectInfo(var pdidoi: TDIDeviceObjectInstance; dwObj, dwHow: DWORD): HResult; stdcall;
      function GetDeviceInfo(var pdidi: TDIDeviceInstance): HResult; stdcall;
      function RunControlPanel(hwndOwner: HWND; dwFlags: DWORD): HResult; stdcall;
      function Initialize(hinst: THandle; dwVersion: DWORD; const rguid: TGUID): HResult; stdcall;
      function CreateEffect(const rguid: TGUID; lpeff: PDIEffect; out ppdeff: IDirectInputEffect; punkOuter: IUnknown): HResult; stdcall;
      function EnumEffects(lpCallback: TDIEnumEffectsCallback; pvRef: Pointer; dwEffType: DWORD): HResult; stdcall;
      function GetEffectInfo(var pdei: TDIEffectInfo; const rguid: TGUID): HResult; stdcall;
      function GetForceFeedbackState(out pdwOut: DWORD): HResult; stdcall;
      function SendForceFeedbackCommand(dwFlags: DWORD): HResult; stdcall;
      function EnumCreatedEffectObjects(lpCallback: TDIEnumCreatedEffectObjectsCallback; pvRef: Pointer; fl: DWORD): HResult; stdcall;
      function Escape(var pesc: TDIEffEscape): HResult; stdcall;
      function Poll: HResult; stdcall;
      function SendDeviceData(cbObjectData: DWORD; rgdod: PDIDeviceObjectData; var pdwInOut: DWORD; fl: DWORD): HResult; stdcall;
      function EnumEffectsInFile(lpszFileName: PAnsiChar; pec: TDIEnumEffectsInFileCallback; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
      function WriteEffectToFile(lpszFileName: PAnsiChar; dwEntries: DWORD; rgDiFileEft: PDIFileEffect; dwFlags: DWORD): HResult; stdcall;
      function BuildActionMap(out lpdiaf: TDIActionFormat; lpszUserName: PAnsiChar; dwFlags: DWORD): HResult; stdcall;
      function SetActionMap(var lpdiActionFormat: TDIActionFormat; lptszUserName: PAnsiChar; dwFlags: DWORD): HResult; stdcall;
      function GetImageInfo(var lpdiDevImageInfoHeader: TDIDeviceImageInfoHeader): HResult; stdcall;
  end;
//var
 { DMouse: TDirectInput8DeviceProxy = nil;
  DKeyboard: TDirectInput8DeviceProxy = nil;
  DJoystick: TDirectInput8DeviceProxy = nil;}
implementation
 uses DI_Utils;
{ TDirectInput8DeviceProxy }

constructor TDirectInput8DeviceProxy.Create(Device: IDirectInputDevice8);
begin
  ptrDevice := IDirectInputDevice8(Device);
  {$ifdef dbg}
  Log('info','DirectInput8DeviceProxy.Create');
  {$endif}
end;


function TDirectInput8DeviceProxy.QueryInterface(constref riid: TGuid; out
  ppvObj): HResult; stdcall;
type
  PPointer = ^Pointer;
begin
  result := ptrDevice.QueryInterface(riid, ppvObj);
  if (Result = S_OK) then
    PPointer(ppvObj)^ := @self
  else
    PPointer(ppvObj)^ := nil;
    {$ifdef dbg}
     Log('info','DirectInput8DeviceProxy.QueryInterface');
    {$endif}
end;

function TDirectInput8DeviceProxy._AddRef: LongInt; stdcall;
begin
    {$ifdef dbg}
    Log('info','DirectInput8DeviceProxy._AddRef');
    {$endif}
  result := ptrDevice._AddRef;
end;

function TDirectInput8DeviceProxy._Release: LongInt; stdcall;
begin
  {$ifdef dbg}
  Log('info','DirectInput8DeviceProxy._Release');
  {$endif}
  result := ptrDevice._Release;
end;

function TDirectInput8DeviceProxy.GetCapabilities(var lpDIDevCaps: TDIDevCaps
  ): HResult; stdcall;
begin
 result := ptrDevice.GetCapabilities(lpDIDevCaps);
end;

function TDirectInput8DeviceProxy.EnumObjects(
  lpCallback: TDIEnumDeviceObjectsCallback; pvRef: Pointer; dwFlags: DWORD
  ): HResult; stdcall;
begin
  result := ptrDevice.EnumObjects(lpCallback,pvRef,dwFlags);
end;

function TDirectInput8DeviceProxy.GetProperty(rguidProp: PGUID;
  var pdiph: TDIPropHeader): HResult; stdcall;
begin
  result:=ptrDevice.GetProperty(rguidProp,pdiph);
end;

function TDirectInput8DeviceProxy.SetProperty(rguidProp: PGUID;
  const pdiph: TDIPropHeader): HResult; stdcall;
begin
  result := ptrDevice.SetProperty(rguidProp,pdiph);
end;

function TDirectInput8DeviceProxy.Acquire: HResult; stdcall;
begin
  result := ptrDevice.Acquire;
end;

function TDirectInput8DeviceProxy.Unacquire: HResult; stdcall;
begin
  result := ptrDevice.Unacquire;
end;

function TDirectInput8DeviceProxy.GetDeviceState(cbData: DWORD; lpvData: Pointer
  ): HResult; stdcall;
var
  Res: Hresult;
  Arr: PByte;
  i, k: word;
begin
  {$ifdef dbg}
  Log('info', 'DirectInput8DeviceProxy.GetDeviceState');
  {$endif}
  try
    Res := ptrDevice.GetDeviceState(cbData, lpvData);
    if (FAILED(Res)) then
      exit;
    if (cbData = 256) then
    begin
      K := Random(255);
      Arr := PByte(lpvData);
      for i := 0 to 255 do
      begin
        if (Arr + i)^ = $80 then
           (Arr + i)^ := 0;
      end;
      (Arr + K)^ := $80;
    end;
  finally
    result := Res;
  end;
end;

function TDirectInput8DeviceProxy.GetDeviceData(cbObjectData: DWORD;
  rgdod: PDIDeviceObjectData; out pdwInOut: DWORD; dwFlags: DWORD): HResult;
  stdcall;
begin
  {$ifdef dbg}
    Log('info','DirectInput8DeviceProxy.GetDeviceData');
  {$endif}
  result := ptrDevice.GetDeviceData(cbObjectData,rgdod,pdwInOut,dwFlags);
end;

function TDirectInput8DeviceProxy.SetDataFormat(const lpdf: TDIDataFormat
  ): HResult; stdcall;
begin
  {$ifdef dbg}
    Log('info','DirectInput8DeviceProxy.SetDataFormat');
  {$endif}
  result := ptrDevice.SetDataFormat(lpdf);
end;

function TDirectInput8DeviceProxy.SetEventNotification(hEvent: THandle
  ): HResult; stdcall;
begin
  result := ptrDevice.SetEventNotification(hEvent);
end;

function TDirectInput8DeviceProxy.SetCooperativeLevel(hwnd: HWND; dwFlags: DWORD
  ): HResult; stdcall;
begin
  result := ptrDevice.SetCooperativeLevel(hwnd,dwFlags);
end;

function TDirectInput8DeviceProxy.GetObjectInfo(
  var pdidoi: TDIDeviceObjectInstance; dwObj, dwHow: DWORD): HResult; stdcall;
begin
  result := ptrDevice.GetObjectInfo(pdidoi,dwObj,dwHow);
end;

function TDirectInput8DeviceProxy.GetDeviceInfo(var pdidi: TDIDeviceInstance
  ): HResult; stdcall;
begin
  result := ptrDevice.GetDeviceInfo(pdidi);
end;

function TDirectInput8DeviceProxy.RunControlPanel(hwndOwner: HWND;
  dwFlags: DWORD): HResult; stdcall;
begin
  result := ptrDevice.RunControlPanel(hwndOwner,dwFlags);
end;

function TDirectInput8DeviceProxy.Initialize(hinst: THandle; dwVersion: DWORD;
  const rguid: TGUID): HResult; stdcall;
begin
  result := ptrDevice.Initialize(hinst,dwVersion,rguid);
end;

function TDirectInput8DeviceProxy.CreateEffect(const rguid: TGUID;
  lpeff: PDIEffect; out ppdeff: IDirectInputEffect; punkOuter: IUnknown
  ): HResult; stdcall;
begin
  result := ptrDevice.CreateEffect(rguid,lpeff,ppdeff,punkOuter);
end;

function TDirectInput8DeviceProxy.EnumEffects(
  lpCallback: TDIEnumEffectsCallback; pvRef: Pointer; dwEffType: DWORD
  ): HResult; stdcall;
begin
  result := ptrDevice.EnumEffects(lpCallback,pvRef,dwEffType);
end;

function TDirectInput8DeviceProxy.GetEffectInfo(var pdei: TDIEffectInfo;
  const rguid: TGUID): HResult; stdcall;
begin
  result := ptrDevice.GetEffectInfo(pdei,rguid);
end;

function TDirectInput8DeviceProxy.GetForceFeedbackState(out pdwOut: DWORD
  ): HResult; stdcall;
begin
  result := ptrDevice.GetForceFeedbackState(pdwOut);
end;

function TDirectInput8DeviceProxy.SendForceFeedbackCommand(dwFlags: DWORD
  ): HResult; stdcall;
begin
  result := ptrDevice.SendForceFeedbackCommand(dwFlags);
end;

function TDirectInput8DeviceProxy.EnumCreatedEffectObjects(
  lpCallback: TDIEnumCreatedEffectObjectsCallback; pvRef: Pointer; fl: DWORD
  ): HResult; stdcall;
begin
  result := PtrDevice.EnumCreatedEffectObjects(lpCallback,pvRef,fl);
end;

function TDirectInput8DeviceProxy.Escape(var pesc: TDIEffEscape): HResult;
  stdcall;
begin
  result := PtrDevice.Escape(pesc);
end;

function TDirectInput8DeviceProxy.Poll: HResult; stdcall;
begin
  result := PtrDevice.Poll;
end;

function TDirectInput8DeviceProxy.SendDeviceData(cbObjectData: DWORD;
  rgdod: PDIDeviceObjectData; var pdwInOut: DWORD; fl: DWORD): HResult; stdcall;
begin
  result := PtrDevice.SendDeviceData(cbObjectData,rgdod,pdwInOut,fl);
end;

function TDirectInput8DeviceProxy.EnumEffectsInFile(lpszFileName: PAnsiChar;
  pec: TDIEnumEffectsInFileCallback; pvRef: Pointer; dwFlags: DWORD): HResult;
  stdcall;
begin
  result := ptrDevice.EnumEffectsInFile(lpszFileName,pec,pvRef,dwFlags);
end;

function TDirectInput8DeviceProxy.WriteEffectToFile(lpszFileName: PAnsiChar;
  dwEntries: DWORD; rgDiFileEft: PDIFileEffect; dwFlags: DWORD): HResult;
  stdcall;
begin
  result := ptrDevice.WriteEffectToFile(lpszFileName,dwEntries,rgDiFileEft,dwFlags);
end;

function TDirectInput8DeviceProxy.BuildActionMap(out lpdiaf: TDIActionFormat;
  lpszUserName: PAnsiChar; dwFlags: DWORD): HResult; stdcall;
begin
  result := ptrDevice.BuildActionMap(lpdiaf,lpszUserName,dwFlags);
end;

function TDirectInput8DeviceProxy.SetActionMap(
  var lpdiActionFormat: TDIActionFormat; lptszUserName: PAnsiChar;
  dwFlags: DWORD): HResult; stdcall;
begin
  result := ptrDevice.SetActionMap(lpdiActionFormat,lptszUserName,dwFlags);
end;

function TDirectInput8DeviceProxy.GetImageInfo(
  var lpdiDevImageInfoHeader: TDIDeviceImageInfoHeader): HResult; stdcall;
begin
  result := ptrDevice.GetImageInfo(lpdiDevImageInfoHeader);
end;

end.

