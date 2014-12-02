// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TMSWebGMapsWebUtil.pas' rev: 28.00 (Windows)

#ifndef Fmx_TmswebgmapswebutilHPP
#define Fmx_TmswebgmapswebutilHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.ShellAPI.hpp>	// Pascal unit
#include <System.Win.ComObj.hpp>	// Pascal unit
#include <Winapi.ShlObj.hpp>	// Pascal unit
#include <FMX.Forms.hpp>	// Pascal unit
#include <System.IOUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Tmswebgmapswebutil
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall XOpenURL(System::UnicodeString AUrl);
extern DELPHI_PACKAGE void __fastcall XOpenFile(System::UnicodeString AOperation, System::UnicodeString AFileName, System::UnicodeString AParameters, System::UnicodeString ADirectory);
extern DELPHI_PACKAGE void __fastcall XCopyFile(System::UnicodeString ASource, System::UnicodeString ADestination, bool AOverwrite = false);
extern DELPHI_PACKAGE System::UnicodeString __fastcall XGetRootDirectory(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall XGetDocumentsDirectory(void);
}	/* namespace Tmswebgmapswebutil */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TMSWEBGMAPSWEBUTIL)
using namespace Fmx::Tmswebgmapswebutil;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TmswebgmapswebutilHPP
