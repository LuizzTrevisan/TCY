// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TMSWebGMapsCommon.pas' rev: 28.00 (Windows)

#ifndef Fmx_TmswebgmapscommonHPP
#define Fmx_TmswebgmapscommonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Tmswebgmapscommon
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TGeocodingResult : unsigned char { erOk, erZeroResults, erOverQueryLimit, erRequestDenied, erInvalidRequest, erOtherProblem };

enum DECLSPEC_DENUM TLocationType : unsigned char { ltRoofTop, ltRangeInterpolated, ltGeometricCenter, ltApproximate, ltNotInitialize };

enum DECLSPEC_DENUM TErrorType : unsigned char { etGMapsProblem, etScreenshotProblem, etJavascriptError, etNotValidMarker, etStreetViewUnknownError, etStreetViewNoResults };

enum DECLSPEC_DENUM TControlPosition : unsigned char { cpTopRight, cpTopLeft, cpTopCenter, cpBottomRight, cpBottomLeft, cpBottomCenter, cpLeftBottom, cpLeftCenter, cpLeftTop, cpRightBottom, cpRightCenter, cpRightTop };

enum DECLSPEC_DENUM TMapType : unsigned char { mtDefault, mtSatellite, mtHybrid, mtTerrain };

enum DECLSPEC_DENUM TControlsType : unsigned char { ctDefault, ctAndroid, ctSmall, ctZoomPan };

enum DECLSPEC_DENUM TZoomStyle : unsigned char { zsDefault, zsSmall, zsLarge };

enum DECLSPEC_DENUM TImgType : unsigned char { itBitmap, itJpeg, itPng };

enum DECLSPEC_DENUM TMapTypeStyle : unsigned char { mtsDefault, mtsDropDownMenu, mtsHorizontalBar };

typedef System::Int8 TZoomMap;

typedef System::Int8 TZoomStreetView;

typedef System::Word THeadingStreetView;

typedef System::Int8 TPitchStreetView;

enum DECLSPEC_DENUM TLanguageName : unsigned char { lnDefault, lnArabic, lnBasque, lnBulgarian, lnBengali, lnCatalan, lnCzech, lnDanish, lnGerman, lnGreek, lnEnglish, lnEnglish_Australian, lnEnglish_GreatBritain, lnSpanish, lnFarsi, lnFinnish, lnFilipino, lnFrench, lnGalician, lnGujarati, lnHindi, lnCroatian, lnHungarian, lnIndonesian, lnItalian, lnHebrew, lnJapanese, lnKannada, lnKorean, lnLithuanian, lnLatvian, lnMalayalam, lnMarathi, lnDutch, lnNorwegian, lnPolish, lnPortuguese, lnPortuguese_Brazil, lnPortuguese_Portugal, lnRomanian, lnRussian, lnSlovak, lnSlovenian, lnSerbian, lnSwedish, lnTagalog, lnTamil, lnTelugu, lnThai, lnTurkish, lnUkrainian, lnVietnamese, lnChinese_Simplified, lnChinese_Tradtional };

enum DECLSPEC_DENUM TLanguageCode : unsigned char { xx, ar, eu, bg, bn, ca, cs, da, de, el, en, en_AU, en_GB, es, fa, fi, fil, fr, gl, gu, hi, hr, hu, id, it, iw, ja, kn, ko, lt, lv, ml, mr, nl, no, pl, pt, pt_BR, pt_PT, ro, ru, sk, sl, sr, sv, tl, ta, te, th, tr, uk, vi, zh_CN, zh_TW };

enum DECLSPEC_DENUM TWeatherTemperatures : unsigned char { wtCelsius, wtFahrenheit };

enum DECLSPEC_DENUM TWeatherLabelColor : unsigned char { wlcBlack, wlcWhite };

enum DECLSPEC_DENUM TWeatherWindSpeed : unsigned char { wwsKilometersPerHour, wwsMetersPerSecond, wwsMilesPerHour };

enum DECLSPEC_DENUM TSymbolType : unsigned char { stBackwardClosedArrow, stBackwardOpenArrow, stCircle, stForwardClosedArrow, stForwardOpenArrow };

enum DECLSPEC_DENUM TDistanceType : unsigned char { dtPixels, dtPercentage };

enum DECLSPEC_DENUM TTravelMode : unsigned char { tmDriving, tmWalking, tmBicycling };

enum DECLSPEC_DENUM TPolygonType : unsigned char { ptPath, ptCircle, ptRectangle };

enum DECLSPEC_DENUM TUnits : unsigned char { usMetric, usImperial };

class DELPHICLASS TFMXWebGMapsGeocodingService;
class PASCALIMPLEMENTATION TFMXWebGMapsGeocodingService : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TFMXWebGMapsGeocodingService(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TFMXWebGMapsGeocodingService(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int TPolylineCount;
extern DELPHI_PACKAGE int TPolygonCount;
extern DELPHI_PACKAGE bool TDirectionsStripHTML;
extern DELPHI_PACKAGE System::UnicodeString __fastcall HTMLStrip(System::UnicodeString s);
}	/* namespace Tmswebgmapscommon */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TMSWEBGMAPSCOMMON)
using namespace Fmx::Tmswebgmapscommon;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TmswebgmapscommonHPP
