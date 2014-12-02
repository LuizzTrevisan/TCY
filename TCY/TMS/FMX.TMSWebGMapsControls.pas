{***************************************************************************)
{ TMS FMX WebGMaps component                                                }
{ for Delphi                                                                }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2013                                               }
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

unit FMX.TMSWebGMapsControls;

interface

uses
  SysUtils, Classes, Types, FMX.TMSWebGMapsCommon, StrUtils,
  FMX.TMSWebGMapsConst, FMX.TMSWebGMapsWebBrowser;

type
  TPanControl = class(TPersistent)
  private
    FPosition: TControlPosition;
    FVisible: Boolean;
    FWebGmaps: TTMSFMXWebGMapsWebBrowser;
    procedure SetPosition(const Value: TControlPosition);
    procedure SetVisible(const Value: Boolean);
  protected
  public
    constructor Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
  published
    property Position : TControlPosition read FPosition write SetPosition default cpTopLeft;
    property Visible : Boolean read FVisible write SetVisible default false;
  end;

  TZoomControl = class(TPersistent)
  private
    FPosition: TControlPosition;
    FVisible: Boolean;
    FWebGmaps: TTMSFMXWebGMapsWebBrowser;
    FStyle: TZoomStyle;
    procedure SetPosition(const Value: TControlPosition);
    procedure SetVisible(const Value: Boolean);
    procedure SetStyle(const Value: TZoomStyle);
  protected
  public
    constructor Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
  published
    property Position : TControlPosition read FPosition write SetPosition default cpLeftBottom;
    property Style : TZoomStyle read FStyle write SetStyle default zsSmall;
    property Visible : Boolean read FVisible write SetVisible default true;
  end;

  TMapTypeControl = class(TPersistent)
  private
    FWebGmaps: TTMSFMXWebGMapsWebBrowser;
    FVisible: Boolean;
    FStyle: TMapTypeStyle;
    FPosition: TControlPosition;
    procedure SetPosition(const Value: TControlPosition);
    procedure SetStyle(const Value: TMapTypeStyle);
    procedure SetVisible(const Value: Boolean);
  protected
  public
    constructor Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
  published
    property Position : TControlPosition read FPosition write SetPosition default cpTopRight;
    property Style : TMapTypeStyle read FStyle write SetStyle default mtsDefault;
    property Visible : Boolean read FVisible write SetVisible default true;
  end;

  TScaleControl = class(TPersistent)
  private
    FWebGmaps: TTMSFMXWebGMapsWebBrowser;
    FVisible: Boolean;
    FPosition: TControlPosition;
    procedure SetPosition(const Value: TControlPosition);
    procedure SetVisible(const Value: Boolean);
  protected
  public
    constructor Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
  published
    property Position : TControlPosition read FPosition write SetPosition default cpBottomLeft;
    property Visible : Boolean read FVisible write SetVisible default true;
  end;

  TStreetViewControl = class(TPersistent)
  private
    FWebGmaps: TTMSFMXWebGMapsWebBrowser;
    FVisible: Boolean;
    FPosition: TControlPosition;
    procedure SetPosition(const Value: TControlPosition);
    procedure SetVisible(const Value: Boolean);
  protected
  public
    constructor Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
  published
    property Position : TControlPosition read FPosition write SetPosition default cpTopLeft;
    property Visible : Boolean read FVisible write SetVisible default true;
  end;

  TOverviewMapControl = class(TPersistent)
  private
    FWebGmaps: TTMSFMXWebGMapsWebBrowser;
    FOpen: Boolean;
    FVisible: Boolean;
    procedure SetOpen(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
  protected
  public
    constructor Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
  published
    property Visible : Boolean read FVisible write SetVisible default true;
    property Open : Boolean read FOpen write SetOpen default false;
  end;

  TControlsOptions = class(TPersistent)
  private
    FWebGmaps: TTMSFMXWebGMapsWebBrowser;
    FControlsType: TControlsType;
    FOverviewMapControl: TOverviewMapControl;
    FScaleControl: TScaleControl;
    FZoomControl: TZoomControl;
    FMapTypeControl: TMapTypeControl;
    FPanControl: TPanControl;
    FStreetViewControl: TStreetViewControl;
    procedure SetControlsType(const Value: TControlsType);
    procedure SetMapTypeControl(const Value: TMapTypeControl);
    procedure SetOverviewMapControl(const Value: TOverviewMapControl);
    procedure SetPanControl(const Value: TPanControl);
    procedure SetScaleControl(const Value: TScaleControl);
    procedure SetStreetViewControl(const Value: TStreetViewControl);
    procedure SetZoomControl(const Value: TZoomControl);
  protected
  public
    constructor Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
    destructor Destroy; override;
  published
    property ControlsType : TControlsType read FControlsType write SetControlsType default ctSmall;
    property PanControl : TPanControl read FPanControl write SetPanControl;
    property ZoomControl : TZoomControl read FZoomControl write SetZoomControl;
    property MapTypeControl : TMapTypeControl read FMapTypeControl write SetMapTypeControl;
    property ScaleControl : TScaleControl read FScaleControl write SetScaleControl;
    property StreetViewControl : TStreetViewControl read FStreetViewControl write SetStreetViewControl;
    property OverviewMapControl : TOverviewMapControl read FOverviewMapControl write SetOverviewMapControl;
  end;


implementation

uses
  FMX.TMSWebGMaps;

{ TPanControl }

constructor TPanControl.Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
begin
  inherited Create;
  FWebGmaps  := AWebGmaps;
  FVisible   := False;
  FPosition  := cpTopLeft;
end;

procedure TPanControl.SetPosition(const Value: TControlPosition);
var
  Script:String;
begin
  FPosition:=Value;
  Script:='map.setOptions( {' +
          '  panControlOptions: {' +
          '    position: google.maps.ControlPosition.'+CONTROL_POSITION_TEXT+
          '  }'+
          '} );';
  Script:=ReplaceTextControlPosition(Script,CONTROL_POSITION_TEXT,Value);
  (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript(Script);
end;

procedure TPanControl.SetVisible(const Value: Boolean);
begin
  FVisible:=Value;
  if Value then
    (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript('map.setOptions( {panControl:true} );')
  else
    (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript('map.setOptions( {panControl:false} );');
end;

{ TZoomControl }

constructor TZoomControl.Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
begin
  inherited Create;
  FWebGmaps  := AWebGmaps;
  FVisible   := True;
  FPosition  := cpLeftBottom;
  FStyle     := zsSmall;
end;

procedure TZoomControl.SetPosition(const Value: TControlPosition);
var
  Script:String;
begin
  FPosition:=Value;
  Script:='map.setOptions( {' +
          '  zoomControlOptions: {' +
          '    position: google.maps.ControlPosition.'+CONTROL_POSITION_TEXT+
          '  }'+
          '} );';
  Script:=ReplaceTextControlPosition(Script,CONTROL_POSITION_TEXT,Value);
  (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript(Script);
end;

procedure TZoomControl.SetStyle(const Value: TZoomStyle);
var
  Script:String;
begin
  FStyle := Value;
  Script:='map.setOptions( {' +
          '  zoomControlOptions: {' +
          '    style: google.maps.ZoomControlStyle.%style%' +
          '  }'+
          '} );';
  case value of
    zsDefault:
      begin
        Script:=ReplaceText(Script,'%style%',ZOOM_DEFAULT);
      end;
    zsSmall:
      begin
        Script:=ReplaceText(Script,'%style%',ZOOM_SMALL);
      end;
    zsLarge:
      begin
        Script:=ReplaceText(Script,'%style%',ZOOM_LARGE);
      end;
  end;
  (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript(Script);
end;

procedure TZoomControl.SetVisible(const Value: Boolean);
begin
  FVisible:=Value;
  if Value then
    (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript('map.setOptions( {zoomControl:true} );')
  else
    (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript('map.setOptions( {zoomControl:false} );');
end;

{ TMapTypeControl }

constructor TMapTypeControl.Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
begin
  inherited Create;
  FWebGmaps  := AWebGmaps;
  FVisible   := True;
  FPosition  := cpTopRight;
  FStyle     := mtsDefault;
end;

procedure TMapTypeControl.SetPosition(const Value: TControlPosition);
var
  Script:String;
begin
  FPosition := Value;
  Script:='map.setOptions( {' +
          '  mapTypeControlOptions: {' +
          '    position: google.maps.ControlPosition.'+CONTROL_POSITION_TEXT+
          '  }'+
          '} );';
  Script:=ReplaceTextControlPosition(Script,CONTROL_POSITION_TEXT,Value);
  (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript(Script);
end;

procedure TMapTypeControl.SetStyle(const Value: TMapTypeStyle);
var
  Script:String;
begin
  FStyle := Value;
  Script:='map.setOptions( {' +
          '  mapTypeControlOptions: {' +
          '    style: google.maps.MapTypeControlStyle.%style%' +
          '  }'+
          '} );';
  case value of
    mtsDefault:
      begin
        Script:=ReplaceText(Script,'%style%',MAPTYPE_DEFAULT);
      end;
    mtsDropDownMenu:
      begin
        Script:=ReplaceText(Script,'%style%',MAPTYPE_DROPDOWNMENU);
      end;
    mtsHorizontalBar:
      begin
        Script:=ReplaceText(Script,'%style%',MAPTYPE_HORIZONTALBAR);
      end;
  end;
  (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript(Script);
end;

procedure TMapTypeControl.SetVisible(const Value: Boolean);
begin
  FVisible:=Value;
  if Value then
    (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript('map.setOptions( {mapTypeControl:true} );')
  else
    (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript('map.setOptions( {mapTypeControl:false} );');
end;

{ TScaleControl }

constructor TScaleControl.Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
begin
  inherited Create;
  FWebGmaps  := AWebGmaps;
  FVisible   := True;
  FPosition  := cpBottomLeft;
end;

procedure TScaleControl.SetPosition(const Value: TControlPosition);
var
  Script:String;
begin
  FPosition := Value;
  Script:='map.setOptions( {' +
          '  scaleControlOptions: {' +
          '    position: google.maps.ControlPosition.'+CONTROL_POSITION_TEXT+
          '  }'+
          '} );';
  Script:=ReplaceTextControlPosition(Script,CONTROL_POSITION_TEXT,Value);
  (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript(Script);
end;

procedure TScaleControl.SetVisible(const Value: Boolean);
begin
  FVisible:=Value;
  if Value then
    (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript('map.setOptions( {scaleControl:true} );')
  else
    (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript('map.setOptions( {scaleControl:false} );');
end;

{ TStreetViewControl }

constructor TStreetViewControl.Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
begin
  inherited Create;
  FWebGmaps  := AWebGmaps;
  FVisible   := True;
  FPosition  := cpTopLeft;
end;

procedure TStreetViewControl.SetPosition(const Value: TControlPosition);
var
  Script:String;
begin
  FPosition := Value;
  Script:='map.setOptions( {' +
          '  streetViewControlOptions: {' +
          '    position: google.maps.ControlPosition.'+CONTROL_POSITION_TEXT+
          '  }'+
          '} );';
  Script:=ReplaceTextControlPosition(Script,CONTROL_POSITION_TEXT,Value);
  (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript(Script);
end;

procedure TStreetViewControl.SetVisible(const Value: Boolean);
begin
  FVisible:=Value;
  if Value then
    (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript('map.setOptions( {streetViewControl:true} );')
  else
    (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript('map.setOptions( {streetViewControl:false} );');
end;

{ TOverviewMapControl }

constructor TOverviewMapControl.Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
begin
  inherited Create;
  FWebGmaps  := AWebGmaps;
  FVisible   := True;
  FOpen      := False;
end;

procedure TOverviewMapControl.SetOpen(const Value: Boolean);
var
  Script:String;
begin
  FOpen := Value;
  Script:='map.setOptions( {' +
          '  overviewMapControlOptions: {' +
          '    opened: %opened%' +
          '  }'+
          '} );';
  if Value then
    Script:=ReplaceText(Script,'%opened%','true')
  else
    Script:=ReplaceText(Script,'%opened%','false');
  (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript(Script);
end;

procedure TOverviewMapControl.SetVisible(const Value: Boolean);
begin
  FVisible:=Value;
  if Value then
    (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript('map.setOptions( {overviewMapControl:true} );')
  else
    (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript('map.setOptions( {overviewMapControl:false} );');
end;

{ TControlsOptions }

constructor TControlsOptions.Create(AWebGmaps: TTMSFMXWebGMapsWebBrowser);
begin
  inherited Create;
  FWebGmaps             := AWebGmaps;
  FControlsType         := ctSmall;
  FPanControl           := TPanControl.Create(AWebGmaps);
  FZoomControl          := TZoomControl.Create(AWebGmaps);
  FMapTypeControl       := TMapTypeControl.Create(AWebGmaps);
  FScaleControl         := TScaleControl.Create(AWebGmaps);
  FStreetViewControl    := TStreetViewControl.Create(AWebGmaps);
  FOverviewMapControl   := TOverviewMapControl.Create(AWebGmaps);
end;

destructor TControlsOptions.Destroy;
begin
  FreeAndNil(FOverviewMapControl);
  FreeAndNil(FStreetViewControl);
  FreeAndNil(FScaleControl);
  FreeAndNil(FMapTypeControl);
  FreeAndNil(FZoomControl);
  FreeAndNil(FPanControl);
  inherited Destroy;
end;

procedure TControlsOptions.SetControlsType(const Value: TControlsType);
var
  Script:String;
begin
  FControlsType := Value;
  Script:='map.setOptions( {' +
          '  navigationControlOptions: {' +
          '    style: google.maps.NavigationControlStyle.%controlstype%' +
          '  }'+
          '} );';
  case Value of
    ctDefault:
      begin
        Script := ReplaceText(Script,'%controlstype%',CONTROL_DEFAULT);
      end;
    ctAndroid:
      begin
        Script := ReplaceText(Script,'%controlstype%',CONTROL_ANDROID);
      end;
    ctSmall:
      begin
        Script := ReplaceText(Script,'%controlstype%',CONTROL_SMALL);
      end;
    ctZoomPan:
      begin
        Script := ReplaceText(Script,'%controlstype%',CONTROL_ZOOMPAN);
      end;
  end;
  (FWebGmaps as TTMSFMXWebGMaps).ExecuteJavascript(Script);
end;

procedure TControlsOptions.SetMapTypeControl(const Value: TMapTypeControl);
begin
  FMapTypeControl := Value;
end;

procedure TControlsOptions.SetOverviewMapControl(
  const Value: TOverviewMapControl);
begin
  FOverviewMapControl := Value;
end;

procedure TControlsOptions.SetPanControl(const Value: TPanControl);
begin
  FPanControl := Value;
end;

procedure TControlsOptions.SetScaleControl(const Value: TScaleControl);
begin
  FScaleControl := Value;
end;

procedure TControlsOptions.SetStreetViewControl(
  const Value: TStreetViewControl);
begin
  FStreetViewControl := Value;
end;

procedure TControlsOptions.SetZoomControl(const Value: TZoomControl);
begin
  FZoomControl := Value;
end;

end.

