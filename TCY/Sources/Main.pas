unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, FMX.StdCtrls, FMX.Effects, FMX.Filter.Effects,
  FMX.ListView.Types, FMX.ListView, FMX.Objects, FMX.VirtualKeyboard, FMX.Ani,
  FMX.Menus,  System.Actions, FMX.ActnList, System.Math, FMX.Layouts,
  FMX.ListBox, FMX.Edit, FMX.Notification, FMX.TMSWebGMapsWebBrowser,
  FMX.TMSWebGMaps, FMX.WebBrowser, CacheLayout;

type
  TFMain = class(TForm)
    Rectangle1: TRectangle;
    Image2: TImage;
    SpeedButton1: TSpeedButton;
    actMenu: TActionList;
    actShowMenuLateral: TAction;
    txtStatus: TText;
    GlowEffect2: TGlowEffect;
    GlowEffect3: TGlowEffect;
    rectMenuLateral: TRectangle;
    rectTop: TRectangle;
    imgTop: TImage;
    BlurEffect1: TBlurEffect;
    textFundo: TText;
    GlowEffect1: TGlowEffect;
    textTop: TText;
    GlowEffect4: TGlowEffect;
    textBottom: TText;
    GlowEffect5: TGlowEffect;
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem3: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    GlowEffect6: TGlowEffect;
    ListBox2: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    procedure actShowMenuLateralExecute(Sender: TObject);
    procedure MenuAnimationInFinish(Sender: TObject);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FNeedRecalc: Boolean;
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.fmx}

uses MapGMaps;

procedure TFMain.actShowMenuLateralExecute(Sender: TObject);
begin
  actShowMenuLateral.Enabled := False;
  actShowMenuLateral.Tag := not actShowMenuLateral.Tag;

  if Boolean(actShowMenuLateral.Tag) then begin
    Rectangle1.BringToFront;
    Image2.Margins.Left := 0;
    rectMenuLateral.Visible := True;
  end else begin
    Image2.Margins.Left := 8;
    rectMenuLateral.Visible := False;
  end;

  actShowMenuLateral.Enabled := True;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  FNeedRecalc := True;
end;

procedure TFMain.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FNeedRecalc := True;
  FMain.SetBounds(0,0,FMain.Width, FMain.Height + Bounds.Height);
end;

procedure TFMain.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  if FNeedRecalc then begin
    FMain.SetBounds(0,0,FMain.Width, FMain.Height - Bounds.Height);
  end;
  FNeedRecalc := False;
end;

procedure TFMain.MenuAnimationInFinish(Sender: TObject);
begin
  actShowMenuLateral.Enabled := True;
end;

end.
