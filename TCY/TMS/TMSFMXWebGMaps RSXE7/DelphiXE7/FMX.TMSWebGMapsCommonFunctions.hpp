// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TMSWebGMapsCommonFunctions.pas' rev: 28.00 (Windows)

#ifndef Fmx_TmswebgmapscommonfunctionsHPP
#define Fmx_TmswebgmapscommonfunctionsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.StrUtils.hpp>	// Pascal unit
#include <Data.DBXJSON.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsCommon.hpp>	// Pascal unit
#include <System.JSON.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Tmswebgmapscommonfunctions
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TLocation;
class PASCALIMPLEMENTATION TLocation : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	double FLatitude;
	double FLongitude;
	
public:
	__fastcall TLocation(void);
	__fastcall virtual ~TLocation(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property double Latitude = {read=FLatitude, write=FLatitude};
	__property double Longitude = {read=FLongitude, write=FLongitude};
};


class DELPHICLASS TBounds;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TBounds : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLocation* FNorthEast;
	TLocation* FSouthWest;
	
public:
	__fastcall TBounds(void);
	__fastcall virtual ~TBounds(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TLocation* NorthEast = {read=FNorthEast, write=FNorthEast};
	__property TLocation* SouthWest = {read=FSouthWest, write=FSouthWest};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall URLEncode(const System::UnicodeString Url);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ColorToHTML(System::Uitypes::TAlphaColor Color);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ConvertCoordinateToString(double Coordinate);
extern DELPHI_PACKAGE double __fastcall ConvertStringToCoordinate(System::UnicodeString Coordinate);
extern DELPHI_PACKAGE System::UnicodeString __fastcall Convert255To1(int value);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetJSONProp(System::Json::TJSONObject* O, System::UnicodeString ID);
extern DELPHI_PACKAGE System::Json::TJSONValue* __fastcall GetJSONValue(System::Json::TJSONObject* O, System::UnicodeString ID);
extern DELPHI_PACKAGE System::UnicodeString __fastcall CleanUpJSON(System::UnicodeString Value);
}	/* namespace Tmswebgmapscommonfunctions */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TMSWEBGMAPSCOMMONFUNCTIONS)
using namespace Fmx::Tmswebgmapscommonfunctions;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TmswebgmapscommonfunctionsHPP
