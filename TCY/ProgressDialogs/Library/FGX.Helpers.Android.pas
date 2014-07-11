{*********************************************************************
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Autor: Brovin Y.D.
 * E-mail: y.brovin@gmail.com
 *
 ********************************************************************}

unit FGX.Helpers.Android;

interface

uses
  FMX.Controls, Androidapi.JNI.App;

{ Themes }

  /// <summary>
  ///   We define which native theme we need to use for pickers using meta information in
  ///   our FMX style (TStyleDescriptor.PlatformTarget)
  /// </summary>
  /// <remarks>
  ///   Theme is applyed only on Android Version >= 4.0.
  ///   If current OS it's Gengebread, we use 0 - default system theme
  /// </remarks>
  /// <returns>Android System theme consts for Dialogs (THEME_HOLO_LIGHT, THEME_HOLO_DARK)</returns>
  function GetNativeTheme: Integer; overload;
  function GetNativeTheme(const ATargetControl: TControl): Integer; overload;

{ Dialogs }

  procedure ShowDialog(ADialog: JDialog; const ADialogID: Integer);
  procedure HideDialog(ADialog: JDialog; const ADialogID: Integer);

implementation

uses
  System.SysUtils, System.Math,
  FMX.Styles, FMX.Forms, FMX.Helpers.Android, FMX.Platform.Android;

function GetNativeTheme(const ATargetControl: TControl): Integer; overload;
const
  ANDROID_LIGHT_THEME = '[LIGHTSTYLE]';
  ANDROID_DARK_THEME = '[DARKSTYLE]';
var
  StyleDescriptor: TStyleDescription;
begin
  Assert(ATargetControl <> nil);

  Result := 0;
  if TOSVersion.Check(3, 0) and (ATargetControl <> nil) then
  begin
    StyleDescriptor := TStyleManager.GetStyleDescriptionForControl(ATargetControl);
    if Assigned(StyleDescriptor) then
    begin
      if StyleDescriptor.PlatformTarget.Contains(ANDROID_LIGHT_THEME) then
        Result := TJAlertDialog.JavaClass.THEME_HOLO_LIGHT;

      if StyleDescriptor.PlatformTarget.Contains(ANDROID_DARK_THEME) then
        Result := TJAlertDialog.JavaClass.THEME_HOLO_DARK;
    end;
  end;
end;

function GetNativeTheme: Integer;
begin
  if Screen.FocusControl <> nil then
    Result := GetNativeTheme(Screen.FocusControl.GetObject as TControl)
  else
    Result := 0;
end;

procedure ShowDialog(ADialog: JDialog; const ADialogID: Integer);
begin
  if IsGingerbreadDevice then
    MainActivity.showDialog(ADialogID, ADialog)
  else
    ADialog.show;
end;

procedure HideDialog(ADialog: JDialog; const ADialogID: Integer);
begin
  if IsGingerbreadDevice then
  begin
    MainActivity.dismissDialog(ADialogID);
    MainActivity.removeDialog(ADialogID);
  end
  else
    ADialog.dismiss;
end;

end.
