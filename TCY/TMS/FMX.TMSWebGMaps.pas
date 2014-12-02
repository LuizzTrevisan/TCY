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

unit FMX.TMSWebGMaps;

{$I TMSDEFS.INC}

interface

uses
  Classes, FMX.TMSWebGMapsWebBrowser, FMX.TMSWebGMapsConst, StrUtils,
  SysUtils, Variants, TypInfo, FMX.Forms, FMX.Dialogs, FMX.TMSWebGMapsWebKit, FMX.Types, FMX.Objects, FMX.Controls,
  FMX.TMSWebGMapsCommon, FMX.TMSWebGMapsControls, FMX.TMSWebGMapsCommonFunctions, FMX.TMSWebGMapsPolygons,
  FMX.TMSWebGMapsPolylines, FMX.TMSWebGMapsMarkers, FMX.TMSWebGMapsDirections, UITypes, Types, DBXJson
  {$IFDEF MACOS}
  ,MacApi.CoreFoundation
    {$IFDEF IOS}
   ,iOSapi.Foundation, iOSApi.UIKit, Macapi.ObjectiveC
    {$ELSE}
   ,MacApi.Foundation, MacApi.CocoaTypes, MacApi.AppKit, Macapi.ObjectiveC
    {$ENDIF}
  {$ENDIF}

  {$IFDEF DELPHIXE6_LVL}
  ,JSON
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 9; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 1; // Build nr.

  // version history
  // v1.0.0.0 : First release
  // v1.5.0.0 : New : XE5 support
  //            New : Mac OSX support
  //            New : Public property APIKey
  //            New : Function Distance() added
  //            New : Procedure GetDirections() overload to use coordinates instead of string values as origin/destination
  //            Improved : Code optimisations
  // v1.6.0.0 : New : Android support
  // v1.6.0.1 : Fixed : Issue with Parent and Visibility
  // v1.6.0.2 : Fixed : Issue with click detection when visible is false on Android
  //          : Fixed : Issue with statusbar height offset on iOS
  // v1.6.0.3 : Fixed : Issue with parsing marker Javascript 
  // v1.6.0.4 : Improved : Published Visible property
  // v1.6.0.5 : Improved : Enabled and Visible property behavior
  // v1.8.0.0 : New : Windows 32 bit support
  // v1.8.0.1 : Fixed : Issue with Android Visibility
  // v1.8.0.2 : Fixed : Issue with Android backbutton and iOS positioning
  // v1.8.0.3 : Improved : Allow interception of URL redirection, blocking navigation
  // v1.9.0.0 : New : function DegreesToLonLat() added
  //          :	New : Directions extended with WayPoints, avoid Tolls/Highways
  //          : New : OnStreetViewChange() event
  //          : New : WebGMaps.Markers.Bounds to retrieve outer bounds of markers
  //          : New : WebGMaps.PolyLines.Bounds to retrieve outer bounds of all poly lines
  //          : New : WebGMaps.PolyLines[].Paths[].PathBounds to retrieve outer bounds of a single polyline
  //          : New : WebGMaps.Polygon.Bounds to retrieve outer bounds of all polygons
  //          : New : WebGMaps.Polygon[].Paths[].PathBounds to retrieve outer bounds of a single polygon
  //          : New : RenderDirections overload added with long/lat parameters
  //          : New : KML Layer support: AddMapKMLLayer, DeleteMapKMLLayer, DeleteMapAllKMLLayer functions and OnKMLLayerClick event added
  //          : New : MapOptions.DisablePOI to disable the display of points of interest icons on the map
  //          : Improved : Polygons and Polylines are automatically displayed when added via the Object Inspector
  //   	      : Improved : In OpenMarkerInfoWindowHTML double quotes are now accepted
  //          : Improved : Trial version compiled in release mode
  // v1.9.0.1 : Fixed : Issue parsing javascript when navigating to streetview from POI


type
  TWebGMapsErrorEvent = procedure(Sender: TObject; ErrorType:TErrorType) of object;
  TMapTypeChange      = procedure(Sender: TObject; NewMapType:TMapType) of object;
  TGMapsError            = procedure(Sender: TObject; ErrorType:TErrorType) of object;
  TEventMarker           = procedure(Sender: TObject; MarkerTitle:String; IdMarker:Integer; Latitude,Longitude:Double) of object;
  TEventMarkerClick      = procedure(Sender: TObject; MarkerTitle:String; IdMarker:Integer; Latitude,Longitude:Double) of object;
  TEventKMLLayer         = procedure(Sender: TObject; ObjectName:String; IdLayer:Integer; Latitude,Longitude:Double) of object;
  TEventPolyline         = procedure(Sender: TObject; IdPolyline:Integer) of object;
  TEventPolylineClick    = procedure(Sender: TObject; IdPolyline:Integer) of object;
  TEventPolygon          = procedure(Sender: TObject; IdPolygon:Integer) of object;
  TEventPolygonClick     = procedure(Sender: TObject; IdPolygon:Integer) of object;
  TEventBounds           = procedure(Sender: TObject; Bounds: TBounds) of object;
  TEventInfoWindow       = procedure(Sender: TObject; IdMarker:Integer) of object;
  TPositionMap           = procedure(Sender: TObject; Latitude,Longitude:Double;X,Y:Integer) of object;
  TPositionMouseMap      = procedure(Sender: TObject; Latitude,Longitude:Double;X,Y:Integer) of object;
  TMapZoomChange         = procedure(Sender: TObject; NewLevel:Integer) of object;
  TExternalMapTypeChange = procedure(Sender: TObject; NewMapType:Integer) of object;
  TStreetViewChange      = procedure(Sender: TObject; Heading,Pitch,Zoom:Integer) of object;

  TTMSFMXWebGMaps = class;

  TStreetViewOptions = class(TPersistent)
  private
    FDefaultLongitude: Double;
    FPitch: TPitchStreetView;
    FDefaultLatitude: Double;
    FHeading: THeadingStreetView;
    FZoom: TZoomStreetView;
    FWebGmaps: TTMSFMXWebGMaps;
    FVisible: Boolean;
    procedure InitStreetView;
    procedure SetDefaultLatitude(const Value: Double);
    procedure SetDefaultLongitude(const Value: Double);
    procedure SetHeading(const Value: THeadingStreetView);
    procedure SetPitch(const Value: TPitchStreetView);
    procedure SetZoom(const Value: TZoomStreetView);
    procedure SetVisible(const Value: Boolean);
  protected
  public
    constructor Create(AWebGmaps: TTMSFMXWebGMaps);
    procedure Assign(Source: TPersistent); override;
  published
    property DefaultLatitude : Double read FDefaultLatitude write SetDefaultLatitude;
    property DefaultLongitude : Double read FDefaultLongitude write SetDefaultLongitude;
    property Heading : THeadingStreetView read FHeading write SetHeading default 0;
    property Pitch : TPitchStreetView read FPitch write SetPitch default 0;
    property Zoom : TZoomStreetView read FZoom write SetZoom default 0;
    property Visible : Boolean read FVisible write SetVisible default false;
  end;

  TMapOptions = class(TPersistent)
  private
    FDraggable: Boolean;
    FDefaultLongitude: Double;
    FPreloaderVisible: Boolean;
    FDefaultLatitude: Double;
    FZoomMap: TZoomMap;
    FMapType: TMapType;
    FWebGmaps: TTMSFMXWebGMaps;
    FDisableControls: Boolean;
    FShowTraffic: Boolean;
    FLanguage: TLanguageName;
    FShowBicycling: Boolean;
    FShowPanoramio: Boolean;
    FShowCloud: Boolean;
    FShowWeather: Boolean;
    FDisablePOI: Boolean;
    procedure SetDraggable(const Value: Boolean);
    procedure SetDefaultLatitude(const Value: Double);
    procedure SetDefaultLongitude(const Value: Double);
    procedure SetMapType(const Value: TMapType);
    procedure SetPreloaderVisible(const Value: Boolean);
    procedure SetZoomMap(const Value: TZoomMap);
    procedure SetDisableControls(const Value: Boolean);
    procedure SetShowTraffic(const Value: Boolean);
    procedure SetLanguage(const Value: TLanguageName);
    procedure SetShowBicycling(const Value: Boolean);
    procedure SetShowPanoramio(const Value: Boolean);
    procedure SetShowCloud(const Value: Boolean);
    procedure SetShowWeather(const Value: Boolean);
    procedure SetDisablePOI(const Value: Boolean);
  protected
  public
    constructor Create(AWebGmaps: TTMSFMXWebGMaps);
  published
    property Language : TLanguageName read FLanguage write SetLanguage default lnDefault;
    property Draggable : Boolean read FDraggable write SetDraggable default true;
    property ZoomMap : TZoomMap read FZoomMap write SetZoomMap default DEFAULT_ZOOM;
    property MapType : TMapType read FMapType write SetMapType default mtDefault;
    property DefaultLatitude : Double read FDefaultLatitude write SetDefaultLatitude;
    property DefaultLongitude : Double read FDefaultLongitude write SetDefaultLongitude;
    property PreloaderVisible : Boolean read FPreloaderVisible write SetPreloaderVisible default true;
    property ShowTraffic : Boolean read FShowTraffic write SetShowTraffic default false;
    property ShowBicycling : Boolean read FShowBicycling write SetShowBicycling default false;
    property ShowPanoramio : Boolean read FShowPanoramio write SetShowPanoramio default false;
    property ShowCloud : Boolean read FShowCloud write SetShowCloud default false;
    property ShowWeather : Boolean read FShowWeather write SetShowWeather default false;
    property DisableControls : Boolean read FDisableControls write SetDisableControls default false;
    property DisablePOI : Boolean read FDisablePOI write SetDisablePOI default false;
  end;

  TWeatherOptions = class(TPersistent)
  private
    FWindSpeedUnit: TWeatherWindSpeed;
    FShowInfoWindows: Boolean;
    FLabelColor: TWeatherLabelColor;
    FTemperatureUnit: TWeatherTemperatures;
    FWebGmaps: TTMSFMXWebGMaps;
    procedure SetLabelColor(const Value: TWeatherLabelColor);
    procedure SetShowInfoWindows(const Value: Boolean);
    procedure SetTemperatureUnit(const Value: TWeatherTemperatures);
    procedure SetWindSpeedUnit(const Value: TWeatherWindSpeed);
  protected
  public
    constructor Create(AWebGmaps: TTMSFMXWebGMaps);
  published
    property TemperatureUnit : TWeatherTemperatures read FTemperatureUnit write SetTemperatureUnit default wtCelsius;
    property LabelColor : TWeatherLabelColor read FLabelColor write SetLabelColor default wlcBlack;
    property WindSpeedUnit : TWeatherWindSpeed read FWindSpeedUnit write SetWindSpeedUnit default wwsKilometersPerHour;
    property ShowInfoWindows : Boolean read FShowInfoWindows write SetShowInfoWindows default true;
  end;

  TJSEventParameter = record
    parameter: String;
    value: String;
  end;

  TJSEventParameters = array of TJSEventParameter;

  [ComponentPlatformsAttribute(pidWin32 or pidiOSSimulator or pidiOSDevice or pidOSX32 or pidAndroid)]
  TTMSFMXWebGMaps = class(TTMSFMXWebGMapsWebBrowser)
  private
    bLaunchFinish: Boolean;
    FPolylines: TPolylines;
    FMarkers: TMarkers;
    FControlsOptions: TControlsOptions;
    FPolygons: TPolygons;
    FMapOptions: TMapOptions;
    FStreetViewOptions: TStreetViewOptions;
    FWeatherOptions: TWeatherOptions;
    FAPIKey: string;

    FOnWebGMapsError: TWebGMapsErrorEvent;
    CompleteHtmlFile: String;
    FOnDownloadFinish: TNotifyEvent;
    FOnMarkerClick: TEventMarkerClick;
    FOnKMLLayerClick: TEventKMLLayer;
    FOnMapClick: TPositionMouseMap;
    FOnMapMoveStart: TPositionMap;
    FOnMapMoveEnd: TPositionMap;
    FOnMapZoomChange: TMapZoomChange;
    FOnMarkerDragStart: TEventMarker;
    FOnMarkerDragEnd: TEventMarker;
    FOnMapTypeChange: TMapTypeChange;
    FOnMapDblClick: TPositionMap;
    FOnMapMove: TPositionMap;
    FOnMapIdle: TNotifyEvent;
    FOnMarkerInfoWindowCloseClick: TEventInfoWindow;
    FOnMarkerDblClick: TEventMarker;
    FOnMarkerDrag: TEventMarker;
    FOnStreetViewMove: TPositionMap;
    FOnStreetViewChange: TStreetViewChange;
    FOnPolylineClick: TEventPolylineClick;
    FOnPolylineDblClick: TEventPolyline;
    FOnPolygonClick: TEventPolygonClick;
    FOnPolygonDblClick: TEventPolygon;
    FOnBoundsRetrieved: TEventBounds;
    FDirections: TDirections;

    function GetVersionNr: Integer; virtual;
    function MapPolylineToJS(Polyline: TPolyline; IsUpdate: Boolean): Boolean;
    function MapPolygonToJS(Polygon: TMapPolygon; IsUpdate: Boolean): Boolean;
    function GetVersion: string;
    procedure SetControlsOptions(const Value: TControlsOptions);
    procedure SetMarkers(const Value: TMarkers);
    procedure SetPolygons(const Value: TPolygons);
    procedure SetPolylines(const Value: TPolylines);
    procedure SetVersion(const Value: string);
    procedure SetMapOptions(const Value: TMapOptions);
    procedure SetStreetViewOptions(const Value: TStreetViewOptions);
    procedure SetWeatherOptions(const Value: TWeatherOptions);
    procedure SetDirections(const Value: TDirections);
  protected
    procedure OnProgressChange(Sender: TObject; Progress: Integer; ProgressMax: Integer);
    procedure MarkerClick(Sender: TObject; MarkerTitle:String; IdMarker:Integer; Latitude,Longitude:Double);
    procedure KMLLayerClick(Sender: TObject; ObjectName:String; IdLayer:Integer; Latitude,Longitude:Double);
    procedure MarkerDblClick(Sender: TObject; MarkerTitle:String; IdMarker:Integer; Latitude,Longitude:Double);
    procedure MarkerInfoWindowCloseClick(Sender: TObject; IdMarker:Integer);
    procedure MarkerDragStart(Sender: TObject; MarkerTitle:String; IdMarker:Integer; Latitude,Longitude:Double);
    procedure MarkerDrag(Sender: TObject; MarkerTitle:String; IdMarker:Integer; Latitude,Longitude:Double);
    procedure MarkerDragEnd(Sender: TObject; MarkerTitle:String; IdMarker:Integer; Latitude,Longitude:Double);
    procedure PolylineClick(Sender: TObject; IdPolyline:Integer);
    procedure PolylineDblClick(Sender: TObject; IdPolyline:Integer);
    procedure PolygonClick(Sender: TObject; IdPolygon:Integer);
    procedure PolygonDblClick(Sender: TObject; IdPolygon:Integer);
    procedure BoundsRetrieved(Sender: TObject; Bounds: TBounds);
    procedure MapClick(Sender: TObject; Latitude,Longitude:Double;X,Y:Integer);
    procedure MapDblClick(Sender: TObject; Latitude,Longitude:Double;X,Y:Integer);
    procedure MapMoveStart(Sender: TObject; Latitude,Longitude:Double;X,Y:Integer);
    procedure MapMoveEnd(Sender: TObject; Latitude,Longitude:Double;X,Y:Integer);
    procedure MapMove(Sender: TObject; Latitude,Longitude:Double;X,Y:Integer);
    procedure StreetViewMove(Sender: TObject; Latitude,Longitude:Double;X,Y:Integer);
    procedure StreetViewChange(Sender: TObject; Heading,Pitch,Zoom:Integer);
    procedure MapTilesLoad(Sender: TObject);
    procedure MapIdle(Sender: TObject);
    procedure MapZoomChange(Sender: TObject; NewLevel:Integer);
    procedure MapTypeChange(Sender: TObject;NewMapType: Integer);
    procedure GMapsError(Sender: TObject;ErrorType:TErrorType);
    procedure BeforeNavigate(var Params: TTMSFMXWebGMapsCustomWebBrowserBeforeNavigateParams); override;
    function ParseForJSEvent(urlstr: String): Boolean;
  public
    function InitHtmlFile: string;
    property APIKey: string read FAPIKey write FAPIKey;
    destructor Destroy; override;
    constructor Create(AOwner:TComponent); override;
    procedure Assign(Source: TPersistent); override;
    function ExecuteJavascript(AScript: String): String; override;

    procedure Initialize; override;
    procedure GoToAddress(Address: String);
    procedure DoEvent(AEvent: String; AParameters: TJSEventParameters);

    function AddMapKMLLayer(Url: string; ZoomToBounds: boolean = true): boolean;
    function DeleteMapKMLLayer(Id:integer): boolean;
    function DeleteAllMapKMLLayer(): boolean;

    function DeleteAllMapMarker:Boolean;
    function CreateMapMarker(Marker:TMarker):Boolean;
    function DeleteMapMarker(Id:Integer):Boolean;
    function CreateMapPolyline(Polyline:TPolyline):Boolean;
    function UpdateMapPolyline(Polyline:TPolyline):Boolean;
    function DeleteMapPolyline(Id:Integer):Boolean;
    function DeleteAllMapPolyline:Boolean;
    function CreateMapPolygon(Polygon:TMapPolygon):Boolean;
    function UpdateMapPolygon(Polygon:TMapPolygon):Boolean;
    function DeleteMapPolygon(Id:Integer):Boolean;
    function DeleteAllMapPolygon:Boolean;
    function openMarkerInfoWindowHtml(Id:Integer; HtmlText:String):Boolean;
    function CloseMarkerInfoWindowHtml(Id:Integer):Boolean;
    function StartMarkerBounceAnimation(Id:Integer):Boolean;
    function StopMarkerBounceAnimation(Id:Integer):Boolean;
    function MapPanTo(Latitude,Longitude:Double):Boolean;
    function MapZoomTo(Bounds:TBounds):Boolean;
    function MapPanBy(X,Y:Integer):Boolean;
    function GetMapBounds: Boolean;
    function DegreesToLonLat(StrLon, StrLat: string; var Lon,Lat: double): boolean;
    function RenderDirections(Origin, Destination: string;
      TravelMode: TTravelMode = tmDriving; AvoidHighways: Boolean = false;
      AvoidTolls: Boolean = false; WayPoints: TStringList = nil;
      OptimizeWayPoints: Boolean = false): Boolean; overload;
    function RenderDirections(OriginLatitude, OriginLongitude,
      DestinationLatitude, DestinationLongitude: double;
      TravelMode: TTravelMode = tmDriving; AvoidHighways: Boolean = false;
      AvoidTolls: Boolean = false; WayPoints: TStringList = nil;
      OptimizeWayPoints: Boolean = false): Boolean; overload;
    function RemoveDirections(): Boolean;
    procedure GetDirections(Origin, Destination: string;
      Alternatives: Boolean = false; TravelMode: TTravelMode = tmDriving;
      Units: TUnits = usMetric; Language: TLanguageName = lnDefault;
      StripHTML: boolean = true;AvoidHighways: Boolean = false; AvoidTolls: Boolean = false;
      WayPoints: TStringList = nil; OptimizeWayPoints: Boolean = false); overload;
    procedure GetDirections(OriginLatitude, OriginLongitude,
      DestinationLatitude, DestinationLongitude: double;
      Alternatives: Boolean = false; TravelMode: TTravelMode = tmDriving;
      Units: TUnits = usMetric; Language: TLanguageName = lnDefault;
      StripHTML: boolean = true;AvoidHighways: Boolean = false; AvoidTolls: Boolean = false;
      WayPoints: TStringList = nil; OptimizeWayPoints: Boolean = false); overload;
    function Distance(la1, lo1, la2, lo2: double): double;
  published
    property Align;
    property Anchors;
    property Markers : TMarkers read FMarkers write SetMarkers;
    property Polylines : TPolylines read FPolylines write SetPolylines;
    property Polygons : TPolygons  read FPolygons write SetPolygons;
    property MapOptions : TMapOptions read FMapOptions write SetMapOptions;
    property Directions : TDirections read FDirections write SetDirections;
    property StreetViewOptions : TStreetViewOptions read FStreetViewOptions write SetStreetViewOptions;
    property ControlsOptions : TControlsOptions read FControlsOptions write SetControlsOptions;
    property TabOrder;
    property WeatherOptions : TWeatherOptions read FWeatherOptions write SetWeatherOptions;
    property Version: string read GetVersion write SetVersion;
    property OnWebGMapsError: TWebGMapsErrorEvent read FOnWebGMapsError write FOnWebGMapsError;
    property OnDownloadFinish: TNotifyEvent read FOnDownloadFinish write FOnDownloadFinish;
    property OnMapIdle: TNotifyEvent read FOnMapIdle write FOnMapIdle;
    property OnMarkerClick: TEventMarkerClick read FOnMarkerClick write FOnMarkerClick;
    property OnKMLLayerClick: TEventKMLLayer read FOnKMLLayerClick write FOnKMLLayerClick;
    property OnMarkerDblClick: TEventMarker read FOnMarkerDblClick write FOnMarkerDblClick;
    property OnMarkerInfoWindowCloseClick: TEventInfoWindow read FOnMarkerInfoWindowCloseClick write FOnMarkerInfoWindowCloseClick;
    property OnMarkerDragStart: TEventMarker read FOnMarkerDragStart write FOnMarkerDragStart;
    property OnMarkerDrag: TEventMarker read FOnMarkerDrag write FOnMarkerDrag;
    property OnMarkerDragEnd: TEventMarker read FOnMarkerDragEnd write FOnMarkerDragEnd;
    property OnPolylineClick: TEventPolylineClick read FOnPolylineClick write FOnPolylineClick;
    property OnPolylineDblClick: TEventPolyline read FOnPolylineDblClick write FOnPolylineDblClick;
    property OnPolygonClick: TEventPolygonClick read FOnPolygonClick write FOnPolygonClick;
    property OnPolygonDblClick: TEventPolygon read FOnPolygonDblClick write FOnPolygonDblClick;
    property OnBoundsRetrieved: TEventBounds read FOnBoundsRetrieved write FOnBoundsRetrieved;
    property OnMapClick: TPositionMouseMap read FOnMapClick write FOnMapClick;
    property OnMapDblClick: TPositionMap read FOnMapDblClick write FOnMapDblClick;
    property OnMapMoveStart: TPositionMap read FOnMapMoveStart write FOnMapMoveStart;
    property OnMapMoveEnd: TPositionMap read FOnMapMoveEnd write FOnMapMoveEnd;
    property OnMapMove: TPositionMap read FOnMapMove write FOnMapMove;
    property OnStreetViewMove: TPositionMap read FOnStreetViewMove write FOnStreetViewMove;
    property OnStreetViewChange: TStreetViewChange read FOnStreetViewChange write FOnStreetViewChange;
    property OnMapZoomChange: TMapZoomChange read FOnMapZoomChange write FOnMapZoomChange;
    property OnMapTypeChange: TMapTypeChange read FOnMapTypeChange write FOnMapTypeChange;
  end;

  function ReplaceTextControlPosition(Script:String; TextToReplace:String; Position:TControlPosition):String;

const
  HTMLStr: String =
'<html> '+
'<head> '+
'<meta name="viewport" content="initial-scale=1.0, user-scalable=yes" /> '+
'<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script> '+
'<script type="text/javascript"> '+
''+
''+
'  var geocoder; '+
'  var map;  '+
'  var trafficLayer;'+
'  var bikeLayer;'+
''+
''+
'  function initialize() { '+
'    geocoder = new google.maps.Geocoder();'+
'    var latlng = new google.maps.LatLng(40.714776,-74.019213); '+
'    var myOptions = { '+
'      zoom: 13, '+
'      center: latlng, '+
'      mapTypeId: google.maps.MapTypeId.ROADMAP '+
'    }; '+
'    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions); '+
'    google.maps.event.addListener(map, "click", '+
'         function(event) '+
'                        {'+
'                         window.location.href = "jsevent://addmarker:lat="+event.latLng.lat()+"#lang="+event.latLng.lng(); '+ //event
'                        } '+
'   ); '+
'    trafficLayer = new google.maps.TrafficLayer();'+
'    bikeLayer = new google.maps.BicyclingLayer();'+
'  } '+
''+
''+
'  function codeAddress(address) { '+
'    if (geocoder) {'+
'      geocoder.geocode( { address: address}, function(results, status) { '+
'        if (status == google.maps.GeocoderStatus.OK) {'+
'          map.setCenter(results[0].geometry.location);'+
'          var marker = new google.maps.Marker({'+
'              map: map,'+
'              position: results[0].geometry.location'+
'          });'+
'        } else {'+
'          alert("Geocode was not successful for the following reason: " + status);'+
'        }'+
'      });'+
'    }'+
'  }'+
''+
''+
'function ClearMarkers() {  '+
'  if (markersArray) {        '+
'    for (i in markersArray) {  '+
'      markersArray[i].setMap(null); '+
'    } '+
'  } '+
'}  '+
''+
''+
'  function PutMarker(Lat, Lang, Msg) { '+
'   var latlng = new google.maps.LatLng(Lat,Lang);'+
'   var marker = new google.maps.Marker({'+
'      position: latlng, '+
'      map: map,'+
'      title: Msg+" ("+Lat+","+Lang+")"'+
'  });'+

'                         window.location.href = "jsevent://addmarker:lat="+Lat+"#lang="+Lang; '+ //event

'  markersArray.push(marker); '+
'  index= (markersArray.length % 10);'+
'  if (index==0) { index=10 } '+
'  icon = "http://www.google.com/mapfiles/kml/paddle/"+index+"-lv.png"; '+
'  marker.setIcon(icon); '+
'  }'+
''+
''+
'  function GotoLatLng(Lat, Lang) { '+
'   var latlng = new google.maps.LatLng(Lat,Lang);'+
'   map.setCenter(latlng);'+
'  }'+
''+
''+
'  function TrafficOn()   { trafficLayer.setMap(map); }'+
''+
'  function TrafficOff()  { trafficLayer.setMap(null); }'+
''+''+
'  function BicyclingOn() { bikeLayer.setMap(map); }'+
''+
'  function BicyclingOff(){ bikeLayer.setMap(null);}'+
''+
'  function StreetViewOn() { map.set("streetViewControl", true); }'+
''+
'  function StreetViewOff() { map.set("streetViewControl", false); }'+
''+
''+'</script> '+
'</head> '+
'<body onload="initialize()"> '+
'  <div id="map_canvas" style="width:100%; height:100%"></div> '+
'  <div id="latlong"> '+
'  <input type="hidden" id="LatValue" >'+
'  <input type="hidden" id="LngValue" >'+
'  </div>  '+
''+
'</body> '+
'</html> ';

implementation

uses
  Math;

function ReplaceTextControlPosition(Script:String; TextToReplace:String; Position:TControlPosition):String;
begin
  case Position of
    cpTopRight:
      begin
        Result:= ReplaceText(Script,TextToReplace,POSITION_TOPRIGHT);
      end;
    cpTopLeft:
      begin
        Result:= ReplaceText(Script,TextToReplace,POSITION_TOPLEFT);
      end;
    cpTopCenter:
      begin
        Result:= ReplaceText(Script,TextToReplace,POSITION_TOPCENTER);
      end;
    cpBottomRight:
      begin
        Result:= ReplaceText(Script,TextToReplace,POSITION_BOTTOMRIGHT);
      end;
    cpBottomLeft:
      begin
        Result:= ReplaceText(Script,TextToReplace,POSITION_BOTTOMLEFT);
      end;
    cpBottomCenter:
      begin
        Result:= ReplaceText(Script,TextToReplace,POSITION_BOTTOMCENTER);
      end;
    cpLeftBottom:
      begin
        Result:= ReplaceText(Script,TextToReplace,POSITION_LEFTBOTTOM);
      end;
    cpLeftCenter:
      begin
        Result:= ReplaceText(Script,TextToReplace,POSITION_LEFTCENTER);
      end;
    cpLeftTop:
      begin
        Result:= ReplaceText(Script,TextToReplace,POSITION_LEFTTOP);
      end;
    cpRightBottom:
      begin
        Result:= ReplaceText(Script,TextToReplace,POSITION_RIGHTBOTTOM);
      end;
    cpRightCenter:
      begin
        Result:= ReplaceText(Script,TextToReplace,POSITION_RIGHTCENTER);
      end;
    cpRightTop:
      begin
        Result:= ReplaceText(Script,TextToReplace,POSITION_RIGHTTOP);
      end;
  end;
end;

{ TTMSFMXWebGMaps }

procedure TTMSFMXWebGMaps.GMapsError(Sender: TObject;ErrorType: TErrorType);
begin
  if Assigned(fOnWebGMapsError) then
    FOnWebGMapsError(Sender,ErrorType);
end;

procedure TTMSFMXWebGMaps.OnProgressChange(Sender: TObject; Progress, ProgressMax: Integer);
begin
end;

procedure TTMSFMXWebGMaps.MapTilesLoad(Sender: TObject);
var
  i: Integer;
begin
  if not(bLaunchFinish) then
  begin
    bLaunchFinish:=True;
    if Markers.Count>0 then
    begin
      for i := 0 to Markers.Count - 1 do
      begin
        CreateMapMarker(Markers[i]);
      end;
    end;
    if Polylines.Count>0 then
    begin
      for i := 0 to Polylines.Count - 1 do
      begin
        CreateMapPolyline(Polylines[i].Polyline);
      end;
    end;
    if Polygons.Count>0 then
    begin
      for i := 0 to Polygons.Count - 1 do
      begin
        CreateMapPolygon(Polygons[i].Polygon);
      end;
    end;

    if FStreetViewOptions.FVisible then
      FStreetViewOptions.InitStreetView;

    if Assigned(FOnDownloadFinish) then
      FOnDownloadFinish(Self);
  end;
end;

procedure TTMSFMXWebGMaps.MapZoomChange(Sender: TObject;NewLevel: Integer);
begin
  FMapOptions.FZoomMap:=NewLevel;
  if Assigned(FOnMapZoomChange) then
    FOnMapZoomChange(Sender,NewLevel);
end;

procedure TTMSFMXWebGMaps.MapClick(Sender: TObject;Latitude, Longitude: Double;X,Y:Integer);
begin
  if Assigned(FOnMapClick) then
    FOnMapClick(Sender,Latitude,Longitude,X,Y);
end;

procedure TTMSFMXWebGMaps.MapDblClick(Sender: TObject;Latitude, Longitude: Double;X,Y:Integer);
begin
  if Assigned(FOnMapDblClick) then
    FOnMapDblClick(Sender,Latitude,Longitude,X,Y);
end;

procedure TTMSFMXWebGMaps.MapIdle(Sender: TObject);
begin
  if Assigned(FOnMapIdle) then
    FOnMapIdle(Sender);
end;

procedure TTMSFMXWebGMaps.MapTypeChange(Sender: TObject;NewMapType: Integer);
begin
  FMapOptions.FMapType:=TMapType(NewMapType);
  if Assigned(FOnMapTypeChange) then
    FOnMapTypeChange(Sender,TMapType(NewMapType));
end;

procedure TTMSFMXWebGMaps.MapMove(Sender: TObject;Latitude, Longitude: Double; X, Y: Integer);
begin
  if Assigned(FOnMapMove) then
    FOnMapMove(Sender,Latitude,Longitude,X,Y);
end;

procedure TTMSFMXWebGMaps.MapMoveEnd(Sender: TObject;Latitude, Longitude: Double;X,Y:Integer);
begin
  FMapOptions.FDefaultLatitude  := Latitude;
  FMapOptions.FDefaultLongitude := Longitude;
  if Assigned(FOnMapMoveEnd) then
    FOnMapMoveEnd(Sender,Latitude,Longitude,X,Y);
end;

procedure TTMSFMXWebGMaps.MapMoveStart(Sender: TObject;Latitude, Longitude: Double;X,Y:Integer);
begin
  if Assigned(FOnMapMoveStart) then
    FOnMapMoveStart(Sender,Latitude,Longitude,X,Y);
end;

procedure TTMSFMXWebGMaps.MarkerClick(Sender: TObject;MarkerTitle: String; IdMarker:Integer; Latitude,Longitude:Double);
begin
  if Assigned(FOnMarkerClick) then
    FOnMarkerClick(Sender,MarkerTitle,IdMarker,Latitude,Longitude);
end;

procedure TTMSFMXWebGMaps.KMLLayerClick(Sender: TObject;ObjectName: String; IdLayer:Integer; Latitude,Longitude:Double);
begin
  if Assigned(FOnKMLLayerClick) then
    FOnKMLLayerClick(Sender,ObjectName,IdLayer,Latitude,Longitude);
end;

procedure TTMSFMXWebGMaps.MarkerDblClick(Sender: TObject;MarkerTitle: String; IdMarker: Integer;
  Latitude, Longitude: Double);
begin
  if Assigned(FOnMarkerDblClick) then
    FOnMarkerDblClick(Sender,MarkerTitle,IdMarker,Latitude,Longitude);
end;

procedure TTMSFMXWebGMaps.MarkerDrag(Sender: TObject;MarkerTitle: String; IdMarker: Integer; Latitude,
  Longitude: Double);
begin
  if Assigned(FOnMarkerDrag) then
    FOnMarkerDrag(Sender,MarkerTitle,IdMarker,Latitude,Longitude);
end;

procedure TTMSFMXWebGMaps.MarkerDragEnd(Sender: TObject;MarkerTitle:String; IdMarker:Integer; Latitude,Longitude:Double);
begin
  if Assigned(FOnMarkerDragEnd) then
    FOnMarkerDragEnd(Sender,MarkerTitle,IdMarker,Latitude,Longitude);
end;

procedure TTMSFMXWebGMaps.MarkerDragStart(Sender: TObject;MarkerTitle:String; IdMarker:Integer; Latitude,Longitude:Double);
begin
  if Assigned(FOnMarkerDragStart) then
    FOnMarkerDragStart(Sender,MarkerTitle,IdMarker,Latitude,Longitude);
end;

procedure TTMSFMXWebGMaps.MarkerInfoWindowCloseClick(Sender: TObject;IdMarker: Integer);
begin
  if Assigned(FOnMarkerInfoWindowCloseClick) then
    FOnMarkerInfoWindowCloseClick(Sender,IdMarker);
end;

procedure TTMSFMXWebGMaps.PolylineClick(Sender: TObject; IdPolyline:Integer);
begin
  if Assigned(FOnPolylineClick) then
    FOnPolylineClick(Sender,IdPolyline);
end;

procedure TTMSFMXWebGMaps.PolylineDblClick(Sender: TObject; IdPolyline: Integer);
begin
  if Assigned(FOnPolylineDblClick) then
    FOnPolylineDblClick(Sender, IdPolyline);
end;

function TTMSFMXWebGMaps.RemoveDirections: Boolean;
begin
  Result := ExecuteJavascript('if (directionsDisplay) directionsDisplay.setMap(null);') = '';
end;

function TTMSFMXWebGMaps.RenderDirections(OriginLatitude, OriginLongitude,
      DestinationLatitude, DestinationLongitude: double;
      TravelMode: TTravelMode = tmDriving; AvoidHighways: Boolean = false;
      AvoidTolls: Boolean = false; WayPoints: TStringList = nil;
      OptimizeWayPoints: Boolean = false): Boolean;
var
  Origin, Destination: string;
begin
  Origin := ConvertCoordinateToString(OriginLatitude) + ','
    + ConvertCoordinateToString(OriginLongitude);
  Destination := ConvertCoordinateToString(DestinationLatitude) + ','
    + ConvertCoordinateToString(DestinationLongitude);

  Result := RenderDirections(Origin, Destination, TravelMode, AvoidHighWays, AvoidTolls, WayPoints, OptimizeWayPoints);
end;

function TTMSFMXWebGMaps.RenderDirections(Origin, Destination: string;
  TravelMode: TTravelMode; AvoidHighways, AvoidTolls: Boolean;
  WayPoints: TStringList; OptimizeWayPoints: Boolean): Boolean;
var
  TextTravelMode, TextAvoidHighways, TextAvoidTolls, TextWayPoints,
  TextOptimizeWayPoints: string;
  I: integer;
begin
  case TravelMode of
    tmDriving: TextTravelMode := 'google.maps.TravelMode.DRIVING';
    tmWalking: TextTravelMode := 'google.maps.TravelMode.WALKING';
    tmBicycling: TextTravelMode := 'google.maps.TravelMode.BICYCLING';
//    tmTransit: TextTravelMode := '&mode=transit';
  end;

  if AvoidHighWays then
    TextAvoidHighways := 'true'
  else
    TextAvoidHighways := 'false';

  if AvoidTolls then
    TextAvoidTolls := 'true'
  else
    TextAvoidTolls := 'false';

  if OptimizeWayPoints then
    TextOptimizeWayPoints := 'true'
  else
    TextOptimizeWayPoints := 'false';

  TextWayPoints := '[]';
  if WayPoints <> nil then
  begin
    TextWayPoints := '';
    for I := 0 to WayPoints.Count - 1 do
    begin
      if I > 0 then
        TextWayPoints := TextWayPoints + ', ';

      TextWayPoints := TextWayPoints + '{ location: ''' + WayPoints.Strings[I] + '''}';
    end;
    TextWayPoints := '[' + TextWayPoints + ']';
  end;

  Result := ExecuteJavascript('calcDirections("' + Origin + '", "' + Destination + '", ' + TextTravelMode + ', ' + TextAvoidHighways + ', ' + TextAvoidTolls + ', ' + TextWayPoints + ', ' + TextOptimizeWayPoints + ');') = '';
end;

function TTMSFMXWebGMaps.ParseForJSEvent(urlstr: String): Boolean;
var
  pref: String;
  params: String;
  arr, arrparams, arrValue: TArray<string>;
  marr: TArray<String>;
  I, K: Integer;
  js: TJSEventParameters;
  functionName: String;
  strm: String;
  func: String;
begin
  {$IFDEF MACOS}
  urlstr := UTF8ToString(NSStrEx(urlstr).stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding).UTF8String);
  {$ENDIF}
  Result := False;
  pref := 'jsevent://';

  if urlstr.ToLower.StartsWith(pref) then
  begin
    urlStr := urlStr.Substring(pref.length);

    arr := urlStr.Split([':']);
    if Length(arr) > 0 then
    begin
      if Length(arr) > 2 then
      begin
        func := marr[0];
        strm := marr[1];

        for K := Length(marr) - 1 downto 2 do
        begin
          strm := strm + ':';
          strm := strm + marr[K];
        end;

        SetLength(arr, Length(arr) + 2);
        arr[Length(arr) - 2] := func;
        arr[Length(arr) - 1] := strm;
      end;

      functionName := arr[0];
      SetLength(js, 0);
      if Length(arr) > 1 then
      begin
        params := arr[1];
        arrparams := params.Split(['#']);
        SetLength(js, Length(arrparams));
        for I := 0 to Length(arrparams) - 1 do
        begin
          arrvalue := arrParams[I].Split(['=']);
          if Length(arrvalue) > 1 then
          begin
            js[I].parameter := arrvalue[0];
            js[I].value := arrvalue[1];
          end;
        end;
      end;

      DoEvent(functionName, js);
      Result := True;
    end;
  end;
end;

procedure TTMSFMXWebGMaps.PolygonClick(Sender: TObject; IdPolygon:Integer);
begin
  if Assigned(FOnPolygonClick) then
    FOnPolygonClick(Sender,IdPolygon);
end;

procedure TTMSFMXWebGMaps.PolygonDblClick(Sender: TObject; IdPolygon: Integer);
begin
  if Assigned(FOnPolygonDblClick) then
    FOnPolygonDblClick(Sender, IdPolygon);
end;

procedure TTMSFMXWebGMaps.Assign(Source: TPersistent);
begin
  if (Source is TTMSFMXWebGMaps) then
  begin
    FMarkers.Assign((Source as TTMSFMXWebGMaps).Markers);
    FPolylines.Assign((Source as TTMSFMXWebGMaps).Polylines);
    FPolygons.Assign((Source as TTMSFMXWebGMaps).Polygons);
    FDirections.Assign((Source as TTMSFMXWebGMaps).Directions);
    FMapOptions.Assign((Source as TTMSFMXWebGMaps).MapOptions);
    FStreetViewOptions.Assign((Source as TTMSFMXWebGMaps).StreetViewOptions);
    FControlsOptions.Assign((Source as TTMSFMXWebGMaps).ControlsOptions);
    FWeatherOptions.Assign((Source as TTMSFMXWebGMaps).WeatherOptions);
  end;
end;

procedure TTMSFMXWebGMaps.BeforeNavigate(
  var Params: TTMSFMXWebGMapsCustomWebBrowserBeforeNavigateParams);
begin
  Params.Cancel := ParseForJSEvent(Params.URL);
  inherited;
end;

function TTMSFMXWebGMaps.AddMapKMLLayer(Url: string; ZoomToBounds: boolean): boolean;
var
  js, zoom: string;
begin
  if ZoomToBounds then
    zoom := 'false'
  else
    zoom :='true';

  js := 'addKMLLayer("' + url + '", ' + zoom + ');';

  Result := ExecuteJavaScript(js) = '';
end;

procedure TTMSFMXWebGMaps.BoundsRetrieved(Sender: TObject; Bounds: TBounds);
begin
  if Assigned(FOnBoundsRetrieved) then
    FOnBoundsRetrieved(Sender,Bounds);
end;

procedure TTMSFMXWebGMaps.StreetViewChange(Sender: TObject; Heading, Pitch,
  Zoom: Integer);
begin
  if Heading < 0 then
    Heading := 360 + Heading
  else if Heading > 360 then
    Heading := Heading - 360;

  if Pitch < -90 then
    Pitch := -90
  else if Pitch > 90 then
    Pitch := 90;

  if Zoom < 0 then
    Zoom := 0
  else if Zoom > 5 then
    Zoom := 5;

  StreetViewOptions.Heading:=Heading;
  StreetViewOptions.Pitch:=Pitch;
  StreetViewOptions.Zoom:=Zoom;
  if Assigned(FOnStreetViewChange) then
    FOnStreetViewChange(Sender,Heading,Pitch,Zoom);
end;

procedure TTMSFMXWebGMaps.StreetViewMove(Sender: TObject;Latitude, Longitude: Double; X, Y: Integer);
begin
  StreetViewOptions.DefaultLatitude:=Latitude;
  StreetViewOptions.DefaultLongitude:=Longitude;
  if Assigned(FOnStreetViewMove) then
    FOnStreetViewMove(Sender,Latitude,Longitude,X,Y);
end;

function TTMSFMXWebGMaps.DegreesToLonLat(StrLon, StrLat: string; var Lon,
  Lat: double): boolean;
var
  deg,min,sec,dir: string;
  err1,err2,err3: integer;
  ddeg,dmin,dsec: double;
  dsep: char;

  function SplitDegrees(s: string; var sDeg,sMin,sSec,sDir: string): boolean;
  var
    vp: integer;
  begin
    Result := false;

    vp := Pos('°',s);

    if vp > 0 then
    begin
      sDeg := copy(s,1,vp-1);
      delete(s,1,vp );

      vp := Pos('''',s);
      if vp > 0 then
      begin
        sMin := copy(s,1,vp-1);
        delete(s,1,vp );

        vp := Pos('"',s);
        if vp > 0 then
        begin
          sSec := copy(s,1,vp - 1);
          delete(s,1,vp);
          sDir := s;
          Result := true;
        end;
      end;
    end;

  end;


begin
  Result := False;

  //Example: 49°31'46.604"N, 17°47'19.809"E

  if SplitDegrees(StrLon, Deg,Min,Sec,Dir) then
  begin
    {$IFDEF DELPHIXE_LVL}
    dsep := FormatSettings.DecimalSeparator;
    FormatSettings.DecimalSeparator := '.';
    {$ENDIF}
    {$IFNDEF DELPHIXE_LVL}
    dsep := DecimalSeparator;
    DecimalSeparator := '.';
    {$ENDIF}

    Val(Deg,ddeg,err1);
    Val(Min,dmin,err2);
    Val(Sec,dsec,err3);

    Lon := dDeg + (dmin * 60 + dsec)/3600;

    if Dir = 'E' then
      Lon := -Lon;


    if (err1 + err2 + err3 = 0) and SplitDegrees(StrLat, Deg,Min,Sec,Dir) then
    begin
      Val(Deg,ddeg,err1);
      Val(Min,dmin,err2);
      Val(Sec,dsec,err3);
      Lat := dDeg + (dmin * 60 + dsec)/3600;
      Result := (err1 + err2 + err3 = 0);

      if Dir = 'S' then
        Lat := -Lat;
    end;

    {$IFDEF DELPHIXE_LVL}
    FormatSettings.DecimalSeparator := dsep;
    {$ENDIF}
    {$IFNDEF DELPHIXE_LVL}
    DecimalSeparator := dsep;
    {$ENDIF}
  end;
end;

function TTMSFMXWebGMaps.DeleteAllMapMarker: Boolean;
begin
  Result:=ExecuteJavascript('deleteAllMapMarker();') = '';
end;

function TTMSFMXWebGMaps.DeleteAllMapPolygon: Boolean;
begin
  TPolygonCount := 0;
  Result:=ExecuteJavascript('deleteAllMapPolygon();') = '';
end;

function TTMSFMXWebGMaps.DeleteAllMapPolyline: Boolean;
begin
  TPolylineCount := 0;
  Result:=ExecuteJavascript('deleteAllMapPolyline();') = '';
end;

function TTMSFMXWebGMaps.DeleteMapMarker(Id: Integer): Boolean;
begin
  Result := ExecuteJavascript('deleteMapMarker('+inttostr(Id)+');') = '';
end;

function TTMSFMXWebGMaps.DeleteMapPolygon(Id: Integer): Boolean;
begin
  TPolygonCount := TPolygonCount - 1;
  Result:=ExecuteJavascript('deleteMapPolygon('+inttostr(Id)+');') = '';
end;

function TTMSFMXWebGMaps.DeleteMapPolyline(Id: Integer): Boolean;
begin
  TPolylineCount := TPolylineCount - 1;
  Result:=ExecuteJavascript('deleteMapPolyline('+inttostr(Id)+');') = '';
end;

function TTMSFMXWebGMaps.DeleteMapKMLLayer(Id: integer): boolean;
begin
  Result := ExecuteJavaScript('deleteKMLLayer(' + IntToStr(Id) + ');') = '';
end;

function TTMSFMXWebGMaps.DeleteAllMapKMLLayer(): boolean;
begin
  Result := ExecuteJavaScript('deleteAllKMLLayer();') = '';
end;

destructor TTMSFMXWebGMaps.Destroy;
begin
  FWebBrowser.DeInitialize;
  FWebBrowser:= nil;

  FreeAndNil(FMarkers);
  FreeAndNil(FPolylines);
  FreeAndNil(FPolygons);
  FreeAndNil(FDirections);
  FreeAndNil(FWeatherOptions);
  FreeAndNil(FMapOptions);
  FreeAndNil(FStreetViewOptions);
  FreeAndNil(FControlsOptions);
  inherited;
end;

function TTMSFMXWebGMaps.Distance(la1, lo1, la2, lo2: double): double;
var
  R: Double;
  dlat,dlon: double;
  a,c: double;
begin
  R := 6371; // km

  dLat := degtorad(la2-la1);
  dLon := degtorad(lo2-lo1);

  la1 := degtorad(la1);
  la2 := degtorad(la2);

  a := sin(dLat/2) * sin(dLat/2) +
       sin(dLon/2) * sin(dLon/2) * cos(la1) * cos(la2);

  c := 2 * arctan2(sqrt(a), sqrt(1-a));
  Result := R * c;
end;

procedure TTMSFMXWebGMaps.DoEvent(AEvent: String; AParameters: TJSEventParameters);
var
  str, param, title: String;
  Lat, Lng, NorthEastLatitude, NorthEastLongitude, SouthWestLatitude, SouthWestLongitude: double;
  I, X, Y, ErrorType, id, maptype, zoomlevel, heading, pitch, zoom: Integer;
  Bounds: TBounds;
begin
  inherited;
  str := '';
  Lat := 0;
  Lng := 0;
  X := 0;
  Y := 0;
  ErrorType := 0;
  maptype := 0;
  zoomlevel := 0;
  id := 0;
  title := '';
  param := '';
  NorthEastLatitude := 0;
  NorthEastLongitude := 0;
  SouthWestLatitude := 0;
  SouthWestLongitude := 0;
  heading := 0;
  pitch := 0;
  zoom := 0;

  for I := 0 to Length(AParameters) - 1 do
  begin
    param := AParameters[I].value;
    str := str + AParameters[I].parameter + ' : ' + param + ' * ';

    if (AParameters[I].parameter = 'lat') and (param <> '') then
      Lat := ConvertStringToCoordinate(param);

    if (AParameters[I].parameter = 'lng') and (param <> '') then
      Lng := ConvertStringToCoordinate(param);

    if (AParameters[I].parameter = 'nelat') and (param <> '') then
      NorthEastLatitude := ConvertStringToCoordinate(param);

    if (AParameters[I].parameter = 'nelng') and (param <> '') then
      NorthEastLongitude := ConvertStringToCoordinate(param);

    if (AParameters[I].parameter = 'swlat') and (param <> '') then
      SouthWestLatitude := ConvertStringToCoordinate(param);

    if (AParameters[I].parameter = 'swlng') and (param <> '') then
      SouthWestLongitude := ConvertStringToCoordinate(param);

    if (AParameters[I].parameter = 'x') and (param <> '') then
      X := StrToInt(param);

    if (AParameters[I].parameter = 'y') and (param <> '') then
      Y := StrToInt(param);

    if (AParameters[I].parameter = 'errorid') and (param <> '') then
      ErrorType := StrToInt(param);

    if (AParameters[I].parameter = 'id') and (param <> '') then
      id := StrToInt(param);

    if (AParameters[I].parameter = 'title') and (param <> '') then
      title := param;

    if (AParameters[I].parameter = 'maptype') and (param <> '') then
      maptype := StrToInt(param);

    if (AParameters[I].parameter = 'zoomlevel') and (param <> '') then
      zoomlevel := StrToInt(param);

    if (AParameters[I].parameter = 'heading') and (param <> '') then
      heading := StrToInt(param);

    if (AParameters[I].parameter = 'pitch') and (param <> '') then
      pitch := StrToInt(param);

    if (AParameters[I].parameter = 'zoom') and (param <> '') then
      zoom := StrToInt(param);
  end;

//  {$IFDEF IOS}
//   NSLog((NSStr('map event: ' + AEvent + ' : ' + str) as ILocalObject).GetObjectID);
//  {$ENDIF}

  if AEvent = 'click' then
    MapClick(Self, Lat, Lng, X, Y);

  if AEvent = 'dblclick' then
    MapDblClick(Self, Lat, Lng, X, Y);

  if AEvent = 'boundsretrieved' then
  begin
  if Assigned(FOnBoundsRetrieved) then
    begin
      Bounds := TBounds.Create;
      Bounds.NorthEast.Latitude := NorthEastLatitude;
      Bounds.NorthEast.Longitude := NorthEastLongitude;
      Bounds.SouthWest.Latitude := SouthWestLatitude;
      Bounds.SouthWest.Longitude := SouthWestLongitude;
      BoundsRetrieved(Self, Bounds);
      Bounds.Free;
    end;
  end;

  if AEvent = 'error' then
    GMapsError(Self, TErrorType(ErrorType));

  if AEvent = 'polylineclick' then
    PolylineClick(Self, Id);

  if AEvent = 'polylinedblclick' then
    PolylineDblClick(Self, id);

  if AEvent = 'polygonclick' then
    PolygonClick(Self, id);

  if AEvent = 'polygondblclick' then
    PolygonDblClick(Self, id);

  if AEvent = 'infowindowcloseclick' then
    MarkerInfoWindowCloseClick(Self, id);

  if AEvent = 'markerclick' then
    MarkerClick(Self, title, id, lat, lng);

  if AEvent = 'kmllayerclick' then
    KMLLayerClick(Self, title, id, lat, lng);

  if AEvent = 'markerdblclick' then
    MarkerDblClick(Self, title, id, lat, lng);

  if AEvent = 'markerdragstart' then
    MarkerDragStart(Self, title, id, lat, lng);

  if AEvent = 'markerdrag' then
    MarkerDrag(Self, title, id, lat, lng);

  if AEvent = 'markerdragend' then
    MarkerDragEnd(Self, title, id, lat, lng);

  if AEvent = 'streetviewmove' then
    StreetViewMove(Self, lat, lng, x, y);

  if AEvent = 'streetviewchange' then
    StreetViewChange(Self, heading, pitch, zoom);

  if AEvent = 'tilesload' then
    MapTilesLoad(Self);

  if AEvent = 'dragstart' then
    MapMoveStart(Self, lat, lng, x, y);

  if AEvent = 'dragend' then
    MapMoveEnd(Self, lat, lng, x, y);

  if AEvent = 'drag' then
    MapMove(Self, lat, lng, x, y);

  if AEvent = 'idle' then
    MapIdle(Self);

  if AEvent = 'typeidchange' then
    MapTypeChange(Self, maptype);

  if AEvent = 'zoomchange' then
    MapZoomChange(Self, zoomlevel);
end;

function TTMSFMXWebGMaps.ExecuteJavascript(AScript: String): String;
begin
  Result := inherited;
  if not (Result = '') then
    if Assigned(FOnWebGMapsError) then
      FOnWebGMapsError(Self,etJavascriptError);
end;

procedure TTMSFMXWebGMaps.GetDirections(OriginLatitude, OriginLongitude,
  DestinationLatitude, DestinationLongitude: double; Alternatives: Boolean;
  TravelMode: TTravelMode; Units: TUnits; Language: TLanguageName;
  StripHTML: boolean;AvoidHighways: Boolean; AvoidTolls: Boolean;
  WayPoints: TStringList; OptimizeWayPoints: Boolean);
var
  Origin, Destination: string;
begin
  Origin := ConvertCoordinateToString(OriginLatitude) + ','
    + ConvertCoordinateToString(OriginLongitude);
  Destination := ConvertCoordinateToString(DestinationLatitude) + ','
    + ConvertCoordinateToString(DestinationLongitude);

  GetDirections(Origin, Destination, Alternatives, TravelMode, Units, Language, 
	StripHTML, AvoidHighways, AvoidTolls, WayPoints, OptimizeWayPoints);
end;

procedure TTMSFMXWebGMaps.GetDirections(Origin, Destination: string;
  Alternatives: Boolean; TravelMode: TTravelMode; Units: TUnits;
  Language: TLanguageName; StripHTML: boolean;AvoidHighways: Boolean; AvoidTolls: Boolean;
  WayPoints: TStringList; OptimizeWayPoints: Boolean);
var
  url, TextAlt, TextTravelMode, TextUnits, LanguageCode: string;
  TextAvoid, TextWayPoints: string;
  resdat: String;
  jv: TJSONValue;
  o, fo: TJSONObject;
  ja: TJSONArray;
  i: integer;
  Route: TRoute;
begin
  TDirectionsStripHTML := StripHTML;

  if Alternatives then
    TextAlt := 'true'
  else
    TextAlt := 'false';

  if Language=lnDefault then
  begin
    LanguageCode := '';
  end
  else
  begin
    LanguageCode := GetEnumName(TypeInfo(TLanguageCode),ord(Language));
    LanguageCode := '&language=' + ReplaceText(LanguageCode,'_','-');
  end;

  case TravelMode of
    tmDriving: TextTravelMode := '';
    tmWalking: TextTravelMode := '&mode=walking';
    tmBicycling: TextTravelMode := '&mode=bicycling';
  end;

  TextUnits := '&units=';
  if Units = usMetric then
    TextUnits := TextUnits + 'metric'
  else
    TextUnits := TextUnits + 'imperial';

  TextAvoid := '';
  if AvoidTolls or AvoidHighways then
  begin
    TextAvoid := '&avoid=';
    if AvoidTolls and AvoidHighways then
      TextAvoid := TextAvoid + 'tolls|highways'
    else if AvoidTolls then
      TextAvoid := TextAvoid + 'tolls'
    else if AvoidHighways then
      TextAvoid := TextAvoid + 'highways';
  end;

  TextWayPoints := '';
  if Waypoints <> nil then
  begin
    TextWayPoints := '&waypoints=';
    if OptimizeWayPoints then
      TextWayPoints := TextWayPoints + 'optimize:true|';
    for I := 0 to WayPoints.Count - 1 do
    begin
      if I > 0 then
        TextWayPoints := TextWayPoints + '|';

      TextWayPoints := TextWayPoints + URLEncode(WayPoints.Strings[I]);
    end;
  end;

  url := 'http://maps.googleapis.com/maps/api/directions/json'
  + '?origin=' + URLEncode(Origin)
  + '&destination=' + URLEncode(Destination)
  + '&alternatives=' + TextAlt
  + TextTravelMode
  + TextUnits
  + LanguageCode
  + TextAvoid
  + TextWayPoints
  + '&sensor=false';

  resdat := WebHttpsGet(url);

  if (resdat <> '') then
  begin
    jv := TJSONObject.ParseJSONValue(string(resdat));

    if Assigned(jv) and (jv is TJSONObject) then
    begin
      try
        o := jv as TJSONObject;
        ja := GetJSONValue(o,'routes') as TJSONArray;

        if Assigned(ja) then
        begin
          Directions.Clear;
          {$IFDEF DELPHIXE6_LVL}
          for i := 0 to ja.Count - 1 do
          begin
            fo := ja.Items[i] as TJSONObject;
          {$ELSE}
          for i := 0 to ja.Size - 1 do
          begin
            fo := ja.Get(i) as TJSONObject;
          {$ENDIF}
            if Assigned(fo) then
            begin
              Route := Directions.Add;
              Route.FromJSON(fo);
            end;
          end;
        end;
      finally
        jv.Free;
      end;
    end;
  end;
end;

function TTMSFMXWebGMaps.GetMapBounds: Boolean;
begin
  Result := ExecuteJavascript('getBounds();') = '';
end;

function TTMSFMXWebGMaps.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(System.Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(System.Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TTMSFMXWebGMaps.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TTMSFMXWebGMaps.GoToAddress(Address: String);
var
  str: String;
begin
  str := Format('codeAddress(%s)',[QuotedStr(Address)]);
  ExecuteJavascript(str);
end;

function TTMSFMXWebGMaps.InitHtmlFile: string;
var
  TextLat,TextLng,LanguageCode:String;
begin
  Result  := HTML_FILE_1 + HTML_FILE_2 + HTML_FILE_3;

  TextLat := ConvertCoordinateToString(FMapOptions.FDefaultLatitude);
  TextLng := ConvertCoordinateToString(FMapOptions.FDefaultLongitude);
  Result  := ReplaceText(Result,'%latitude%',textlat);
  Result  := ReplaceText(Result,'%longitude%',textlng);
  Result  := ReplaceText(Result,'%zoom%',inttostr(FMapOptions.FZoomMap));

  if ApiKey <> '' then
    Result  := ReplaceText(Result,'%apikey%','apikey=' + APIKey + '&')
  else
    Result  := ReplaceText(Result,'%apikey%',APIKey);

  case ControlsOptions.ControlsType of
    ctDefault:
      begin
        Result := ReplaceText(Result,'%controlstype%',CONTROL_DEFAULT);
      end;
    ctAndroid:
      begin
        Result := ReplaceText(Result,'%controlstype%',CONTROL_ANDROID);
      end;
    ctSmall:
      begin
        Result := ReplaceText(Result,'%controlstype%',CONTROL_SMALL);
      end;
    ctZoomPan:
      begin
        Result := ReplaceText(Result,'%controlstype%',CONTROL_ZOOMPAN);
      end;
  end;

  if MapOptions.DisablePOI then
    Result := ReplaceText(Result, '%disablepoi%', 'off')
  else
    Result := ReplaceText(Result, '%disablepoi%', 'on');

  if MapOptions.FDraggable then
    Result:=ReplaceText(Result,'%draggable%','true')
  else
    Result:=ReplaceText(Result,'%draggable%','false');

  Result:=ReplaceText(Result,'%disableDoubleClickZoom%','true');

  if MapOptions.FDisableControls then
    Result:=ReplaceText(Result,'%disableDefaultUI%','true')
  else
    Result:=ReplaceText(Result,'%disableDefaultUI%','false');

  Result:=ReplaceText(Result,'%keyboardShortcuts%','false');
  Result:=ReplaceText(Result,'%scrollwheel%','false');

  if MapOptions.FShowTraffic then
    Result:=ReplaceText(Result,'%showtraffic%','map')
  else
    Result:=ReplaceText(Result,'%showtraffic%','null');

  if MapOptions.FShowBicycling then
    Result:=ReplaceText(Result,'%showbicycling%','map')
  else
    Result:=ReplaceText(Result,'%showbicycling%','null');

  if MapOptions.FShowPanoramio then
    Result:=ReplaceText(Result,'%showpanoramio%','map')
  else
    Result:=ReplaceText(Result,'%showpanoramio%','null');

  if MapOptions.FShowCloud then
    Result:=ReplaceText(Result,'%showcloud%','map')
  else
    Result:=ReplaceText(Result,'%showcloud%','null');

  if MapOptions.FShowWeather then
    Result:=ReplaceText(Result,'%showweather%','map')
  else
    Result:=ReplaceText(Result,'%showweather%','null');

  case FWeatherOptions.FTemperatureUnit of
    wtCelsius:
      Result:=ReplaceText(Result,'%weatherTemperature%',WEATHER_TEMPERATURE_CELSIUS);
    wtFahrenheit:
      Result:=ReplaceText(Result,'%weatherTemperature%',WEATHER_TEMPERATURE_FAHRENHEIT);
  end;

  case FWeatherOptions.FWindSpeedUnit of
    wwsKilometersPerHour:
      Result:=ReplaceText(Result,'%weatherWindSpeed%',WEATHER_WIND_SPEED_KILOMETERS_PER_HOUR);
    wwsMetersPerSecond:
      Result:=ReplaceText(Result,'%weatherWindSpeed%',WEATHER_WIND_SPEED_METERS_PER_SECOND);
    wwsMilesPerHour:
      Result:=ReplaceText(Result,'%weatherWindSpeed%',WEATHER_WIND_SPEED_MILES_PER_HOUR);
  end;

  case FWeatherOptions.FLabelColor of
    wlcBlack:
      Result:=ReplaceText(Result,'%weatherLabelColor%',WEATHER_LABEL_COLOR_BLACK);
    wlcWhite:
      Result:=ReplaceText(Result,'%weatherLabelColor%',WEATHER_LABEL_COLOR_WHITE);
  end;

  if FWeatherOptions.FShowInfoWindows then
  begin
    Result:=ReplaceText(Result,'%weatherSuppressInfoWinddows%','false');
  end
  else
  begin
    Result:=ReplaceText(Result,'%weatherSuppressInfoWinddows%','true');
  end;

  case FMapOptions.FMapType of
    mtDefault:
      Result:=ReplaceText(Result,'%maptype%',MAP_DEFAULT);
    mtSatellite:
      Result:=ReplaceText(Result,'%maptype%',MAP_SATELLITE);
    mtHybrid:
      Result:=ReplaceText(Result,'%maptype%',MAP_HYBRID);
    mtTerrain:
    Result:=ReplaceText(Result,'%maptype%',MAP_TERRAIN);
  end;

  if MapOptions.Language=lnDefault then
  begin
    Result:=ReplaceText(Result,'&language=%lang%','');
  end
  else
  begin
    LanguageCode := GetEnumName(TypeInfo(TLanguageCode),ord(FMapOptions.Language));
    LanguageCode := ReplaceText(LanguageCode,'_','-');
    Result:=ReplaceText(Result,'%lang%',LanguageCode);
  end;

  if ControlsOptions.PanControl.Visible then
    Result:=ReplaceText(Result,'%panControl%','true')
  else
    Result:=ReplaceText(Result,'%panControl%','false');
  Result:=ReplaceTextControlPosition(Result,'%panControlPosition%',ControlsOptions.PanControl.Position);

  if ControlsOptions.ZoomControl.Visible then
    Result:=ReplaceText(Result,'%zoomControl%','true')
  else
    Result:=ReplaceText(Result,'%zoomControl%','false');
  Result:=ReplaceTextControlPosition(Result,'%zoomControlPosition%',ControlsOptions.ZoomControl.Position);
  case ControlsOptions.ZoomControl.Style of
    zsDefault:
      Result:=ReplaceText(Result,'%zoomControlStyle%',ZOOM_DEFAULT);
    zsSmall:
      Result:=ReplaceText(Result,'%zoomControlStyle%',ZOOM_SMALL);
    zsLarge:
      Result:=ReplaceText(Result,'%zoomControlStyle%',ZOOM_LARGE);
  end;

  if ControlsOptions.MapTypeControl.Visible then
    Result:=ReplaceText(Result,'%mapTypeControl%','true')
  else
    Result:=ReplaceText(Result,'%mapTypeControl%','false');
  Result:=ReplaceTextControlPosition(Result,'%mapTypeControlPosition%',ControlsOptions.MapTypeControl.Position);
  case ControlsOptions.MapTypeControl.Style of
    mtsDefault:
    Result:=ReplaceText(Result,'%mapTypeControlStyle%',MAPTYPE_DEFAULT);
    mtsDropDownMenu:
    Result:=ReplaceText(Result,'%mapTypeControlStyle%',MAPTYPE_DROPDOWNMENU);
    mtsHorizontalBar:
    Result:=ReplaceText(Result,'%mapTypeControlStyle%',MAPTYPE_HORIZONTALBAR);
  end;

  if ControlsOptions.ScaleControl.Visible then
    Result:=ReplaceText(Result,'%scaleControl%','true')
  else
    Result:=ReplaceText(Result,'%scaleControl%','false');
  Result:=ReplaceTextControlPosition(Result,'%scaleControlPosition%',ControlsOptions.ScaleControl.Position);

  if ControlsOptions.StreetViewControl.Visible then
    Result:=ReplaceText(Result,'%streetViewControl%','true')
  else
    Result:=ReplaceText(Result,'%streetViewControl%','false');
  Result:=ReplaceTextControlPosition(Result,'%streetViewControlPosition%',ControlsOptions.StreetViewControl.Position);

  if StreetViewOptions.Visible then
    Result:=ReplaceText(Result,'%SVVisible%','true')
  else
    Result:=ReplaceText(Result,'%SVVisible%','false');
  Result:=ReplaceText(Result,'%SVLat%',ConvertCoordinateToString(StreetViewOptions.DefaultLatitude));
  Result:=ReplaceText(Result,'%SVLng%',ConvertCoordinateToString(StreetViewOptions.DefaultLongitude));
  Result:=ReplaceText(Result,'%SVHeading%',IntToStr(StreetViewOptions.Heading));
  Result:=ReplaceText(Result,'%SVZoom%',IntToStr(StreetViewOptions.Zoom));
  Result:=ReplaceText(Result,'%SVPitch%',IntToStr(StreetViewOptions.Pitch));

  // OverviewMapControl
  if ControlsOptions.OverviewMapControl.Visible then
    Result:=ReplaceText(Result,'%overviewMapControl%','true')
  else
    Result:=ReplaceText(Result,'%overviewMapControl%','false');

  if ControlsOptions.OverviewMapControl.Open then
    Result:=ReplaceText(Result,'%overviewMapControlOpened%','true')
  else
    Result:=ReplaceText(Result,'%overviewMapControlOpened%','false');
end;

procedure TTMSFMXWebGMaps.Initialize;
var
  HtmlFile: string;
begin
  inherited;
  try
    Navigate(HTML_BLANK_PAGE);

    HtmlFile := InitHtmlFile;

    LoadHTML(HTMLFile);
  except
    if Assigned(FOnWebGMapsError) then
      FOnWebGMapsError(Self,etGMapsProblem);
  end;
end;

function TTMSFMXWebGMaps.CloseMarkerInfoWindowHtml(Id: Integer): Boolean;
begin
  Result:=ExecuteJavascript('closeMarkerInfoWindowHtml('+inttostr(Id)+');') = '';
end;

function TTMSFMXWebGMaps.MapPanBy(X, Y: Integer): Boolean;
begin
  Result:=ExecuteJavascript('map.panBy('+inttostr(X)+', '+inttostr(Y)+');') = '';
end;

function TTMSFMXWebGMaps.MapPanTo(Latitude, Longitude: Double): Boolean;
var
  TextLat,TextLng:String;
begin
  TextLat := ConvertCoordinateToString(Latitude);
  TextLng := ConvertCoordinateToString(Longitude);
  Result:=ExecuteJavascript('map.panTo(new google.maps.LatLng('+TextLat+', '+TextLng+'));') = '';
end;

function TTMSFMXWebGMaps.MapPolygonToJS(Polygon: TMapPolygon;
  IsUpdate: Boolean): Boolean;
var
  TextLat,TextLng,TextZIndex,TextVisible,TextGeodesic,TextClickable,TextEditable,
  TextPath, TextType, TextRadius, neTextLat,neTextLng,swTextLat,swTextLng,
  js:String;
  I: integer;
begin
  TextZIndex := IntToStr(Polygon.Zindex);

  if Polygon.Visible then
    TextVisible:='true'
  else
    TextVisible:='false';

  if Polygon.Geodesic then
    TextGeodesic:='true'
  else
    TextGeodesic:='false';

  if Polygon.Clickable then
    TextClickable:='true'
  else
    TextClickable:='false';

  if Polygon.Editable then
    TextEditable:='true'
  else
    TextEditable:='false';

  if Polygon.PolygonType = ptPath then
  begin
  TextPath := '[';
  for I := 0 to Polygon.Path.Count - 1 do
  begin
    TextLat    := ConvertCoordinateToString(Polygon.Path[I].Latitude);
    TextLng    := ConvertCoordinateToString(Polygon.Path[I].Longitude);

    TextPath := TextPath
    +'new google.maps.LatLng(' + TextLat + ', ' + TextLng + ')';

    if I < Polygon.Path.Count - 1 then
      TextPath := TextPath + ',';
  end;
  TextPath := TextPath + ']';
  TextType := 'path';
  end
  else
  begin
    TextPath := 'null';
    if Polygon.PolygonType = ptCircle then
      TextType := 'circle'
    else if Polygon.PolygonType = ptRectangle then
      TextType := 'rectangle';
  end;

  TextLat    := ConvertCoordinateToString(Polygon.Center.Latitude);
  TextLng    := ConvertCoordinateToString(Polygon.Center.Longitude);
  TextRadius := IntToStr(Polygon.Radius);

  neTextLat := ConvertCoordinateToString(Polygon.Bounds.NorthEast.Latitude);
  neTextLng := ConvertCoordinateToString(Polygon.Bounds.NorthEast.Longitude);
  swTextLat := ConvertCoordinateToString(Polygon.Bounds.SouthWest.Latitude);
  swTextLng := ConvertCoordinateToString(Polygon.Bounds.SouthWest.Longitude);

  if IsUpdate then
  begin
  js := 'updateMapPolygon('+IntToStr(Polygon.ItemIndex - 1)+', '
                                      +TextClickable+', '
                                      +TextEditable+', '
                                      +TextPath+', "'
                                      +ColorToHTML(Polygon.BackgroundColor)+'", "'
                                      +ColorToHTML(Polygon.BorderColor)+'", '
                                      +IntToStr(Polygon.BorderWidth)+', '
                                      +Convert255To1(Polygon.BackgroundOpacity)+' , '
                                      +Convert255To1(Polygon.BorderOpacity)+' , '
                                      +TextVisible+', '
                                      +TextGeodesic+', '
                                      +TextZIndex+', "'
                                      +TextType+'", '
                                      +TextLat+', '
                                      +TextLng+', '
                                      +TextRadius+', '
                                      +neTextLat+', '
                                      +neTextLng+', '
                                      +swTextLat+', '
                                      +swTextLng+
                                      ');';

    Result:=(ExecuteJavascript(js)) = '';
  end
  else
  begin
    js := 'createMapPolygon('+TextClickable+', '
                                      +TextEditable+', '
                                      +TextPath+', "'
                                      +ColorToHTML(Polygon.BackgroundColor)+'", "'
                                      +ColorToHTML(Polygon.BorderColor)+'", '
                                      +IntToStr(Polygon.BorderWidth)+', '
                                      +Convert255To1(Polygon.BackgroundOpacity)+' , '
                                      +Convert255To1(Polygon.BorderOpacity)+' , '
                                      +TextVisible+', '
                                      +TextGeodesic+', '
                                      +TextZIndex+', "'
                                      +TextType+'", '
                                      +TextLat+', '
                                      +TextLng+', '
                                      +TextRadius+', '
                                      +neTextLat+', '
                                      +neTextLng+', '
                                      +swTextLat+', '
                                      +swTextLng+
                                      ');';
    Result:=ExecuteJavascript(js) = ''
  end;
end;

function TTMSFMXWebGMaps.MapPolylineToJS(Polyline: TPolyline;
  IsUpdate: Boolean): Boolean;
var
  TextLat,TextLng,TextZIndex,TextVisible,TextGeodesic,TextClickable,TextEditable,
  TextPath,TextIcons,TextRotation,TextOffset,TextRepeat,js:String;
  I: integer;
begin

  TextZIndex := IntToStr(Polyline.Zindex);

  if Polyline.Visible then
    TextVisible:='true'
  else
    TextVisible:='false';

  if Polyline.Geodesic then
    TextGeodesic:='true'
  else
    TextGeodesic:='false';

  if Polyline.Clickable then
    TextClickable:='true'
  else
    TextClickable:='false';

  if Polyline.Editable then
    TextEditable:='true'
  else
    TextEditable:='false';

  TextIcons := '[';
  for I := 0 to Polyline.Icons.Count - 1 do
  begin
    if Polyline.Icons[I].FixedRotation then
      TextRotation:='true'
    else
      TextRotation:='false';

    if Polyline.Icons[I].RepeatType = dtPixels then
      TextRepeat:='px'
    else
      TextRepeat:='%';

    if Polyline.Icons[I].OffsetType = dtPixels then
      TextOffset:='px'
    else
      TextOffset:='%';

    TextIcons := TextIcons + '{ icon: { path:';

    case Polyline.Icons[I].SymbolType of
      stBackwardClosedArrow: TextIcons := TextIcons + ' google.maps.SymbolPath.BACKWARD_CLOSED_ARROW';
      stBackwardOpenArrow: TextIcons := TextIcons + ' google.maps.SymbolPath.BACKWARD_OPEN_ARROW';
      stForwardClosedArrow: TextIcons := TextIcons + ' google.maps.SymbolPath.FORWARD_CLOSED_ARROW';
      stForwardOpenArrow: TextIcons := TextIcons + ' google.maps.SymbolPath.FORWARD_OPEN_ARROW';
      stCircle: TextIcons := TextIcons + ' google.maps.SymbolPath.CIRCLE';
    end;
    TextIcons := TextIcons + '}, fixedRotation: ' + TextRotation
    + ', repeat: "' + IntToStr(Polyline.Icons[I].RepeatValue) + TextRepeat + '", offset: "'
    + IntToStr(Polyline.Icons[I].Offset) + TextOffset + '" }';

    if I < Polyline.Icons.Count - 1 then
      TextIcons := TextIcons + ',';
  end;
  TextIcons := TextIcons + ']';

  TextPath := '[';
  for I := 0 to Polyline.Path.Count - 1 do
  begin
    TextLat    := ConvertCoordinateToString(Polyline.Path[I].Latitude);
    TextLng    := ConvertCoordinateToString(Polyline.Path[I].Longitude);

    TextPath := TextPath
    +'new google.maps.LatLng(' + TextLat + ', ' + TextLng + ')';

    if I < Polyline.Path.Count - 1 then
      TextPath := TextPath + ',';
  end;
  TextPath := TextPath + ']';

  if IsUpdate then
  begin
    js := 'updateMapPolyline('+IntToStr(Polyline.ItemIndex - 1)+', '
                                      +TextClickable+', '
                                      +TextEditable+', '
                                      +TextIcons+', '
                                      +TextPath+', "'
                                      +ColorToHTML(Polyline.Color)+'", '
                                      +IntToStr(Polyline.Width)+', '
                                      +Convert255To1(Polyline.Opacity)+' , '
                                      +TextVisible+', '
                                      +TextGeodesic+', '
                                      +TextZIndex+');';
    Result:= ExecuteJavascript(js) = ''
  end
  else
  begin
    js := 'createMapPolyline('+TextClickable+', '
                                      +TextEditable+', '
                                      +TextIcons+', '
                                      +TextPath+', "'
                                      +ColorToHTML(Polyline.Color)+'", '
                                      +IntToStr(Polyline.Width)+', '
                                      +Convert255To1(Polyline.Opacity)+' , '
                                      +TextVisible+', '
                                      +TextGeodesic+', '
                                      +TextZIndex+');';
    Result:=ExecuteJavascript(js) = ''
  end;
end;

function TTMSFMXWebGMaps.MapZoomTo(Bounds: TBounds): Boolean;
var
  neTextLat,neTextLng,swTextLat,swTextLng:String;
begin
  neTextLat := ConvertCoordinateToString(Bounds.NorthEast.Latitude);
  neTextLng := ConvertCoordinateToString(Bounds.NorthEast.Longitude);
  swTextLat := ConvertCoordinateToString(Bounds.SouthWest.Latitude);
  swTextLng := ConvertCoordinateToString(Bounds.SouthWest.Longitude);
  Result:=ExecuteJavascript('map.fitBounds(new google.maps.LatLngBounds(new google.maps.LatLng('+swTextLat+', '+swTextLng+'), new google.maps.LatLng('+neTextLat+', '+neTextLng+')));') = '';
end;

function TTMSFMXWebGMaps.openMarkerInfoWindowHtml(Id: Integer;
  HtmlText: String): Boolean;
begin
  HtmlText := StringReplace(HtmlText, '"', '\"', [rfReplaceAll]);
  Result:=ExecuteJavascript('openMarkerInfoWindowHtml('+inttostr(Id)+',"'+HtmlText+'");') = '';
end;

constructor TTMSFMXWebGMaps.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FMapOptions := TMapOptions.Create(Self);
  FStreetViewOptions := TStreetViewOptions.Create(Self);
  FControlsOptions := TControlsOptions.Create(Self);
  FWeatherOptions := TWeatherOptions.Create(Self);
  FDirections := TDirections.Create(Self);
  FAPIKey := EmptyStr;

  FMarkers := TMarkers.Create(Self);
  FPolylines := TPolylines.Create(Self);
  FPolygons := TPolygons.Create(Self);

  bLaunchFinish:=False;

  Width             := DEFAULT_WIDTH;
  Height            := DEFAULT_HEIGHT;
  CompleteHtmlFile  := '';
  Width := 400;
  Height := 250;
  TPolylineCount := 0;
  TPolygonCount := 0;
end;

function TTMSFMXWebGMaps.CreateMapMarker(Marker: TMarker): Boolean;
var
  TextLat,TextLng,TextDrag,TextVisible,TextClickable,TextFlat,TextDropAnimation,
  TextZIndex,TextLabelColor,TextLabelBorderColor,TextLabelPadding,
  TextLabelFontName,TextLabelFontColor,TextLabelFontSize,TextLabelText:String;
begin
  TextLat    := ConvertCoordinateToString(Marker.Latitude);
  TextLng    := ConvertCoordinateToString(Marker.Longitude);
  TextZIndex := IntToStr(Marker.Zindex);

  if Marker.Draggable then
    TextDrag := 'true'
  else
    TextDrag := 'false';

  if Marker.Visible then
    TextVisible := 'true'
  else
    TextVisible := 'false';

  if Marker.Clickable then
    TextClickable := 'true'
  else
    TextClickable := 'false';

  if Marker.Flat then
    TextFlat := 'true'
  else
    TextFlat := 'false';

  if Marker.InitialDropAnimation then
    TextDropAnimation := 'true'
  else
    TextDropAnimation := 'false';

  TextLabelText := Marker.MapLabel.Text;
  TextLabelColor := ColorToHTML(Marker.MapLabel.Color);
  TextLabelBorderColor := ColorToHTML(Marker.MapLabel.BorderColor);
  TextLabelPadding := IntToStr(Marker.MapLabel.Margin);
  TextLabelFontName := Marker.MapLabel.Font.Family;
  TextLabelFontColor := ColorToHTML(Marker.MapLabel.FontColor);
  TextLabelFontSize := FloatToStr(Marker.MapLabel.Font.Size);

  Result:=ExecuteJavascript('createMapMarker("'+TextLat+'", "'
                                      +TextLng+'", "'
                                      +StringReplace(Marker.Title, '"', '\"', [rfReplaceAll]) +'", '
                                      +TextDrag+', '
                                      +TextVisible+', '
                                      +TextClickable+', '
                                      +TextFlat+', '
                                      +TextDropAnimation+', "'
                                      +Marker.Icon+'" , '
                                      +TextZIndex+' , "'
                                      +StringReplace(TextLabelText, '"', '&quot;', [rfReplaceAll]) +'", "'
                                      +TextLabelColor+'", "'
                                      +TextLabelBorderColor+'", '
                                      +TextLabelPadding+', "'
                                      +TextLabelFontName+'", "'
                                      +TextLabelFontColor+'", '
                                      +TextLabelFontSize+' '
                                      +' );') = ''

end;

function TTMSFMXWebGMaps.CreateMapPolygon(Polygon: TMapPolygon): Boolean;
begin
  Result := MapPolygonToJS(Polygon, false);
end;

function TTMSFMXWebGMaps.CreateMapPolyline(Polyline: TPolyline): Boolean;
begin
  Result := MapPolylineToJS(Polyline, false);
end;

procedure TTMSFMXWebGMaps.SetControlsOptions(const Value: TControlsOptions);
begin
  FControlsOptions := Value;
end;

procedure TTMSFMXWebGMaps.SetDirections(const Value: TDirections);
begin
  FDirections := Value;
end;

procedure TTMSFMXWebGMaps.SetMapOptions(const Value: TMapOptions);
begin
  FMapOptions := Value;
end;

procedure TTMSFMXWebGMaps.SetMarkers(const Value: TMarkers);
begin
  FMarkers.Assign(Value);
end;

procedure TTMSFMXWebGMaps.SetPolygons(const Value: TPolygons);
begin
  FPolygons.Assign(Value);
end;

procedure TTMSFMXWebGMaps.SetPolylines(const Value: TPolylines);
begin
  FPolylines.Assign(Value);
end;

procedure TTMSFMXWebGMaps.SetStreetViewOptions(const Value: TStreetViewOptions);
begin
  FStreetViewOptions := Value;
end;

procedure TTMSFMXWebGMaps.SetVersion(const Value: string);
begin

end;

procedure TTMSFMXWebGMaps.SetWeatherOptions(const Value: TWeatherOptions);
begin
  FWeatherOptions := Value;
end;

function TTMSFMXWebGMaps.StartMarkerBounceAnimation(Id: Integer): Boolean;
begin
  Result:=ExecuteJavascript('startMarkerBounceAnimation('+inttostr(Id)+');') = '';
end;

function TTMSFMXWebGMaps.StopMarkerBounceAnimation(Id: Integer): Boolean;
begin
  Result:=ExecuteJavascript('stopMarkerBounceAnimation('+inttostr(Id)+');') = '';
end;

function TTMSFMXWebGMaps.UpdateMapPolygon(Polygon: TMapPolygon): Boolean;
begin
  Result := MapPolygonToJS(Polygon, true);
end;

function TTMSFMXWebGMaps.UpdateMapPolyline(Polyline: TPolyline): Boolean;
begin
  Result := MapPolylineToJS(Polyline, true);
end;

{ TMapOptions }

constructor TMapOptions.Create(AWebGmaps: TTMSFMXWebGMaps);
begin
  inherited Create;
  FWebGmaps               := AWebGmaps;
  FDraggable              := True;
  FDisableControls        := False;
  FDisablePOI             := False;
  FShowTraffic            := False;
  FShowBicycling          := False;
  FShowPanoramio          := False;
  FShowCloud              := False;
  FDefaultLatitude        := DEFAULT_LATITUDE;
  FDefaultLongitude       := DEFAULT_LONGITUDE;
  FPreloaderVisible       := True;
  FZoomMap                := DEFAULT_ZOOM;
  FMapType                := mtDefault;
  FLanguage               := lnDefault;
end;

procedure TMapOptions.SetDefaultLatitude(const Value: Double);
begin
  FDefaultLatitude := Value;
end;

procedure TMapOptions.SetDefaultLongitude(const Value: Double);
begin
  FDefaultLongitude := Value;
end;

procedure TMapOptions.SetDisableControls(const Value: Boolean);
begin
  FDisableControls := Value;
  if Value then
    FWebGmaps.ExecuteJavascript('map.setOptions( {disableDefaultUI:true} );')
  else
    FWebGmaps.ExecuteJavascript('map.setOptions( {disableDefaultUI:false} );');
end;

procedure TMapOptions.SetDisablePOI(const Value: Boolean);
begin
  FDisablePOI := Value;
end;

procedure TMapOptions.SetDraggable(const Value: Boolean);
begin
  FDraggable := Value;
  if Value then
    FWebGmaps.ExecuteJavascript('map.setOptions( {draggable:true} );')
  else
    FWebGmaps.ExecuteJavascript('map.setOptions( {draggable:false} );')
end;

procedure TMapOptions.SetLanguage(const Value: TLanguageName);
begin
  FLanguage := Value;
  FWebGmaps.Initialize;
end;

procedure TMapOptions.SetMapType(const Value: TMapType);
begin
  FMapType := Value;
  case Value of
    mtDefault:
      FWebGmaps.ExecuteJavascript('map.setMapTypeId('+MAP_TYPE_PREFIX+MAP_DEFAULT+');');
    mtSatellite:
      FWebGmaps.ExecuteJavascript('map.setMapTypeId('+MAP_TYPE_PREFIX+MAP_SATELLITE+');');
    mtHybrid:
      FWebGmaps.ExecuteJavascript('map.setMapTypeId('+MAP_TYPE_PREFIX+MAP_HYBRID+');');
    mtTerrain:
      FWebGmaps.ExecuteJavascript('map.setMapTypeId('+MAP_TYPE_PREFIX+MAP_TERRAIN+');');
  end;
end;

procedure TMapOptions.SetPreloaderVisible(const Value: Boolean);
begin
  FPreloaderVisible := Value;
end;

procedure TMapOptions.SetShowBicycling(const Value: Boolean);
begin
  FShowBicycling := Value;
  if Value then
    FWebGmaps.ExecuteJavascript('ShowBicycling();')
  else
    FWebGmaps.ExecuteJavascript('HideBicyling();');
end;

procedure TMapOptions.SetShowCloud(const Value: Boolean);
begin
  FShowCloud := Value;
  if Value then
    FWebGmaps.ExecuteJavascript('ShowCloud();')
  else
    FWebGmaps.ExecuteJavascript('HideCloud();');
end;

procedure TMapOptions.SetShowPanoramio(const Value: Boolean);
begin
  FShowPanoramio := Value;
  if Value then
    FWebGmaps.ExecuteJavascript('ShowPanoramio();')
  else
    FWebGmaps.ExecuteJavascript('HidePanoramio();');
end;

procedure TMapOptions.SetShowTraffic(const Value: Boolean);
begin
  FShowTraffic := Value;
  if Value then
    FWebGmaps.ExecuteJavascript('ShowTraffic();')
  else
    FWebGmaps.ExecuteJavascript('HideTraffic();');
end;

procedure TMapOptions.SetShowWeather(const Value: Boolean);
begin
  FShowWeather := Value;
  if Value then
    FWebGmaps.ExecuteJavascript('ShowWeather();')
  else
    FWebGmaps.ExecuteJavascript('HideWeather();');
end;

procedure TMapOptions.SetZoomMap(const Value: TZoomMap);
begin
  FZoomMap := Value;
  FWebGmaps.ExecuteJavascript('setzoommap('+inttostr(Value)+');');
end;

{ TStreetViewOptions }

procedure TStreetViewOptions.Assign(Source: TPersistent);
begin
  if (Source is TStreetViewOptions) then
  begin
     FDefaultLatitude := (Source as TStreetViewOptions).DefaultLatitude;
     FDefaultLongitude := (Source as TStreetViewOptions).DefaultLongitude;
     FHeading := (Source as TStreetViewOptions).Heading;
     FPitch := (Source as TStreetViewOptions).Pitch;
     FZoom := (Source as TStreetViewOptions).Zoom;
     FVisible := (Source as TStreetViewOptions).Visible;
  end;
end;

constructor TStreetViewOptions.Create(AWebGmaps: TTMSFMXWebGMaps);
begin
  inherited Create;
  FWebGmaps          := AWebGmaps;
  FDefaultLatitude   := DEFAULT_LATITUDE;
  FDefaultLongitude  := DEFAULT_LONGITUDE;
  FHeading           := 0;
  FZoom              := 0;
  FPitch             := 0;
end;

procedure TStreetViewOptions.InitStreetView;
var
  TextLat,TextLng:String;
begin
  TextLat := ConvertCoordinateToString(FDefaultLatitude);
  TextLng := ConvertCoordinateToString(FDefaultLongitude);
  FWebGmaps.ExecuteJavascript('showStreetview("'+TextLat+'", "'+TextLng+'", '+
                                           inttostr(FHeading)+', '+
                                           inttostr(FZoom)+', '+
                                           inttostr(FPitch)+' );');
end;

procedure TStreetViewOptions.SetDefaultLatitude(const Value: Double);
begin
  FDefaultLatitude := Value;
end;

procedure TStreetViewOptions.SetDefaultLongitude(const Value: Double);
begin
  FDefaultLongitude := Value;
end;

procedure TStreetViewOptions.SetHeading(const Value: THeadingStreetView);
begin
  FHeading := Value;
end;

procedure TStreetViewOptions.SetPitch(const Value: TPitchStreetView);
begin
  FPitch := Value;
end;

procedure TStreetViewOptions.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
  if Value then
    InitStreetView
  else
    FWebGmaps.ExecuteJavascript('streetviewPanorama.setVisible(false);');
end;

procedure TStreetViewOptions.SetZoom(const Value: TZoomStreetView);
begin
  FZoom := Value;
end;

{ TWeatherOptions }

constructor TWeatherOptions.Create(AWebGmaps: TTMSFMXWebGMaps);
begin
  inherited Create;
  FWebGmaps        := AWebGmaps;
  FTemperatureUnit := wtCelsius;
  FWindSpeedUnit   := wwsKilometersPerHour;
  FLabelColor      := wlcBlack;
  FShowInfoWindows := True;
end;

procedure TWeatherOptions.SetLabelColor(const Value: TWeatherLabelColor);
begin
  FLabelColor := Value;
  case Value of
    wlcBlack:
      FWebGmaps.ExecuteJavascript('weatherLayer.setOptions( {labelColor:google.maps.weather.LabelColor.'+WEATHER_LABEL_COLOR_BLACK+'} );');
    wlcWhite:
      FWebGmaps.ExecuteJavascript('weatherLayer.setOptions( {labelColor:google.maps.weather.LabelColor.'+WEATHER_LABEL_COLOR_WHITE+'} );');
  end;
end;

procedure TWeatherOptions.SetShowInfoWindows(const Value: Boolean);
begin
  FShowInfoWindows := Value;
  if Value then
    FWebGmaps.ExecuteJavascript('weatherLayer.setOptions( {suppressInfoWindows:false} );')
  else
    FWebGmaps.ExecuteJavascript('weatherLayer.setOptions( {suppressInfoWindows:true} );');
end;

procedure TWeatherOptions.SetTemperatureUnit(const Value: TWeatherTemperatures);
begin
  FTemperatureUnit := Value;
  case Value of
    wtCelsius:
      FWebGmaps.ExecuteJavascript('weatherLayer.setOptions( {temperatureUnits:google.maps.weather.TemperatureUnit.'+WEATHER_TEMPERATURE_CELSIUS+'} );');
    wtFahrenheit:
      FWebGmaps.ExecuteJavascript('weatherLayer.setOptions( {temperatureUnits:google.maps.weather.TemperatureUnit.'+WEATHER_TEMPERATURE_FAHRENHEIT+'} );');
  end;
end;

procedure TWeatherOptions.SetWindSpeedUnit(const Value: TWeatherWindSpeed);
begin
  FWindSpeedUnit := Value;
  case Value of
    wwsKilometersPerHour:
      FWebGmaps.ExecuteJavascript('weatherLayer.setOptions( {windSpeedUnits:google.maps.weather.WindSpeedUnit.'+WEATHER_WIND_SPEED_KILOMETERS_PER_HOUR+'} );');
    wwsMetersPerSecond:
      FWebGmaps.ExecuteJavascript('weatherLayer.setOptions( {windSpeedUnits:google.maps.weather.WindSpeedUnit.'+WEATHER_WIND_SPEED_METERS_PER_SECOND+'} );');
    wwsMilesPerHour:
      FWebGmaps.ExecuteJavascript('weatherLayer.setOptions( {windSpeedUnits:google.maps.weather.WindSpeedUnit.'+WEATHER_WIND_SPEED_MILES_PER_HOUR+'} );');
  end;
end;

end.
