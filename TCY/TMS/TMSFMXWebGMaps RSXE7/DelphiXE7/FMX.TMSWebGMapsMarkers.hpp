// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TMSWebGMapsMarkers.pas' rev: 28.00 (Windows)

#ifndef Fmx_TmswebgmapsmarkersHPP
#define Fmx_TmswebgmapsmarkersHPP

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
#include <FMX.TMSWebGMapsWebBrowser.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsConst.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsCommonFunctions.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <FMX.Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Tmswebgmapsmarkers
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TMapLabel;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TMapLabel : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Uitypes::TAlphaColor FBorderColor;
	System::Uitypes::TAlphaColor FColor;
	Fmx::Graphics::TFont* FFont;
	int FMargin;
	System::UnicodeString FText;
	System::Classes::TCollectionItem* FOwner;
	System::Uitypes::TAlphaColor FFontColor;
	void __fastcall SetBorderColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetFont(Fmx::Graphics::TFont* const Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetOwner(System::Classes::TCollectionItem* const Value);
	void __fastcall SetFontColor(const System::Uitypes::TAlphaColor Value);
	
protected:
	__property System::Classes::TCollectionItem* Owner = {read=FOwner, write=SetOwner};
	
public:
	__fastcall TMapLabel(System::Classes::TCollectionItem* CollectionItem);
	__fastcall virtual ~TMapLabel(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=SetColor, default=-1};
	__property System::Uitypes::TAlphaColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=-16777216};
	__property int Margin = {read=FMargin, write=FMargin, default=2};
	__property Fmx::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::Uitypes::TAlphaColor FontColor = {read=FFontColor, write=SetFontColor, default=-16777216};
};

#pragma pack(pop)

class DELPHICLASS TMarker;
class PASCALIMPLEMENTATION TMarker : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* FWebGMaps;
	double FLatitude;
	bool FDraggable;
	System::UnicodeString FTitle;
	double FLongitude;
	System::UnicodeString FIcon;
	bool FVisible;
	bool FClickable;
	bool FFlat;
	bool FInitialDropAnimation;
	int FZindex;
	TMapLabel* FMapLabel;
	int FTag;
	void __fastcall SetDraggable(const bool Value);
	void __fastcall SetIcon(const System::UnicodeString Value);
	void __fastcall SetLatitude(const double Value);
	void __fastcall SetLongitude(const double Value);
	void __fastcall SetTitle(const System::UnicodeString Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetClickable(const bool Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetInitialDropAnimation(const bool Value);
	void __fastcall SetZindex(const int Value);
	void __fastcall SetMapLabel(TMapLabel* const Value);
	void __fastcall SetTag(const int Value);
	
public:
	__fastcall virtual TMarker(System::Classes::TCollection* Collection);
	__fastcall virtual ~TMarker(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property double Latitude = {read=FLatitude, write=SetLatitude};
	__property double Longitude = {read=FLongitude, write=SetLongitude};
	__property System::UnicodeString Title = {read=FTitle, write=SetTitle};
	__property System::UnicodeString Icon = {read=FIcon, write=SetIcon};
	__property bool Draggable = {read=FDraggable, write=SetDraggable, nodefault};
	__property bool Clickable = {read=FClickable, write=SetClickable, nodefault};
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property bool InitialDropAnimation = {read=FInitialDropAnimation, write=SetInitialDropAnimation, nodefault};
	__property int Zindex = {read=FZindex, write=SetZindex, nodefault};
	__property TMapLabel* MapLabel = {read=FMapLabel, write=SetMapLabel};
	__property int Tag = {read=FTag, write=SetTag, default=0};
};


class DELPHICLASS TMarkers;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TMarkers : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TMarker* operator[](int index) { return Items[index]; }
	
private:
	Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* FWebGMaps;
	HIDESBASE TMarker* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TMarker* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Classes::TCollectionNotification Action);
	
public:
	__fastcall TMarkers(Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* AWebGMaps);
	HIDESBASE TMarker* __fastcall Add(double Latitude, double Longitude, System::UnicodeString Title, System::UnicodeString Icon, bool Draggable, bool Visible, bool Clickable, bool Flat, bool InitialDropAnimation, int zIndex)/* overload */;
	HIDESBASE TMarker* __fastcall Add(double Latitude, double Longitude, System::UnicodeString Title)/* overload */;
	HIDESBASE TMarker* __fastcall Add(void)/* overload */;
	__property TMarker* Items[int index] = {read=GetItem, write=SetItem/*, default*/};
	Fmx::Tmswebgmapscommonfunctions::TBounds* __fastcall Bounds(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TMarkers(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Tmswebgmapsmarkers */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TMSWEBGMAPSMARKERS)
using namespace Fmx::Tmswebgmapsmarkers;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TmswebgmapsmarkersHPP
