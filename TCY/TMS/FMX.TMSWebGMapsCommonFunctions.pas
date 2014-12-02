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

unit FMX.TMSWebGMapsCommonFunctions;

{$I TMSDEFS.INC}

interface

uses
  Types, Classes, SysUtils, UITypes, StrUtils
  , DBXJSON
  , FMX.TMSWebGMapsCommon
  {$IFDEF DELPHIXE6_LVL}
  ,JSON
  {$ENDIF}
  ;

type
  TLocation = class(TPersistent)
  private
    FLatitude: double;
    FLongitude: double;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Latitude : double read FLatitude write FLatitude;
    property Longitude : double read FLongitude write FLongitude;
  end;

  TBounds = class(TPersistent)
  private
    FNorthEast: TLocation;
    FSouthWest: TLocation;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property NorthEast : TLocation read FNorthEast write FNorthEast;
    property SouthWest : TLocation read FSouthWest write FSouthWest;
  end;


  function URLEncode(const Url: String): String;
  function ColorToHTML(Color: TAlphaColor): String;
  function ConvertCoordinateToString(Coordinate: Double): String;
  function ConvertStringToCoordinate(Coordinate: String): Double;
  function Convert255To1(value: integer): string;
  function GetJSONProp(O: TJSONOBject; ID: string): string;
  function GetJSONValue(O: TJSONObject; ID: string): TJSONValue;
  function CleanUpJSON(Value: string): string;

implementation

{ TLocation }

procedure TLocation.Assign(Source: TPersistent);
begin
  if (Source is TLocation) then
  begin
    FLatitude := (Source as TLocation).Latitude;
    FLongitude := (Source as TLocation).Longitude;
  end;
end;

constructor TLocation.Create;
begin
  inherited;
  FLatitude := 0;
  FLongitude := 0;
end;

destructor TLocation.Destroy;
begin
  inherited;
end;

{ TBounds }

procedure TBounds.Assign(Source: TPersistent);
begin
  if (Source is TBounds) then
  begin
    FNorthEast.Assign((Source as TBounds).NorthEast);
    FSouthWest.Assign((Source as TBounds).SouthWest);
  end;
end;

constructor TBounds.Create;
begin
  inherited;
  FNorthEast := TLocation.Create;
  FSouthWest := TLocation.Create;
end;

destructor TBounds.Destroy;
begin
  FNorthEast.Free;
  FSouthWest.Free;
  inherited;
end;

function URLEncode(const Url: string): String;
var
  i: Integer;
  UrlA: string;
  res: string;
begin
  res := '';
  UrlA := Url;

  {$IFDEF DELPHI_LLVM}
  for i := 0 to Length(UrlA) - 1 do
  {$ELSE}
  for i := 1 to Length(UrlA) do
  {$ENDIF}
  begin
    case UrlA[i] of
      'A'..'Z', 'a'..'z', '0'..'9', '-', '_', '.':
        res := res + UrlA[i];
    else
        res := res + '%' + IntToHex(Ord(UrlA[i]), 2);
    end;
  end;

  Result := string(res);
end;

function GetBValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb);
end;

function GetGValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb shr 8);
end;

function GetRValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb shr 16);
end;

function ColorToHTML(Color: TAlphaColor): String;
begin
  Result := Format('#%0.2X%0.2X%0.2X',
                   [GetRValue(Color),
                    GetGValue(Color),
                    GetBValue(Color)]);
end;

function ConvertCoordinateToString(Coordinate: Double): String;
begin
  Result := FloatToStr(Coordinate);
  Result := Replacetext(Result,FormatSettings.DecimalSeparator,'.');
end;

function ConvertStringToCoordinate(Coordinate: String): Double;
begin
  Coordinate := Replacetext(Coordinate,'.',FormatSettings.DecimalSeparator);
  Result := StrToFloat(Coordinate);
end;

function Convert255To1(value: integer): string;
begin
  Result := StringReplace(FloatToStr(Round((1 / 255) * value * 100) / 100), FormatSettings.DecimalSeparator, '.', [rfReplaceAll]);
end;

function GetJSONProp(O: TJSONOBject; ID: string): string;
var
  p: TJSONPair;
begin
  Result := '';
  p := o.Get(ID);
  if Assigned(p) then
    Result := p.JsonValue.Value;
end;

function GetJSONValue(O: TJSONObject; ID: string): TJSONValue;
var
  p: TJSONPair;
begin
  Result := nil;
  p := o.Get(ID);
  if Assigned(p) then
  begin
    Result := p.JsonValue;
  end;
end;

function CleanUpJSON(Value: string): string;
const
  JSONStart: string = '{';
  JSONEnd: string = '}';
var
  i: integer;
  res: string;

begin
  res := Value;
  i := Pos(JSONStart,res);

  if i > 1 then
    System.Delete(res,1,i - 1);

  i := length(res);

  while (i > 1) and (res[i] <> JSONEnd) do
  begin
    dec(i);
  end;

  System.Delete(res,i + 1, length(res) - i);

  Result := res;
end;

end.
