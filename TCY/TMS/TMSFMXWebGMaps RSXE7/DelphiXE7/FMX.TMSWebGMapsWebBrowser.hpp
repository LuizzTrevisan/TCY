// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TMSWebGMapsWebBrowser.pas' rev: 28.00 (Windows)

#ifndef Fmx_TmswebgmapswebbrowserHPP
#define Fmx_TmswebgmapswebbrowserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <FMX.Dialogs.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.TypInfo.hpp>	// Pascal unit
#include <System.UIConsts.hpp>	// Pascal unit
#include <System.Generics.Collections.hpp>	// Pascal unit
#include <FMX.StdCtrls.hpp>	// Pascal unit
#include <FMX.Types.hpp>	// Pascal unit
#include <FMX.Types3D.hpp>	// Pascal unit
#include <FMX.Forms.hpp>	// Pascal unit
#include <FMX.Consts.hpp>	// Pascal unit
#include <FMX.Controls.hpp>	// Pascal unit
#include <FMX.Graphics.hpp>	// Pascal unit
#include <System.Generics.Defaults.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Tmswebgmapswebbrowser
{
//-- type declarations -------------------------------------------------------
__interface ITMSFMXWebGMapsCustomWebBrowser;
typedef System::DelphiInterface<ITMSFMXWebGMapsCustomWebBrowser> _di_ITMSFMXWebGMapsCustomWebBrowser;
__interface  INTERFACE_UUID("{FEC8EF97-7236-430C-B9F6-EDF05763B4B7}") ITMSFMXWebGMapsCustomWebBrowser  : public System::IInterface 
{
	
public:
	virtual System::UnicodeString __fastcall GetURL(void) = 0 ;
	virtual void __fastcall SetURL(const System::UnicodeString AValue) = 0 ;
	__property System::UnicodeString URL = {read=GetURL, write=SetURL};
	virtual void __fastcall Navigate(const System::UnicodeString AURL) = 0 /* overload */;
	virtual void __fastcall Navigate(void) = 0 /* overload */;
	virtual System::UnicodeString __fastcall ExecuteJavascript(System::UnicodeString AScript) = 0 ;
	virtual void __fastcall LoadHTML(System::UnicodeString AHTML) = 0 ;
	virtual void __fastcall LoadFile(System::UnicodeString AFile) = 0 ;
	virtual void * __fastcall NativeBrowser(void) = 0 ;
	virtual void __fastcall GoForward(void) = 0 ;
	virtual void __fastcall GoBack(void) = 0 ;
	virtual void __fastcall Reload(void) = 0 ;
	virtual void __fastcall StopLoading(void) = 0 ;
	virtual void __fastcall UpdateBounds(void) = 0 ;
	virtual void __fastcall UpdateVisible(void) = 0 ;
	virtual void __fastcall UpdateEnabled(void) = 0 ;
	virtual void __fastcall Initialize(void) = 0 ;
	virtual void __fastcall DeInitialize(void) = 0 ;
	virtual void * __fastcall NativeDialog(void) = 0 ;
};

__interface ITMSFMXWebGMapsWebBrowserService;
typedef System::DelphiInterface<ITMSFMXWebGMapsWebBrowserService> _di_ITMSFMXWebGMapsWebBrowserService;
class DELPHICLASS TTMSFMXWebGMapsCustomWebBrowser;
__interface  INTERFACE_UUID("{348E7B8B-0ED8-4BE0-9D26-A679C0327F9A}") ITMSFMXWebGMapsWebBrowserService  : public System::IInterface 
{
	
public:
	virtual _di_ITMSFMXWebGMapsCustomWebBrowser __fastcall CreateWebBrowser(TTMSFMXWebGMapsCustomWebBrowser* const AValue) = 0 ;
};

struct DECLSPEC_DRECORD TTMSFMXWebGMapsCustomWebBrowserNavigateCompleteParams
{
public:
	System::UnicodeString URL;
};


struct DECLSPEC_DRECORD TTMSFMXWebGMapsCustomWebBrowserBeforeNavigateParams
{
public:
	System::UnicodeString URL;
	bool Cancel;
};


typedef void __fastcall (__closure *TTMSFMXWebGMapsCustomWebBrowserNavigateComplete)(System::TObject* Sender, TTMSFMXWebGMapsCustomWebBrowserNavigateCompleteParams &Params);

typedef void __fastcall (__closure *TTMSFMXWebGMapsCustomWebBrowserBeforeNavigate)(System::TObject* Sender, TTMSFMXWebGMapsCustomWebBrowserBeforeNavigateParams &Params);

class PASCALIMPLEMENTATION TTMSFMXWebGMapsCustomWebBrowser : public Fmx::Controls::TControl
{
	typedef Fmx::Controls::TControl inherited;
	
private:
	_di_ITMSFMXWebGMapsCustomWebBrowser FWebBrowser;
	System::UnicodeString FURL;
	TTMSFMXWebGMapsCustomWebBrowserNavigateComplete FOnNavigateComplete;
	TTMSFMXWebGMapsCustomWebBrowserBeforeNavigate FOnBeforeNavigate;
	System::Classes::TNotifyEvent FOnHardwareButtonClicked;
	System::UnicodeString __fastcall GetURL(void);
	void __fastcall SetURL(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetVersion(void);
	int __fastcall GetVersionNr(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall DoHardwareButtonClicked(void);
	virtual void __fastcall BeforeNavigate(TTMSFMXWebGMapsCustomWebBrowserBeforeNavigateParams &Params);
	virtual void __fastcall NavigateComplete(TTMSFMXWebGMapsCustomWebBrowserNavigateCompleteParams &Params);
	virtual void __fastcall SetParent(Fmx::Types::TFmxObject* const Value);
	virtual void __fastcall SetVisible(const bool Value);
	virtual void __fastcall SetEnabled(const bool Value);
	virtual void __fastcall Loaded(void);
	void __fastcall ShowMsgTrial(void);
	
public:
	__fastcall virtual TTMSFMXWebGMapsCustomWebBrowser(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTMSFMXWebGMapsCustomWebBrowser(void);
	virtual void __fastcall Show(void);
	virtual void __fastcall Hide(void);
	virtual void __fastcall Move(void);
	virtual void __fastcall SetBounds(float X, float Y, float AWidth, float AHeight);
	virtual void __fastcall Resize(void);
	virtual void __fastcall DoAbsoluteChanged(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Navigate(void)/* overload */;
	virtual void __fastcall Navigate(const System::UnicodeString AURL)/* overload */;
	virtual System::UnicodeString __fastcall ExecuteJavascript(System::UnicodeString AScript);
	virtual void __fastcall LoadHTML(System::UnicodeString AHTML);
	virtual void __fastcall LoadFile(System::UnicodeString AFile);
	virtual void __fastcall Initialize(void);
	virtual void __fastcall GoForward(void);
	virtual void __fastcall GoBack(void);
	virtual void __fastcall Reload(void);
	virtual void __fastcall StopLoading(void);
	__property System::UnicodeString URL = {read=GetURL, write=SetURL};
	void * __fastcall NativeBrowser(void);
	__property TTMSFMXWebGMapsCustomWebBrowserBeforeNavigate OnBeforeNavigate = {read=FOnBeforeNavigate, write=FOnBeforeNavigate};
	__property TTMSFMXWebGMapsCustomWebBrowserNavigateComplete OnNavigateComplete = {read=FOnNavigateComplete, write=FOnNavigateComplete};
	__property System::Classes::TNotifyEvent OnHardwareButtonClicked = {read=FOnHardwareButtonClicked, write=FOnHardwareButtonClicked};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


class DELPHICLASS TTMSFMXWebGMapsWebBrowserFactoryService;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TTMSFMXWebGMapsWebBrowserFactoryService : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
protected:
	System::Generics::Collections::TList__1<_di_ITMSFMXWebGMapsCustomWebBrowser>* FWebBrowsers;
	virtual _di_ITMSFMXWebGMapsCustomWebBrowser __fastcall DoCreateWebBrowser(TTMSFMXWebGMapsCustomWebBrowser* const AValue) = 0 ;
	
public:
	__fastcall TTMSFMXWebGMapsWebBrowserFactoryService(void);
	__fastcall virtual ~TTMSFMXWebGMapsWebBrowserFactoryService(void);
	_di_ITMSFMXWebGMapsCustomWebBrowser __fastcall CreateWebBrowser(TTMSFMXWebGMapsCustomWebBrowser* const AValue);
private:
	void *__ITMSFMXWebGMapsWebBrowserService;	// ITMSFMXWebGMapsWebBrowserService 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {348E7B8B-0ED8-4BE0-9D26-A679C0327F9A}
	operator _di_ITMSFMXWebGMapsWebBrowserService()
	{
		_di_ITMSFMXWebGMapsWebBrowserService intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator ITMSFMXWebGMapsWebBrowserService*(void) { return (ITMSFMXWebGMapsWebBrowserService*)&__ITMSFMXWebGMapsWebBrowserService; }
	#endif
	
};

#pragma pack(pop)

class DELPHICLASS TTMSFMXWebGMapsWebBrowser;
class PASCALIMPLEMENTATION TTMSFMXWebGMapsWebBrowser : public TTMSFMXWebGMapsCustomWebBrowser
{
	typedef TTMSFMXWebGMapsCustomWebBrowser inherited;
	
__published:
	__property Align = {default=0};
	__property Anchors;
	__property Height;
	__property Margins;
	__property Position;
	__property URL = {default=0};
	__property Visible = {default=1};
	__property Width;
	__property Enabled = {default=1};
	__property OnBeforeNavigate;
	__property OnNavigateComplete;
	__property OnHardwareButtonClicked;
	__property Version = {default=0};
	__property Size;
public:
	/* TTMSFMXWebGMapsCustomWebBrowser.Create */ inline __fastcall virtual TTMSFMXWebGMapsWebBrowser(System::Classes::TComponent* AOwner) : TTMSFMXWebGMapsCustomWebBrowser(AOwner) { }
	/* TTMSFMXWebGMapsCustomWebBrowser.Destroy */ inline __fastcall virtual ~TTMSFMXWebGMapsWebBrowser(void) { }
	
};


class DELPHICLASS TTMSFMXWebGMapsWebBrowserPopupForm;
class DELPHICLASS TTMSFMXWebGMapsWebBrowserPopup;
class PASCALIMPLEMENTATION TTMSFMXWebGMapsWebBrowserPopupForm : public Fmx::Forms::TCustomForm
{
	typedef Fmx::Forms::TCustomForm inherited;
	
private:
	TTMSFMXWebGMapsWebBrowserPopup* FWebBrowserPopup;
	
protected:
	void __fastcall UpdateBackGround(void);
	
public:
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTMSFMXWebGMapsWebBrowserPopupForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TCustomForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTMSFMXWebGMapsWebBrowserPopupForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TCustomForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTMSFMXWebGMapsWebBrowserPopupForm(void) { }
	
};


class PASCALIMPLEMENTATION TTMSFMXWebGMapsWebBrowserPopup : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FModal;
	TTMSFMXWebGMapsWebBrowserPopupForm* FWebBrowserForm;
	TTMSFMXWebGMapsCustomWebBrowser* FWebBrowser;
	TTMSFMXWebGMapsCustomWebBrowserNavigateComplete FOnNavigateComplete;
	TTMSFMXWebGMapsCustomWebBrowserBeforeNavigate FOnBeforeNavigate;
	System::UnicodeString FURL;
	Fmx::Forms::TFormPosition FPosition;
	int FWidth;
	int FHeight;
	int FTop;
	int FLeft;
	bool FFullScreen;
	bool FCloseButton;
	System::Classes::TNotifyEvent FOnClose;
	
protected:
	void __fastcall ButtonClose(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall BeforeNavigate(System::TObject* Sender, TTMSFMXWebGMapsCustomWebBrowserBeforeNavigateParams &Params);
	void __fastcall NavigateComplete(System::TObject* Sender, TTMSFMXWebGMapsCustomWebBrowserNavigateCompleteParams &Params);
	
public:
	__fastcall virtual TTMSFMXWebGMapsWebBrowserPopup(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTMSFMXWebGMapsWebBrowserPopup(void);
	System::Uitypes::TModalResult __fastcall Open(bool AModal = true)/* overload */;
	System::Uitypes::TModalResult __fastcall Open(System::UnicodeString AURL, bool AModal = true)/* overload */;
	void __fastcall Close(System::Uitypes::TModalResult AModalResult = (System::Uitypes::TModalResult)(0x1));
	
__published:
	__property TTMSFMXWebGMapsCustomWebBrowserBeforeNavigate OnBeforeNavigate = {read=FOnBeforeNavigate, write=FOnBeforeNavigate};
	__property TTMSFMXWebGMapsCustomWebBrowserNavigateComplete OnNavigateComplete = {read=FOnNavigateComplete, write=FOnNavigateComplete};
	__property System::UnicodeString URL = {read=FURL, write=FURL};
	__property Fmx::Forms::TFormPosition Position = {read=FPosition, write=FPosition, default=4};
	__property bool FullScreen = {read=FFullScreen, write=FFullScreen, default=0};
	__property int Width = {read=FWidth, write=FWidth, default=640};
	__property int Height = {read=FHeight, write=FHeight, default=480};
	__property int Left = {read=FLeft, write=FLeft, default=0};
	__property int Top = {read=FTop, write=FTop, default=0};
	__property bool CloseButton = {read=FCloseButton, write=FCloseButton, default=0};
	__property System::Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MAJ_VER = System::Int8(0x1);
static const System::Int8 MIN_VER = System::Int8(0x0);
static const System::Int8 REL_VER = System::Int8(0x0);
static const System::Int8 BLD_VER = System::Int8(0x1);
}	/* namespace Tmswebgmapswebbrowser */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TMSWEBGMAPSWEBBROWSER)
using namespace Fmx::Tmswebgmapswebbrowser;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TmswebgmapswebbrowserHPP
