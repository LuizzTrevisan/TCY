unit MapImage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Math,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Main, FGX.VirtualKeyboard, System.Actions, FMX.ActnList, FMX.Objects,
  FMX.Effects, FMX.ListBox, FMX.Layouts, FMX.ListView.Types, FMX.ListView,
  FMX.Edit, uMapImage;

type
  TFMapImage = class(TFMain)
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    MapImage1: TMapImage;
    procedure Rectangle2Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Image1DragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure SourceMarkerGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure MapImage1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
    minHeight, minWidth, maxHeight, maxWidth: Single;
    procedure VerificaPosicaoTamanhoMinimo;
    procedure ZoomImage(Size, X, Y: Single);
    procedure CreateMarker(X, Y: Single);
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
  MapImage1.RotationAngle := RadToDeg(-EventInfo.Angle);
end;

procedure TFMapImage.CreateMarker(X, Y: Single);
var
  newMarker: TImage;
begin
  newMarker := TImage.Create(Rectangle2);
  //newMarker.DragMode := TDragMode.dmAutomatic;
  newMarker.Visible := False;
//  newMarker.MultiResBitmap[0].Bitmap := SourceMarker.MultiResBitmap[0].Bitmap;
//  newMarker.Width := SourceMarker.Width;
//  newMarker.Height := SourceMarker.Height;
  // newMarker.OnMouseUp := SourceMarkerMouseUp;
  // newMarker.OnGesture := SourceMarkerGesture;
  // newMarker.OnDragDrop := SourceMarkerDragDrop;
  newMarker.Touch.InteractiveGestures := [TInteractiveGesture.Pan];
  newMarker.Position.X := X - Rectangle2.Position.X - (newMarker.Width / 2);
  newMarker.Position.Y := Y - Rectangle2.Position.Y - newMarker.Height -
    RectClient.Position.Y;
  newMarker.Parent := Rectangle2;
  newMarker.BringToFront;
  newMarker.Anchors := [];
  newMarker.Visible := True;

end;

procedure TFMapImage.VerificaPosicaoTamanhoMinimo;
begin                {
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
                }
end;

procedure TFMapImage.ZoomImage(Size, X, Y: Single);
var
  eventDistance, widthDistance, heightDistance: Single;
begin
  eventDistance  := Size / 100;

//  widthDistance  := (eventDistance * (Rectangle2.Width / 100));
//  heightDistance := (eventDistance * (Rectangle2.Height / 100));

  Rectangle2.Scale.X := Rectangle2.Scale.X  + eventDistance;
  Rectangle2.Scale.Y := Rectangle2.Scale.Y  + eventDistance;


 {
  Rectangle2.Width := Rectangle2.Width + widthDistance;
  Rectangle2.Height := Rectangle2.Height + heightDistance;

  if (Rectangle2.Width < maxWidth) and (Rectangle2.Height < maxHeight) then
  begin
    Rectangle2.Position.X := Rectangle2.Position.X -
      ((X / Self.Width) * widthDistance);

    Rectangle2.Position.Y := Rectangle2.Position.Y -
      ((Y / Self.Height) * heightDistance);
  end;
  }
  VerificaPosicaoTamanhoMinimo;
end;

procedure TFMapImage.handleZoom(EventInfo: TGestureEventInfo);
begin

  if not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags) then
    ZoomImage(EventInfo.Distance - FLastDistance, EventInfo.Location.X,
      EventInfo.Location.Y);

  FLastDistance := EventInfo.Distance;

end;

procedure TFMapImage.Image1DragOver(Sender: TObject; const Data: TDragObject;
  const Point: TPointF; var Operation: TDragOperation);
begin
  inherited;
  TImage(Data.Source).Position.X := Point.X;
  TImage(Data.Source).Position.Y := Point.Y;
end;

procedure TFMapImage.MapImage1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  inherited;
  MapImage1.Marcadores.Add(TMarcador.Create(MapImage1, X, Y));
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
  end;

  FLastPosition := EventInfo.Location;
end;

procedure TFMapImage.Rectangle2Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  inherited;
  if EventInfo.GestureID = igiPan then
    handlePan(EventInfo)
  else if EventInfo.GestureID = igiZoom then
   // handleZoom(EventInfo)
  else if EventInfo.GestureID = igiDoubleTap then begin
    CreateMarker(EventInfo.Location.X, EventInfo.Location.Y);

    // newMarker.AnimateFloatDelay('Position.Y', newMarker.Position.Y - 10,
    // 0.2, 0.1);
    // newMarker.AnimateFloatDelay('Position.Y', EventInfo.Location.Y -
    // Rectangle2.Position.Y - newMarker.Height - RectClient.Position.Y,
    // 0.2, 0.4);

  end;

end;

procedure TFMapImage.SpeedButton2Click(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  ZoomImage(50, Self.Width / 2, Self.Height / 2);
  MapImage1.MarcadorScale.Y  := MapImage1.MarcadorScale.Y - 0.1;
  MapImage1.MarcadorScale.X  := MapImage1.MarcadorScale.X - 0.1;
  for i := 0 to MapImage1.Marcadores.Count -1 do begin
    MapImage1.Marcadores[I].Scale.X := MapImage1.MarcadorScale.X;
    MapImage1.Marcadores[I].Scale.y := MapImage1.MarcadorScale.Y;
  end;
end;

procedure TFMapImage.SpeedButton3Click(Sender: TObject);
var
  i : Integer;
begin
  inherited;
  ZoomImage(-50, Self.Width / 2, Self.Height / 2);
  MapImage1.MarcadorScale.Y  := MapImage1.MarcadorScale.Y + 0.1;
  MapImage1.MarcadorScale.X  := MapImage1.MarcadorScale.X + 0.1;
  for i := 0 to MapImage1.Marcadores.Count -1 do begin
    MapImage1.Marcadores[I].Scale.X := MapImage1.MarcadorScale.X;
    MapImage1.Marcadores[I].Scale.Y := MapImage1.MarcadorScale.Y;
  end;
end;



end.
