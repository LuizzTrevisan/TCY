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

unit FGX.LinkedLabel;

interface

uses
  System.Classes, System.UITypes, FMX.StdCtrls, FMX.Controls, FMX.Objects, FMX.Types;

type

{ TfgLinkedLabel }

  IFGXLaunchService = interface;

  TfgCustomLinkedLabel = class (TLabel)
  public
    const DEFAULT_CURSOR = crHandPoint;
    const DEFAULT_COLOR = TAlphaColorRec.Black;
    const DEFAULT_COLOR_HOVER = TAlphaColorRec.Blue;
    const DEFAULT_COLOR_VISITED = TAlphaColorRec.Magenta;
    const DEFAULT_VISITED = False;
  strict private
    FLaunchService: IFGXLaunchService;
    FUrl: string;
    FVisited: Boolean;
    FColor: TAlphaColor;
    FHoverColor: TAlphaColor;
    FVisitedColor: TAlphaColor;
    procedure SetColor(const Index: Integer; const Value: TAlphaColor);
    procedure SetVisited(const Value: Boolean);
  protected
    { Styles }
    function GetDefaultStyleLookupName: string; override;
    { Painting }
    procedure Paint; override;
    { Mouse events }
    procedure DoMouseEnter; override;
    procedure DoMouseLeave; override;
    procedure Click; override;
    procedure UpdateColor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    property Color: TAlphaColor index 0 read FColor write SetColor default DEFAULT_COLOR;
    property HoverColor: TAlphaColor index 1 read FHoverColor write SetColor default DEFAULT_COLOR_HOVER;
    property Url: string read FUrl write FUrl;
    property Cursor default DEFAULT_CURSOR;
    property Visited: Boolean read FVisited write SetVisited default DEFAULT_VISITED;
    property VisitedColor: TAlphaColor index 2 read FVisitedColor write SetColor default DEFAULT_COLOR_VISITED;
  end;

  TfgLinkedLabel = class(TfgCustomLinkedLabel)
  published
    property Cursor;
    property Color;
    property HoverColor;
    property Url;
    property VisitedColor;
    property Visited;
  end;

{ IFMXLaunchService }

  IFGXLaunchService = interface
  ['{3C0888FA-61DD-4B76-9F0E-1956E6E08E86}']
    function OpenURL(const AUrl: string): Boolean;
  end;

implementation

uses
  FMX.Platform
{$IFDEF MSWINDOWS}
  , FGX.LinkedLabel.Win
{$ENDIF}
{$IFDEF IOS}
  , FGX.LinkedLabel.iOS
{$ELSE}
{$IFDEF MACOS}
  , FGX.LinkedLabel.Mac
{$ENDIF}
{$ENDIF}
{$IFDEF ANDROID}
  , FGX.LinkedLabel.Android
{$ENDIF}
  ;

{ TLinkedLabel }

procedure TfgCustomLinkedLabel.Click;
begin
  if Assigned(FLaunchService) then
  begin
    FLaunchService.OpenURL(Url);
    FVisited := True;
  end;
end;

constructor TfgCustomLinkedLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HitTest := True;
  Font.Style := [TFontStyle.fsUnderline];
  StyledSettings := [];
  Cursor := DEFAULT_CURSOR;
  FVisited := False;
  FColor := DEFAULT_COLOR;
  FHoverColor := DEFAULT_COLOR_HOVER;
  FVisitedColor := DEFAULT_COLOR_VISITED;

  TPlatformServices.Current.SupportsPlatformService(IFGXLaunchService, IInterface(FLaunchService));
end;

destructor TfgCustomLinkedLabel.Destroy;
begin
  FLaunchService := nil;
  inherited Destroy;
end;

procedure TfgCustomLinkedLabel.DoMouseEnter;
begin
  inherited DoMouseEnter;
  Repaint;
end;

procedure TfgCustomLinkedLabel.DoMouseLeave;
begin
  inherited DoMouseLeave;
  Repaint;
end;

function TfgCustomLinkedLabel.GetDefaultStyleLookupName: string;
begin
  Result := 'LabelStyle';
end;

procedure TfgCustomLinkedLabel.Paint;
begin
  UpdateColor;
  inherited Paint;
end;

procedure TfgCustomLinkedLabel.SetColor(const Index: Integer; const Value: TAlphaColor);
begin
  case Index of
    0: FColor := Value;
    1: FHoverColor := Value;
    2: FVisitedColor := Value;
  end;
  Repaint;
end;

procedure TfgCustomLinkedLabel.SetVisited(const Value: Boolean);
begin
  if Visited <> Value then
  begin
    FVisited := Value;
    UpdateColor;
  end;
end;

procedure TfgCustomLinkedLabel.UpdateColor;
begin
  if IsMouseOver then
    TextSettings.FontColor := FHoverColor
  else if FVisited then
    TextSettings.FontColor := FVisitedColor
  else
    TextSettings.FontColor := Color;
end;

initialization
  RegisterFmxClasses([TfgCustomLinkedLabel, TfgLinkedLabel]);
  RegisterService;
end.
