// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TMSWebGMapsReverseGeocoding.pas' rev: 28.00 (Windows)

#ifndef Fmx_TmswebgmapsreversegeocodingHPP
#define Fmx_TmswebgmapsreversegeocodingHPP

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
namespace Tmswebgmapsreversegeocoding
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TWebGMapsAddress;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TWebGMapsAddress : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmx::Tmswebgmapscommon::TFMXWebGMapsGeocodingService* FWebGmapsGeocodingService;
	System::UnicodeString FFormattedAddress;
	System::UnicodeString FStreetNumber;
	System::UnicodeString FStreet;
	System::UnicodeString FPostalCode;
	System::UnicodeString FCountry;
	System::UnicodeString FCity;
	System::UnicodeString FRegion;
	System::UnicodeString FCountryCode;
	System::UnicodeString FState;
	void __fastcall SetFormattedAddress(const System::UnicodeString Value);
	void __fastcall SetStreetNumber(const System::UnicodeString Value);
	void __fastcall SetStreet(const System::UnicodeString Value);
	void __fastcall SetCity(const System::UnicodeString Value);
	void __fastcall SetCountry(const System::UnicodeString Value);
	void __fastcall SetPostalCode(const System::UnicodeString Value);
	void __fastcall SetRegion(const System::UnicodeString Value);
	void __fastcall SetCounntryCode(const System::UnicodeString Value);
	void __fastcall SetState(const System::UnicodeString Value);
	
public:
	__fastcall TWebGMapsAddress(Fmx::Tmswebgmapscommon::TFMXWebGMapsGeocodingService* AWebGmapsGeocodingService);
	
__published:
	__property System::UnicodeString FormattedAddress = {read=FFormattedAddress, write=SetFormattedAddress};
	__property System::UnicodeString StreetNumber = {read=FStreetNumber, write=SetStreetNumber};
	__property System::UnicodeString Street = {read=FStreet, write=SetStreet};
	__property System::UnicodeString City = {read=FCity, write=SetCity};
	__property System::UnicodeString State = {read=FState, write=SetState};
	__property System::UnicodeString Region = {read=FRegion, write=SetRegion};
	__property System::UnicodeString Country = {read=FCountry, write=SetCountry};
	__property System::UnicodeString CountryCode = {read=FCountryCode, write=SetCounntryCode};
	__property System::UnicodeString PostalCode = {read=FPostalCode, write=SetPostalCode};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWebGMapsAddress(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TTMSFMXWebGMapsReverseGeocoding;
class PASCALIMPLEMENTATION TTMSFMXWebGMapsReverseGeocoding : public Fmx::Tmswebgmapscommon::TFMXWebGMapsGeocodingService
{
	typedef Fmx::Tmswebgmapscommon::TFMXWebGMapsGeocodingService inherited;
	
private:
	double FLatitude;
	double FLongitude;
	TWebGMapsAddress* FResultAddress;
	Xml::Xmlintf::_di_IXMLNode __fastcall FoundNode(Xml::Xmlintf::_di_IXMLNode XmlNode, System::UnicodeString NodeName);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetLatitude(const double Value);
	void __fastcall SetLongitude(const double Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	System::UnicodeString __fastcall SetCoord(double d);
	
public:
	__fastcall virtual ~TTMSFMXWebGMapsReverseGeocoding(void);
	__fastcall virtual TTMSFMXWebGMapsReverseGeocoding(System::Classes::TComponent* AOwner);
	Fmx::Tmswebgmapscommon::TGeocodingResult __fastcall LaunchReverseGeocoding(void);
	
__published:
	__property TWebGMapsAddress* ResultAddress = {read=FResultAddress};
	__property double Latitude = {read=FLatitude, write=SetLatitude};
	__property double Longitude = {read=FLongitude, write=SetLongitude};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MAJ_VER = System::Int8(0x1);
static const System::Int8 MIN_VER = System::Int8(0x0);
static const System::Int8 REL_VER = System::Int8(0x0);
static const System::Int8 BLD_VER = System::Int8(0x0);
}	/* namespace Tmswebgmapsreversegeocoding */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TMSWEBGMAPSREVERSEGEOCODING)
using namespace Fmx::Tmswebgmapsreversegeocoding;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TmswebgmapsreversegeocodingHPP
