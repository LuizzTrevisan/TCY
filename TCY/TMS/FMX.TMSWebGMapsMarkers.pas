{***************************************************************************)
{ TMS FMX WebGMaps component                                                }
{ for Delphi                                                                }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2013 - 2014                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit FMX.TMSWebGMapsMarkers;

interface

{$I TMSDEFS.INC}

uses
  SysUtils, Classes, FMX.Types, FMX.TMSWebGMapsCommon, StrUtils,
  FMX.TMSWebGMapsWebBrowser, FMX.TMSWebGMapsConst, FMX.TMSWebGMapsCommonFunctions, UITypes
  {$IFDEF DELPHIXE5_LVL}
  , FMX.Graphics
  {$ENDIF}
  ;

type

  TMapLabel = class(TPersistent)
  private
    FBorderColor: TAlphaColor;
    FColor: TAlphaColor;
    FFont: TFont;
    FMargin: integer;
    FText: string;
    FOwner: TCollectionItem;
    FFontColor: TAlphaColor;
    procedure SetBorderColor(const Value: TAlphaColor);
    procedure SetColor(const Value: TAlphaColor);
    procedure SetFont(const Value: TFont);
    procedure SetText(const Value: string);
    procedure SetOwner(const Value: TCollectionItem);
    procedure SetFontColor(const Value: TAlphaColor);

  protected
    property Owner : TCollectionItem read FOwner write SetOwner;
  public
    constructor Create(CollectionItem : TCollectionItem);
    destructor Destroy; override;
    procedure Assign(Source : TPersistent); override;
  published
    property Text : string read FText write SetText;
    property Color : TAlphaColor read FColor write SetColor default TAlphaColorRec.White;
    property BorderColor : TAlphaColor read FBorderColor write SetBorderColor default TAlphaColorRec.Black;
    property Margin : integer read FMargin write FMargin default 2;
    property Font : TFont read FFont write SetFont;
    property FontColor : TAlphaColor read FFontColor write SetFontColor default TAlphaColorRec.Black;
  end;

  TMarker = class(TCollectionItem)
  private
    FWebGMaps : TTMSFMXWebGMapsWebBrowser;
    FLatitude: double;
    FDraggable: boolean;
    FTitle: String;
    FLongitude: double;
    FIcon: String;
    FVisible: boolean;
    FClickable: boolean;
    FFlat: boolean;
    FInitialDropAnimation: boolean;
    FZindex: integer;
    FMapLabel: TMapLabel;
    FTag: integer;
    procedure SetDraggable(const Value: boolean);
    procedure SetIcon(const Value: String);
    procedure SetLatitude(const Value: double);
    procedure SetLongitude(const Value: double);
    procedure SetTitle(const Value: String);
    procedure SetVisible(const Value: boolean);
    procedure SetClickable(const Value: boolean);
    procedure SetFlat(const Value: boolean);
    procedure SetInitialDropAnimation(const Value: boolean);
    procedure SetZindex(const Value: integer);
    procedure SetMapLabel(const Value: TMapLabel);
    procedure SetTag(const Value: integer);
  protected
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source : TPersistent); override;
  published
    property Visible : boolean read FVisible write SetVisible;
    property Latitude : double read FLatitude write SetLatitude;
    property Longitude : double read FLongitude write SetLongitude;
    property Title : String read FTitle write SetTitle;
    property Icon : String read FIcon write SetIcon;
    property Draggable : boolean read FDraggable write SetDraggable;
    property Clickable : boolean read FClickable write SetClickable;
    property Flat : boolean read FFlat write SetFlat;
    property InitialDropAnimation : boolean read FInitialDropAnimation write SetInitialDropAnimation;
    property Zindex : integer read FZindex write SetZindex;
    property MapLabel : TMapLabel read FMapLabel write SetMapLabel;
    property Tag: integer read FTag write SetTag default 0;
  end;

  TMarkers = class(TCollection)
  private
    FWebGMaps : TTMSFMXWebGMapsWebBrowser;
    function GetItem(Index : integer) : TMarker;
    procedure SetItem(Index : integer; Value : TMarker);
  protected
    function GetOwner : TPersistent; override;
    procedure Update(Item : TCollectionItem); override;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
  public
    constructor Create(AWebGMaps : TTMSFMXWebGMapsWebBrowser);
    function Add(Latitude,Longitude:Double; Title,Icon :string; Draggable,Visible,Clickable,Flat,InitialDropAnimation:Boolean; zIndex:Integer): TMarker; overload;
    function Add(Latitude,Longitude:Double; Title: string): TMarker; overload;
    function Add: TMarker; overload;
    property Items[index : integer] : TMarker read GetItem write SetItem; default;
    function Bounds: TBounds;
  end;


implementation

uses
  FMX.TMSWebGMaps;

{ TMarker }

procedure TMarker.Assign(Source: TPersistent);
var
  MarkerSource : TMarker;
begin
  if (Source is TMarker) then
  begin
    MarkerSource          := TMarker(Source);
    FLatitude             := MarkerSource.FLatitude;
    FLongitude            := MarkerSource.FLongitude;
    FDraggable            := MarkerSource.FDraggable;
    FClickable            := MarkerSource.FClickable;
    FFlat                 := MarkerSource.FFlat;
    FInitialDropAnimation := MarkerSource.FInitialDropAnimation;
    FTitle                := MarkerSource.FTitle;
    FIcon                 := MarkerSource.FIcon;
    FVisible              := MarkerSource.FVisible;
    FZindex               := MarkerSource.FZindex;
    FTag                  := MarkerSource.FTag;
    FMapLabel.Assign(MarkerSource.FMapLabel);
    
    Changed(True);
  end
  else
    inherited;
end;

constructor TMarker.Create(Collection: TCollection);
begin
  inherited;
  FWebGMaps             := TMarkers(Collection).FWebGMaps;
  FLatitude             := 0;
  FLongitude            := 0;
  FDraggable            := True;
  FClickable            := True;
  FFlat                 := False;
  FInitialDropAnimation := False;
  FTitle                := 'Marker'+inttostr(Index);
  FIcon                 := '';
  FVisible              := True;
  FZindex               := Index;
  FTag                  := 0;
  FMapLabel             := TMapLabel.Create(Self);
end;

destructor TMarker.Destroy;
begin
  FMapLabel.Free;
  inherited;
end;

procedure TMarker.SetClickable(const Value: boolean);
begin
  FClickable := Value;
  if Value then
    (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<allmarkers.length) allmarkers['+inttostr(Index)+'].setClickable(true);')
  else
    (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<allmarkers.length) allmarkers['+inttostr(Index)+'].setClickable(false);');
end;

procedure TMarker.SetDraggable(const Value: boolean);
begin
  FDraggable := Value;
  if Value then
    (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<allmarkers.length) allmarkers['+inttostr(Index)+'].setDraggable(true);')
  else
    (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<allmarkers.length) allmarkers['+inttostr(Index)+'].setDraggable(false);');
end;

procedure TMarker.SetFlat(const Value: boolean);
begin
  FFlat := Value;
  if Value then
    (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<allmarkers.length) allmarkers['+inttostr(Index)+'].setFlat(true);')
  else
    (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<allmarkers.length) allmarkers['+inttostr(Index)+'].setFlat(false);');
end;

procedure TMarker.SetIcon(const Value: String);
begin
  FIcon := Value;
end;

procedure TMarker.SetInitialDropAnimation(const Value: boolean);
begin
  FInitialDropAnimation := Value;
end;

procedure TMarker.SetLatitude(const Value: double);
var
  TextLat,TextLong:String;
begin
  FLatitude := Value;
  TextLat   := ConvertCoordinateToString(FLatitude);
  TextLong  := ConvertCoordinateToString(FLongitude);
  (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<allmarkers.length) allmarkers['+inttostr(Index)+'].setPosition(new google.maps.LatLng('+TextLat+','+TextLong+'));');
end;

procedure TMarker.SetLongitude(const Value: double);
var
  TextLat,TextLong:String;
begin
  FLongitude := Value;
  TextLat    := ConvertCoordinateToString(FLatitude);
  TextLong   := ConvertCoordinateToString(FLongitude);
  (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<allmarkers.length) allmarkers['+inttostr(Index)+'].setPosition(new google.maps.LatLng('+TextLat+','+TextLong+'));');
end;

procedure TMarker.SetMapLabel(const Value: TMapLabel);
begin
  FMapLabel := Value;
end;

procedure TMarker.SetTag(const Value: integer);
begin
  FTag := Value;
end;

procedure TMarker.SetTitle(const Value: String);
begin
  FTitle := Value;
  (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<allmarkers.length) allmarkers['+inttostr(Index)+'].setTitle("' + StringReplace(value, '"', '\"', [rfReplaceAll]) + '");');
end;

procedure TMarker.SetVisible(const Value: boolean);
begin
  FVisible := Value;
  if Value then
  begin
    (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<allmarkers.length) allmarkers['+inttostr(Index)+'].setVisible(true);');
    (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<alllabels.length) alllabels['+inttostr(Index)+'].show();');
  end
  else
  begin
    (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<allmarkers.length) allmarkers['+inttostr(Index)+'].setVisible(false);');
    (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<alllabels.length) alllabels['+inttostr(Index)+'].hide();');
  end;
end;

procedure TMarker.SetZindex(const Value: integer);
begin
  FZindex := Value;
  (FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript('if ('+inttostr(Index)+'<allmarkers.length) allmarkers['+inttostr(Index)+'].setZIndex('+inttostr(Value)+');');
end;

{ TMarkers }

function TMarkers.Add(Latitude, Longitude: Double; Title, Icon: string;
  Draggable, Visible, Clickable, Flat, InitialDropAnimation: Boolean; Zindex: Integer): TMarker;
begin
  Result                       := TMarker(inherited Add);
  Result.FLatitude             := Latitude;
  Result.FLongitude            := Longitude;
  Result.FTitle                := Title;
  Result.FIcon                 := Icon;
  Result.FDraggable            := Draggable;
  Result.FClickable            := Clickable;
  Result.FFlat                 := Flat;
  Result.FInitialDropAnimation := InitialDropAnimation;
  Result.FVisible              := Visible;
  Result.FZindex               := zIndex;
  Result.Changed(False);
end;

function TMarkers.Add(Latitude, Longitude: Double; Title: string): TMarker;
begin
  Result := Add(Latitude, Longitude, Title, '', false, true, true, false, false, 0);
end;

function TMarkers.Add: TMarker;
begin
  Result := TMarker(inherited Add);
end;

function TMarkers.Bounds: TBounds;
var
  maxlat,minlat: double;
  maxlon,minlon: double;
  i: integer;
begin
  maxlat := -180;
  maxlon := -90;
  minlat := +180;
  minlon := +90;

  for i := 0 to Count - 1 do
  begin
    if Items[i].Longitude < minlon then
      minlon := Items[i].Longitude;

    if Items[i].Latitude < minlat then
      minlat := Items[i].Latitude;

    if Items[i].Longitude > maxlon then
      maxlon := Items[i].Longitude;

    if Items[i].Latitude > maxlat then
      maxlat := Items[i].Latitude;
  end;

  if (maxlat = -180) then
    maxlat := 180;

  if (maxlon = -90) then
    maxlat := 90;

  if (minlat = 180) then
    minlat := -180;

  if (minlon = 90) then
    minlon := -90;

  Result := TBounds.Create;
  Result.NorthEast.Latitude := maxlat;
  Result.NorthEast.Longitude := maxlon;

  Result.SouthWest.Latitude := minlat;
  Result.SouthWest.Longitude := minlon;
end;

constructor TMarkers.Create(AWebGMaps : TTMSFMXWebGMapsWebBrowser);
begin
  inherited Create(TMarker);
  FWebGMaps:=AWebGMaps;
end;

function TMarkers.GetItem(Index: integer): TMarker;
begin
  Result := TMarker(inherited GetItem(Index));
end;

procedure TMarkers.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
var
  Marker:TMarker;
begin
  inherited;
//  if (Action=cnDeleting) or (Action=cnExtracting) then
//Fix DeleteMapMarker was triggered twice when using WebGMaps1.Markers.Delete(Index);
  if (Action=cnExtracting) then
  begin
    if item<>nil then
    begin
      Marker:=(Item as TMarker);
      (Marker.FWebGmaps as TTMSFMXWebGMaps).DeleteMapMarker(Marker.index);
    end;
  end;
end;

function TMarkers.GetOwner: TPersistent;
begin
  Result := FWebGMaps;
end;

procedure TMarkers.SetItem(Index: integer; Value: TMarker);
begin
  inherited SetItem(Index, Value);
end;

procedure TMarkers.Update(Item: TCollectionItem);
var
  Marker:TMarker;
begin
  inherited;
  if Item<>nil then
  begin
    Marker:=(Item as TMarker);
    (FWebGmaps as TTMSFMXWebGMaps).CreateMapMarker(Marker);
  end;
end;

{ TMapLabel }

procedure TMapLabel.Assign(Source: TPersistent);
var
  FSource : TMapLabel;
begin
  if (Source is TMapLabel) then
  begin
    FSource := TMapLabel(Source);
    FText := FSource.FText;
    FColor := FSource.Color;
    FBorderColor := FSource.BorderColor;
    FMargin := FSource.FMargin;
    FFont.Assign(FSource.FFont);
//    Changed(True);
  end;
end;

constructor TMapLabel.Create(CollectionItem: TCollectionItem);
begin
  FOwner := TMarker(CollectionItem);
  FText := '';
  FColor := TAlphaColorRec.White;
  FBorderColor := TAlphaColorRec.Black;
  FMargin := 2;
  FFont := TFont.Create;
  FFont.Family := 'Arial';
  FFont.Size := 12;
  FFontColor := TAlphaColorRec.Black;
end;

destructor TMapLabel.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TMapLabel.SetBorderColor(const Value: TAlphaColor);
begin
  FBorderColor := Value;
end;

procedure TMapLabel.SetColor(const Value: TAlphaColor);
begin
  FColor := Value;
end;

procedure TMapLabel.SetFont(const Value: TFont);
begin
  FFont := Value;
end;

procedure TMapLabel.SetFontColor(const Value: TAlphaColor);
begin
  FFontColor := Value;
end;

procedure TMapLabel.SetOwner(const Value: TCollectionItem);
begin
  FOwner := Value;
end;

procedure TMapLabel.SetText(const Value: string);
var
  js: string;
begin
  FText := Value;
  if Value = EmptyStr then
    js := 'alllabels['+inttostr(FOwner.Index)+'].hide();'
  else
    js := 'alllabels['+inttostr(FOwner.Index)+'].show();';

  js := 'if ('+inttostr(FOwner.Index)+'<alllabels.length) { ' + js + ' alllabels['+inttostr(FOwner.Index)+'].setText("' + StringReplace(value, '"', '&quote;', [rfReplaceAll]) + '"); }';
 (TMarker(FOwner).FWebGmaps as TTMSFMXWebGMapsWebBrowser).ExecuteJavascript(js);
end;

end.
