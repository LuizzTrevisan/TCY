unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Filter.Effects, FMX.ListView.Types, FMX.ListView, FMX.Objects,
  FMX.Ani, FMX.Menus, System.Actions, FMX.ActnList,System.Math, FMX.Layouts,
  FMX.ListBox;

type
  TForm1 = class(TForm)
    Image1: TImage;
    BlurEffect1: TBlurEffect;
    Text1: TText;
    GlowEffect1: TGlowEffect;
    Text2: TText;
    GlowEffect2: TGlowEffect;
    actMenu: TActionList;
    actShowMenuLateral: TAction;
    GlowEffect3: TGlowEffect;
    Panel2: TPanel;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    SpeedButton1: TSpeedButton;
    Image2: TImage;
    rectFormMenuShow: TRectangle;
    rectFormMenuShowAnimationIn: TFloatAnimation;
    MenuAnimationIn: TFloatAnimation;
    rectFormMenuShowAnimationOut: TFloatAnimation;
    MenuAnimationOut: TFloatAnimation;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBox2: TListBox;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    procedure FormCreate(Sender: TObject);
    procedure actShowMenuLateralExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuAnimationInFinish(Sender: TObject);
    procedure rectFormMenuShowAnimationOutFinish(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses MapGMaps;

procedure TForm1.actShowMenuLateralExecute(Sender: TObject);
begin
  actShowMenuLateral.Enabled := False;
  actShowMenuLateral.Tag := not actShowMenuLateral.Tag;

  if Boolean(actShowMenuLateral.Tag) then begin
    MenuAnimationIn.Start;
    rectFormMenuShow.Opacity := 0;
    rectFormMenuShow.Visible := True;
    rectFormMenuShowAnimationIn.Start;
  end else begin
    MenuAnimationOut.Start;
    rectFormMenuShowAnimationOut.Start;
  end;


end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  MenuAnimationOut.StopValue  := -ListBox1.Width;
  MenuAnimationIn.StartValue := -ListBox1.Width;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ListBox1.Position.X := -ListBox1.Width;
end;

procedure TForm1.ListBoxItem2Click(Sender: TObject);
begin
  TFrmMapGMaps.getMe;
  frameGMaps.Parent  := Panel2 ;
  frameGMaps.Visible := True;
  actShowMenuLateral.Execute;

end;

procedure TForm1.ListBoxItem3Click(Sender: TObject);
begin
  actShowMenuLateral.Execute;
end;

procedure TForm1.MenuAnimationInFinish(Sender: TObject);
begin
  actShowMenuLateral.Enabled := True;
end;

procedure TForm1.rectFormMenuShowAnimationOutFinish(Sender: TObject);
begin
  rectFormMenuShow.Visible := False;
end;

end.
