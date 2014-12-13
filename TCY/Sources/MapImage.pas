unit MapImage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Math,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Main, System.Actions, FMX.ActnList, FMX.Objects,
  FMX.Effects, FMX.ListBox, FMX.Layouts, FMX.ListView.Types, FMX.ListView,
  FMX.Edit, uMapImage, FMX.ExtCtrls, FMX.Ani, FMX.Controls.Presentation,
  System.Sensors, System.Sensors.Components, Data.DB, Datasnap.DBClient;

type
  MarkerOpcao = (Nenhuma, Adicionando, Editando);

  TFMapImage = class(TFMain)
    Rectangle3: TRectangle;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
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
    MapImage1: TMapImage;
    ComboBox1: TComboBox;
    LocationSensor1: TLocationSensor;
    Button3: TButton;
    edtlat: TEdit;
    edtlong: TEdit;
    atu: TButton;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1la: TFloatField;
    ClientDataSet1lo: TFloatField;
    ClientDataSet1Title: TStringField;
    ClientDataSet1Index: TIntegerField;
    ClientDataSet1categoria: TIntegerField;
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
    procedure MapImage1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Button1Click(Sender: TObject);
    procedure MapImage1SelectMarker(marker: TMarcador);
    procedure MapImage1MarkerMove(marker: TMarcador);
    procedure LocationSensor1LocationChanged(Sender: TObject;
      const OldLocation, NewLocation: TLocationCoord2D);
    procedure Button3Click(Sender: TObject);
    procedure atuClick(Sender: TObject);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GPSLocationClick(Sender: TObject);
    procedure ClientDataSet1BeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
    minHeight, minWidth, maxHeight, maxWidth: Single;
    Operacao: MarkerOpcao;
    procedure VerificaPosicaoTamanhoMinimo;
    procedure ZoomImage(Size, X, Y: Single);
    procedure CarregarMarcadores;
    procedure Mostrar;
    procedure Ocultar;

  public
    { Public declarations }
    FLastPosition: TPointF;
    FLastDistance: Integer;
    procedure AddPicture(files: TStrings);
    procedure handlePan(EventInfo: TGestureEventInfo);
    procedure handleZoom(EventInfo: TGestureEventInfo);
    procedure handleRotate(EventInfo: TGestureEventInfo);
    procedure AtualizaLocalGPS;
  end;

var
  FMapImage: TFMapImage;

implementation

{$R *.fmx}

procedure TFMapImage.AddPicture(files: TStrings);
begin

end;

procedure TFMapImage.AtualizaLocalGPS;
const
  totWid = 0.009452;
  totHeig = 0.005901;
  // LongIni =  -52.680848; // -52.676524 casa
  // latIni = -26.215312;  //final -26.218189

  LongIni = -52.695230; // final   -52.685778
  latIni = -26.199538; // final -26.193637

var
  dif: Single;
begin
  inherited;

  dif := edtlong.Text.ToSingle() - LongIni;
  MapImage1.Circle.X := (dif / totWid) * MapImage1.Width;

  dif := edtlat.Text.ToSingle() - latIni;
  MapImage1.Circle.Y := MapImage1.Height - (dif / totHeig) * MapImage1.Height;
end;

procedure TFMapImage.atuClick(Sender: TObject);
begin
  inherited;
  AtualizaLocalGPS;
end;

procedure TFMapImage.Button1Click(Sender: TObject);
begin
  inherited;
  if Operacao = MarkerOpcao.Nenhuma then
    Operacao := MarkerOpcao.Adicionando;

  ClientDataSet1.Edit;
  ClientDataSet1Title.AsString := Edit1.Text;
  ClientDataSet1categoria.AsInteger := ComboBox1.ItemIndex;
  ClientDataSet1.Post;

  ClientDataSet1.SaveToFile(GetHomePath + '/Tm.txt');

  Ocultar;
  txtAjuda.Text := 'Clique no Mapa para Adicionar um Marcador';
  Operacao := MarkerOpcao.Nenhuma;
end;

procedure TFMapImage.Button2Click(Sender: TObject);
begin
  inherited;
  ClientDataSet1.Delete;
  Ocultar;
  txtAjuda.Text := 'Clique no Mapa para Adicionar um Marcador';
end;

procedure TFMapImage.Button3Click(Sender: TObject);
begin
  inherited;
  LocationSensor1.Active := not LocationSensor1.Active;
  Button3.Text := LocationSensor1.Active.ToString();
end;

procedure TFMapImage.CarregarMarcadores;
begin
  if FileExists(GetHomePath + '/Tm.txt') then
  begin
    try
      ClientDataSet1.LoadFromFile(GetHomePath + '/Tm.txt');
    except
      ClientDataSet1.Close;
      ClientDataSet1.CreateDataSet;
    end;
  end
  else
  begin
    ClientDataSet1.Close;
    ClientDataSet1.CreateDataSet;
    ClientDataSet1.EmptyDataSet;
  end;

  if (ClientDataSet1.RecordCount > 0) then
  begin

    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      ClientDataSet1.Edit;
      ClientDataSet1.Post;
      ClientDataSet1.Next;
    end;
  end;

end;

procedure TFMapImage.ClientDataSet1BeforeDelete(DataSet: TDataSet);
var
  i: Integer;
begin
  inherited;
  for i := 0 to MapImage1.Marcadores.Count - 1 do
    if MapImage1.Marcadores[i].Tag = ClientDataSet1Index.AsInteger then
    begin
      MapImage1.Marcadores.Delete(i);
      Break;
    end;
end;

procedure TFMapImage.ClientDataSet1BeforePost(DataSet: TDataSet);
var
  vMarker: TMarcador;
  i: Integer;
begin
  inherited;

  if Operacao = MarkerOpcao.Adicionando then
  begin
    vMarker := TMarcador.Create(MapImage1, ClientDataSet1la.AsFloat,
      ClientDataSet1lo.AsFloat, ClientDataSet1Title.AsString,
      ClientDataSet1categoria.AsInteger);

    MapImage1.Marcadores.Add(vMarker);

    if ClientDataSet1Index.AsInteger <= 0 then
    begin
      Operacao := MarkerOpcao.Nenhuma;
      ClientDataSet1.Edit;
      if MapImage1.Marcadores.Count >= 2 then
        ClientDataSet1Index.AsInteger := MapImage1.Marcadores
          [MapImage1.Marcadores.Count - 2].Tag + 1
      else
        ClientDataSet1Index.AsInteger := 1;

      // ClientDataSet1.Post;
      Operacao := MarkerOpcao.Adicionando;
    end;

    vMarker.Tag := ClientDataSet1Index.AsInteger;

  end
  else if Operacao = MarkerOpcao.Editando then
  begin

    for i := 0 to MapImage1.Marcadores.Count - 1 do
      if MapImage1.Marcadores[i].Tag = ClientDataSet1Index.AsInteger then
      begin
        MapImage1.Marcadores[i].Caption := ClientDataSet1Title.AsString;
        Break;
      end;
  end;
end;

procedure TFMapImage.FormCreate(Sender: TObject);
begin
  inherited;
  // minHeight := Rectangle2.Height;
  // minWidth := Rectangle2.Width;
  //
  // maxHeight := Rectangle2.Height * 2;
  // maxWidth := Rectangle2.Width * 2;
end;

procedure TFMapImage.FormShow(Sender: TObject);
begin
  inherited;
  Operacao := MarkerOpcao.Adicionando;
  CarregarMarcadores;
end;

procedure TFMapImage.GPSLocationClick(Sender: TObject);
begin
  inherited;
  LocationSensor1.Active := not LocationSensor1.Active;
  GpsAnimation.Enabled := LocationSensor1.Active;
end;

procedure TFMapImage.handlePan(EventInfo: TGestureEventInfo);
begin
  if not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags) then
  begin
    MapImage1.Position.X := MapImage1.Position.X +
      (EventInfo.Location.X - FLastPosition.X);

    MapImage1.Position.Y := MapImage1.Position.Y +
      (EventInfo.Location.Y - FLastPosition.Y);

    // VerificaPosicaoTamanhoMinimo;
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
  pos: TPosition;
  eventDistance: Single;
begin
  eventDistance := Size / 100;

  pos := MapImage1.Position;


  if (MapImage1.Scale.X + eventDistance <= 0.1) then
  begin
    MapImage1.Scale.X := 0.1;
    MapImage1.Scale.Y := 0.1;
  end
  else
  begin
    MapImage1.Scale.X := MapImage1.Scale.X + eventDistance;
    MapImage1.Scale.Y := MapImage1.Scale.Y + eventDistance;
  end;

  MapImage1.Position.X := ((MapImage1.Position.X * MapImage1.Scale.X) / 2 ) * MapImage1.Scale.X ;
  MapImage1.Position.Y := ((MapImage1.Position.Y * MapImage1.Scale.Y) / 2 ) * MapImage1.Scale.X;

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

procedure TFMapImage.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
begin
  edtlat.Text := NewLocation.Latitude.ToString();
  edtlong.Text := NewLocation.Longitude.ToString();
  AtualizaLocalGPS;
end;

procedure TFMapImage.MapImage1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  inherited;
  if (EventInfo.GestureID = System.UITypes.igiLongTap) then
  begin
    txtAjuda.Text := 'Adicionando Novo Marcador';
    Edit1.Text := '';
    // MapImage1.Marcadores.Add(TMarcador.Create(MapImage1, vPoint.X, vPoint.Y,'Nome OASDOA'));
    ComboBox1.DropDown;
    Mostrar;
    Edit1.SetFocus;
  end;
  // MapImage1.Marcadores.Add(TMarcador.Create(MapImage1, vPoint.X, vPoint.Y,'Nome OASDOA'));

  if (EventInfo.GestureID = igiPan) then
  begin
    handlePan(EventInfo)
  end;
end;

procedure TFMapImage.MapImage1MarkerMove(marker: TMarcador);
begin
  inherited;
  Operacao := MarkerOpcao.Editando;

  ClientDataSet1.First;
  ClientDataSet1.FindKey([marker.Tag]);
  ClientDataSet1.Edit;
  ClientDataSet1.FieldByName('la').AsFloat := marker.X;
  ClientDataSet1.FieldByName('lo').AsFloat := marker.Y;
  ClientDataSet1.Post;

  ClientDataSet1.SaveToFile(GetHomePath + '/Tm.txt');
end;

procedure TFMapImage.MapImage1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  inherited;
  Operacao := MarkerOpcao.Nenhuma;
  if ClientDataSet1.State <> dsInsert then
    ClientDataSet1.Append;

  ClientDataSet1.FieldByName('la').AsFloat := X;
  ClientDataSet1.FieldByName('lo').AsFloat := Y;
  // ClientDataSet1.Post;

  if Boolean(actShowMenuLateral.Tag) then
    actShowMenuLateral.Execute;
{$IFDEF WIN32}
  txtAjuda.Text := 'Adicionando Novo Marcador';
  Edit1.Text := '';

  // MapImage1.Marcadores.Add(TMarcador.Create(MapImage1, vPoint.X, vPoint.Y,'Nome OASDOA'));

  Mostrar;
{$ENDIF}
end;

procedure TFMapImage.MapImage1Paint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  inherited;
  // MapImage1.Bitmap.Canvas.FillRect(RectF(0, 0, 900, 900), 2, 2,
  // [TCorner.TopLeft], 1, Canvas.Stroke);
  // Canvas.FillText(ARect,'ASDSDSD',False,1,[],TTextAlign.Center);
end;

procedure TFMapImage.MapImage1SelectMarker(marker: TMarcador);
begin
  inherited;
  Operacao := MarkerOpcao.Editando;

  ClientDataSet1.First;
  ClientDataSet1.FindKey([marker.Tag]);
  txtAjuda.Text := 'Editando Marcador';

  Edit1.Text := ClientDataSet1Title.AsString;
  Mostrar;

end;

procedure TFMapImage.Mostrar;
begin
  rectMarkers.Height := 140;
end;

procedure TFMapImage.Ocultar;
begin
  rectMarkers.Height := rectMarkersTop.Height
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
  // MapImage1.MarcadorScale.Y := MapImage1.MarcadorScale.Y - 0.1;
  // MapImage1.MarcadorScale.X := MapImage1.MarcadorScale.X - 0.1;
  // for i := 0 to MapImage1.Marcadores.Count - 1 do
  // begin
  // MapImage1.Marcadores[i].Scale.X := MapImage1.MarcadorScale.X;
  // MapImage1.Marcadores[i].Scale.Y := MapImage1.MarcadorScale.Y;
  // end;
end;

procedure TFMapImage.SpeedButton3Click(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  ZoomImage(-20, Self.Width / 2, Self.Height / 2);
  // MapImage1.MarcadorScale.Y := MapImage1.MarcadorScale.Y + 0.1;
  // MapImage1.MarcadorScale.X := MapImage1.MarcadorScale.X + 0.1;
  // for i := 0 to MapImage1.Marcadores.Count - 1 do
  // begin
  // MapImage1.Marcadores[i].Scale.X := MapImage1.MarcadorScale.X;
  // MapImage1.Marcadores[i].Scale.Y := MapImage1.MarcadorScale.Y;
  // end;
end;

end.
