unit di_utils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Windows, DirectInput;



function VirtualKeyCodesToDI(const VKey: word): word;
function DIToVirtualKeyCodes(const DIKey: word): word;
function VKeyToWord(const aVKey: string): word;
function VKeyToString(const VKey: word): string;
function DIKeyToString(const DIKey: word): string;

implementation
 uses StrUtils,LogStuff;
function VirtualKeyCodesToDI(const VKey: word): word;
begin
  result := -1;
  case VKey of
    VK_ESCAPE:
      result := DIK_Escape;
    VK_0:
      result := DIK_0;
    VK_1:
      result := DIK_1;
    VK_2:
      result := DIK_2;
    VK_3:
      result := DIK_3;
    VK_4:
      result := DIK_4;
    VK_5:
      result := DIK_5;
    VK_6:
      result := DIK_6;
    VK_7:
      result := DIK_7;
    VK_8:
      result := DIK_8;
    VK_9:
      result := DIK_9;
    VK_OEM_MINUS:
      result := DIK_Minus;
    VK_OEM_PLUS:
      result := DIK_Equals;
    VK_Back:
      result := DIK_Back;
    VK_Tab:
      result := DIK_TAB;
    VK_Return:
      result := DIK_Return;
    VK_A:
      result := DIK_A;
    VK_B:
      result := DIK_B;
    VK_C:
      result := DIK_C;
    VK_D:
      result := DIK_D;
    VK_E:
      result := DIK_E;
    VK_F:
      result := DIK_F;
    VK_G:
      result := DIK_G;
    VK_H:
      result := DIK_H;
    VK_I:
      result := DIK_I;
    VK_J:
      result := DIK_J;
    VK_K:
      result := DIK_K;
    VK_L:
      result := DIK_L;
    VK_M:
      result := DIK_M;
    VK_N:
      result := DIK_N;
    VK_O:
      result := DIK_O;
    VK_P:
      result := DIK_P;
    VK_Q:
      result := DIK_Q;
    VK_R:
      result := DIK_R;
    VK_S:
      result := DIK_S;
    VK_T:
      result := DIK_T;
    VK_U:
      result := DIK_U;
    VK_V:
      result := DIK_V;
    VK_W:
      result := DIK_W;
    VK_X:
      result := DIK_X;
    VK_Y:
      result := DIK_Y;
    VK_Z:
      result := DIK_Z;
    VK_NUMPAD0:
      result := DIK_NUMPAD0;
    VK_NUMPAD1:
      result := DIK_NUMPAD1;
    VK_NUMPAD2:
      result := DIK_NUMPAD2;
    VK_NUMPAD3:
      result := DIK_NUMPAD3;
    VK_NUMPAD4:
      result := DIK_NUMPAD4;
    VK_NUMPAD5:
      result := DIK_NUMPAD5;
    VK_NUMPAD6:
      result := DIK_NUMPAD6;
    VK_NUMPAD7:
      result := DIK_NUMPAD7;
    VK_NUMPAD8:
      result := DIK_NUMPAD8;
    VK_NUMPAD9:
      result := DIK_NUMPAD9;
    VK_NUMLOCK:
      result := DIK_NUMLOCK;
    VK_OEM_4:
      result := DIK_LBRACKET;
    VK_OEM_6:
      result := DIK_RBRACKET;
    VK_LCONTROL:
      result := DIK_LCONTROL;
    VK_RCONTROL:
      result := DIK_RCONTROL;
    VK_OEM_1:
      result := DIK_SEMICOLON;
    VK_OEM_7:
      result := DIK_APOSTROPHE;
    VK_OEM_3:
      result := DIK_GRAVE;
    VK_F1:
      result := DIK_F1;
    VK_F2:
      result := DIK_F2;
    VK_F3:
      result := DIK_F3;
    VK_F4:
      result := DIK_F4;
    VK_F5:
      result := DIK_F5;
    VK_F6:
      result := DIK_F6;
    VK_F7:
      result := DIK_F7;
    VK_F8:
      result := DIK_F8;
    VK_F9:
      result := DIK_F9;
    VK_F10:
      result := DIK_F10;
    VK_F11:
      result := DIK_F11;
    VK_F12:
      result := DIK_F12;
    VK_F13:
      result := DIK_F13;
    VK_F14:
      result := DIK_F14;
    VK_F15:
      result := DIK_F15;
    VK_LSHIFT:
      result := DIK_LSHIFT;
    VK_RSHIFT:
      result := DIK_RSHIFT;
    VK_OEM_5:
      result := DIK_BACKSLASH;
    VK_OEM_COMMA:
      result := DIK_COMMA;
    VK_OEM_PERIOD:
      result := DIK_PERIOD;
    VK_LMENU:
      result := DIK_LMENU;
    VK_RMENU:
      result := DIK_RMENU;
    VK_OEM_2:
      result := DIK_SLASH;
    VK_MULTIPLY:
      result := DIK_MULTIPLY;
    VK_SPACE:
      result := DIK_SPACE;
    VK_CAPITAL:
      result := DIK_CAPITAL;
    VK_SCROLL:
      result := DIK_SCROLL;
    VK_SUBTRACT:
      result := DIK_SUBTRACT;
    VK_ADD:
      result := DIK_ADD;
    VK_DECIMAL:
      result := DIK_DECIMAL;
    VK_MEDIA_NEXT_TRACK:
      result := DIK_NEXTTRACK;
    VK_MEDIA_PREV_TRACK:
      result := DIK_PREVTRACK;
    VK_VOLUME_MUTE:
      result := DIK_MUTE;
    VK_MEDIA_PLAY_PAUSE:
      result := DIK_PLAYPAUSE;
    VK_VOLUME_UP:
      result := DIK_VOLUMEUP;
    VK_VOLUME_DOWN:
      result := DIK_VOLUMEDOWN;
    VK_MEDIA_STOP:
      result := DIK_MEDIASTOP;
    VK_DIVIDE:
      result := DIK_DIVIDE;
    VK_PAUSE:
      result := DIK_PAUSE;
    VK_HOME:
      result := DIK_HOME;
    VK_UP:
      result := DIK_UP;
    VK_PRIOR:
      result := DIK_PRIOR;
    VK_LEFT:
      result := DIK_LEFT;
    VK_RIGHT:
      result := DIK_RIGHT;
    VK_END:
      result := DIK_END;
    VK_DOWN:
      result := DIK_DOWN;
    VK_NEXT:
      result := DIK_NEXT;
    VK_INSERT:
      result := DIK_INSERT;
    VK_DELETE:
      result := DIK_DELETE;
    VK_LWIN:
      result := DIK_LWIN;
    VK_RWIN:
      result := DIK_RWIN;
    VK_APPS:
      result := DIK_APPS;
    VK_SLEEP:
      result := DIK_SLEEP;
    VK_BROWSER_HOME:
      result := DIK_WEBHOME;
    VK_BROWSER_SEARCH:
      result := DIK_WEBSEARCH;
    VK_BROWSER_FAVORITES:
      result := DIK_WEBFAVORITES;
    VK_BROWSER_REFRESH:
      result := DIK_WEBREFRESH;
    VK_BROWSER_STOP:
      result := DIK_WEBSTOP;
    VK_BROWSER_FORWARD:
      result := DIK_WEBFORWARD;
    VK_BROWSER_BACK:
      result := DIK_WEBBACK;
  end;
end;

function DIToVirtualKeyCodes(const DIKey: word): word;
begin
  case DIKey of
    DIK_Escape:
      result := VK_ESCAPE;
    DIK_0:
      result := VK_0;
    DIK_1:
      result := VK_1;
    DIK_2:
      result := VK_2;
    DIK_3:
      result := VK_3;
    DIK_4:
      result := VK_4;
    DIK_5:
      result := VK_5;
    DIK_6:
      result := VK_6;
    DIK_7:
      result := VK_7;
    DIK_8:
      result := VK_8;
    DIK_9:
      result := VK_9;
    DIK_Minus:
      result := VK_OEM_MINUS;
    DIK_Equals:
      result := VK_OEM_PLUS;
    DIK_Back:
      result := VK_Back;
    DIK_TAB:
      result := VK_Tab;
    DIK_Return:
      result := VK_Return;
    DIK_A:
      result := VK_A;
    DIK_B:
      result := VK_B;
    DIK_C:
      result := VK_C;
    DIK_D:
      result := VK_D;
    DIK_E:
      result := VK_E;
    DIK_F:
      result := VK_F;
    DIK_G:
      result := VK_G;
    DIK_H:
      result := VK_H;
    DIK_I:
      result := VK_I;
    DIK_J:
      result := VK_J;
    DIK_K:
      result := VK_K;
    DIK_L:
      result := VK_L;
    DIK_M:
      result := VK_M;
    DIK_N:
      result := VK_N;
    DIK_O:
      result := VK_O;
    DIK_P:
      result := VK_P;
    DIK_Q:
      result := VK_Q;
    DIK_R:
      result := VK_R;
    DIK_S:
      result := VK_S;
    DIK_T:
      result := VK_T;
    DIK_U:
      result := VK_U;
    DIK_V:
      result := VK_V;
    DIK_W:
      result := VK_W;
    DIK_X:
      result := VK_X;
    DIK_Y:
      result := VK_Y;
    DIK_Z:
      result := VK_Z;
    DIK_NUMPAD0:
      result := VK_NUMPAD0;
    DIK_NUMPAD1:
      result := VK_NUMPAD1;
    DIK_NUMPAD2:
      result := VK_NUMPAD2;
    DIK_NUMPAD3:
      result := VK_NUMPAD3;
    DIK_NUMPAD4:
      result := VK_NUMPAD4;
    DIK_NUMPAD5:
      result := VK_NUMPAD5;
    DIK_NUMPAD6:
      result := VK_NUMPAD6;
    DIK_NUMPAD7:
      result := VK_NUMPAD7;
    DIK_NUMPAD8:
      result := VK_NUMPAD8;
    DIK_NUMPAD9:
      result := VK_NUMPAD9;
    DIK_NUMLOCK:
      result := VK_NUMLOCK;
    DIK_LBRACKET:
      result := VK_OEM_4;
    DIK_RBRACKET:
      result := VK_OEM_6;
    DIK_LCONTROL:
      result := VK_LCONTROL;
    DIK_RCONTROL:
      result := VK_RCONTROL;
    DIK_SEMICOLON:
      result := VK_OEM_1;
    DIK_APOSTROPHE:
      result := VK_OEM_7;
    DIK_GRAVE:
      result := VK_OEM_3;
    DIK_F1:
      result := VK_F1;
    DIK_F2:
      result := VK_F2;
    DIK_F3:
      result := VK_F3;
    DIK_F4:
      result := VK_F4;
    DIK_F5:
      result := VK_F5;
    DIK_F6:
      result := VK_F6;
    DIK_F7:
      result := VK_F7;
    DIK_F8:
      result := VK_F8;
    DIK_F9:
      result := VK_F9;
    DIK_F10:
      result := VK_F10;
    DIK_F11:
      result := VK_F11;
    DIK_F12:
      result := VK_F12;
    DIK_F13:
      result := VK_F13;
    DIK_F14:
      result := VK_F14;
    DIK_F15:
      result := VK_F15;
    DIK_LSHIFT:
      result := VK_LSHIFT;
    DIK_RSHIFT:
      result := VK_RSHIFT;
    DIK_BACKSLASH:
      result := VK_OEM_5;
    DIK_COMMA:
      result := VK_OEM_COMMA;
    DIK_PERIOD:
      result := VK_OEM_PERIOD;
    DIK_LMENU:
      result := VK_LMENU;
    DIK_RMENU:
      result := VK_RMENU;
    DIK_SLASH:
      result := VK_OEM_2;
    DIK_MULTIPLY:
      result := VK_MULTIPLY;
    DIK_SPACE:
      result := VK_SPACE;
    DIK_CAPITAL:
      result := VK_CAPITAL;
    DIK_SCROLL:
      result := VK_SCROLL;
    DIK_SUBTRACT:
      result := VK_SUBTRACT;
    DIK_ADD:
      result := VK_ADD;
    DIK_DECIMAL:
      result := VK_DECIMAL;
    DIK_NEXTTRACK:
      result := VK_MEDIA_NEXT_TRACK;
    DIK_PREVTRACK:
      result := VK_MEDIA_PREV_TRACK;
    DIK_MUTE:
      result := VK_VOLUME_MUTE;
    DIK_PLAYPAUSE:
      result := VK_MEDIA_PLAY_PAUSE;
    DIK_VOLUMEUP:
      result := VK_VOLUME_UP;
    DIK_VOLUMEDOWN:
      result := VK_VOLUME_DOWN;
    DIK_MEDIASTOP:
      result := VK_MEDIA_STOP;
    DIK_DIVIDE:
      result := VK_DIVIDE;
    DIK_PAUSE:
      result := VK_PAUSE;
    DIK_HOME:
      result := VK_HOME;
    DIK_UP:
      result := VK_UP;
    DIK_PRIOR:
      result := VK_PRIOR;
    DIK_LEFT:
      result := VK_LEFT;
    DIK_RIGHT:
      result := VK_RIGHT;
    DIK_END:
      result := VK_END;
    DIK_DOWN:
      result := VK_DOWN;
    DIK_NEXT:
      result := VK_NEXT;
    DIK_INSERT:
      result := VK_INSERT;
    DIK_DELETE:
      result := VK_DELETE;
    DIK_LWIN:
      result := VK_LWIN;
    DIK_RWIN:
      result := VK_RWIN;
    DIK_APPS:
      result := VK_APPS;
    DIK_SLEEP:
      result := VK_SLEEP;
    DIK_WEBHOME:
      result := VK_BROWSER_HOME;
    DIK_WEBSEARCH:
      result := VK_BROWSER_SEARCH;
    DIK_WEBFAVORITES:
      result := VK_BROWSER_FAVORITES;
    DIK_WEBREFRESH:
      result := VK_BROWSER_REFRESH;
    DIK_WEBSTOP:
      result := VK_BROWSER_STOP;
    DIK_WEBFORWARD:
      result := VK_BROWSER_FORWARD;
    DIK_WEBBACK:
      result := VK_BROWSER_BACK;
  end;
end;


function VKeyToWord(const aVKey: string): word;
begin
  if aVKey = '' then
    Exit(0);
  case UpperCase(aVKey) of
    'VK_LBUTTON': result := 1;
    'VK_RBUTTON': result := 2;
    'VK_CANCEL': result := 3;
    'VK_MBUTTON': result := 4;
    'VK_XBUTTON1': result := 5;
    'VK_XBUTTON2': result := 6;
    'VK_BACK': result := 8;
    'VK_TAB': result := 9;
    'VK_CLEAR': result := 12;
    'VK_RETURN': result := 13;
    'VK_SHIFT': result := 16;
    'VK_CONTROL': result := 17;
    'VK_MENU': result := 18;
    'VK_PAUSE': result := 19;
    'VK_CAPITAL': result := 20;
    'VK_KANA': result := 21;
    'VK_HANGEUL': result := 21;
    'VK_HANGUL': result := 21;
    'VK_JUNJA': result := 23;
    'VK_FINAL': result := 24;
    'VK_HANJA': result := 25;
    'VK_KANJI': result := 25;
    'VK_ESCAPE': result := 27;
    'VK_CONVERT': result := 28;
    'VK_NONCONVERT': result := 29;
    'VK_ACCEPT': result := 30;
    'VK_MODECHANGE': result := 31;
    'VK_SPACE': result := 32;
    'VK_PRIOR': result := 33;
    'VK_NEXT': result := 34;
    'VK_END': result := 35;
    'VK_HOME': result := 36;
    'VK_LEFT': result := 37;
    'VK_UP': result := 38;
    'VK_RIGHT': result := 39;
    'VK_DOWN': result := 40;
    'VK_SELECT': result := 41;
    'VK_PRINT': result := 42;
    'VK_EXECUTE': result := 43;
    'VK_SNAPSHOT': result := 44;
    'VK_INSERT': result := 45;
    'VK_DELETE': result := 46;
    'VK_HELP': result := 47;
    'VK_0': result := 48;
    'VK_1': result := 49;
    'VK_2': result := 50;
    'VK_3': result := 51;
    'VK_4': result := 52;
    'VK_5': result := 53;
    'VK_6': result := 54;
    'VK_7': result := 55;
    'VK_8': result := 56;
    'VK_9': result := 57;
    'VK_A': result := 65;
    'VK_B': result := 66;
    'VK_C': result := 67;
    'VK_D': result := 68;
    'VK_E': result := 69;
    'VK_F': result := 70;
    'VK_G': result := 71;
    'VK_H': result := 72;
    'VK_I': result := 73;
    'VK_J': result := 74;
    'VK_K': result := 75;
    'VK_L': result := 76;
    'VK_M': result := 77;
    'VK_N': result := 78;
    'VK_O': result := 79;
    'VK_P': result := 80;
    'VK_Q': result := 81;
    'VK_R': result := 82;
    'VK_S': result := 83;
    'VK_T': result := 84;
    'VK_U': result := 85;
    'VK_V': result := 86;
    'VK_W': result := 87;
    'VK_X': result := 88;
    'VK_Y': result := 89;
    'VK_Z': result := 90;
    'VK_LWIN': result := 91;
    'VK_RWIN': result := 92;
    'VK_APPS': result := 93;
    'VK_SLEEP': result := 95;
    'VK_NUMPAD0': result := 96;
    'VK_NUMPAD1': result := 97;
    'VK_NUMPAD2': result := 98;
    'VK_NUMPAD3': result := 99;
    'VK_NUMPAD4': result := 100;
    'VK_NUMPAD5': result := 101;
    'VK_NUMPAD6': result := 102;
    'VK_NUMPAD7': result := 103;
    'VK_NUMPAD8': result := 104;
    'VK_NUMPAD9': result := 105;
    'VK_MULTIPLY': result := 106;
    'VK_ADD': result := 107;
    'VK_SEPARATOR': result := 108;
    'VK_SUBTRACT': result := 109;
    'VK_DECIMAL': result := 110;
    'VK_DIVIDE': result := 111;
    'VK_F1': result := 112;
    'VK_F2': result := 113;
    'VK_F3': result := 114;
    'VK_F4': result := 115;
    'VK_F5': result := 116;
    'VK_F6': result := 117;
    'VK_F7': result := 118;
    'VK_F8': result := 119;
    'VK_F9': result := 120;
    'VK_F10': result := 121;
    'VK_F11': result := 122;
    'VK_F12': result := 123;
    'VK_F13': result := 124;
    'VK_F14': result := 125;
    'VK_F15': result := 126;
    'VK_F16': result := 127;
    'VK_F17': result := 128;
    'VK_F18': result := 129;
    'VK_F19': result := 130;
    'VK_F20': result := 131;
    'VK_F21': result := 132;
    'VK_F22': result := 133;
    'VK_F23': result := 134;
    'VK_F24': result := 135;
    'VK_NUMLOCK': result := 144;
    'VK_SCROLL': result := 145;
    'VK_OEM_NEC_EQUAL': result := 146;
    'VK_OEM_FJ_JISHO': result := 146;
    'VK_OEM_FJ_MASSHOU': result := 147;
    'VK_OEM_FJ_TOUROKU': result := 148;
    'VK_OEM_FJ_LOYA': result := 149;
    'VK_OEM_FJ_ROYA': result := 150;
    'VK_LSHIFT': result := 160;
    'VK_LCONTROL': result := 162;
    'VK_LMENU': result := 164;
    'VK_RSHIFT': result := 161;
    'VK_RCONTROL': result := 163;
    'VK_RMENU': result := 165;
    'VK_BROWSER_BACK': result := 166;
    'VK_BROWSER_FORWARD': result := 167;
    'VK_BROWSER_REFRESH': result := 168;
    'VK_BROWSER_STOP': result := 169;
    'VK_BROWSER_SEARCH': result := 170;
    'VK_BROWSER_FAVORITES': result := 171;
    'VK_BROWSER_HOME': result := 172;
    'VK_VOLUME_MUTE': result := 173;
    'VK_VOLUME_DOWN': result := 174;
    'VK_VOLUME_UP': result := 175;
    'VK_MEDIA_NEXT_TRACK': result := 176;
    'VK_MEDIA_PREV_TRACK': result := 177;
    'VK_MEDIA_STOP': result := 178;
    'VK_MEDIA_PLAY_PAUSE': result := 179;
    'VK_LAUNCH_MAIL': result := 180;
    'VK_LAUNCH_MEDIA_SELECT': result := 181;
    'VK_LAUNCH_APP1': result := 182;
    'VK_LAUNCH_APP2': result := 183;
    'VK_OEM_1': result := 186;
    'VK_OEM_PLUS': result := 187;
    'VK_OEM_COMMA': result := 188;
    'VK_OEM_MINUS': result := 189;
    'VK_OEM_PERIOD': result := 190;
    'VK_OEM_2': result := 191;
    'VK_OEM_3': result := 192;
    'VK_OEM_4': result := 219;
    'VK_OEM_5': result := 220;
    'VK_OEM_6': result := 221;
    'VK_OEM_7': result := 222;
    'VK_OEM_8': result := 223;
    'VK_OEM_AX': result := 225;
    'VK_OEM_102': result := 226;
    'VK_ICO_HELP': result := 227;
    'VK_ICO_00': result := 228;
    'VK_PROCESSKEY': result := 229;
    'VK_ICO_CLEAR': result := 230;
    'VK_PACKET': result := 231;
    'VK_OEM_RESET': result := 233;
    'VK_OEM_JUMP': result := 234;
    'VK_OEM_PA1': result := 235;
    'VK_OEM_PA2': result := 236;
    'VK_OEM_PA3': result := 237;
    'VK_OEM_WSCTRL': result := 238;
    'VK_OEM_CUSEL': result := 239;
    'VK_OEM_ATTN': result := 240;
    'VK_OEM_FINISH': result := 241;
    'VK_OEM_COPY': result := 242;
    'VK_OEM_AUTO': result := 243;
    'VK_OEM_ENLW': result := 244;
    'VK_OEM_BACKTAB': result := 245;
    'VK_ATTN': result := 246;
    'VK_CRSEL': result := 247;
    'VK_EXSEL': result := 248;
    'VK_EREOF': result := 249;
    'VK_PLAY': result := 250;
    'VK_ZOOM': result := 251;
    'VK_NONAME': result := 252;
    'VK_PA1': result := 253;
    'VK_OEM_CLEAR': result := 254;
    else
      Result := 0;
  end;
end;


function VKeyToString(const VKey: word): string;
begin
  result:='';
  case Vkey of
    1: result := 'VK_LBUTTON';
    2: result := 'VK_RBUTTON';
    3: result := 'VK_CANCEL';
    4: result := 'VK_MBUTTON';
    5: result := 'VK_XBUTTON1';
    6: result := 'VK_XBUTTON2';
    8: result := 'VK_BACK';
    9: result := 'VK_TAB';
    12: result := 'VK_CLEAR';
    13: result := 'VK_RETURN';
    16: result := 'VK_SHIFT';
    17: result := 'VK_CONTROL';
    18: result := 'VK_MENU';
    19: result := 'VK_PAUSE';
    20: result := 'VK_CAPITAL';
    21: result := 'VK_HANGUL';
    23: result := 'VK_JUNJA';
    24: result := 'VK_FINAL';
    25: result := 'VK_HANJA';
    27: result := 'VK_ESCAPE';
    28: result := 'VK_CONVERT';
    29: result := 'VK_NONCONVERT';
    30: result := 'VK_ACCEPT';
    31: result := 'VK_MODECHANGE';
    32: result := 'VK_SPACE';
    33: result := 'VK_PRIOR';
    34: result := 'VK_NEXT';
    35: result := 'VK_END';
    36: result := 'VK_HOME';
    37: result := 'VK_LEFT';
    38: result := 'VK_UP';
    39: result := 'VK_RIGHT';
    40: result := 'VK_DOWN';
    41: result := 'VK_SELECT';
    42: result := 'VK_PRINT';
    43: result := 'VK_EXECUTE';
    44: result := 'VK_SNAPSHOT';
    45: result := 'VK_INSERT';
    46: result := 'VK_DELETE';
    47: result := 'VK_HELP';
    48: result := 'VK_0';
    49: result := 'VK_1';
    50: result := 'VK_2';
    51: result := 'VK_3';
    52: result := 'VK_4';
    53: result := 'VK_5';
    54: result := 'VK_6';
    55: result := 'VK_7';
    56: result := 'VK_8';
    57: result := 'VK_9';
    65: result := 'VK_A';
    66: result := 'VK_B';
    67: result := 'VK_C';
    68: result := 'VK_D';
    69: result := 'VK_E';
    70: result := 'VK_F';
    71: result := 'VK_G';
    72: result := 'VK_H';
    73: result := 'VK_I';
    74: result := 'VK_J';
    75: result := 'VK_K';
    76: result := 'VK_L';
    77: result := 'VK_M';
    78: result := 'VK_N';
    79: result := 'VK_O';
    80: result := 'VK_P';
    81: result := 'VK_Q';
    82: result := 'VK_R';
    83: result := 'VK_S';
    84: result := 'VK_T';
    85: result := 'VK_U';
    86: result := 'VK_V';
    87: result := 'VK_W';
    88: result := 'VK_X';
    89: result := 'VK_Y';
    90: result := 'VK_Z';
    91: result := 'VK_LWIN';
    92: result := 'VK_RWIN';
    93: result := 'VK_APPS';
    95: result := 'VK_SLEEP';
    96: result := 'VK_NUMPAD0';
    97: result := 'VK_NUMPAD1';
    98: result := 'VK_NUMPAD2';
    99: result := 'VK_NUMPAD3';
    100: result := 'VK_NUMPAD4';
    101: result := 'VK_NUMPAD5';
    102: result := 'VK_NUMPAD6';
    103: result := 'VK_NUMPAD7';
    104: result := 'VK_NUMPAD8';
    105: result := 'VK_NUMPAD9';
    106: result := 'VK_MULTIPLY';
    107: result := 'VK_ADD';
    108: result := 'VK_SEPARATOR';
    109: result := 'VK_SUBTRACT';
    110: result := 'VK_DECIMAL';
    111: result := 'VK_DIVIDE';
    112: result := 'VK_F1';
    113: result := 'VK_F2';
    114: result := 'VK_F3';
    115: result := 'VK_F4';
    116: result := 'VK_F5';
    117: result := 'VK_F6';
    118: result := 'VK_F7';
    119: result := 'VK_F8';
    120: result := 'VK_F9';
    121: result := 'VK_F10';
    122: result := 'VK_F11';
    123: result := 'VK_F12';
    124: result := 'VK_F13';
    125: result := 'VK_F14';
    126: result := 'VK_F15';
    127: result := 'VK_F16';
    128: result := 'VK_F17';
    129: result := 'VK_F18';
    130: result := 'VK_F19';
    131: result := 'VK_F20';
    132: result := 'VK_F21';
    133: result := 'VK_F22';
    134: result := 'VK_F23';
    135: result := 'VK_F24';
    144: result := 'VK_NUMLOCK';
    145: result := 'VK_SCROLL';
    146: result := 'VK_OEM_NEC_EQUAL';
    147: result := 'VK_OEM_FJ_MASSHOU';
    148: result := 'VK_OEM_FJ_TOUROKU';
    149: result := 'VK_OEM_FJ_LOYA';
    150: result := 'VK_OEM_FJ_ROYA';
    160: result := 'VK_LSHIFT';
    162: result := 'VK_LCONTROL';
    164: result := 'VK_LMENU';
    161: result := 'VK_RSHIFT';
    163: result := 'VK_RCONTROL';
    165: result := 'VK_RMENU';
    166: result := 'VK_BROWSER_BACK';
    167: result := 'VK_BROWSER_FORWARD';
    168: result := 'VK_BROWSER_REFRESH';
    169: result := 'VK_BROWSER_STOP';
    170: result := 'VK_BROWSER_SEARCH';
    171: result := 'VK_BROWSER_FAVORITES';
    172: result := 'VK_BROWSER_HOME';
    173: result := 'VK_VOLUME_MUTE';
    174: result := 'VK_VOLUME_DOWN';
    175: result := 'VK_VOLUME_UP';
    176: result := 'VK_MEDIA_NEXT_TRACK';
    177: result := 'VK_MEDIA_PREV_TRACK';
    178: result := 'VK_MEDIA_STOP';
    179: result := 'VK_MEDIA_PLAY_PAUSE';
    180: result := 'VK_LAUNCH_MAIL';
    181: result := 'VK_LAUNCH_MEDIA_SELECT';
    182: result := 'VK_LAUNCH_APP1';
    183: result := 'VK_LAUNCH_APP2';
    186: result := 'VK_OEM_1';
    187: result := 'VK_OEM_PLUS';
    188: result := 'VK_OEM_COMMA';
    189: result := 'VK_OEM_MINUS';
    190: result := 'VK_OEM_PERIOD';
    191: result := 'VK_OEM_2';
    192: result := 'VK_OEM_3';
    219: result := 'VK_OEM_4';
    220: result := 'VK_OEM_5';
    221: result := 'VK_OEM_6';
    222: result := 'VK_OEM_7';
    223: result := 'VK_OEM_8';
    225: result := 'VK_OEM_AX';
    226: result := 'VK_OEM_102';
    227: result := 'VK_ICO_HELP';
    228: result := 'VK_ICO_00';
    229: result := 'VK_PROCESSKEY';
    230: result := 'VK_ICO_CLEAR';
    231: result := 'VK_PACKET';
    233: result := 'VK_OEM_RESET';
    234: result := 'VK_OEM_JUMP';
    235: result := 'VK_OEM_PA1';
    236: result := 'VK_OEM_PA2';
    237: result := 'VK_OEM_PA3';
    238: result := 'VK_OEM_WSCTRL';
    239: result := 'VK_OEM_CUSEL';
    240: result := 'VK_OEM_ATTN';
    241: result := 'VK_OEM_FINISH';
    242: result := 'VK_OEM_COPY';
    243: result := 'VK_OEM_AUTO';
    244: result := 'VK_OEM_ENLW';
    245: result := 'VK_OEM_BACKTAB';
    246: result := 'VK_ATTN';
    247: result := 'VK_CRSEL';
    248: result := 'VK_EXSEL';
    249: result := 'VK_EREOF';
    250: result := 'VK_PLAY';
    251: result := 'VK_ZOOM';
    252: result := 'VK_NONAME';
    253: result := 'VK_PA1';
    254: result := 'VK_OEM_CLEAR';
  end;
  Result := StringReplace(Result,'VK_','',[rfReplaceAll, rfIgnoreCase]);
end;

function DIKeyToString(const DIKey: word): string;
begin
 Log(IntToStr(dikey) +':' +IntToHEX(DiKey,2));
 result:= VKeyToString(DIToVirtualKeyCodes(DIKey));
end;

end.
