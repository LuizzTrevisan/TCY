// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TMSWebGMapsGeocoding.pas' rev: 28.00 (Windows)

#ifndef Fmx_TmswebgmapsgeocodingHPP
#define Fmx_TmswebgmapsgeocodingHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsCommon.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsConst.hpp>	// Pascal unit
#include <System.StrUtils.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.TypInfo.hpp>	// Pascal unit
#include <Xml.XMLDoc.hpp>	// Pascal unit
#include <Xml.XMLIntf.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsCommonFunctions.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsWebKit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Tmswebgmapsgeocoding
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TTMSFMXWebGMapsGeocoding;
class PASCALIMPLEMENTATION TTMSFMXWebGMapsGeocoding : public Fmx::Tmswebgmapscommon::TFMXWebGMapsGeocodingService
{
	typedef Fmx::Tmswebgmapscommon::TFMXWebGMapsGeocodingService inherited;
	
private:
	System::UnicodeString FAddress;
	double FResultLatitude;
	double FResultLongitude;
	Fmx::Tmswebgmapscommon::TLocationType FResultLocationType;
	void __fastcall SetAddress(const System::UnicodeString Value);
	Xml::Xmlintf::_di_IXMLNode __fastcall FoundNode(Xml::Xmlintf::_di_IXMLNode XmlNode, System::UnicodeString NodeName);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	double __fastcall GetCoord(System::UnicodeString s);
	
public:
	__fastcall virtual ~TTMSFMXWebGMapsGeocoding(void);
	__fastcall virtual TTMSFMXWebGMapsGeocoding(System::Classes::TComponent* AOwner);
	Fmx::Tmswebgmapscommon::TGeocodingResult __fastcall LaunchGeocoding(void);
	
__published:
	__property System::UnicodeString Address = {read=FAddress, write=SetAddress};
	__property double ResultLatitude = {read=FResultLatitude};
	__property double ResultLongitude = {read=FResultLongitude};
	__property Fmx::Tmswebgmapscommon::TLocationType ResultLocationType = {read=FResultLocationType, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MAJ_VER = System::Int8(0x1);
static const System::Int8 MIN_VER = System::Int8(0x0);
static const System::Int8 REL_VER = System::Int8(0x0);
static const System::Int8 BLD_VER = System::Int8(0x0);
}	/* namespace Tmswebgmapsgeocoding */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TMSWEBGMAPSGEOCODING)
using namespace Fmx::Tmswebgmapsgeocoding;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TmswebgmapsgeocodingHPP
