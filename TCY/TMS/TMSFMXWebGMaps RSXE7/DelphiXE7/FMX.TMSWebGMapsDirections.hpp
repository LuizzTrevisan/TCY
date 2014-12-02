// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TMSWebGMapsDirections.pas' rev: 28.00 (Windows)

#ifndef Fmx_TmswebgmapsdirectionsHPP
#define Fmx_TmswebgmapsdirectionsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsCommon.hpp>	// Pascal unit
#include <System.StrUtils.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsWebBrowser.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsConst.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsCommonFunctions.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsPolylines.hpp>	// Pascal unit
#include <Data.DBXJSON.hpp>	// Pascal unit
#include <System.JSON.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Tmswebgmapsdirections
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TStep;
class DELPHICLASS TLeg;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TStep : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLeg* FLeg;
	System::UnicodeString FInstructions;
	int FDistance;
	int FDuration;
	Fmx::Tmswebgmapscommonfunctions::TLocation* FStartLocation;
	Fmx::Tmswebgmapscommonfunctions::TLocation* FEndLocation;
	Fmx::Tmswebgmapspolylines::TPolyline* FPolyline;
	Fmx::Tmswebgmapscommon::TTravelMode FTravelMode;
	System::UnicodeString FDistanceText;
	System::UnicodeString FDurationText;
	void __fastcall SetDistance(const int Value);
	void __fastcall SetDuration(const int Value);
	void __fastcall SetEndLocation(Fmx::Tmswebgmapscommonfunctions::TLocation* const Value);
	void __fastcall SetStartLocation(Fmx::Tmswebgmapscommonfunctions::TLocation* const Value);
	void __fastcall SetTravelMode(const Fmx::Tmswebgmapscommon::TTravelMode Value);
	void __fastcall SetInstructions(const System::UnicodeString Value);
	void __fastcall SetDistanceText(const System::UnicodeString Value);
	void __fastcall SetDurationText(const System::UnicodeString Value);
	
public:
	__fastcall virtual TStep(System::Classes::TCollection* Collection);
	__fastcall virtual ~TStep(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall FromJSON(System::Json::TJSONObject* jo);
	
__published:
	__property System::UnicodeString Instructions = {read=FInstructions, write=SetInstructions};
	__property int Distance = {read=FDistance, write=SetDistance, default=0};
	__property System::UnicodeString DistanceText = {read=FDistanceText, write=SetDistanceText};
	__property int Duration = {read=FDuration, write=SetDuration, default=0};
	__property System::UnicodeString DurationText = {read=FDurationText, write=SetDurationText};
	__property Fmx::Tmswebgmapscommonfunctions::TLocation* EndLocation = {read=FEndLocation, write=SetEndLocation};
	__property Fmx::Tmswebgmapscommonfunctions::TLocation* StartLocation = {read=FStartLocation, write=SetStartLocation};
	__property Fmx::Tmswebgmapspolylines::TPolyline* Polyline = {read=FPolyline, write=FPolyline};
	__property Fmx::Tmswebgmapscommon::TTravelMode TravelMode = {read=FTravelMode, write=SetTravelMode, default=0};
};

#pragma pack(pop)

class DELPHICLASS TSteps;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TSteps : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TStep* operator[](int index) { return Items[index]; }
	
private:
	TLeg* FLeg;
	HIDESBASE TStep* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TStep* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Classes::TCollectionNotification Action);
	
public:
	__fastcall TSteps(TLeg* ALeg);
	HIDESBASE TStep* __fastcall Add(void)/* overload */;
	__property TStep* Items[int index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TSteps(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TRoute;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLeg : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TRoute* FRoute;
	int FDistance;
	System::UnicodeString FStartAddress;
	int FDuration;
	TSteps* FSteps;
	Fmx::Tmswebgmapscommonfunctions::TLocation* FStartLocation;
	System::UnicodeString FEndAddress;
	Fmx::Tmswebgmapscommonfunctions::TLocation* FEndLocation;
	System::UnicodeString FDistanceText;
	System::UnicodeString FDurationText;
	void __fastcall SetSteps(TSteps* const Value);
	void __fastcall SetDistance(const int Value);
	void __fastcall SetDuration(const int Value);
	void __fastcall SetEndAddress(const System::UnicodeString Value);
	void __fastcall SetEndLocation(Fmx::Tmswebgmapscommonfunctions::TLocation* const Value);
	void __fastcall SetStartAddress(const System::UnicodeString Value);
	void __fastcall SetStartLocation(Fmx::Tmswebgmapscommonfunctions::TLocation* const Value);
	void __fastcall SetDistanceText(const System::UnicodeString Value);
	void __fastcall SetDurationText(const System::UnicodeString Value);
	
public:
	__fastcall virtual TLeg(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLeg(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall FromJSON(System::Json::TJSONObject* jo);
	
__published:
	__property int Distance = {read=FDistance, write=SetDistance, default=0};
	__property System::UnicodeString DistanceText = {read=FDistanceText, write=SetDistanceText};
	__property int Duration = {read=FDuration, write=SetDuration, default=0};
	__property System::UnicodeString DurationText = {read=FDurationText, write=SetDurationText};
	__property System::UnicodeString EndAddress = {read=FEndAddress, write=SetEndAddress};
	__property Fmx::Tmswebgmapscommonfunctions::TLocation* EndLocation = {read=FEndLocation, write=SetEndLocation};
	__property System::UnicodeString StartAddress = {read=FStartAddress, write=SetStartAddress};
	__property Fmx::Tmswebgmapscommonfunctions::TLocation* StartLocation = {read=FStartLocation, write=SetStartLocation};
	__property TSteps* Steps = {read=FSteps, write=SetSteps};
};

#pragma pack(pop)

class DELPHICLASS TLegs;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLegs : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLeg* operator[](int index) { return Items[index]; }
	
private:
	TRoute* FRoute;
	HIDESBASE TLeg* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLeg* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Classes::TCollectionNotification Action);
	
public:
	__fastcall TLegs(TRoute* ARoute)/* overload */;
	HIDESBASE TLeg* __fastcall Add(void)/* overload */;
	__property TLeg* Items[int index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLegs(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TRoute : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* FWebGMaps;
	Fmx::Tmswebgmapspolylines::TPolyline* FPolyline;
	System::UnicodeString FSummary;
	Fmx::Tmswebgmapscommonfunctions::TBounds* FBounds;
	System::UnicodeString FCopyRights;
	TLegs* FLegs;
	void __fastcall SetBounds(Fmx::Tmswebgmapscommonfunctions::TBounds* const Value);
	void __fastcall SetSummary(const System::UnicodeString Value);
	void __fastcall SetLegs(TLegs* const Value);
	void __fastcall SetPolyline(Fmx::Tmswebgmapspolylines::TPolyline* const Value);
	
public:
	__fastcall virtual TRoute(System::Classes::TCollection* Collection);
	__fastcall virtual ~TRoute(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall FromJSON(System::Json::TJSONObject* jo);
	
__published:
	__property Fmx::Tmswebgmapspolylines::TPolyline* Polyline = {read=FPolyline, write=SetPolyline};
	__property System::UnicodeString Summary = {read=FSummary, write=SetSummary};
	__property Fmx::Tmswebgmapscommonfunctions::TBounds* Bounds = {read=FBounds, write=SetBounds};
	__property System::UnicodeString CopyRights = {read=FCopyRights};
	__property TLegs* Legs = {read=FLegs, write=SetLegs};
};

#pragma pack(pop)

class DELPHICLASS TDirections;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TDirections : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TRoute* operator[](int index) { return Items[index]; }
	
private:
	Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* FWebGMaps;
	HIDESBASE TRoute* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TRoute* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Classes::TCollectionNotification Action);
	
public:
	__fastcall TDirections(Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* AWebGMaps);
	HIDESBASE TRoute* __fastcall Add(void)/* overload */;
	__property TRoute* Items[int index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TDirections(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Tmswebgmapsdirections */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TMSWEBGMAPSDIRECTIONS)
using namespace Fmx::Tmswebgmapsdirections;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TmswebgmapsdirectionsHPP
