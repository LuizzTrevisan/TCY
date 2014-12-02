// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TMSWebGMaps.pas' rev: 28.00 (Windows)

#ifndef Fmx_TmswebgmapsHPP
#define Fmx_TmswebgmapsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsWebBrowser.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsConst.hpp>	// Pascal unit
#include <System.StrUtils.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.TypInfo.hpp>	// Pascal unit
#include <FMX.Forms.hpp>	// Pascal unit
#include <FMX.Dialogs.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsWebKit.hpp>	// Pascal unit
#include <FMX.Types.hpp>	// Pascal unit
#include <FMX.Objects.hpp>	// Pascal unit
#include <FMX.Controls.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsCommon.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsControls.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsCommonFunctions.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsPolygons.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsPolylines.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsMarkers.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsDirections.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <Data.DBXJSON.hpp>	// Pascal unit
#include <System.JSON.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Tmswebgmaps
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TWebGMapsErrorEvent)(System::TObject* Sender, Fmx::Tmswebgmapscommon::TErrorType ErrorType);

typedef void __fastcall (__closure *TMapTypeChange)(System::TObject* Sender, Fmx::Tmswebgmapscommon::TMapType NewMapType);

typedef void __fastcall (__closure *TGMapsError)(System::TObject* Sender, Fmx::Tmswebgmapscommon::TErrorType ErrorType);

typedef void __fastcall (__closure *TEventMarker)(System::TObject* Sender, System::UnicodeString MarkerTitle, int IdMarker, double Latitude, double Longitude);

typedef void __fastcall (__closure *TEventMarkerClick)(System::TObject* Sender, System::UnicodeString MarkerTitle, int IdMarker, double Latitude, double Longitude);

typedef void __fastcall (__closure *TEventKMLLayer)(System::TObject* Sender, System::UnicodeString ObjectName, int IdLayer, double Latitude, double Longitude);

typedef void __fastcall (__closure *TEventPolyline)(System::TObject* Sender, int IdPolyline);

typedef void __fastcall (__closure *TEventPolylineClick)(System::TObject* Sender, int IdPolyline);

typedef void __fastcall (__closure *TEventPolygon)(System::TObject* Sender, int IdPolygon);

typedef void __fastcall (__closure *TEventPolygonClick)(System::TObject* Sender, int IdPolygon);

typedef void __fastcall (__closure *TEventBounds)(System::TObject* Sender, Fmx::Tmswebgmapscommonfunctions::TBounds* Bounds);

typedef void __fastcall (__closure *TEventInfoWindow)(System::TObject* Sender, int IdMarker);

typedef void __fastcall (__closure *TPositionMap)(System::TObject* Sender, double Latitude, double Longitude, int X, int Y);

typedef void __fastcall (__closure *TPositionMouseMap)(System::TObject* Sender, double Latitude, double Longitude, int X, int Y);

typedef void __fastcall (__closure *TMapZoomChange)(System::TObject* Sender, int NewLevel);

typedef void __fastcall (__closure *TExternalMapTypeChange)(System::TObject* Sender, int NewMapType);

typedef void __fastcall (__closure *TStreetViewChange)(System::TObject* Sender, int Heading, int Pitch, int Zoom);

class DELPHICLASS TStreetViewOptions;
class DELPHICLASS TTMSFMXWebGMaps;
class PASCALIMPLEMENTATION TStreetViewOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	double FDefaultLongitude;
	Fmx::Tmswebgmapscommon::TPitchStreetView FPitch;
	double FDefaultLatitude;
	Fmx::Tmswebgmapscommon::THeadingStreetView FHeading;
	Fmx::Tmswebgmapscommon::TZoomStreetView FZoom;
	TTMSFMXWebGMaps* FWebGmaps;
	bool FVisible;
	void __fastcall InitStreetView(void);
	void __fastcall SetDefaultLatitude(const double Value);
	void __fastcall SetDefaultLongitude(const double Value);
	void __fastcall SetHeading(const Fmx::Tmswebgmapscommon::THeadingStreetView Value);
	void __fastcall SetPitch(const Fmx::Tmswebgmapscommon::TPitchStreetView Value);
	void __fastcall SetZoom(const Fmx::Tmswebgmapscommon::TZoomStreetView Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TStreetViewOptions(TTMSFMXWebGMaps* AWebGmaps);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property double DefaultLatitude = {read=FDefaultLatitude, write=SetDefaultLatitude};
	__property double DefaultLongitude = {read=FDefaultLongitude, write=SetDefaultLongitude};
	__property Fmx::Tmswebgmapscommon::THeadingStreetView Heading = {read=FHeading, write=SetHeading, default=0};
	__property Fmx::Tmswebgmapscommon::TPitchStreetView Pitch = {read=FPitch, write=SetPitch, default=0};
	__property Fmx::Tmswebgmapscommon::TZoomStreetView Zoom = {read=FZoom, write=SetZoom, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TStreetViewOptions(void) { }
	
};


class DELPHICLASS TMapOptions;
class PASCALIMPLEMENTATION TMapOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FDraggable;
	double FDefaultLongitude;
	bool FPreloaderVisible;
	double FDefaultLatitude;
	Fmx::Tmswebgmapscommon::TZoomMap FZoomMap;
	Fmx::Tmswebgmapscommon::TMapType FMapType;
	TTMSFMXWebGMaps* FWebGmaps;
	bool FDisableControls;
	bool FShowTraffic;
	Fmx::Tmswebgmapscommon::TLanguageName FLanguage;
	bool FShowBicycling;
	bool FShowPanoramio;
	bool FShowCloud;
	bool FShowWeather;
	bool FDisablePOI;
	void __fastcall SetDraggable(const bool Value);
	void __fastcall SetDefaultLatitude(const double Value);
	void __fastcall SetDefaultLongitude(const double Value);
	void __fastcall SetMapType(const Fmx::Tmswebgmapscommon::TMapType Value);
	void __fastcall SetPreloaderVisible(const bool Value);
	void __fastcall SetZoomMap(const Fmx::Tmswebgmapscommon::TZoomMap Value);
	void __fastcall SetDisableControls(const bool Value);
	void __fastcall SetShowTraffic(const bool Value);
	void __fastcall SetLanguage(const Fmx::Tmswebgmapscommon::TLanguageName Value);
	void __fastcall SetShowBicycling(const bool Value);
	void __fastcall SetShowPanoramio(const bool Value);
	void __fastcall SetShowCloud(const bool Value);
	void __fastcall SetShowWeather(const bool Value);
	void __fastcall SetDisablePOI(const bool Value);
	
public:
	__fastcall TMapOptions(TTMSFMXWebGMaps* AWebGmaps);
	
__published:
	__property Fmx::Tmswebgmapscommon::TLanguageName Language = {read=FLanguage, write=SetLanguage, default=0};
	__property bool Draggable = {read=FDraggable, write=SetDraggable, default=1};
	__property Fmx::Tmswebgmapscommon::TZoomMap ZoomMap = {read=FZoomMap, write=SetZoomMap, default=10};
	__property Fmx::Tmswebgmapscommon::TMapType MapType = {read=FMapType, write=SetMapType, default=0};
	__property double DefaultLatitude = {read=FDefaultLatitude, write=SetDefaultLatitude};
	__property double DefaultLongitude = {read=FDefaultLongitude, write=SetDefaultLongitude};
	__property bool PreloaderVisible = {read=FPreloaderVisible, write=SetPreloaderVisible, default=1};
	__property bool ShowTraffic = {read=FShowTraffic, write=SetShowTraffic, default=0};
	__property bool ShowBicycling = {read=FShowBicycling, write=SetShowBicycling, default=0};
	__property bool ShowPanoramio = {read=FShowPanoramio, write=SetShowPanoramio, default=0};
	__property bool ShowCloud = {read=FShowCloud, write=SetShowCloud, default=0};
	__property bool ShowWeather = {read=FShowWeather, write=SetShowWeather, default=0};
	__property bool DisableControls = {read=FDisableControls, write=SetDisableControls, default=0};
	__property bool DisablePOI = {read=FDisablePOI, write=SetDisablePOI, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TMapOptions(void) { }
	
};


class DELPHICLASS TWeatherOptions;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TWeatherOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmx::Tmswebgmapscommon::TWeatherWindSpeed FWindSpeedUnit;
	bool FShowInfoWindows;
	Fmx::Tmswebgmapscommon::TWeatherLabelColor FLabelColor;
	Fmx::Tmswebgmapscommon::TWeatherTemperatures FTemperatureUnit;
	TTMSFMXWebGMaps* FWebGmaps;
	void __fastcall SetLabelColor(const Fmx::Tmswebgmapscommon::TWeatherLabelColor Value);
	void __fastcall SetShowInfoWindows(const bool Value);
	void __fastcall SetTemperatureUnit(const Fmx::Tmswebgmapscommon::TWeatherTemperatures Value);
	void __fastcall SetWindSpeedUnit(const Fmx::Tmswebgmapscommon::TWeatherWindSpeed Value);
	
public:
	__fastcall TWeatherOptions(TTMSFMXWebGMaps* AWebGmaps);
	
__published:
	__property Fmx::Tmswebgmapscommon::TWeatherTemperatures TemperatureUnit = {read=FTemperatureUnit, write=SetTemperatureUnit, default=0};
	__property Fmx::Tmswebgmapscommon::TWeatherLabelColor LabelColor = {read=FLabelColor, write=SetLabelColor, default=0};
	__property Fmx::Tmswebgmapscommon::TWeatherWindSpeed WindSpeedUnit = {read=FWindSpeedUnit, write=SetWindSpeedUnit, default=0};
	__property bool ShowInfoWindows = {read=FShowInfoWindows, write=SetShowInfoWindows, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWeatherOptions(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TJSEventParameter
{
public:
	System::UnicodeString parameter;
	System::UnicodeString value;
};


typedef System::DynamicArray<TJSEventParameter> TJSEventParameters;

class PASCALIMPLEMENTATION TTMSFMXWebGMaps : public Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser
{
	typedef Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser inherited;
	
private:
	bool bLaunchFinish;
	Fmx::Tmswebgmapspolylines::TPolylines* FPolylines;
	Fmx::Tmswebgmapsmarkers::TMarkers* FMarkers;
	Fmx::Tmswebgmapscontrols::TControlsOptions* FControlsOptions;
	Fmx::Tmswebgmapspolygons::TPolygons* FPolygons;
	TMapOptions* FMapOptions;
	TStreetViewOptions* FStreetViewOptions;
	TWeatherOptions* FWeatherOptions;
	System::UnicodeString FAPIKey;
	TWebGMapsErrorEvent FOnWebGMapsError;
	System::UnicodeString CompleteHtmlFile;
	System::Classes::TNotifyEvent FOnDownloadFinish;
	TEventMarkerClick FOnMarkerClick;
	TEventKMLLayer FOnKMLLayerClick;
	TPositionMouseMap FOnMapClick;
	TPositionMap FOnMapMoveStart;
	TPositionMap FOnMapMoveEnd;
	TMapZoomChange FOnMapZoomChange;
	TEventMarker FOnMarkerDragStart;
	TEventMarker FOnMarkerDragEnd;
	TMapTypeChange FOnMapTypeChange;
	TPositionMap FOnMapDblClick;
	TPositionMap FOnMapMove;
	System::Classes::TNotifyEvent FOnMapIdle;
	TEventInfoWindow FOnMarkerInfoWindowCloseClick;
	TEventMarker FOnMarkerDblClick;
	TEventMarker FOnMarkerDrag;
	TPositionMap FOnStreetViewMove;
	TStreetViewChange FOnStreetViewChange;
	TEventPolylineClick FOnPolylineClick;
	TEventPolyline FOnPolylineDblClick;
	TEventPolygonClick FOnPolygonClick;
	TEventPolygon FOnPolygonDblClick;
	TEventBounds FOnBoundsRetrieved;
	Fmx::Tmswebgmapsdirections::TDirections* FDirections;
	System::UnicodeString __fastcall InitHtmlFile(void);
	HIDESBASE virtual int __fastcall GetVersionNr(void);
	bool __fastcall MapPolylineToJS(Fmx::Tmswebgmapspolylines::TPolyline* Polyline, bool IsUpdate);
	bool __fastcall MapPolygonToJS(Fmx::Tmswebgmapspolygons::TMapPolygon* Polygon, bool IsUpdate);
	HIDESBASE System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetControlsOptions(Fmx::Tmswebgmapscontrols::TControlsOptions* const Value);
	void __fastcall SetMarkers(Fmx::Tmswebgmapsmarkers::TMarkers* const Value);
	void __fastcall SetPolygons(Fmx::Tmswebgmapspolygons::TPolygons* const Value);
	void __fastcall SetPolylines(Fmx::Tmswebgmapspolylines::TPolylines* const Value);
	HIDESBASE void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetMapOptions(TMapOptions* const Value);
	void __fastcall SetStreetViewOptions(TStreetViewOptions* const Value);
	void __fastcall SetWeatherOptions(TWeatherOptions* const Value);
	void __fastcall SetDirections(Fmx::Tmswebgmapsdirections::TDirections* const Value);
	
protected:
	void __fastcall OnProgressChange(System::TObject* Sender, int Progress, int ProgressMax);
	void __fastcall MarkerClick(System::TObject* Sender, System::UnicodeString MarkerTitle, int IdMarker, double Latitude, double Longitude);
	void __fastcall KMLLayerClick(System::TObject* Sender, System::UnicodeString ObjectName, int IdLayer, double Latitude, double Longitude);
	void __fastcall MarkerDblClick(System::TObject* Sender, System::UnicodeString MarkerTitle, int IdMarker, double Latitude, double Longitude);
	void __fastcall MarkerInfoWindowCloseClick(System::TObject* Sender, int IdMarker);
	void __fastcall MarkerDragStart(System::TObject* Sender, System::UnicodeString MarkerTitle, int IdMarker, double Latitude, double Longitude);
	void __fastcall MarkerDrag(System::TObject* Sender, System::UnicodeString MarkerTitle, int IdMarker, double Latitude, double Longitude);
	void __fastcall MarkerDragEnd(System::TObject* Sender, System::UnicodeString MarkerTitle, int IdMarker, double Latitude, double Longitude);
	void __fastcall PolylineClick(System::TObject* Sender, int IdPolyline);
	void __fastcall PolylineDblClick(System::TObject* Sender, int IdPolyline);
	void __fastcall PolygonClick(System::TObject* Sender, int IdPolygon);
	void __fastcall PolygonDblClick(System::TObject* Sender, int IdPolygon);
	void __fastcall BoundsRetrieved(System::TObject* Sender, Fmx::Tmswebgmapscommonfunctions::TBounds* Bounds);
	void __fastcall MapClick(System::TObject* Sender, double Latitude, double Longitude, int X, int Y);
	void __fastcall MapDblClick(System::TObject* Sender, double Latitude, double Longitude, int X, int Y);
	void __fastcall MapMoveStart(System::TObject* Sender, double Latitude, double Longitude, int X, int Y);
	void __fastcall MapMoveEnd(System::TObject* Sender, double Latitude, double Longitude, int X, int Y);
	void __fastcall MapMove(System::TObject* Sender, double Latitude, double Longitude, int X, int Y);
	void __fastcall StreetViewMove(System::TObject* Sender, double Latitude, double Longitude, int X, int Y);
	void __fastcall StreetViewChange(System::TObject* Sender, int Heading, int Pitch, int Zoom);
	void __fastcall MapTilesLoad(System::TObject* Sender);
	void __fastcall MapIdle(System::TObject* Sender);
	void __fastcall MapZoomChange(System::TObject* Sender, int NewLevel);
	void __fastcall MapTypeChange(System::TObject* Sender, int NewMapType);
	void __fastcall GMapsError(System::TObject* Sender, Fmx::Tmswebgmapscommon::TErrorType ErrorType);
	virtual void __fastcall BeforeNavigate(Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsCustomWebBrowserBeforeNavigateParams &Params);
	bool __fastcall ParseForJSEvent(System::UnicodeString urlstr);
	
public:
	__property System::UnicodeString APIKey = {read=FAPIKey, write=FAPIKey};
	__fastcall virtual ~TTMSFMXWebGMaps(void);
	__fastcall virtual TTMSFMXWebGMaps(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual System::UnicodeString __fastcall ExecuteJavascript(System::UnicodeString AScript);
	virtual void __fastcall Initialize(void);
	void __fastcall GoToAddress(System::UnicodeString Address);
	void __fastcall DoEvent(System::UnicodeString AEvent, TJSEventParameters AParameters);
	bool __fastcall AddMapKMLLayer(System::UnicodeString Url, bool ZoomToBounds = true);
	bool __fastcall DeleteMapKMLLayer(int Id);
	bool __fastcall DeleteAllMapKMLLayer(void);
	bool __fastcall DeleteAllMapMarker(void);
	bool __fastcall CreateMapMarker(Fmx::Tmswebgmapsmarkers::TMarker* Marker);
	bool __fastcall DeleteMapMarker(int Id);
	bool __fastcall CreateMapPolyline(Fmx::Tmswebgmapspolylines::TPolyline* Polyline);
	bool __fastcall UpdateMapPolyline(Fmx::Tmswebgmapspolylines::TPolyline* Polyline);
	bool __fastcall DeleteMapPolyline(int Id);
	bool __fastcall DeleteAllMapPolyline(void);
	bool __fastcall CreateMapPolygon(Fmx::Tmswebgmapspolygons::TMapPolygon* Polygon);
	bool __fastcall UpdateMapPolygon(Fmx::Tmswebgmapspolygons::TMapPolygon* Polygon);
	bool __fastcall DeleteMapPolygon(int Id);
	bool __fastcall DeleteAllMapPolygon(void);
	bool __fastcall openMarkerInfoWindowHtml(int Id, System::UnicodeString HtmlText);
	bool __fastcall CloseMarkerInfoWindowHtml(int Id);
	bool __fastcall StartMarkerBounceAnimation(int Id);
	bool __fastcall StopMarkerBounceAnimation(int Id);
	bool __fastcall MapPanTo(double Latitude, double Longitude);
	bool __fastcall MapZoomTo(Fmx::Tmswebgmapscommonfunctions::TBounds* Bounds);
	bool __fastcall MapPanBy(int X, int Y);
	bool __fastcall GetMapBounds(void);
	bool __fastcall DegreesToLonLat(System::UnicodeString StrLon, System::UnicodeString StrLat, double &Lon, double &Lat);
	bool __fastcall RenderDirections(System::UnicodeString Origin, System::UnicodeString Destination, Fmx::Tmswebgmapscommon::TTravelMode TravelMode = (Fmx::Tmswebgmapscommon::TTravelMode)(0x0), bool AvoidHighways = false, bool AvoidTolls = false, System::Classes::TStringList* WayPoints = (System::Classes::TStringList*)(0x0), bool OptimizeWayPoints = false)/* overload */;
	bool __fastcall RenderDirections(double OriginLatitude, double OriginLongitude, double DestinationLatitude, double DestinationLongitude, Fmx::Tmswebgmapscommon::TTravelMode TravelMode = (Fmx::Tmswebgmapscommon::TTravelMode)(0x0), bool AvoidHighways = false, bool AvoidTolls = false, System::Classes::TStringList* WayPoints = (System::Classes::TStringList*)(0x0), bool OptimizeWayPoints = false)/* overload */;
	bool __fastcall RemoveDirections(void);
	void __fastcall GetDirections(System::UnicodeString Origin, System::UnicodeString Destination, bool Alternatives = false, Fmx::Tmswebgmapscommon::TTravelMode TravelMode = (Fmx::Tmswebgmapscommon::TTravelMode)(0x0), Fmx::Tmswebgmapscommon::TUnits Units = (Fmx::Tmswebgmapscommon::TUnits)(0x0), Fmx::Tmswebgmapscommon::TLanguageName Language = (Fmx::Tmswebgmapscommon::TLanguageName)(0x0), bool StripHTML = true, bool AvoidHighways = false, bool AvoidTolls = false, System::Classes::TStringList* WayPoints = (System::Classes::TStringList*)(0x0), bool OptimizeWayPoints = false)/* overload */;
	void __fastcall GetDirections(double OriginLatitude, double OriginLongitude, double DestinationLatitude, double DestinationLongitude, bool Alternatives = false, Fmx::Tmswebgmapscommon::TTravelMode TravelMode = (Fmx::Tmswebgmapscommon::TTravelMode)(0x0), Fmx::Tmswebgmapscommon::TUnits Units = (Fmx::Tmswebgmapscommon::TUnits)(0x0), Fmx::Tmswebgmapscommon::TLanguageName Language = (Fmx::Tmswebgmapscommon::TLanguageName)(0x0), bool StripHTML = true, bool AvoidHighways = false, bool AvoidTolls = false, System::Classes::TStringList* WayPoints = (System::Classes::TStringList*)(0x0), bool OptimizeWayPoints = false)/* overload */;
	double __fastcall Distance(double la1, double lo1, double la2, double lo2);
	
__published:
	__property Align = {default=0};
	__property Anchors;
	__property Fmx::Tmswebgmapsmarkers::TMarkers* Markers = {read=FMarkers, write=SetMarkers};
	__property Fmx::Tmswebgmapspolylines::TPolylines* Polylines = {read=FPolylines, write=SetPolylines};
	__property Fmx::Tmswebgmapspolygons::TPolygons* Polygons = {read=FPolygons, write=SetPolygons};
	__property TMapOptions* MapOptions = {read=FMapOptions, write=SetMapOptions};
	__property Fmx::Tmswebgmapsdirections::TDirections* Directions = {read=FDirections, write=SetDirections};
	__property TStreetViewOptions* StreetViewOptions = {read=FStreetViewOptions, write=SetStreetViewOptions};
	__property Fmx::Tmswebgmapscontrols::TControlsOptions* ControlsOptions = {read=FControlsOptions, write=SetControlsOptions};
	__property TabOrder = {default=-1};
	__property TWeatherOptions* WeatherOptions = {read=FWeatherOptions, write=SetWeatherOptions};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TWebGMapsErrorEvent OnWebGMapsError = {read=FOnWebGMapsError, write=FOnWebGMapsError};
	__property System::Classes::TNotifyEvent OnDownloadFinish = {read=FOnDownloadFinish, write=FOnDownloadFinish};
	__property System::Classes::TNotifyEvent OnMapIdle = {read=FOnMapIdle, write=FOnMapIdle};
	__property TEventMarkerClick OnMarkerClick = {read=FOnMarkerClick, write=FOnMarkerClick};
	__property TEventKMLLayer OnKMLLayerClick = {read=FOnKMLLayerClick, write=FOnKMLLayerClick};
	__property TEventMarker OnMarkerDblClick = {read=FOnMarkerDblClick, write=FOnMarkerDblClick};
	__property TEventInfoWindow OnMarkerInfoWindowCloseClick = {read=FOnMarkerInfoWindowCloseClick, write=FOnMarkerInfoWindowCloseClick};
	__property TEventMarker OnMarkerDragStart = {read=FOnMarkerDragStart, write=FOnMarkerDragStart};
	__property TEventMarker OnMarkerDrag = {read=FOnMarkerDrag, write=FOnMarkerDrag};
	__property TEventMarker OnMarkerDragEnd = {read=FOnMarkerDragEnd, write=FOnMarkerDragEnd};
	__property TEventPolylineClick OnPolylineClick = {read=FOnPolylineClick, write=FOnPolylineClick};
	__property TEventPolyline OnPolylineDblClick = {read=FOnPolylineDblClick, write=FOnPolylineDblClick};
	__property TEventPolygonClick OnPolygonClick = {read=FOnPolygonClick, write=FOnPolygonClick};
	__property TEventPolygon OnPolygonDblClick = {read=FOnPolygonDblClick, write=FOnPolygonDblClick};
	__property TEventBounds OnBoundsRetrieved = {read=FOnBoundsRetrieved, write=FOnBoundsRetrieved};
	__property TPositionMouseMap OnMapClick = {read=FOnMapClick, write=FOnMapClick};
	__property TPositionMap OnMapDblClick = {read=FOnMapDblClick, write=FOnMapDblClick};
	__property TPositionMap OnMapMoveStart = {read=FOnMapMoveStart, write=FOnMapMoveStart};
	__property TPositionMap OnMapMoveEnd = {read=FOnMapMoveEnd, write=FOnMapMoveEnd};
	__property TPositionMap OnMapMove = {read=FOnMapMove, write=FOnMapMove};
	__property TPositionMap OnStreetViewMove = {read=FOnStreetViewMove, write=FOnStreetViewMove};
	__property TStreetViewChange OnStreetViewChange = {read=FOnStreetViewChange, write=FOnStreetViewChange};
	__property TMapZoomChange OnMapZoomChange = {read=FOnMapZoomChange, write=FOnMapZoomChange};
	__property TMapTypeChange OnMapTypeChange = {read=FOnMapTypeChange, write=FOnMapTypeChange};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MAJ_VER = System::Int8(0x1);
static const System::Int8 MIN_VER = System::Int8(0x9);
static const System::Int8 REL_VER = System::Int8(0x0);
static const System::Int8 BLD_VER = System::Int8(0x1);
extern DELPHI_PACKAGE System::UnicodeString HTMLStr;
extern DELPHI_PACKAGE System::UnicodeString __fastcall ReplaceTextControlPosition(System::UnicodeString Script, System::UnicodeString TextToReplace, Fmx::Tmswebgmapscommon::TControlPosition Position);
}	/* namespace Tmswebgmaps */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TMSWEBGMAPS)
using namespace Fmx::Tmswebgmaps;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TmswebgmapsHPP
