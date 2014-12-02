unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, FMX.StdCtrls, FMX.Effects, FMX.Filter.Effects,
  FMX.ListView.Types, FMX.ListView, FMX.Objects, FMX.VirtualKeyboard, FMX.Ani,
  FMX.Menus, System.Actions, FMX.ActnList, System.Math, FMX.Layouts,
  FMX.ListBox, FMX.Edit, FMX.Notification, FMX.TMSWebGMapsWebBrowser,
  FMX.TMSWebGMaps, FMX.WebBrowser;

type
  TFMain = class(TForm)
    Rectangle1: TRectangle;
    Image2: TImage;
    btnMenu: TSpeedButton;
    actMenu: TActionList;
    actShowMenuLateral: TAction;
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
    lsMenu: TListBox;
    lsHeader: TListBoxGroupHeader;
    liImagem: TListBoxItem;
    liGMaps: TListBoxItem;
    ListBox2: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    GlowEffect6: TGlowEffect;
    RectClient: TRectangle;
    procedure actShowMenuLateralExecute(Sender: TObject);
    procedure liGMapsClick(Sender: TObject);
    procedure fgVirtualKeyboard1Hide(Sender: TObject; const Bounds: TRect);
    procedure fgVirtualKeyboard1Show(Sender: TObject; const Bounds: TRect);
    procedure liImagemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.fmx}

uses MapGMaps, MapImage;

procedure TFMain.actShowMenuLateralExecute(Sender: TObject);
begin
  actShowMenuLateral.Enabled := False;
  actShowMenuLateral.Tag := not actShowMenuLateral.Tag;

  if Boolean(actShowMenuLateral.Tag) then begin
    Rectangle1.BringToFront;
    rectMenuLateral.BringToFront;
    Image2.Margins.Left := 0;
    rectMenuLateral.Visible := True;
  end else begin
    Image2.Margins.Left := 8;
    rectMenuLateral.Visible := False;
  end;

  actShowMenuLateral.Enabled := True;
end;

procedure TFMain.fgVirtualKeyboard1Hide(Sender: TObject; const Bounds: TRect);
begin
  RectClient.Align := TAlignLayout.Client;
end;

procedure TFMain.fgVirtualKeyboard1Show(Sender: TObject; const Bounds: TRect);
begin
  RectClient.Align := TAlignLayout.Top;
  RectClient.Height := Self.Height - Bounds.Height - Rectangle1.Height;
end;

procedure TFMain.liGMapsClick(Sender: TObject);
begin
  if Assigned(FMapImage) then
    FMapImage.Close;

  if not Assigned(FMapGMaps) then
    Application.CreateForm(TFMapGMaps, FMapGMaps);

  actShowMenuLateral.Execute;
  FMapGMaps.TMSFMXWebGMaps1.Visible := True;
  FMapGMaps.TMSFMXWebGMaps1.Repaint;
  FMapGMaps.liGMaps.IsSelected := True;
  FMapGMaps.Show;

end;

procedure TFMain.liImagemClick(Sender: TObject);
begin

  if Assigned(FMapGMaps) then
    FMapGMaps.Close;

  if not Assigned(FMapImage) then
    Application.CreateForm(TFMapImage, FMapImage);

  actShowMenuLateral.Execute;
  FMapImage.liImagem.IsSelected := True;

  FMapImage.Show;
end;

end.
