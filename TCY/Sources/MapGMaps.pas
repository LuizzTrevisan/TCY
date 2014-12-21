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
    cdsPontos: TClientDataSet;
    cdsPontosla: TFloatField;
    cdsPontoslo: TFloatField;
    cdsPontosTitle: TStringField;
    TMSFMXWebGMaps1: TTMSFMXWebGMaps;
    rectMarkers: TRectangle;
    rectMarkersTop: TRectangle;
    edtDescricao: TEdit;
    rectOpcoes: TRectangle;
    btAdicionar: TButton;
    btRemover: TButton;
    txtAjuda: TText;
    lvMarcadores: TListView;
    cdsPontosIndex: TIntegerField;
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
    procedure btAdicionarClick(Sender: TObject);
    procedure btRemoverClick(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject;
      const OldLocation, NewLocation: TLocationCoord2D);
    procedure TMSFMXWebGMaps1MarkerClick(Sender: TObject; MarkerTitle: string;
      IdMarker: Integer; Latitude, Longitude: Double);
    procedure TMSFMXWebGMaps1MarkerDragEnd(Sender: TObject; MarkerTitle: string;
      IdMarker: Integer; Latitude, Longitude: Double);
    procedure actShowMenuLateralExecute(Sender: TObject);
    procedure lvMarcadoresDeleteItem(Sender: TObject; AIndex: Integer);
    procedure cdsPontosBeforeDelete(DataSet: TDataSet);
    procedure cdsPontosBeforePost(DataSet: TDataSet);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMenuPopUpClick(Sender: TObject);
    procedure liRemoverTodosMarcadoresClick(Sender: TObject);
    procedure ShowListClick(Sender: TObject);
    procedure GPSLocationClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvMarcadoresGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
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

procedure TFMapGMaps.btAdicionarClick(Sender: TObject);
begin
  inherited;


  if Operacao = MarkerOpcao.Nenhuma then
    Operacao := MarkerOpcao.Adicionando;

  cdsPontos.Edit;
  cdsPontosTitle.AsString := edtDescricao.Text;
  cdsPontos.Post;

  cdsPontos.SaveToFile(GetHomePath + '/Te.txt');

  Ocultar;
  txtAjuda.Text := 'Clique no Mapa para Adicionar um Marcador';
  Operacao := MarkerOpcao.Nenhuma;


end;

procedure TFMapGMaps.btRemoverClick(Sender: TObject);
begin
  inherited;
  cdsPontos.Delete;
  Ocultar;
  txtAjuda.Text := 'Clique no Mapa para Adicionar um Marcador';
end;

procedure TFMapGMaps.Button4Click(Sender: TObject);
begin
  inherited;
  while not cdsPontos.Eof do
    cdsPontos.Delete;
  cdsPontos.SaveToFile(GetHomePath + '/Te.txt');
end;

procedure TFMapGMaps.CarregarMarcadores;
begin

  if FileExists(GetHomePath + '/Te.txt') then begin
    try
      cdsPontos.EmptyDataSet;
      cdsPontos.LoadFromFile(GetHomePath + '/Te.txt');
    except
      cdsPontos.Close;
      cdsPontos.CreateDataSet;
    end;
  end else begin
    cdsPontos.Close;
    cdsPontos.CreateDataSet;
    cdsPontos.EmptyDataSet;
  end;

  if (cdsPontos.RecordCount > 0) then begin

    cdsPontos.First;
    while not cdsPontos.Eof do begin
      cdsPontos.Edit;
      cdsPontos.Post;
      cdsPontos.Next;
    end;

  end;

end;

procedure TFMapGMaps.cdsPontosBeforeDelete(DataSet: TDataSet);
var
  i: Integer;
begin
  inherited;
  for i := 0 to TMSFMXWebGMaps1.Markers.Count - 1 do
    if TMSFMXWebGMaps1.Markers[i].Tag = cdsPontosIndex.AsInteger then begin
      TMSFMXWebGMaps1.Markers.Delete(i);
      Break;
    end;
end;

procedure TFMapGMaps.cdsPontosBeforePost(DataSet: TDataSet);
var
  vMarker: TMarker;
  i: Integer;
begin
  inherited;

  if Operacao = MarkerOpcao.Adicionando then begin

    vMarker := TMSFMXWebGMaps1.Markers.Add(cdsPontosla.AsFloat,
      cdsPontoslo.AsFloat, cdsPontosTitle.AsString, '', True, True,
      True, False, True, 0);
    vMarker.MapLabel.Text := cdsPontosTitle.AsString;

    if cdsPontosIndex.AsInteger <= 0 then begin
      Operacao := MarkerOpcao.Nenhuma;
      cdsPontos.Edit;
      if TMSFMXWebGMaps1.Markers.Count >= 2 then
        cdsPontosIndex.AsInteger := TMSFMXWebGMaps1.Markers
          [TMSFMXWebGMaps1.Markers.Count - 2].Tag + 1
      else
        cdsPontosIndex.AsInteger := 1;
      // ClientDataSet1.Post;
      Operacao := MarkerOpcao.Adicionando;
    end;

    vMarker.Tag := cdsPontosIndex.AsInteger;

  end
  else if Operacao = MarkerOpcao.Editando then begin

    for i := 0 to TMSFMXWebGMaps1.Markers.Count - 1 do
      if TMSFMXWebGMaps1.Markers[i].Tag = cdsPontosIndex.AsInteger then
      begin
        TMSFMXWebGMaps1.Markers[i].MapLabel.Text := cdsPontosTitle.AsString;
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

  //ajusta tamanho dos botoes pra fica do tambanho da tela (adicionar e excluir)
  btAdicionar.Width := Self.Width / 2 - 2;
  btRemover.Width := btAdicionar.Width - 2;
end;

procedure TFMapGMaps.FormShow(Sender: TObject);
begin
  inherited;
  Operacao := MarkerOpcao.Adicionando;
  CarregarMarcadores;
end;

procedure TFMapGMaps.liRemoverTodosMarcadoresClick(Sender: TObject);
begin
  inherited;
  cdsPontos.First;
  while not cdsPontos.Eof do
    cdsPontos.Delete;
  lbMenu.Visible := False;

  cdsPontos.SaveToFile(GetHomePath + '/Te.txt');
end;

procedure TFMapGMaps.lvMarcadoresDeleteItem(Sender: TObject; AIndex: Integer);
begin
  inherited;
  cdsPontos.RecNo := AIndex + 1;
  cdsPontos.Delete;
end;

procedure TFMapGMaps.lvMarcadoresGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  bounds : TBounds;
begin
  inherited;


  //quanto segura um item pressionado na lista, da zoom nas suas coordenadas.
  if (EventInfo.GestureID = System.UITypes.igiLongTap) then  begin

    cdsPontos.RecNo := lvMarcadores.ItemIndex  + 1;
    bounds := FMX.TMSWebGMapsCommonFunctions.TBounds.Create;
    bounds.NorthEast.Latitude := cdsPontosla.AsFloat + 0.002;
    bounds.NorthEast.Longitude := cdsPontoslo.AsFloat + 0.002;
    bounds.SouthWest.Latitude := cdsPontosla.AsFloat - 0.002;
    bounds.SouthWest.Longitude := cdsPontoslo.AsFloat - 0.002;
    TMSFMXWebGMaps1.MapZoomTo(bounds);

    //ocultar a lista de pontos
    ShowListClick(ShowList);
  end;

end;

procedure TFMapGMaps.GPSLocationClick(Sender: TObject);
begin
  inherited;

  //ativa o gps para encontrar localizacao atual

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



  //quando muda  localizacao do GPS, aplica o zoom novamente
  LocationSensor1.Active := False;
  TMSFMXWebGMaps1.MapPanTo(NewLocation.Latitude, NewLocation.Longitude);

  bounds := FMX.TMSWebGMapsCommonFunctions.TBounds.Create;

  bounds.NorthEast.Latitude := NewLocation.Latitude + 0.002;
  bounds.NorthEast.Longitude := NewLocation.Longitude + 0.002;
  bounds.SouthWest.Latitude := NewLocation.Latitude - 0.002;
  bounds.SouthWest.Longitude := NewLocation.Longitude - 0.002;
  TMSFMXWebGMaps1.MapZoomTo(bounds);



  //circulo da localização atual
  if not Assigned(PolygonLocationItem) then begin
    PolygonLocationItem := TMSFMXWebGMaps1.Polygons.Add;
    CircleLocation := PolygonLocationItem.Polygon;
    CircleLocation.PolygonType := FMX.TMSWebGMapsCommon.TPolygonType.ptCircle;
    CircleLocation.BackgroundOpacity := 80;
    CircleLocation.BorderWidth := 2;
  end;

  CircleLocation.Radius := 45;
  CircleLocation.Visible := True;
  CircleLocation.Center.Latitude := NewLocation.Latitude;
  CircleLocation.Center.Longitude := NewLocation.Longitude;


  //quando encontra a localizacao, apaga o circulo antigo e desenha novamente
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
  //igual a tela da utf

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
    RectMenu.Visible := False;
    rectOpcoes.Visible := False;
    edtDescricao.Visible := False;
    TMSFMXWebGMaps1.Visible := False;
    lvMarcadores.Visible := True;
    lvMarcadores.Items.Clear;
    cdsPontos.First;

    while not cdsPontos.Eof do begin
      lvMarcadores.Items.Add.Text := CdsPontosTitle.AsString;
      cdsPontos.Next;
    end;
  end else begin
    if Boolean(actShowMenuLateral.Tag) then
      actShowMenuLateral.Execute;
    txtAjuda.Text := 'Clique no Mapa para Adicionar um Marcador ';
    RectMenu.Visible := True;
    rectOpcoes.Visible := True;
    edtDescricao.Visible := True;
    rectMarkers.Align := TAlignLayout.Bottom;
    lvMarcadores.Visible := False;
    TMSFMXWebGMaps1.Visible := True;
    Ocultar;
  end;

end;

procedure TFMapGMaps.TMSFMXWebGMaps1MapClick(Sender: TObject;
  Latitude, Longitude: Double; X, Y: Integer);
var
  bounds: FMX.TMSWebGMapsCommonFunctions.TBounds;
begin
  inherited;

  Operacao := MarkerOpcao.Nenhuma;
  if cdsPontos.State <> dsInsert then
    cdsPontos.Append;

  cdsPontos.FieldByName('la').AsFloat := Latitude;
  cdsPontos.FieldByName('lo').AsFloat := Longitude;
  // ClientDataSet1.Post;

  if Boolean(actShowMenuLateral.Tag) then
    actShowMenuLateral.Execute;

  txtAjuda.Text := 'Adicionando Novo Marcador';
  edtDescricao.Text := '';
  Mostrar;


  //aplica zoom aonde clico no mapa
  bounds := FMX.TMSWebGMapsCommonFunctions.TBounds.Create;
  bounds.NorthEast.Latitude := Latitude + 0.002;
  bounds.NorthEast.Longitude := Longitude + 0.002;
  bounds.SouthWest.Latitude := Latitude - 0.002;
  bounds.SouthWest.Longitude := Longitude - 0.002;

  //aplica o zoom montando acima
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

  cdsPontos.First;
  cdsPontos.FindKey([TMSFMXWebGMaps1.Markers[IdMarker].Tag]);
  txtAjuda.Text := 'Editando Marcador';

  edtDescricao.Text := cdsPontosTitle.AsString;
  Mostrar;

  //zoom no marcador
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

  //quanto termina de arrastar o ponto, atualiza as coordenadas

  Operacao := MarkerOpcao.Editando;

  cdsPontos.First;
  cdsPontos.FindKey([TMSFMXWebGMaps1.Markers[IdMarker].Tag]);
  cdsPontos.Edit;
  cdsPontos.FieldByName('la').AsFloat := Latitude;
  cdsPontos.FieldByName('lo').AsFloat := Longitude;
  cdsPontos.Post;

  cdsPontos.SaveToFile(GetHomePath + '/Te.txt');

end;

end.
