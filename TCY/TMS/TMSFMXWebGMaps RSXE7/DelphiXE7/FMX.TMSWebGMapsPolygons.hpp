// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TMSWebGMapsPolygons.pas' rev: 28.00 (Windows)

#ifndef Fmx_TmswebgmapspolygonsHPP
#define Fmx_TmswebgmapspolygonsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <FMX.Types.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsCommon.hpp>	// Pascal unit
#include <System.StrUtils.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsConst.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsCommonFunctions.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsWebBrowser.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsPolylines.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Tmswebgmapspolygons
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TMapPolygon;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TMapPolygon : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FZindex;
	int FWidth;
	bool FVisible;
	bool FGeodesic;
	bool FClickable;
	bool FEditable;
	System::UnicodeString FTitle;
	int FItemIndex;
	System::Uitypes::TAlphaColor FBorderColor;
	int FBackgroundOpacity;
	int FBorderOpacity;
	System::Uitypes::TAlphaColor FBackgroundColor;
	int FBorderWidth;
	Fmx::Tmswebgmapspolylines::TPath* FPath;
	int FTag;
	Fmx::Tmswebgmapscommon::TPolygonType FPolygonType;
	int FRadius;
	Fmx::Tmswebgmapscommonfunctions::TLocation* FCenter;
	Fmx::Tmswebgmapscommonfunctions::TBounds* FBounds;
	System::Classes::TPersistent* FOwner;
	void __fastcall SetClickable(const bool Value);
	void __fastcall SetEditable(const bool Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetZindex(const int Value);
	void __fastcall SetGeodesic(const bool Value);
	void __fastcall SetBackgroundColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetBackgroundOpacity(const int Value);
	void __fastcall SetBorderColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetBorderOpacity(const int Value);
	void __fastcall SetBorderWidth(const int Value);
	void __fastcall SetPath(Fmx::Tmswebgmapspolylines::TPath* const Value);
	void __fastcall SetTag(const int Value);
	void __fastcall SetPolygonType(const Fmx::Tmswebgmapscommon::TPolygonType Value);
	void __fastcall SetRadius(const int Value);
	void __fastcall SetCenter(Fmx::Tmswebgmapscommonfunctions::TLocation* const Value);
	void __fastcall SetBounds(Fmx::Tmswebgmapscommonfunctions::TBounds* const Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TMapPolygon(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TMapPolygon(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property int ItemIndex = {read=FItemIndex, nodefault};
	Fmx::Tmswebgmapscommonfunctions::TBounds* __fastcall PathBounds(void);
	
__published:
	__property bool Clickable = {read=FClickable, write=SetClickable, default=1};
	__property bool Editable = {read=FEditable, write=SetEditable, default=0};
	__property bool Geodesic = {read=FGeodesic, write=SetGeodesic, default=0};
	__property Fmx::Tmswebgmapspolylines::TPath* Path = {read=FPath, write=SetPath};
	__property System::Uitypes::TAlphaColor BackgroundColor = {read=FBackgroundColor, write=SetBackgroundColor, default=-16776961};
	__property int BackgroundOpacity = {read=FBackgroundOpacity, write=SetBackgroundOpacity, default=100};
	__property System::Uitypes::TAlphaColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=-16776961};
	__property int BorderOpacity = {read=FBorderOpacity, write=SetBorderOpacity, default=255};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=4};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Zindex = {read=FZindex, write=SetZindex, default=0};
	__property int Tag = {read=FTag, write=SetTag, default=0};
	__property Fmx::Tmswebgmapscommon::TPolygonType PolygonType = {read=FPolygonType, write=SetPolygonType, default=0};
	__property int Radius = {read=FRadius, write=SetRadius, default=10000};
	__property Fmx::Tmswebgmapscommonfunctions::TLocation* Center = {read=FCenter, write=SetCenter};
	__property Fmx::Tmswebgmapscommonfunctions::TBounds* Bounds = {read=FBounds, write=SetBounds};
};

#pragma pack(pop)

class DELPHICLASS TPolygonItem;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPolygonItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TMapPolygon* FPolygon;
	void __fastcall SetPolygon(TMapPolygon* const Value);
	
public:
	__fastcall virtual TPolygonItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TPolygonItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TMapPolygon* Polygon = {read=FPolygon, write=SetPolygon};
};

#pragma pack(pop)

class DELPHICLASS TPolygons;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPolygons : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TPolygonItem* operator[](int index) { return Items[index]; }
	
private:
	Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* FWebGMaps;
	HIDESBASE TPolygonItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TPolygonItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Classes::TCollectionNotification Action);
	
public:
	__fastcall TPolygons(Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* AWebGMaps);
	HIDESBASE TPolygonItem* __fastcall Add(bool Clickable, bool Editable, bool Geodesic, Fmx::Tmswebgmapspolylines::TPath* Path, System::Uitypes::TAlphaColor BackgroundColor, System::Uitypes::TAlphaColor BorderColor, int BackgroundOpacity, int BorderOpacity, int BorderWidth, bool Visible, int Zindex)/* overload */;
	HIDESBASE TPolygonItem* __fastcall Add(Fmx::Tmswebgmapspolylines::TPath* Path)/* overload */;
	HIDESBASE TPolygonItem* __fastcall Add(void)/* overload */;
	__property TPolygonItem* Items[int index] = {read=GetItem, write=SetItem/*, default*/};
	Fmx::Tmswebgmapscommonfunctions::TBounds* __fastcall Bounds(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TPolygons(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Tmswebgmapspolygons */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TMSWEBGMAPSPOLYGONS)
using namespace Fmx::Tmswebgmapspolygons;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TmswebgmapspolygonsHPP
