unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Filter.Effects, FMX.ListView.Types, FMX.ListView,
  FMX.Objects,
  FMX.Ani, FMX.Menus, System.Actions, FMX.ActnList, System.Math, FMX.Layouts,
  FMX.ListBox, MainMenu, FMX.Edit, FMX.Notification;

type
  TFMain = class(TForm)
    Rectangle1: TRectangle;
    Image2: TImage;
    SpeedButton1: TSpeedButton;
    actMenu: TActionList;
    actShowMenuLateral: TAction;
    Rectangle2: TRectangle;
    procedure actShowMenuLateralExecute(Sender: TObject);
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
  FMain: TFMain;
  frMainMenu: TfrMainMenu;

implementation

{$R *.fmx}

uses MapGMaps;

procedure TFMain.actShowMenuLateralExecute(Sender: TObject);
begin
  actShowMenuLateral.Enabled := False;
  actShowMenuLateral.Tag := not actShowMenuLateral.Tag;

  if not Assigned(frMainMenu) then
    frMainMenu := TfrMainMenu.Create(Self);

  if Boolean(actShowMenuLateral.Tag) then begin
    frMainMenu.Parent := Self;
    if Assigned(frameGMaps) then
      frameGMaps.TMSFMXWebGMaps1.Visible := False;
    frMainMenu.BringToFront;
    Rectangle1.BringToFront;
    frMainMenu.MenuAnimationIn.Start;
  end else begin
    frMainMenu.MenuAnimationOut.Start;
    if Assigned(frameGMaps) then
      frameGMaps.TMSFMXWebGMaps1.Visible := True;
  end;
end;

procedure TFMain.ListBoxItem2Click(Sender: TObject);
begin
  TFrmMapGMaps.getMe;
  // frameGMaps.Parent  := Panel2 ;
  frameGMaps.Visible := True;
  actShowMenuLateral.Execute;

end;

procedure TFMain.ListBoxItem3Click(Sender: TObject);
begin
  actShowMenuLateral.Execute;
end;

procedure TFMain.MenuAnimationInFinish(Sender: TObject);
begin
  actShowMenuLateral.Enabled := True;
end;

procedure TFMain.rectFormMenuShowAnimationOutFinish(Sender: TObject);
begin
  frMainMenu.Parent := nil;
end;

end.
