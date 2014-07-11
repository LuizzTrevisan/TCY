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

unit FGX.ProgressDialog.iOS;

interface

uses
  System.UITypes, System.UIConsts, iOSapi.UIKit, FGX.ProgressDialog, FGX.ProgressDialog.Types;

const
  SHADOW_ALPHA       = 180;
  MESSAGE_FONT_SIZE  = 15;
  MESSAGE_MARGIN     = 5;
  MESSAGE_HEIGHT     = 20;
  INDICATOR_MARGIN   = 5.0;
  PROGRESSBAR_WIDTH  = 200;
  PROGRESSBAR_HEIGHT = 20;

type

  { TIOSProgressDialogService }

  TIOSProgressDialogService = class (TInterfacedObject, IFGXProgressDialogService)
  public
    { IFGXProgressDialogService }
    function CreateNativeProgressDialog(const AOwner: TObject): TfgNativeProgressDialog;
    function CreateNativeActivityDialog(const AOwner: TObject): TfgNativeActivityDialog;
  end;

  TiOSNativeActivityDialog = class (TfgNativeActivityDialog)
  private
    FActivityIndicator: UIActivityIndicatorView;
    FShadowColor: TAlphaColor;
    FShadowView: UIView;
    FMessageLabel: UILabel;
  protected
    procedure MessageChanged; override;
  public
    constructor Create(const AOwner: TObject); override;
    destructor Destroy; override;
    procedure Show; override;
    procedure Hide; override;
  end;

  TiOSNativeProgressDialog = class (TfgNativeProgressDialog)
  private
    FProgressView: UIProgressView;
    FShadowColor: TAlphaColor;
    FShadowView: UIView;
    FMessageLabel: UILabel;
  protected
    procedure MessageChanged; override;
    procedure ProgressChanged; override;
  public
    constructor Create(const AOwner: TObject); override;
    destructor Destroy; override;
    procedure ResetProgress; override;
    procedure Show; override;
    procedure Hide; override;
  end;

procedure RegisterService;

implementation

uses
  System.Types, System.Math,
  FMX.Platform, FMX.Platform.iOS, FMX.Forms, FMX.Helpers.iOS,
  FGX.Helpers.iOS,
  iOSapi.CoreGraphics, iOSapi.Foundation,
  Macapi.Helpers;

procedure RegisterService;
begin
  TPlatformServices.Current.AddPlatformService(IFGXProgressDialogService, TIOSProgressDialogService.Create);
end;

{ TIOSProgressDialogService }

function TIOSProgressDialogService.CreateNativeActivityDialog(const AOwner: TObject): TfgNativeActivityDialog;
begin
  Result := TiOSNativeActivityDialog.Create(AOwner);
end;

function TIOSProgressDialogService.CreateNativeProgressDialog(const AOwner: TObject): TfgNativeProgressDialog;
begin
  Result := TiOSNativeProgressDialog.Create(AOwner);
end;

{ TiOSNativeProgressDialog }

constructor TiOSNativeActivityDialog.Create(const AOwner: TObject);
var
  ScreenBounds: NSSize;
  CenterPoint: NSPoint;
begin
  Assert(MainScreen <> nil);
  Assert(SharedApplication.keyWindow <> nil);
  Assert(SharedApplication.keyWindow.rootViewController <> nil);
  Assert(SharedApplication.keyWindow.rootViewController.view <> nil);

  inherited Create(AOwner);
  FShadowColor := MakeColor(0, 0, 0, SHADOW_ALPHA);

  // Shadow
  ScreenBounds := MainScreen.bounds.size;
  FShadowView := TUIView.Alloc;
  FShadowView.initWithFrame(CGRect.Create(ScreenBounds.Width, ScreenBounds.Height));
  FShadowView.setUserInteractionEnabled(True);
  FShadowView.setHidden(True);
  FShadowView.setAutoresizingMask(UIViewAutoresizingFlexibleWidth or UIViewAutoresizingFlexibleHeight);
  FShadowView.setBackgroundColor(TUIColor.MakeColor(FShadowColor));

  CenterPoint := FShadowView.center;
  // Creating Ani indicator
  FActivityIndicator := TUIActivityIndicatorView.Alloc;
  FActivityIndicator.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhite);
  FActivityIndicator.startAnimating;
  FActivityIndicator.setCenter(CGPointMake(CenterPoint.X, CenterPoint.Y - FActivityIndicator.bounds.height - INDICATOR_MARGIN));

  // Creating message label
  FMessageLabel := TUILabel.Create;
  FMessageLabel.setTextColor(TUIColor.whiteColor);
  FMessageLabel.setBackgroundColor(TUIColor.clearColor);
  FMessageLabel.setFont(FMessageLabel.font.fontWithSize(MESSAGE_FONT_SIZE));
  FMessageLabel.setBounds(CGRect.Create(FShadowView.bounds.width, 25));
  FMessageLabel.setTextAlignment(UITextAlignmentCenter);
  FMessageLabel.setCenter(CGPointMake(CenterPoint.X, CenterPoint.Y + MESSAGE_MARGIN));

  // Adding view
  FShadowView.addSubview(FActivityIndicator);
  FShadowView.addSubview(FMessageLabel);

  // Adding Shadow to application
  SharedApplication.keyWindow.rootViewController.view.AddSubview(FShadowView);
end;

destructor TiOSNativeActivityDialog.Destroy;
begin
  FActivityIndicator.removeFromSuperview;
  FActivityIndicator.release;
  FShadowView.removeFromSuperview;
  FShadowView.release;
  inherited Destroy;
end;

procedure TiOSNativeActivityDialog.Hide;
begin
  Assert(FShadowView <> nil);

  FadeOut(FShadowView, DEFAULT_ANIMATION_DURATION);
  DoHide;
end;

procedure TiOSNativeActivityDialog.MessageChanged;
begin
  Assert(FMessageLabel <> nil);

  FMessageLabel.setText(StrToNSStr(Message));

  // We should call it once for starting animation
  Application.ProcessMessages;
end;

procedure TiOSNativeActivityDialog.Show;
begin
  Assert(FShadowView <> nil);
  Assert(FMessageLabel <> nil);

  FadeIn(FShadowView, DEFAULT_ANIMATION_DURATION);
  DoShow;

  // We should call it once for starting animation
  Application.ProcessMessages;
end;

{ TiOSNativeProgressDialog }

constructor TiOSNativeProgressDialog.Create(const AOwner: TObject);
var
  ScreenBounds: NSSize;
  CenterPoint: NSPoint;
begin
  inherited Create(AOwner);
  FShadowColor := MakeColor(0, 0, 0, SHADOW_ALPHA);

  // Shadow
  ScreenBounds := MainScreen.bounds.size;
  FShadowView := TUIView.Alloc;
  FShadowView.setUserInteractionEnabled(True);
  FShadowView.initWithFrame(CGRect.Create(ScreenBounds.Width, ScreenBounds.Height));
  FShadowView.setHidden(True);
  FShadowView.setAutoresizingMask(UIViewAutoresizingFlexibleWidth or UIViewAutoresizingFlexibleHeight);
  FShadowView.setBackgroundColor(TUIColor.MakeColor(FShadowColor));

  CenterPoint := FShadowView.center;

  // Creating message label
  FMessageLabel := TUILabel.Create;
  FMessageLabel.setBackgroundColor(TUIColor.clearColor);
  FMessageLabel.setTextColor(TUIColor.whiteColor);
  FMessageLabel.setBounds(CGRect.Create(FShadowView.bounds.width, MESSAGE_HEIGHT));
  FMessageLabel.setTextAlignment(UITextAlignmentCenter);
  FMessageLabel.setFont(FMessageLabel.font.fontWithSize(MESSAGE_FONT_SIZE));
  FMessageLabel.setCenter(CGPointMake(CenterPoint.X, CenterPoint.Y - FMessageLabel.bounds.height));

  // Creating Ani indicator
  FProgressView := TUIProgressView.Alloc;
  FProgressView.initWithProgressViewStyle(UIProgressViewStyleDefault);
  FProgressView.setBounds(CGRect.Create(PROGRESSBAR_WIDTH, PROGRESSBAR_HEIGHT));
  FProgressView.setCenter(CenterPoint);

  // Adding view
  FShadowView.addSubview(FProgressView);
  FShadowView.addSubview(FMessageLabel);

  // Adding Shadow to application
  SharedApplication.keyWindow.rootViewController.view.AddSubview(FShadowView);
end;

destructor TiOSNativeProgressDialog.Destroy;
begin

  inherited Destroy;
end;

procedure TiOSNativeProgressDialog.Hide;
begin
  Assert(FShadowView <> nil);

  FadeOut(FShadowView, DEFAULT_ANIMATION_DURATION);
  DoHide;
end;

procedure TiOSNativeProgressDialog.MessageChanged;
begin
  Assert(FMessageLabel <> nil);

  FMessageLabel.setText(StrToNSStr(Message));

  // We should call it once for starting animation
  Application.ProcessMessages;
end;

procedure TiOSNativeProgressDialog.ProgressChanged;
begin
  Assert(FProgressView <> nil);
  Assert(InRange(Progress, 0, 100));

  FProgressView.setProgress(Progress / 100, True);

  // We should call it once for starting animation
  Application.ProcessMessages;
end;

procedure TiOSNativeProgressDialog.ResetProgress;
begin
  Assert(FProgressView <> nil);

  inherited ResetProgress;
  FProgressView.setProgress(0);
end;

procedure TiOSNativeProgressDialog.Show;
begin
  Assert(FShadowView <> nil);
  Assert(FMessageLabel <> nil);

  FadeIn(FShadowView, DEFAULT_ANIMATION_DURATION);
  DoShow;

  // We should call it once for starting animation
  Application.ProcessMessages;
end;

end.
