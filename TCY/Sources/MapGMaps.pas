unit MapGmaps;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms,
  FMX.Dialogs, FMX.StdCtrls, Main, System.Actions, FMX.ActnList, FMX.Objects,
  FMX.Effects, FMX.Layouts, System.Sensors, FMX.Edit, System.Math,
  FMX.TMSWebGMapsWebBrowser, FMX.TMSWebGMaps, System.Sensors.Components,
  Data.DB, Datasnap.DBClient, FMX.ListBox, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, FMX.ListView.Types, FMX.ListView, FMX.TMSWEBgMapsMarkers,
  FMX.TMSWebGMapsCommonFunctions, FMX.TMSWebGMapsPolygons,
  FMX.TMSWebGMapsCommon, FMX.Ani, FMX.Controls.Presentation;

type
  MarkerOpcao = (Nenhuma, Adicionando, Editando);

  TFMapGMaps = class(TFMain)
    LocationSensor1: TLocationSensor;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1la: TFloatField;
    ClientDataSet1lo: TFloatField;
    ClientDataSet1Title: TStringField;
    TMSFMXWebGMaps1: TTMSFMXWebGMaps;
    rectMarkers: TRectangle;
    rectMarkersTop: TRectangle;
    Edit1: TEdit;
    Rectangle2: TRectangle;
    Button1: TButton;
    Button2: TButton;
    txtAjuda: TText;
    lvMarcadores: TListView;
    ClientDataSet1Index: TIntegerField;
    btnMenuPopUp: TSpeedButton;
    lbMenu: TListBox;
    liRemoverTodosMarcadores: TListBoxItem;
    GlowEffect7: TGlowEffect;
    GPSLocation: TImage;
    ShowList: TImage;
    GpsAnimation: TFloatAnimation;
    procedure FormResize(Sender: TObject);
    procedure TMSFMXWebGMaps1MapClick(Sender: TObject;
      Latitude, Longitude: Double; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject;
      const OldLocation, NewLocation: TLocationCoord2D);
    procedure TMSFMXWebGMaps1MarkerClick(Sender: TObject; MarkerTitle: string;
      IdMarker: Integer; Latitude, Longitude: Double);
    procedure TMSFMXWebGMaps1MarkerDragEnd(Sender: TObject; MarkerTitle: string;
      IdMarker: Integer; Latitude, Longitude: Double);
    procedure actShowMenuLateralExecute(Sender: TObject);
    procedure lvMarcadoresDeleteItem(Sender: TObject; AIndex: Integer);
    procedure ClientDataSet1BeforeDelete(DataSet: TDataSet);
    procedure TMSFMXWebGMaps1DownloadFinish(Sender: TObject);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMenuPopUpClick(Sender: TObject);
    procedure liRemoverTodosMarcadoresClick(Sender: TObject);
    procedure ShowListClick(Sender: TObject);
    procedure GPSLocationClick(Sender: TObject);
  private
    { Private declarations }
    PolygonLocationItem: TPolygonItem;
    CircleLocation: TMapPolygon;
    Operacao: MarkerOpcao;
    procedure Mostrar;
    procedure Ocultar;
    procedure CarregarMarcadores;
  public
    { Public declarations }
  end;

var
  FMapGMaps: TFMapGMaps;

implementation

{$R *.fmx}

procedure TFMapGMaps.actShowMenuLateralExecute(Sender: TObject);
begin
  inherited;
  Ocultar;
  rectMarkers.BringToFront;
end;

procedure TFMapGMaps.btnMenuPopUpClick(Sender: TObject);
begin
  inherited;
  lbMenu.Visible := not lbMenu.Visible;
end;

procedure TFMapGMaps.Button1Click(Sender: TObject);
begin
  inherited;
  if Operacao = MarkerOpcao.Nenhuma then
    Operacao := MarkerOpcao.Adicionando;

  ClientDataSet1.Edit;
  ClientDataSet1Title.AsString := Edit1.Text;
  ClientDataSet1.Post;

  ClientDataSet1.SaveToFile(GetHomePath + '/Te.txt');

  Ocultar;
  txtAjuda.Text := 'Clique no Mapa para Adicionar um Marcador';
  Operacao := MarkerOpcao.Nenhuma;
end;

procedure TFMapGMaps.Button2Click(Sender: TObject);
begin
  inherited;
  ClientDataSet1.Delete;
  Ocultar;
  txtAjuda.Text := 'Clique no Mapa para Adicionar um Marcador';
end;

procedure TFMapGMaps.Button4Click(Sender: TObject);
begin
  inherited;
  while not ClientDataSet1.Eof do
    ClientDataSet1.Delete;
  ClientDataSet1.SaveToFile(GetHomePath + '/Te.txt');
end;

procedure TFMapGMaps.CarregarMarcadores;
begin

  if FileExists(GetHomePath + '/Te.txt') then begin
    try
      ClientDataSet1.LoadFromFile(GetHomePath + '/Te.txt');
    except
      ClientDataSet1.Close;
      ClientDataSet1.CreateDataSet;
    end;
  end else begin
    ClientDataSet1.Close;
    ClientDataSet1.CreateDataSet;
    ClientDataSet1.EmptyDataSet;
  end;

  if (ClientDataSet1.RecordCount > 0) then begin

    ClientDataSet1.First;
    while not ClientDataSet1.Eof do begin
      ClientDataSet1.Edit;
      ClientDataSet1.Post;
      ClientDataSet1.Next;
    end;
  end;

end;

procedure TFMapGMaps.ClientDataSet1BeforeDelete(DataSet: TDataSet);
var
  i: Integer;
begin
  inherited;
  for i := 0 to TMSFMXWebGMaps1.Markers.Count - 1 do
    if TMSFMXWebGMaps1.Markers[i].Tag = ClientDataSet1Index.AsInteger then begin
      TMSFMXWebGMaps1.Markers.Delete(i);
      Break;
    end;
end;

procedure TFMapGMaps.ClientDataSet1BeforePost(DataSet: TDataSet);
var
  vMarker: TMarker;
  i: Integer;
begin
  inherited;

  if Operacao = MarkerOpcao.Adicionando then begin

    vMarker := TMSFMXWebGMaps1.Markers.Add(ClientDataSet1la.AsFloat,
      ClientDataSet1lo.AsFloat, ClientDataSet1Title.AsString, '', True, True,
      True, False, True, 0);
    vMarker.MapLabel.Text := 'MapLabel:' + ClientDataSet1Title.AsString;

    if ClientDataSet1Index.AsInteger <= 0 then begin
      Operacao := MarkerOpcao.Nenhuma;
      ClientDataSet1.Edit;
      if TMSFMXWebGMaps1.Markers.Count >= 2 then
        ClientDataSet1Index.AsInteger := TMSFMXWebGMaps1.Markers
          [TMSFMXWebGMaps1.Markers.Count - 2].Tag + 1
      else
        ClientDataSet1Index.AsInteger := 1;
      // ClientDataSet1.Post;
      Operacao := MarkerOpcao.Adicionando;
    end;

    vMarker.Tag := ClientDataSet1Index.AsInteger;

  end
  else if Operacao = MarkerOpcao.Editando then begin

    for i := 0 to TMSFMXWebGMaps1.Markers.Count - 1 do
      if TMSFMXWebGMaps1.Markers[i].Tag = ClientDataSet1Index.AsInteger then
      begin
        TMSFMXWebGMaps1.Markers[i].MapLabel.Text := 'MapLabel:' +
          ClientDataSet1Title.AsString;
        Break;
      end;
  end;

end;

procedure TFMapGMaps.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  TMSFMXWebGMaps1.Visible := False;
end;

procedure TFMapGMaps.FormCreate(Sender: TObject);
begin
  inherited;
  Ocultar;

end;

procedure TFMapGMaps.FormResize(Sender: TObject);
begin
  inherited;
  Button1.Width := Self.Width / 2 - 2;
  Button2.Width := Button1.Width - 2;
end;

procedure TFMapGMaps.liRemoverTodosMarcadoresClick(Sender: TObject);
begin
  inherited;
  ClientDataSet1.First;
  while not ClientDataSet1.Eof do
    ClientDataSet1.Delete;
  lbMenu.Visible := False;

  ClientDataSet1.SaveToFile(GetHomePath + '/Te.txt');
end;

procedure TFMapGMaps.lvMarcadoresDeleteItem(Sender: TObject; AIndex: Integer);
begin
  inherited;
  ClientDataSet1.RecNo := AIndex + 1;
  ClientDataSet1.Delete;
end;

procedure TFMapGMaps.GPSLocationClick(Sender: TObject);
begin
  inherited;
  GpsAnimation.Enabled := True;
  if not LocationSensor1.Active then begin
    LocationSensor1.Active := True;
  end;
end;

procedure TFMapGMaps.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var
  bounds: FMX.TMSWebGMapsCommonFunctions.TBounds;
begin
  inherited;
  LocationSensor1.Active := False;
  TMSFMXWebGMaps1.MapPanTo(NewLocation.Latitude, NewLocation.Longitude);

  bounds := FMX.TMSWebGMapsCommonFunctions.TBounds.Create;

  bounds.NorthEast.Latitude := NewLocation.Latitude + 0.002;
  bounds.NorthEast.Longitude := NewLocation.Longitude + 0.002;
  bounds.SouthWest.Latitude := NewLocation.Latitude - 0.002;
  bounds.SouthWest.Longitude := NewLocation.Longitude - 0.002;
  TMSFMXWebGMaps1.MapZoomTo(bounds);

  if not Assigned(PolygonLocationItem) then begin
    PolygonLocationItem := TMSFMXWebGMaps1.Polygons.Add;
    CircleLocation := PolygonLocationItem.Polygon;
    CircleLocation.PolygonType := FMX.TMSWebGMapsCommon.TPolygonType.ptCircle;
    CircleLocation.BackgroundOpacity := 80;
    CircleLocation.BorderWidth := 2;
  end;

  CircleLocation.Radius := 50;
  CircleLocation.Visible := True;
  CircleLocation.Center.Latitude := NewLocation.Latitude;
  CircleLocation.Center.Longitude := NewLocation.Longitude;

  TMSFMXWebGMaps1.DeleteAllMapPolygon;
  TMSFMXWebGMaps1.CreateMapPolygon(CircleLocation);

  GpsAnimation.Enabled := False;
  GPSLocation.Opacity := 1;
  GPSLocation.Repaint;

end;

procedure TFMapGMaps.Mostrar;
begin
  // rectMarkers.AnimateFloat('Height', 140);
  rectMarkers.Height := 140;
end;

procedure TFMapGMaps.Ocultar;
begin
  // rectMarkers.AnimateFloat('Height', rectMarkersTop.Height);
  rectMarkers.Height := rectMarkersTop.Height;
end;

procedure TFMapGMaps.ShowListClick(Sender: TObject);
begin
  inherited;
  ShowList.Tag := not ShowList.Tag;
  if Boolean(ShowList.Tag) then begin
    // rectMarkers.AnimateFloat('Height', Self.Height);
    rectMarkers.Height := Self.Height;
    txtAjuda.Text := 'Lista de Marcadores ';
    Rectangle1.Visible := False;
    Rectangle2.Visible := False;
    Edit1.Visible := False;
    TMSFMXWebGMaps1.Visible := False;
    lvMarcadores.Visible := True;
    lvMarcadores.Items.Clear;
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do begin
      lvMarcadores.Items.Add.Text := ClientDataSet1Title.AsString;
      ClientDataSet1.Next;
    end;
  end else begin
    if Boolean(actShowMenuLateral.Tag) then
      actShowMenuLateral.Execute;
    txtAjuda.Text := 'Clique no Mapa para Adicionar um Marcador ';
    Rectangle1.Visible := True;
    Rectangle2.Visible := True;
    Edit1.Visible := True;
    rectMarkers.Align := TAlignLayout.Bottom;
    lvMarcadores.Visible := False;
    TMSFMXWebGMaps1.Visible := True;
    Ocultar;
  end;
end;

procedure TFMapGMaps.TMSFMXWebGMaps1DownloadFinish(Sender: TObject);
begin
  inherited;
  Operacao := MarkerOpcao.Adicionando;
  CarregarMarcadores;
end;

procedure TFMapGMaps.TMSFMXWebGMaps1MapClick(Sender: TObject;
  Latitude, Longitude: Double; X, Y: Integer);
var
  bounds: FMX.TMSWebGMapsCommonFunctions.TBounds;
begin
  inherited;
  Operacao := MarkerOpcao.Nenhuma;
  if ClientDataSet1.State <> dsInsert then
    ClientDataSet1.Append;

  ClientDataSet1.FieldByName('la').AsFloat := Latitude;
  ClientDataSet1.FieldByName('lo').AsFloat := Longitude;
  // ClientDataSet1.Post;

  if Boolean(actShowMenuLateral.Tag) then
    actShowMenuLateral.Execute;

  txtAjuda.Text := 'Adicionando Novo Marcador';
  Edit1.Text := '';
  Mostrar;

  bounds := FMX.TMSWebGMapsCommonFunctions.TBounds.Create;
  bounds.NorthEast.Latitude := Latitude + 0.002;
  bounds.NorthEast.Longitude := Longitude + 0.002;
  bounds.SouthWest.Latitude := Latitude - 0.002;
  bounds.SouthWest.Longitude := Longitude - 0.002;

  TMSFMXWebGMaps1.MapZoomTo(bounds);

end;

procedure TFMapGMaps.TMSFMXWebGMaps1MarkerClick(Sender: TObject;
  MarkerTitle: string; IdMarker: Integer; Latitude, Longitude: Double);
var
  i: Integer;
  vMarker: TMarker;
  bounds: FMX.TMSWebGMapsCommonFunctions.TBounds;
begin
  inherited;
  Operacao := MarkerOpcao.Editando;

  ClientDataSet1.First;
  ClientDataSet1.FindKey([TMSFMXWebGMaps1.Markers[IdMarker].Tag]);
  txtAjuda.Text := 'Editando Marcador';

  Edit1.Text := ClientDataSet1Title.AsString;
  Mostrar;

  bounds := FMX.TMSWebGMapsCommonFunctions.TBounds.Create;
  bounds.NorthEast.Latitude := TMSFMXWebGMaps1.Markers[IdMarker]
    .Latitude + 0.002;
  bounds.NorthEast.Longitude := TMSFMXWebGMaps1.Markers[IdMarker]
    .Longitude + 0.002;
  bounds.SouthWest.Latitude := TMSFMXWebGMaps1.Markers[IdMarker]
    .Latitude - 0.002;
  bounds.SouthWest.Longitude := TMSFMXWebGMaps1.Markers[IdMarker]
    .Longitude - 0.002;

  TMSFMXWebGMaps1.MapZoomTo(bounds);

end;

procedure TFMapGMaps.TMSFMXWebGMaps1MarkerDragEnd(Sender: TObject;
  MarkerTitle: string; IdMarker: Integer; Latitude, Longitude: Double);
begin
  inherited;
  Operacao := MarkerOpcao.Editando;

  ClientDataSet1.First;
  ClientDataSet1.FindKey([TMSFMXWebGMaps1.Markers[IdMarker].Tag]);
  ClientDataSet1.Edit;
  ClientDataSet1.FieldByName('la').AsFloat := Latitude;
  ClientDataSet1.FieldByName('lo').AsFloat := Longitude;
  ClientDataSet1.Post;

  ClientDataSet1.SaveToFile(GetHomePath + '/Te.txt');

end;

end.
