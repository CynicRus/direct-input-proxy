library dinput8;

{$mode objfpc}{$H+}

uses
  Classes, Windows, dinput8proxy, logstuff, dinputdevice8proxy, directinputhook,
  uiostuff, di_utils;

procedure DllMain(Reason: PtrInt);
begin
  Case Reason Of
    DLL_PROCESS_ATTACH:
    begin
      Initialize();
      Exit;
    end;

    DLL_PROCESS_DETACH:
    begin
      DeInitialize();
      Exit;
    end;
  end;
end;

exports DirectInput8Create,DllCanUnloadNow,DllGetClassObject,DllRegisterServer,DllUnRegisterServer;
var
  called: boolean = false;
begin
  Dll_Process_Detach_Hook := @DllMain;
  if (not called) then
  begin
    DllMain(DLL_PROCESS_ATTACH);
    called := true;
  end;
end.

