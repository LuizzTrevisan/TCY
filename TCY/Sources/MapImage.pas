unit MapImage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Math,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Main, FGX.VirtualKeyboard, System.Actions, FMX.ActnList, FMX.Objects,
  FMX.Effects, FMX.ListBox, FMX.Layouts, FMX.ListView.Types, FMX.ListView,
  FMX.Edit;

type
  TFMapImage = class(TFMain)
    Image1: TImage;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SourceMarker: TImage;
    procedure Image1Gesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure Rectangle2Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Image1DragDrop(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
    procedure Image1DragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure SourceMarkerGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure SourceMarkerMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
    minHeight, minWidth, maxHeight, maxWidth: Single;
    procedure VerificaPosicaoTamanhoMinimo;
    procedure ZoomImage(Size, X, Y: Single);
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
  FMapImage: TFMapImage;

implementation

{$R *.fmx}

procedure TFMapImage.AddPicture(files: TStrings);
begin

end;

procedure TFMapImage.FormCreate(Sender: TObject);
begin
  inherited;
  minHeight := Rectangle2.Height;
  minWidth := Rectangle2.Width;

  maxHeight := Rectangle2.Height * 2;
  maxWidth := Rectangle2.Width * 2;
end;

procedure TFMapImage.handlePan(EventInfo: TGestureEventInfo);
begin
  if not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags) then begin
    Rectangle2.Position.X := Rectangle2.Position.X +
      (EventInfo.Location.X - FLastPosition.X);

    Rectangle2.Position.Y := Rectangle2.Position.Y +
      (EventInfo.Location.Y - FLastPosition.Y);

    VerificaPosicaoTamanhoMinimo;
  end;

  FLastPosition := EventInfo.Location;

end;

procedure TFMapImage.handleRotate(EventInfo: TGestureEventInfo);
begin
  Image1.RotationAngle := RadToDeg(-EventInfo.Angle);
end;

procedure TFMapImage.VerificaPosicaoTamanhoMinimo;
begin
  if Rectangle2.Position.X > 0 then
    Rectangle2.Position.X := 0;

  if Rectangle2.Position.Y > 0 then
    Rectangle2.Position.Y := 0;
  if Rectangle2.Height < minHeight then
    Rectangle2.Height := minHeight;

  if Rectangle2.Width < minWidth then
    Rectangle2.Width := minWidth;

  if Rectangle2.Width > maxWidth then
    Rectangle2.Width := maxWidth;

  if Rectangle2.Height > maxHeight then
    Rectangle2.Height := maxHeight;

  if Rectangle2.Position.Y < RectClient.Height - Rectangle2.Height then
    Rectangle2.Position.Y := RectClient.Height - Rectangle2.Height;

  if Rectangle2.Position.X < RectClient.Width - Rectangle2.Width then
    Rectangle2.Position.X := RectClient.Width - Rectangle2.Width;

end;

procedure TFMapImage.ZoomImage(Size, X, Y: Single);
var
  eventDistance, widthDistance, heightDistance: Single;
begin
  eventDistance := Size / 10;
  widthDistance := (eventDistance * (Rectangle2.Width / 100));
  heightDistance := (eventDistance * (Rectangle2.Height / 100));

  Rectangle2.Width := Rectangle2.Width + widthDistance;
  Rectangle2.Height := Rectangle2.Height + heightDistance;

  if (Rectangle2.Width < maxWidth) and (Rectangle2.Height < maxHeight) then
  begin
    Rectangle2.Position.X := Rectangle2.Position.X -
      ((X / Self.Width) * widthDistance);

    Rectangle2.Position.Y := Rectangle2.Position.Y -
      ((Y / Self.Height) * heightDistance);
  end;

  VerificaPosicaoTamanhoMinimo;
end;

procedure TFMapImage.handleZoom(EventInfo: TGestureEventInfo);
begin

  if not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags) then
    ZoomImage(EventInfo.Distance - FLastDistance, EventInfo.Location.X,
      EventInfo.Location.Y);

  FLastDistance := EventInfo.Distance;

end;

procedure TFMapImage.Image1DragDrop(Sender: TObject; const Data: TDragObject;
  const Point: TPointF);
begin
  inherited;
  TImage(Data.Source).Position.X := Point.X;
  TImage(Data.Source).Position.Y := Point.Y;
end;

procedure TFMapImage.Image1DragOver(Sender: TObject; const Data: TDragObject;
  const Point: TPointF; var Operation: TDragOperation);
begin
  inherited;
  TImage(Data.Source).Position.X := Point.X;
  TImage(Data.Source).Position.Y := Point.Y;
end;

procedure TFMapImage.Image1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  inherited;

  // else if EventInfo.GestureID = igiRotate then
  // handleRotate(EventInfo);
  // else if EventInfo.GestureID = igiPressAndTap then
  // handlePressAndTap(EventInfo);
end;

procedure TFMapImage.SourceMarkerGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  inherited;
  if not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags) then begin
    TImage(Sender).Position.X := TImage(Sender).Position.X +
      (EventInfo.Location.X - FLastPosition.X);

    TImage(Sender).Position.Y := TImage(Sender).Position.Y +
      (EventInfo.Location.Y - FLastPosition.Y);

    // VerificaPosicaoTamanhoMinimo;
  end;

  FLastPosition := EventInfo.Location;
end;

procedure TFMapImage.SourceMarkerMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  inherited;
  ShowMessage('Opa');
end;

procedure TFMapImage.Rectangle2Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  newMarker: TImage;
begin
  inherited;
  if EventInfo.GestureID = igiPan then
    handlePan(EventInfo)
  else if EventInfo.GestureID = igiZoom then
    handleZoom(EventInfo)
  else if EventInfo.GestureID = igiDoubleTap then begin

    newMarker := TImage.Create(Rectangle2);
    newMarker.DragMode := TDragMode.dmAutomatic;
    newMarker.Visible := False;
    newMarker.MultiResBitmap[0].Bitmap := SourceMarker.MultiResBitmap[0].Bitmap;
    newMarker.Width := SourceMarker.Width;
    newMarker.Height := SourceMarker.Height;

    newMarker.OnMouseUp := SourceMarkerMouseUp;
    newMarker.OnGesture := SourceMarkerGesture;
    newMarker.Touch.InteractiveGestures := [TInteractiveGesture.Pan];

    newMarker.Position.X := EventInfo.Location.X - Rectangle2.Position.X -
      (newMarker.Width / 2);
    newMarker.Position.Y := EventInfo.Location.Y - Rectangle2.Position.Y -
      newMarker.Height - RectClient.Position.Y;

    newMarker.Parent := Rectangle2;
    newMarker.BringToFront;
    newMarker.Anchors := [];
    newMarker.Visible := True;

    newMarker.AnimateFloatDelay('Position.Y', newMarker.Position.Y - 10,
      0.2, 0.1);
    newMarker.AnimateFloatDelay('Position.Y', EventInfo.Location.Y -
      Rectangle2.Position.Y - newMarker.Height - RectClient.Position.Y,
      0.2, 0.4);

  end;

end;

procedure TFMapImage.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  ZoomImage(50, Self.Width / 2, Self.Height / 2);
end;

procedure TFMapImage.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  ZoomImage(-50, Self.Width / 2, Self.Height / 2);
end;

end.
