{********************************************************************}
{                                                                    }
{ written by TMS Software                                            }
{            copyright © 2014                                        }
{            Email : info@tmssoftware.com                            }
{            Web : http://www.tmssoftware.com                        }
{                                                                    }
{ The source code is given as is. The author is not responsible      }
{ for any possible damage done due to the use of this code.          }
{ The complete source code remains property of the author and may    }
{ not be distributed, published, given or sold in any form as such.  }
{ No parts of the source code can be included in any other component }
{ or application without written authorization of the author.        }
{********************************************************************}

unit FMX.TMSWebGMapsWebBrowser.Win;

interface

{$I TMSDEFS.INC}

{$DEFINE CHROMIUMOFF}

procedure RegisterWebBrowserService;
procedure UnRegisterWebBrowserService;

implementation

uses
  Classes, FMX.Types, FMX.Platform, FMX.TMSWebGMapsWebBrowser
  {$IFNDEF CHROMIUMOFF}
  {$IFDEF MSWINDOWS},
  ceflib, ceffmx
  {$ENDIF}
  {$ENDIF}
  ;

type
  TTMSFMXWinWebGMapsWebBrowserService = class;

  TTMSFMXWinWebGMapsWebBrowserService = class(TTMSFMXWebGMapsWebBrowserFactoryService)
  protected
    function DoCreateWebBrowser(const AValue: TTMSFMXWebGMapsCustomWebBrowser): ITMSFMXWebGMapsCustomWebBrowser; override;
  end;

  {$IFNDEF CHROMIUMOFF}
  {$IFDEF MSWINDOWS}
  TChromiumFMXProtected = class(TChromiumFMX);
  {$ENDIF}
  {$ENDIF}
  TTMSFMXWebGMapsCustomWebBrowserProtected = class(TTMSFMXWebGMapsCustomWebBrowser);

  TTMSFMXWinWebGMapsWebBrowser = class(TInterfacedObject, ITMSFMXWebGMapsCustomWebBrowser)
  private
    {$IFNDEF CHROMIUMOFF}
    {$IFDEF MSWINDOWS}
    FWebBrowser: TChromiumFMX;
    {$ENDIF}
    {$ENDIF}
    FURL: string;
    FWebControl: TTMSFMXWebGMapsCustomWebBrowser;
  protected
    {$IFNDEF CHROMIUMOFF}
    {$IFDEF MSWINDOWS}
    procedure BeforeBrowse(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame;
    const request: ICefRequest; navType: TCefHandlerNavtype;
    isRedirect: boolean; out Result: Boolean);
    procedure LoadEnd(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer; out Result: Boolean);
    {$ENDIF}
    {$ENDIF}
    function GetURL: string;
    procedure SetURL(const AValue: string);
    procedure Navigate(const AURL: string); overload;
    procedure Navigate; overload;
    function ExecuteJavascript(AScript: String): String;
    procedure LoadHTML(AHTML: String);
    procedure LoadFile(AFile: String);
    procedure GoForward;
    procedure GoBack;
    procedure Reload;
    procedure StopLoading;
    procedure UpdateVisible;
    procedure UpdateEnabled;
    procedure UpdateBounds;
    procedure Initialize;
    procedure DeInitialize;
    function NativeBrowser: Pointer;
    function NativeDialog: Pointer;
  public
    constructor Create(const AWebControl: TTMSFMXWebGMapsCustomWebBrowser);
  end;

var
  WebBrowserService: ITMSFMXWebGMapsWebBrowserService;

procedure RegisterWebBrowserService;
begin
  if not TPlatformServices.Current.SupportsPlatformService(ITMSFMXWebGMapsWebBrowserService, IInterface(WebBrowserService)) then
  begin
    WebBrowserService := TTMSFMXWinWebGMapsWebBrowserService.Create;
    TPlatformServices.Current.AddPlatformService(ITMSFMXWebGMapsWebBrowserService, WebBrowserService);
  end;
end;

procedure UnregisterWebBrowserService;
begin
  TPlatformServices.Current.RemovePlatformService(ITMSFMXWebGMapsWebBrowserService);
end;

function TTMSFMXWinWebGMapsWebBrowser.GetURL: string;
begin
  Result := FURL;
end;

procedure TTMSFMXWinWebGMapsWebBrowser.GoBack;
begin
  {$IFNDEF CHROMIUMOFF}
  {$IFDEF MSWINDOWS}
  if Assigned(FWebBrowser) and Assigned(FWebBrowser.Browser) then
    FWebBrowser.Browser.GoBack;
  {$ENDIF}
  {$ENDIF}
end;

procedure TTMSFMXWinWebGMapsWebBrowser.GoForward;
begin
  {$IFNDEF CHROMIUMOFF}
  {$IFDEF MSWINDOWS}
  if Assigned(FWebBrowser) and Assigned(FWebBrowser.Browser) then
    FWebBrowser.Browser.GoForward;
  {$ENDIF}
  {$ENDIF}
end;

procedure TTMSFMXWinWebGMapsWebBrowser.Initialize;
begin
  {$IFNDEF CHROMIUMOFF}
  {$IFDEF MSWINDOWS}
  if Assigned(FWebBrowser) and not Assigned(FWebBrowser.Browser) then
  begin
    FWebBrowser.DefaultUrl := GetURL;
    TChromiumFMXProtected(FWebBrowser).Loaded;
  end;
  {$ENDIF}
  {$ENDIF}
end;

{$IFNDEF CHROMIUMOFF}
{$IFDEF MSWINDOWS}
procedure TTMSFMXWinWebGMapsWebBrowser.LoadEnd(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer;
  out Result: Boolean);
var
  Params: TTMSFMXWebGMapsCustomWebBrowserNavigateCompleteParams;
begin
  Params.URL := browser.MainFrame.Url;
  if Assigned(FWebControl) then
  begin
    FURL := Params.URL;
    TTMSFMXWebGMapsCustomWebBrowserProtected(FWebControl).NavigateComplete(Params);
  end;
end;
{$ENDIF}
{$ENDIF}

procedure TTMSFMXWinWebGMapsWebBrowser.LoadFile(AFile: String);
begin
  {$IFNDEF CHROMIUMOFF}
  {$IFDEF MSWINDOWS}
  if Assigned(FWebBrowser) and Assigned(FWebBrowser.Browser) and Assigned(FWebBrowser.Browser.MainFrame) then
    FWebBrowser.Browser.MainFrame.LoadFile(AFile, AFile);
  {$ENDIF}
  {$ENDIF}
end;

procedure TTMSFMXWinWebGMapsWebBrowser.LoadHTML(AHTML: String);
begin
  {$IFNDEF CHROMIUMOFF}
  {$IFDEF MSWINDOWS}
  if Assigned(FWebBrowser) and Assigned(FWebBrowser.Browser) and Assigned(FWebBrowser.Browser.MainFrame) then
    FWebBrowser.Browser.MainFrame.LoadString(AHTML, 'about:blank');
  {$ENDIF}
  {$ENDIF}
end;

procedure TTMSFMXWinWebGMapsWebBrowser.Navigate(const AURL: string);
begin
  {$IFNDEF CHROMIUMOFF}
  {$IFDEF MSWINDOWS}
  if Assigned(FWebBrowser) then
    FWebBrowser.Load(AURL);
  {$ENDIF}
  {$ENDIF}
end;

function TTMSFMXWinWebGMapsWebBrowser.NativeBrowser: Pointer;
begin
  {$IFNDEF CHROMIUMOFF}
    {$IFDEF MSWINDOWS}
    Result := FWebBrowser;
    {$ELSE}
    Result := nil;
    {$ENDIF}
  {$ELSE}
  Result := nil;
  {$ENDIF}
end;

function TTMSFMXWinWebGMapsWebBrowser.NativeDialog: Pointer;
begin
  Result := nil;
end;

procedure TTMSFMXWinWebGMapsWebBrowser.Navigate;
begin
  Navigate(FURL);
end;

procedure TTMSFMXWinWebGMapsWebBrowser.Reload;
begin
  {$IFNDEF CHROMIUMOFF}
  {$IFDEF MSWINDOWS}
  if Assigned(FWebBrowser) and Assigned(FWebBrowser.Browser) then
    FWebBrowser.Browser.Reload;
  {$ENDIF}
  {$ENDIF}
end;

procedure TTMSFMXWinWebGMapsWebBrowser.SetURL(const AValue: string);
begin
  FURL := AValue;
end;

procedure TTMSFMXWinWebGMapsWebBrowser.StopLoading;
begin
  {$IFNDEF CHROMIUMOFF}
  {$IFDEF MSWINDOWS}
  if Assigned(FWebBrowser) and Assigned(FWebBrowser.Browser) then
    FWebBrowser.Browser.StopLoad;
  {$ENDIF}
  {$ENDIF}
end;

procedure TTMSFMXWinWebGMapsWebBrowser.UpdateBounds;
begin
end;

procedure TTMSFMXWinWebGMapsWebBrowser.UpdateEnabled;
begin
end;

procedure TTMSFMXWinWebGMapsWebBrowser.UpdateVisible;
begin
end;

{$IFNDEF CHROMIUMOFF}
{$IFDEF MSWINDOWS}
procedure TTMSFMXWinWebGMapsWebBrowser.BeforeBrowse(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  const request: ICefRequest; navType: TCefHandlerNavtype; isRedirect: boolean;
  out Result: Boolean);
var
  Params: TTMSFMXWebGMapsCustomWebBrowserBeforeNavigateParams;
begin
  Params.URL := request.Url;
  Params.Cancel := Result;
  if Assigned(FWebControl) then
  begin
    FURL := Params.URL;
    TTMSFMXWebGMapsCustomWebBrowserProtected(FWebControl).BeforeNavigate(Params);
  end;
  Result := Params.Cancel;
end;
{$ENDIF}
{$ENDIF}

constructor TTMSFMXWinWebGMapsWebBrowser.Create(const AWebControl: TTMSFMXWebGMapsCustomWebBrowser);
begin
  FWebControl := AWebControl;
  {$IFNDEF CHROMIUMOFF}
  {$IFDEF MSWINDOWS}
  FWebBrowser := TChromiumFMX.Create(FWebControl);
  FWebBrowser.OnBeforeBrowse := BeforeBrowse;
  FWebBrowser.OnLoadEnd := LoadEnd;
  FWebBrowser.Parent := FWebControl;
  {$IFDEF DELPHIXE6_LVL}
  FWebBrowser.Align := TAlignLayout.Client;
  {$ELSE}
  FWebBrowser.Align := TAlignLayout.alClient;
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
end;

procedure TTMSFMXWinWebGMapsWebBrowser.DeInitialize;
begin
  {$IFNDEF CHROMIUMOFF}
  {$IFDEF MSWINDOWS}
  if Assigned(FWebBrowser) then
  begin
    FWebBrowser.Free;
    FWebBrowser := nil;
  end;
  {$ENDIF}
  {$ENDIF}
end;

function TTMSFMXWinWebGMapsWebBrowser.ExecuteJavascript(AScript: String): String;
begin
  Result := '';
  {$IFNDEF CHROMIUMOFF}
  {$IFDEF MSWINDOWS}
  if Assigned(FWebBrowser) and Assigned(FWebBrowser.Browser) then
    FWebBrowser.Browser.MainFrame.ExecuteJavaScript(AScript, '', -1);
  {$ENDIF}
  {$ENDIF}
end;

{ TTMSFMXWinWebGMapsWebBrowserService }

function TTMSFMXWinWebGMapsWebBrowserService.DoCreateWebBrowser(const AValue: TTMSFMXWebGMapsCustomWebBrowser): ITMSFMXWebGMapsCustomWebBrowser;
begin
  Result := TTMSFMXWinWebGMapsWebBrowser.Create(AValue);
end;

{$IFNDEF CHROMIUMOFF}
{$IFDEF MSWINDOWS}
initialization
  CefCache := 'cache';
{$ENDIF}
{$ENDIF}

end.
