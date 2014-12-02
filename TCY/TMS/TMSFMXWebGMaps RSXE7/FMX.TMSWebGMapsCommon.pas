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

unit FMX.TMSWebGMapsCommon;

interface

uses
  Classes, SysUtils, Types;

type
  TGeocodingResult     = (erOk, erZeroResults, erOverQueryLimit, erRequestDenied, erInvalidRequest, erOtherProblem);
  TLocationType        = (ltRoofTop, ltRangeInterpolated, ltGeometricCenter, ltApproximate, ltNotInitialize);
  TErrorType           = (etGMapsProblem, etScreenshotProblem, etJavascriptError, etNotValidMarker, etStreetViewUnknownError, etStreetViewNoResults);
  TControlPosition     = (cpTopRight,cpTopLeft,cpTopCenter,cpBottomRight,cpBottomLeft,cpBottomCenter,
                          cpLeftBottom,cpLeftCenter,cpLeftTop,cpRightBottom,cpRightCenter,cpRightTop);
  TMapType             = (mtDefault,mtSatellite,mtHybrid,mtTerrain);
  TControlsType        = (ctDefault,ctAndroid,ctSmall,ctZoomPan);
  TZoomStyle           = (zsDefault,zsSmall,zsLarge);
  TImgType             = (itBitmap, itJpeg, itPng);
  TMapTypeStyle        = (mtsDefault,mtsDropDownMenu,mtsHorizontalBar);
  TZoomMap             = 0..21;
  TZoomStreetView      = 0..5;
  THeadingStreetView   = 0..360;
  TPitchStreetView     = -90..90;
  TLanguageName        = (lnDefault,lnArabic,lnBasque,lnBulgarian,lnBengali,lnCatalan,lnCzech,
                          lnDanish,lnGerman,lnGreek,lnEnglish,lnEnglish_Australian,lnEnglish_GreatBritain,
                          lnSpanish,lnFarsi,lnFinnish,lnFilipino,lnFrench,lnGalician,lnGujarati,
                          lnHindi,lnCroatian,lnHungarian,lnIndonesian,lnItalian,lnHebrew,lnJapanese,
                          lnKannada,lnKorean,lnLithuanian,lnLatvian,lnMalayalam,lnMarathi,lnDutch,
                          lnNorwegian,lnPolish,lnPortuguese,lnPortuguese_Brazil,lnPortuguese_Portugal,
                          lnRomanian,lnRussian,lnSlovak,lnSlovenian,lnSerbian,lnSwedish,lnTagalog,
                          lnTamil,lnTelugu,lnThai,lnTurkish,lnUkrainian,lnVietnamese,lnChinese_Simplified,
                          lnChinese_Tradtional);
  TLanguageCode        = (xx,ar,eu,bg,bn,ca,cs,da,de,el,en,en_AU,en_GB,es,fa,fi,fil,fr,
                          gl,gu,hi,hr,hu,id,it,iw,ja,kn,ko,lt,lv,ml,mr,nl,no,pl,pt,
                          pt_BR,pt_PT,ro,ru,sk,sl,sr,sv,tl,ta,te,th,tr,uk,vi,zh_CN,zh_TW);
  TWeatherTemperatures = (wtCelsius,wtFahrenheit);
  TWeatherLabelColor   = (wlcBlack,wlcWhite);
  TWeatherWindSpeed    = (wwsKilometersPerHour,wwsMetersPerSecond,wwsMilesPerHour);
  TSymbolType          = (stBackwardClosedArrow, stBackwardOpenArrow, stCircle, stForwardClosedArrow, stForwardOpenArrow);
  TDistanceType        = (dtPixels, dtPercentage);
  TTravelMode          = (tmDriving, tmWalking, tmBicycling);
  TPolygonType         = (ptPath, ptCircle, ptRectangle);
  TUnits               = (usMetric, usImperial);

  TFMXWebGMapsGeocodingService = class(TComponent);

var
  TPolylineCount: integer;
  TPolygonCount: integer;
  TDirectionsStripHTML: boolean;


{$EXTERNALSYM Hiword}
function Hiword(L: DWORD): integer;
{$EXTERNALSYM LoWord}
function LoWord(L: DWORD): Integer;
{$EXTERNALSYM MakeWord}
function MakeWord(b1,b2: integer): integer;
{$EXTERNALSYM MakeLong}
function MakeLong(i1,i2: integer): integer;
function HTMLStrip(s: string): string;

implementation

function Hiword(L: DWORD): integer;
begin
  Result := L shr 16;
end;

function LoWord(L: DWORD): Integer;
begin
  Result := L AND $FFFF;
end;

function MakeWord(b1,b2: integer): integer;
begin
  Result := b1 or b2 shl 8;
end;

function MakeLong(i1,i2: integer): integer;
begin
  Result := i1 or i2 shl 16;
end;

function VarPos(su,s:string;var Res:Integer):Integer;
begin
  Res := Pos(su,s);
  Result := Res;
end;

function HTMLStrip(s: string): string;
var
  TagPos: integer;
begin
  Result := '';
  // replace line breaks by linefeeds
  while (pos('<BR>', uppercase(s)) > 0) do
    s := StringReplace(s, '<BR>', chr(13) + chr(10), [rfIgnoreCase]);
  while (pos('<HR>', uppercase(s)) > 0) do
    s := StringReplace(s, '<HR>', chr(13) + chr(10), [rfIgnoreCase]);

  // remove all other tags
  while (VarPos('<', s, TagPos) > 0) do
  begin
    Result := Result + Copy(s, 1, TagPos - 1);
    if (VarPos('>', s, TagPos) > 0) then
      Delete(s, 1, TagPos)
    else
      Break;
  end;

  while (pos('"', s) > 0) do
    s := StringReplace(s, '"', #39, [rfIgnoreCase]);


  Result := Result + s;
end;

end.
