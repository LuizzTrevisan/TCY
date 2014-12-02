// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TMSWebGMapsPolylines.pas' rev: 28.00 (Windows)

#ifndef Fmx_TmswebgmapspolylinesHPP
#define Fmx_TmswebgmapspolylinesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsCommon.hpp>	// Pascal unit
#include <System.StrUtils.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsConst.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsCommonFunctions.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsWebBrowser.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Tmswebgmapspolylines
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSymbol;
class DELPHICLASS TPolyline;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TSymbol : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TPolyline* FPolyline;
	Fmx::Tmswebgmapscommon::TSymbolType FSymbolType;
	int FOffset;
	Fmx::Tmswebgmapscommon::TDistanceType FRepeatType;
	int FRepeatValue;
	Fmx::Tmswebgmapscommon::TDistanceType FOffsetType;
	bool FFixedRotation;
	void __fastcall SetOffset(const int Value);
	void __fastcall SetSymbolType(const Fmx::Tmswebgmapscommon::TSymbolType Value);
	void __fastcall SetOffsetType(const Fmx::Tmswebgmapscommon::TDistanceType Value);
	void __fastcall SetRepeatValue(const int Value);
	void __fastcall SetFixedRotation(const bool Value);
	void __fastcall SetRepeatType(const Fmx::Tmswebgmapscommon::TDistanceType Value);
	
public:
	__fastcall virtual TSymbol(System::Classes::TCollection* Collection);
	__fastcall virtual ~TSymbol(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Fmx::Tmswebgmapscommon::TSymbolType SymbolType = {read=FSymbolType, write=SetSymbolType, default=2};
	__property int Offset = {read=FOffset, write=SetOffset, default=0};
	__property Fmx::Tmswebgmapscommon::TDistanceType OffsetType = {read=FOffsetType, write=SetOffsetType, default=1};
	__property int RepeatValue = {read=FRepeatValue, write=SetRepeatValue, default=0};
	__property Fmx::Tmswebgmapscommon::TDistanceType RepeatType = {read=FRepeatType, write=SetRepeatType, default=1};
	__property bool FixedRotation = {read=FFixedRotation, write=SetFixedRotation, default=0};
};

#pragma pack(pop)

class DELPHICLASS TSymbols;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TSymbols : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TSymbol* operator[](int index) { return Items[index]; }
	
private:
	TPolyline* FPolyline;
	HIDESBASE TSymbol* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TSymbol* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Classes::TCollectionNotification Action);
	
public:
	__fastcall TSymbols(TPolyline* APolyline)/* overload */;
	__fastcall TSymbols(void)/* overload */;
	HIDESBASE TSymbol* __fastcall Add(void)/* overload */;
	__property TSymbol* Items[int index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TSymbols(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TPathItem;
class PASCALIMPLEMENTATION TPathItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	double FLatitude;
	double FLongitude;
	void __fastcall SetLatitude(const double Value);
	void __fastcall SetLongitude(const double Value);
	
public:
	__fastcall virtual TPathItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TPathItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property double Latitude = {read=FLatitude, write=SetLatitude};
	__property double Longitude = {read=FLongitude, write=SetLongitude};
};


class DELPHICLASS TPath;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPath : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TPathItem* operator[](int index) { return Items[index]; }
	
private:
	System::Classes::TPersistent* FOwner;
	HIDESBASE TPathItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TPathItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Classes::TCollectionNotification Action);
	
public:
	__fastcall TPath(System::Classes::TPersistent* APersistent)/* overload */;
	__fastcall TPath(void)/* overload */;
	HIDESBASE TPathItem* __fastcall Add(void)/* overload */;
	HIDESBASE TPathItem* __fastcall Add(double Latitude, double Longitude)/* overload */;
	__property TPathItem* Items[int index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TPath(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPolyline : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FZindex;
	int FOpacity;
	int FWidth;
	System::Uitypes::TAlphaColor FColor;
	bool FVisible;
	bool FGeodesic;
	bool FClickable;
	bool FEditable;
	TPath* FPath;
	TSymbols* FIcons;
	int FItemIndex;
	int FTag;
	System::Classes::TPersistent* FOwner;
	void __fastcall SetClickable(const bool Value);
	void __fastcall SetColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetEditable(const bool Value);
	void __fastcall SetOpacity(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetZindex(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetPath(TPath* const Value);
	void __fastcall SetGeodesic(const bool Value);
	void __fastcall SetIcons(TSymbols* const Value);
	void __fastcall SetTag(const int Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TPolyline(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TPolyline(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall DecodeValues(System::UnicodeString s);
	__property int ItemIndex = {read=FItemIndex, nodefault};
	Fmx::Tmswebgmapscommonfunctions::TBounds* __fastcall PathBounds(void);
	
__published:
	__property bool Clickable = {read=FClickable, write=SetClickable, default=1};
	__property bool Editable = {read=FEditable, write=SetEditable, default=0};
	__property bool Geodesic = {read=FGeodesic, write=SetGeodesic, default=0};
	__property TSymbols* Icons = {read=FIcons, write=SetIcons};
	__property TPath* Path = {read=FPath, write=SetPath};
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=SetColor, default=-16776961};
	__property int Opacity = {read=FOpacity, write=SetOpacity, default=100};
	__property int Width = {read=FWidth, write=SetWidth, default=4};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Zindex = {read=FZindex, write=SetZindex, default=0};
	__property int Tag = {read=FTag, write=SetTag, default=0};
};

#pragma pack(pop)

class DELPHICLASS TPolylineItem;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPolylineItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TPolyline* FPolyline;
	void __fastcall SetPolyline(TPolyline* const Value);
	
public:
	__fastcall virtual TPolylineItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TPolylineItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TPolyline* Polyline = {read=FPolyline, write=SetPolyline};
};

#pragma pack(pop)

class DELPHICLASS TPolylines;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPolylines : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TPolylineItem* operator[](int index) { return Items[index]; }
	
private:
	Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* FWebGMaps;
	HIDESBASE TPolylineItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TPolylineItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Classes::TCollectionNotification Action);
	
public:
	__fastcall TPolylines(Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* AWebGMaps);
	HIDESBASE TPolylineItem* __fastcall Add(bool Clickable, bool Editable, bool Geodesic, TSymbols* Icons, TPath* Path, System::Uitypes::TAlphaColor Color, int Opacity, int Width, bool Visible, int Zindex)/* overload */;
	HIDESBASE TPolylineItem* __fastcall Add(TPath* Path)/* overload */;
	HIDESBASE TPolylineItem* __fastcall Add(void)/* overload */;
	__property TPolylineItem* Items[int index] = {read=GetItem, write=SetItem/*, default*/};
	Fmx::Tmswebgmapscommonfunctions::TBounds* __fastcall Bounds(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TPolylines(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Tmswebgmapspolylines */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TMSWEBGMAPSPOLYLINES)
using namespace Fmx::Tmswebgmapspolylines;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TmswebgmapspolylinesHPP
