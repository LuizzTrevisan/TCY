// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TMSWebGMapsControls.pas' rev: 28.00 (Windows)

#ifndef Fmx_TmswebgmapscontrolsHPP
#define Fmx_TmswebgmapscontrolsHPP

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
#include <FMX.TMSWebGMapsConst.hpp>	// Pascal unit
#include <FMX.TMSWebGMapsWebBrowser.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Tmswebgmapscontrols
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPanControl;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPanControl : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmx::Tmswebgmapscommon::TControlPosition FPosition;
	bool FVisible;
	Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* FWebGmaps;
	void __fastcall SetPosition(const Fmx::Tmswebgmapscommon::TControlPosition Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TPanControl(Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* AWebGmaps);
	
__published:
	__property Fmx::Tmswebgmapscommon::TControlPosition Position = {read=FPosition, write=SetPosition, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPanControl(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TZoomControl;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TZoomControl : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmx::Tmswebgmapscommon::TControlPosition FPosition;
	bool FVisible;
	Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* FWebGmaps;
	Fmx::Tmswebgmapscommon::TZoomStyle FStyle;
	void __fastcall SetPosition(const Fmx::Tmswebgmapscommon::TControlPosition Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetStyle(const Fmx::Tmswebgmapscommon::TZoomStyle Value);
	
public:
	__fastcall TZoomControl(Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* AWebGmaps);
	
__published:
	__property Fmx::Tmswebgmapscommon::TControlPosition Position = {read=FPosition, write=SetPosition, default=6};
	__property Fmx::Tmswebgmapscommon::TZoomStyle Style = {read=FStyle, write=SetStyle, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TZoomControl(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TMapTypeControl;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TMapTypeControl : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* FWebGmaps;
	bool FVisible;
	Fmx::Tmswebgmapscommon::TMapTypeStyle FStyle;
	Fmx::Tmswebgmapscommon::TControlPosition FPosition;
	void __fastcall SetPosition(const Fmx::Tmswebgmapscommon::TControlPosition Value);
	void __fastcall SetStyle(const Fmx::Tmswebgmapscommon::TMapTypeStyle Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TMapTypeControl(Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* AWebGmaps);
	
__published:
	__property Fmx::Tmswebgmapscommon::TControlPosition Position = {read=FPosition, write=SetPosition, default=0};
	__property Fmx::Tmswebgmapscommon::TMapTypeStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TMapTypeControl(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TScaleControl;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TScaleControl : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* FWebGmaps;
	bool FVisible;
	Fmx::Tmswebgmapscommon::TControlPosition FPosition;
	void __fastcall SetPosition(const Fmx::Tmswebgmapscommon::TControlPosition Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TScaleControl(Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* AWebGmaps);
	
__published:
	__property Fmx::Tmswebgmapscommon::TControlPosition Position = {read=FPosition, write=SetPosition, default=4};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TScaleControl(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TStreetViewControl;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TStreetViewControl : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* FWebGmaps;
	bool FVisible;
	Fmx::Tmswebgmapscommon::TControlPosition FPosition;
	void __fastcall SetPosition(const Fmx::Tmswebgmapscommon::TControlPosition Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TStreetViewControl(Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* AWebGmaps);
	
__published:
	__property Fmx::Tmswebgmapscommon::TControlPosition Position = {read=FPosition, write=SetPosition, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TStreetViewControl(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TOverviewMapControl;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TOverviewMapControl : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* FWebGmaps;
	bool FOpen;
	bool FVisible;
	void __fastcall SetOpen(const bool Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TOverviewMapControl(Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* AWebGmaps);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property bool Open = {read=FOpen, write=SetOpen, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TOverviewMapControl(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TControlsOptions;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TControlsOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* FWebGmaps;
	Fmx::Tmswebgmapscommon::TControlsType FControlsType;
	TOverviewMapControl* FOverviewMapControl;
	TScaleControl* FScaleControl;
	TZoomControl* FZoomControl;
	TMapTypeControl* FMapTypeControl;
	TPanControl* FPanControl;
	TStreetViewControl* FStreetViewControl;
	void __fastcall SetControlsType(const Fmx::Tmswebgmapscommon::TControlsType Value);
	void __fastcall SetMapTypeControl(TMapTypeControl* const Value);
	void __fastcall SetOverviewMapControl(TOverviewMapControl* const Value);
	void __fastcall SetPanControl(TPanControl* const Value);
	void __fastcall SetScaleControl(TScaleControl* const Value);
	void __fastcall SetStreetViewControl(TStreetViewControl* const Value);
	void __fastcall SetZoomControl(TZoomControl* const Value);
	
public:
	__fastcall TControlsOptions(Fmx::Tmswebgmapswebbrowser::TTMSFMXWebGMapsWebBrowser* AWebGmaps);
	__fastcall virtual ~TControlsOptions(void);
	
__published:
	__property Fmx::Tmswebgmapscommon::TControlsType ControlsType = {read=FControlsType, write=SetControlsType, default=2};
	__property TPanControl* PanControl = {read=FPanControl, write=SetPanControl};
	__property TZoomControl* ZoomControl = {read=FZoomControl, write=SetZoomControl};
	__property TMapTypeControl* MapTypeControl = {read=FMapTypeControl, write=SetMapTypeControl};
	__property TScaleControl* ScaleControl = {read=FScaleControl, write=SetScaleControl};
	__property TStreetViewControl* StreetViewControl = {read=FStreetViewControl, write=SetStreetViewControl};
	__property TOverviewMapControl* OverviewMapControl = {read=FOverviewMapControl, write=SetOverviewMapControl};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Tmswebgmapscontrols */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TMSWEBGMAPSCONTROLS)
using namespace Fmx::Tmswebgmapscontrols;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TmswebgmapscontrolsHPP
