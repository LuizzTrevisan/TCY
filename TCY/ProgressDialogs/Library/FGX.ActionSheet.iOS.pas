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

unit FGX.ActionSheet.iOS;

interface

uses
  System.Classes, System.Generics.Collections, FMX.Helpers.iOS, FGX.ActionSheet, FGX.ActionSheet.Types,
  Macapi.ObjectiveC, iOSapi.CocoaTypes, iOSapi.UIKit;

type

  { TiOSActionSheetService }

  TiOSActionSheetDelegate = class;

  TiOSActionSheetService = class (TInterfacedObject, IFGXActionSheetService)
  private
    [weak] FActions: TfgActionsCollections;
    FActionsLinks: TDictionary<NSInteger, TfgActionCollectionItem>;
    FActionSheet: UIActionSheet;
    FDelegate: TiOSActionSheetDelegate;
  protected
    procedure DoButtonClicked(const AButtonIndex: Integer); virtual;
    function CreateActionButton(const Action: TfgActionCollectionItem): NSInteger; virtual;
    procedure CreateSheetActions(const AUseUIGuidline: Boolean); virtual;
  public
    constructor Create;
    destructor Destroy; override;

    { IFGXActionSheetService }
    procedure Show(const Title: string; Actions: TfgActionsCollections; const UseUIGuidline: Boolean = True);
  end;

  TNotifyButtonClicked = procedure (const AButtonIndex: Integer) of object;

  TiOSActionSheetDelegate = class (TOCLocal, UIActionSheetDelegate)
  private
    FOnButtonClicked: TNotifyButtonClicked;
  public
    constructor Create(const AOnButtonClicked: TNotifyButtonClicked);
    { UIActionSheetDelegate }
    procedure actionSheet(actionSheet: UIActionSheet; clickedButtonAtIndex: NSInteger); cdecl;
    procedure actionSheetCancel(actionSheet: UIActionSheet); cdecl;
    procedure didPresentActionSheet(actionSheet: UIActionSheet); cdecl;
    procedure willPresentActionSheet(actionSheet: UIActionSheet); cdecl;
  end;

procedure RegisterService;

implementation

uses
  FMX.Platform, FGX.Helpers.iOS, iOSapi.Foundation, Macapi.Helpers;

procedure RegisterService;
begin
  TPlatformServices.Current.AddPlatformService(IFGXActionSheetService, TiOSActionSheetService.Create);
end;

{ TiOSActionSheetService }

constructor TiOSActionSheetService.Create;
begin
  FDelegate := TiOSActionSheetDelegate.Create(DoButtonClicked);
  FActionsLinks := TDictionary<NSInteger, TfgActionCollectionItem>.Create;
end;

function TiOSActionSheetService.CreateActionButton(const Action: TfgActionCollectionItem): NSInteger;
begin
  Assert(Action <> nil);
  Assert(FActionsLinks <> nil);

  Result := FActionSheet.addButtonWithTitle(StrToNSStr(Action.Caption));
  FActionsLinks.Add(Result, Action);
end;

procedure TiOSActionSheetService.CreateSheetActions(const AUseUIGuidline: Boolean);
var
  Action: TfgActionCollectionItem;
  I: Integer;
  Index: Integer;
begin
  Assert(FActions <> nil);

  FActionsLinks.Clear;
  if AUseUIGuidline then
  begin
    { Get destructive action caption }
    Index := FActions.IndexOfDestructiveButton;
    if Index <> -1 then
    begin
      CreateActionButton(FActions[Index]);
      FActionSheet.setDestructiveButtonIndex(0);
    end;
  end;

  for I := 0 to FActions.Count - 1 do
  begin
    Action := FActions[I];
    if not Action.Visible then
      Continue;

    if (AUseUIGuidline and (Action.Style = TfgActionStyle.Normal)) or not AUseUIGuidline then
      CreateActionButton(Action);
  end;

  if AUseUIGuidline then
  begin
    { Apple doesn't recommend to use Cancel button on iPad
      See: https://developer.apple.com/library/ios/documentation/uikit/reference/UIActionSheet_Class/Reference/Reference.html#//apple_ref/occ/instp/UIActionSheet/cancelButtonIndex }
    if InterfaceIdiom <> TfgInterfaceIdiom.Tablet then
    begin
      Index := FActions.IndexOfCancelButton;
      if Index <> -1 then
      begin
        CreateActionButton(FActions[Index]);
        FActionSheet.setCancelButtonIndex(FActionsLinks.Count - 1);
      end;
    end;
  end;
end;

destructor TiOSActionSheetService.Destroy;
begin
  FActionsLinks.Free;
  if FActionSheet <> nil then
    FActionSheet.release;
  FDelegate.Free;
  inherited Destroy;
end;

procedure TiOSActionSheetService.DoButtonClicked(const AButtonIndex: Integer);
var
  Action: TfgActionCollectionItem;
begin
  Assert(FActions <> nil);
  Assert(FActionsLinks <> nil);

  Action := FActionsLinks.Items[AButtonIndex];
  if Assigned(Action.OnClick) then
    Action.OnClick(Action);
end;

procedure TiOSActionSheetService.Show(const Title: string; Actions: TfgActionsCollections; const UseUIGuidline: Boolean);
begin
  Assert(Actions <> nil);
  Assert(SharedApplication <> nil);
  Assert(SharedApplication.keyWindow <> nil);
  Assert(SharedApplication.keyWindow.rootViewController <> nil);

  FActions := Actions;
  { Removing old UIActionSheet and get new instance }
  if FActionSheet <> nil then
    FActionSheet.release;
  FActionSheet := TUIActionSheet.Alloc;
  FActionSheet.initWithTitle(StrToNSStr(Title), (FDelegate as ILocalObject).GetObjectID, nil, nil, nil);

  CreateSheetActions(UseUIGuidline);

  { Displaying }
  FActionSheet.showInView(SharedApplication.keyWindow.rootViewController.view);
end;

{ TiOSActionSheetDelegate }

procedure TiOSActionSheetDelegate.actionSheet(actionSheet: UIActionSheet; clickedButtonAtIndex: NSInteger);
begin
  if Assigned(FOnButtonClicked) then
    FOnButtonClicked(clickedButtonAtIndex);
end;

procedure TiOSActionSheetDelegate.actionSheetCancel(actionSheet: UIActionSheet);
begin

end;

constructor TiOSActionSheetDelegate.Create(const AOnButtonClicked: TNotifyButtonClicked);
begin
  inherited Create;
  FOnButtonClicked := AOnButtonClicked;
end;

procedure TiOSActionSheetDelegate.didPresentActionSheet(actionSheet: UIActionSheet);
begin

end;

procedure TiOSActionSheetDelegate.willPresentActionSheet(actionSheet: UIActionSheet);
begin

end;

end.
