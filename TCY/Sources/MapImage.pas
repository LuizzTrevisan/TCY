unit MapImage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Math,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Main, FGX.VirtualKeyboard, System.Actions, FMX.ActnList, FMX.Objects,
  FMX.Effects, FMX.ListBox, FMX.Layouts;

type
  TFMain1 = class(TFMain)
    Image1: TImage;
    Rectangle2: TRectangle;
    procedure Image1Gesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
  public
    { Public declarations }
    FLastPosition: TPointF;
    FLastDistance: Integer;
    procedure AddPicture(files: TStrings);
    procedure handlePan(EventInfo: TGestureEventInfo);
    procedure handleZoom(EventInfo: TGestureEventInfo);
    procedure handleRotate(EventInfo: TGestureEventInfo);
  end;

var
  FMain1: TFMain1;

implementation

{$R *.fmx}

procedure TFMain1.AddPicture(files: TStrings);
begin

end;

procedure TFMain1.handlePan(EventInfo: TGestureEventInfo);
begin
  if not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags) then begin

    Rectangle2.Position.X := Rectangle2.Position.X +
      (EventInfo.Location.X - FLastPosition.X);
    {
      if Rectangle2.Position.X < 0 then
      Rectangle2.Position.X := 0;
      if Rectangle2.Position.X > (RectClient.Width - Rectangle2.Width) then
      Rectangle2.Position.X := RectClient.Width - Rectangle2.Width;
    }
    Rectangle2.Position.Y := Rectangle2.Position.Y +
      (EventInfo.Location.Y - FLastPosition.Y);

    { if Image1.Position.Y < 0 then
      Image1.Position.Y := 0;
      if Image1.Position.Y > (RectClient.Height - Image1.Height) then
      Image1.Position.Y := RectClient.Height - Image1.Height;
    }
  end;

  FLastPosition := EventInfo.Location;

end;

procedure TFMain1.handleRotate(EventInfo: TGestureEventInfo);
begin
  Image1.RotationAngle := RadToDeg(-EventInfo.Angle);
end;

procedure TFMain1.handleZoom(EventInfo: TGestureEventInfo);
begin

  if not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags) then begin
    Rectangle2.Width := Rectangle2.Width + ((EventInfo.Distance - FLastDistance) *
      (Rectangle2.Width / 100));
    Rectangle2.Height := Rectangle2.Height + ((EventInfo.Distance - FLastDistance) *
      (Rectangle2.Height / 100));

    Rectangle2.Position.X := Rectangle2.Position.X -
      ((EventInfo.Distance - FLastDistance) * (Rectangle2.Width / 100)) / 2;
    Rectangle2.Position.Y := Rectangle2.Position.Y -
      ((EventInfo.Distance - FLastDistance) * (Rectangle2.Height / 100)) / 2;

  end;

  FLastDistance := EventInfo.Distance;

end;

procedure TFMain1.Image1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  inherited;
  if EventInfo.GestureID = igiPan then
    handlePan(EventInfo)
  else if EventInfo.GestureID = igiZoom then
    handleZoom(EventInfo);

  // else if EventInfo.GestureID = igiRotate then
  // handleRotate(EventInfo);
  // else if EventInfo.GestureID = igiPressAndTap then
  // handlePressAndTap(EventInfo);
end;

procedure TFMain1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  inherited;
  with TCircle.Create(Rectangle2) do begin
    Width := 10;
    Height := 10;
    Position.X := X;
    Position.Y := Y;
    Parent := Rectangle2;
    BringToFront;
    Anchors := [];
  end;

end;

end.
