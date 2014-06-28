unit MainMenu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, FMX.Effects, FMX.Objects, FMX.Ani, System.Actions,
  FMX.ActnList,FMX.Notification;

type
  TfrMainMenu = class(TFrame)
    Rectangle3: TRectangle;
    Rectangle2: TRectangle;
    Image1: TImage;
    BlurEffect1: TBlurEffect;
    Text1: TText;
    GlowEffect1: TGlowEffect;
    Text2: TText;
    GlowEffect2: TGlowEffect;
    Text3: TText;
    GlowEffect4: TGlowEffect;
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    GlowEffect3: TGlowEffect;
    MenuAnimationIn: TFloatAnimation;
    MenuAnimationOut: TFloatAnimation;
    ListBox2: TListBox;
    NotificationCenter1: TNotificationCenter;
    ListBoxHeader1: TListBoxHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    procedure MenuAnimationOutFinish(Sender: TObject);
    procedure MenuAnimationInFinish(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }

  end;

implementation

{$R *.fmx}

uses Main, MapGMaps;

{ TfrMainMenu }

constructor TfrMainMenu.Create(AOwner: TComponent);
begin
  inherited;
  TControl(MenuAnimationIn.Parent).Position.X := -TControl(MenuAnimationIn.Parent).Width;
  MenuAnimationOut.StopValue := -TControl(MenuAnimationIn.Parent).Width;
  MenuAnimationIn.StartValue := -TControl(MenuAnimationIn.Parent).Width;
end;

procedure TfrMainMenu.ListBoxItem2Click(Sender: TObject);
begin
  Main.FMain.actShowMenuLateral.Execute;
  MapGMaps.TFrmMapGMaps.getMe.Parent := Main.FMain;
end;

procedure TfrMainMenu.ListBoxItem3Click(Sender: TObject);
var
  a : Tnotification     ;
begin
  a := NotificationCenter1.CreateNotification ;
  a.Name := 'Opa';
  a.AlertBody := 'Deposite 500.000,00 para ter acesso a esta funcao';
  NotificationCenter1.PresentNotification(a);
  a.DisposeOf;

  Main.FMain.actShowMenuLateral.Execute;
  if Assigned(MapGMaps.frameGMaps) then
    MapGMaps.TFrmMapGMaps.getMe.Parent := nil
end;

procedure TfrMainMenu.MenuAnimationInFinish(Sender: TObject);
begin
  FMain.actShowMenuLateral.Enabled := True;
end;

procedure TfrMainMenu.MenuAnimationOutFinish(Sender: TObject);
begin
  Main.FMain.actShowMenuLateral.Enabled := True;
  frMainMenu.Parent := nil;
end;

end.
