unit MapImage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Math,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Main, System.Actions, FMX.ActnList, FMX.Objects,
  FMX.Effects, FMX.ListBox, FMX.Layouts, FMX.ListView.Types, FMX.ListView,
  FMX.Edit, uMapImage, FMX.ExtCtrls, FMX.Ani, FMX.Controls.Presentation;

type
  TFMapImage = class(TFMain)
    Rectangle3: TRectangle;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    MapImage1: TMapImage;
    rectMarkers: TRectangle;
    Rectangle2: TRectangle;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    lvMarcadores: TListView;
    rectMarkersTop: TRectangle;
    txtAjuda: TText;
    GPSLocation: TImage;
    GpsAnimation: TFloatAnimation;
    ShowList: TImage;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Image1DragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure SourceMarkerGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure MapImage1Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure MapImage1Paint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure MapImage1Tap(Sender: TObject; const Point: TPointF);
    procedure MapImage1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    vPoint: TPointF;
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

procedure TFMapImage.Button1Click(Sender: TObject);
begin
  inherited;
    MapImage1.Marcadores.Add(TMarcador.Create(MapImage1, vPoint.X, vPoint.Y,'Nome OASDOA'));
end;

procedure TFMapImage.FormCreate(Sender: TObject);
begin
  inherited;
  // minHeight := Rectangle2.Height;
  // minWidth := Rectangle2.Width;
  //
  // maxHeight := Rectangle2.Height * 2;
  // maxWidth := Rectangle2.Width * 2;
  vPoint := TPointF.Create(0, 0)
end;

procedure TFMapImage.handlePan(EventInfo: TGestureEventInfo);
begin
  if not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags) then
  begin
    MapImage1.Position.X := MapImage1.Position.X +
      (EventInfo.Location.X - FLastPosition.X);

    MapImage1.Position.Y := MapImage1.Position.Y +
      (EventInfo.Location.Y - FLastPosition.Y);

    VerificaPosicaoTamanhoMinimo;
  end;

  FLastPosition := EventInfo.Location;

end;

procedure TFMapImage.handleRotate(EventInfo: TGestureEventInfo);
begin
  MapImage1.RotationAngle := RadToDeg(-EventInfo.Angle);
end;

procedure TFMapImage.VerificaPosicaoTamanhoMinimo;
begin {
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
  pos : TPosition;
  eventDistance  : Single;
begin
  eventDistance := Size / 100;

  pos :=  MapImage1.Position;
  // widthDistance  := (eventDistance * (Rectangle2.Width / 100));
  // heightDistance := (eventDistance * (Rectangle2.Height / 100));
  if (MapImage1.Scale.X + eventDistance <= 0.3) then
  begin
    MapImage1.Scale.X := 0.3;
    MapImage1.Scale.Y := 0.3;
  end
  else
  begin
    MapImage1.Scale.X := MapImage1.Scale.X + eventDistance;
    MapImage1.Scale.Y := MapImage1.Scale.Y + eventDistance;
  end;


  MapImage1.Position := pos;

  // MapImage1.Bitmap.BitmapScale := MapImage1.Bitmap.BitmapScale  + eventDistance;

  // MapImage1.BitmapScale.Y := MapImage1.BitmapScale.Y  + eventDistance;

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

procedure TFMapImage.MapImage1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  inherited;

  if (EventInfo.GestureID = System.UITypes.igiLongTap) then
    rectMarkers.Visible :=True;
//    MapImage1.Marcadores.Add(TMarcador.Create(MapImage1, vPoint.X, vPoint.Y,'Nome OASDOA'));

  if EventInfo.GestureID = igiPan then
    handlePan(EventInfo)
end;

procedure TFMapImage.MapImage1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  inherited;
  vPoint.X := X;
  vPoint.Y := Y;

 // MapImage1.Marcadores.Add(TMarcador.Create(MapImage1, vPoint.X, vPoint.Y,'Nome OASDOA'));
  rectMarkers.Visible := True;
end;

procedure TFMapImage.MapImage1Paint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  inherited;
  // MapImage1.Bitmap.Canvas.FillRect(RectF(0, 0, 900, 900), 2, 2,
  // [TCorner.TopLeft], 1, Canvas.Stroke);
  // Canvas.FillText(ARect,'ASDSDSD',False,1,[],TTextAlign.Center);
end;

procedure TFMapImage.MapImage1Tap(Sender: TObject; const Point: TPointF);
begin
  inherited;
  // MapImage1.Marcadores.Add(TMarcador.Create(MapImage1, vPoint.X, vPoint.Y));
end;

procedure TFMapImage.SourceMarkerGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  inherited;

  if not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags) then
  begin
    TImage(Sender).Position.X := TImage(Sender).Position.X +
      (EventInfo.Location.X - FLastPosition.X);
    TImage(Sender).Position.Y := TImage(Sender).Position.Y +
      (EventInfo.Location.Y - FLastPosition.Y);
  end;

  FLastPosition := EventInfo.Location;
end;

procedure TFMapImage.SpeedButton2Click(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  ZoomImage(20, Self.Width / 2, Self.Height / 2);
  MapImage1.MarcadorScale.Y := MapImage1.MarcadorScale.Y - 0.1;
  MapImage1.MarcadorScale.X := MapImage1.MarcadorScale.X - 0.1;
  for i := 0 to MapImage1.Marcadores.Count - 1 do
  begin
    MapImage1.Marcadores[i].Scale.X := MapImage1.MarcadorScale.X;
    MapImage1.Marcadores[i].Scale.Y := MapImage1.MarcadorScale.Y;
  end;
end;

procedure TFMapImage.SpeedButton3Click(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  ZoomImage(-20, Self.Width / 2, Self.Height / 2);
  MapImage1.MarcadorScale.Y := MapImage1.MarcadorScale.Y + 0.1;
  MapImage1.MarcadorScale.X := MapImage1.MarcadorScale.X + 0.1;
  for i := 0 to MapImage1.Marcadores.Count - 1 do
  begin
    MapImage1.Marcadores[i].Scale.X := MapImage1.MarcadorScale.X;
    MapImage1.Marcadores[i].Scale.Y := MapImage1.MarcadorScale.Y;
  end;
end;

end.
