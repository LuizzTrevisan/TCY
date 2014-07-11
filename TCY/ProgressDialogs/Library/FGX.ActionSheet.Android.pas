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

unit FGX.ActionSheet.Android;

interface

uses
  FGX.ActionSheet, FGX.ActionSheet.Types, Androidapi.JNIBridge, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.App, Androidapi.JNI.JavaTypes;

type

  { TAndroidActionSheetService }

  TfgActionSheetListener = class;

  TAndroidActionSheetService = class (TInterfacedObject, IFGXActionSheetService)
  private
    FListener: TfgActionSheetListener;
    FActions: TfgActionsCollections;
  protected
    procedure DoButtonClicked(const ButtonIndex: Integer); virtual;
    function ItemsToJavaArray: TJavaObjectArray<JCharSequence>;
  public
    constructor Create;
    destructor Destroy; override;

    { IFGXActionSheetService }
    procedure Show(const ATitle: string; Actions: TfgActionsCollections; const UseUIGuidline: Boolean = True);
  end;

  TfgNotifyButtonClicked = procedure (const ButtonIndex: Integer) of object;

  TfgActionSheetListener = class (TJavaLocal, JDialogInterface_OnClickListener)
  private
    FOnButtonClicked: TfgNotifyButtonClicked;
  public
    constructor Create(const AOnButtonClicked: TfgNotifyButtonClicked);
    { JPopupMenu_OnMenuItemClickListener }
     procedure onClick(dialog: JDialogInterface; which: Integer); cdecl;
  end;

procedure RegisterService;

implementation

uses
  System.Classes, System.Math, System.SysUtils, Androidapi.Helpers,
  FGX.Helpers.Android,
  FMX.Platform, FMX.Platform.Android, FMX.Helpers.Android, FMX.Types, FMX.Controls,
  FMX.Dialogs;

procedure RegisterService;
begin
  if TOSVersion.Check(2, 0) then
    TPlatformServices.Current.AddPlatformService(IFGXActionSheetService, TAndroidActionSheetService.Create);
end;

{ TAndroidActionSheetService }

constructor TAndroidActionSheetService.Create;
begin
  FListener := TfgActionSheetListener.Create(DoButtonClicked);
end;

destructor TAndroidActionSheetService.Destroy;
begin
  FListener.Free;
  inherited Destroy;
end;

procedure TAndroidActionSheetService.DoButtonClicked(const ButtonIndex: Integer);
var
  Action: TfgActionCollectionItem;
begin
  Assert(FActions <> nil, 'List of all actions (TActionCollection) already was destroyed');
  Assert(InRange(ButtonIndex, 0, FActions.Count - 1), 'Android returns wrong index of actions. Out of range.');

  if InRange(ButtonIndex, 0, FActions.Count - 1) then
  begin
    Action := (FActions.Items[ButtonIndex] as TfgActionCollectionItem);
    if Assigned(Action.OnClick) then
      Action.OnClick(Action);
  end;
end;

function TAndroidActionSheetService.ItemsToJavaArray: TJavaObjectArray<JCharSequence>;
var
  Action: TfgActionCollectionItem;
  I: Integer;
  Items: TJavaObjectArray<JCharSequence>;
begin
  Items := TJavaObjectArray<JCharSequence>.Create(FActions.CountOfVisibleActions);
  for I := 0 to FActions.Count - 1 do
  begin
    Action := FActions[I];
    if Action.Visible then
      Items.SetRawItem(I, (StrToJCharSequence(Action.Caption) as ILocalObject).GetObjectID);
  end;
  Result := Items;
end;

procedure TAndroidActionSheetService.Show(const ATitle: string; Actions: TfgActionsCollections; const UseUIGuidline: Boolean = True);
var
  DialogBuilder: JAlertDialog_Builder;
  Dialog: JAlertDialog;
  Items: TJavaObjectArray<JCharSequence>;
begin
  Assert(Actions <> nil);

  FActions := Actions;

  { Create Alert Dialog }
  if TOSVersion.Major <= 2 then
    DialogBuilder := TJAlertDialog_Builder.JavaClass.init(SharedActivityContext)
  else
    DialogBuilder := TJAlertDialog_Builder.JavaClass.init(SharedActivityContext, GetNativeTheme);

  { Forming  Action List }
  Items := ItemsToJavaArray;
  if not ATitle.IsEmpty then
    DialogBuilder.setTitle(StrToJCharSequence(ATitle));
  DialogBuilder.setItems(Items, FListener);
  DialogBuilder.setCancelable(True);

  CallInUIThread(procedure begin
    Dialog := DialogBuilder.Create;
    Dialog.Show;
  end);
end;

{ TActionSheetListener }

constructor TfgActionSheetListener.Create(const AOnButtonClicked: TfgNotifyButtonClicked);
begin
  inherited Create;
  FOnButtonClicked := AOnButtonClicked;
end;

procedure TfgActionSheetListener.onClick(dialog: JDialogInterface; which: Integer);
begin
  if Assigned(FOnButtonClicked) then
    TThread.Synchronize(nil, procedure begin
      FOnButtonClicked(which);
    end);
end;

end.
