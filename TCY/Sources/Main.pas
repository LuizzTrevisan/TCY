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
    RectMenu: TRectangle;
    ImgMenu: TImage;
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
    lsOpcoes: TListBox;
    lsHeader: TListBoxGroupHeader;
    liImagem: TListBoxItem;
    liGMaps: TListBoxItem;
    ListBoxRodape: TListBox;
    liConfiguracoes: TListBoxItem;
    liAjuda: TListBoxItem;
    GlowEffect6: TGlowEffect;
    RectClient: TRectangle;
    procedure actShowMenuLateralExecute(Sender: TObject);
    procedure liGMapsClick(Sender: TObject);
    procedure liImagemClick(Sender: TObject);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
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
    RectMenu.BringToFront;
    rectMenuLateral.BringToFront;
    ImgMenu.Margins.Left := 0;
    rectMenuLateral.Visible := True;
  end else begin
    ImgMenu.Margins.Left := 8;
    rectMenuLateral.Visible := False;
  end;

  actShowMenuLateral.Enabled := True;
end;

procedure TFMain.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin

  //quando oculta o teclado, retornar o conteudo preenchendo toda tela
  RectClient.Align := TAlignLayout.Client;
end;

procedure TFMain.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin

  //quando mostra o teclado, calcula o tamanho que pode sobrar para o aplicativo.
  RectClient.Align := TAlignLayout.Top;
  RectClient.Height := Self.Height - Bounds.Height - RectMenu.Height;

end;

procedure TFMain.liGMapsClick(Sender: TObject);
begin
  //caso a tela da utf estiver aberta, fecha.
  if Assigned(FMapImage) then
    FMapImage.Close;

   //instancia
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
  //caso a tela da navegação livre esteja aberta, fecha
  if Assigned(FMapGMaps) then
    FMapGMaps.Close;

  //se nao ta instanciado, cria uma nova instancia.
  if not Assigned(FMapImage) then
    Application.CreateForm(TFMapImage, FMapImage);

  //fehcar o menu lateral
  actShowMenuLateral.Execute;
  FMapImage.liImagem.IsSelected := True;

  FMapImage.Show;
end;

end.
