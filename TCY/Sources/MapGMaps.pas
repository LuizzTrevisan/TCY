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
  FGX.ProgressDialog, FGX.ProgressDialog.Types;

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
    Text2: TText;
    Image3: TImage;
    Image1: TImage;
    BindingsList1: TBindingsList;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    LinkListControlToField1: TLinkListControlToField;
    Rectangle3: TRectangle;
    ClientDataSet1Index: TIntegerField;
    fgProgressDialog1: TfgProgressDialog;
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
    procedure Image3Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ListView1DeleteItem(Sender: TObject; AIndex: Integer);
    procedure ClientDataSet1BeforeDelete(DataSet: TDataSet);
    procedure TMSFMXWebGMaps1DownloadFinish(Sender: TObject);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
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
  Text2.Text := 'Clique no Mapa para Adicionar um Local';
  Operacao := MarkerOpcao.Nenhuma;
end;

procedure TFMapGMaps.Button2Click(Sender: TObject);
begin
  inherited;
  ClientDataSet1.Delete;
  Ocultar;
  Text2.Text := 'Clique no Mapa para Adicionar um Local';
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
    while not ClientDataSet1.eof do begin
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
    showmessage(ClientDataSet1la.AsFloat.ToString() + ' ' +
      ClientDataSet1lo.AsFloat.ToString());
  if Operacao = MarkerOpcao.Adicionando then begin

    if fgProgressDialog1.Progress < 100 then
      fgProgressDialog1.Progress :=
        ((ClientDataSet1.RecNo / ClientDataSet1.RecordCount) * 90) + 10;

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

    showmessage(vMarker.Tag.ToString());

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

procedure TFMapGMaps.FormCreate(Sender: TObject);
begin
  inherited;
  fgProgressDialog1.Show;

  fgProgressDialog1.Title := 'Preparando o Mapa';
  fgProgressDialog1.Kind := TfgProgressDialogKind.Determinated;

  fgProgressDialog1.Message := 'Carregando os Dados';
  fgProgressDialog1.Progress := 10;

  Ocultar;

end;

procedure TFMapGMaps.FormResize(Sender: TObject);
begin
  inherited;
  Button1.Width := Self.Width / 2 - 5;
  Button2.Width := Button1.Width - 5;
end;

procedure TFMapGMaps.Image1Click(Sender: TObject);
begin
  inherited;

  Image1.Tag := not Image1.Tag;
  if Boolean(Image1.Tag) then begin
    Text2.Text := 'Lista de Marcadores ';
    Rectangle1.Visible := False;
    Rectangle2.Visible := False;
    Edit1.Visible := False;
    TMSFMXWebGMaps1.Visible := False;
    rectMarkers.Align := TAlignLayout.Client;
    Rectangle3.Sides := [TSide.Bottom];
    ListView1.Visible := True;
  end else begin
    if Boolean(actShowMenuLateral.Tag) then
      actShowMenuLateral.Execute;
    Text2.Text := 'Clique no Mapa para Adicionar um Marcador ';
    Rectangle1.Visible := True;
    Rectangle2.Visible := True;
    Edit1.Visible := True;
    rectMarkers.Align := TAlignLayout.Bottom;
    TMSFMXWebGMaps1.Visible := True;
    Rectangle3.Sides := [];
    ListView1.Visible := False;
    Ocultar;
  end;

end;

procedure TFMapGMaps.Image3Click(Sender: TObject);
begin
  inherited;
  if not LocationSensor1.Active then begin
    LocationSensor1.Active := True;
  end;
end;

procedure TFMapGMaps.ListView1DeleteItem(Sender: TObject; AIndex: Integer);
begin
  inherited;
  showmessage(AIndex.ToString());
  ClientDataSet1.RecNo := AIndex + 1;
  ClientDataSet1.Delete;

end;

procedure TFMapGMaps.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
begin
  inherited;
  LocationSensor1.Active := False;
end;

procedure TFMapGMaps.Mostrar;
begin
  rectMarkers.Height := 140;
end;

procedure TFMapGMaps.Ocultar;
begin
  rectMarkers.Height := rectMarkersTop.Height;
end;

procedure TFMapGMaps.TMSFMXWebGMaps1DownloadFinish(Sender: TObject);
begin
  inherited;

  Operacao := MarkerOpcao.Adicionando;
  CarregarMarcadores;
  fgProgressDialog1.Hide;

end;

procedure TFMapGMaps.TMSFMXWebGMaps1MapClick(Sender: TObject;
  Latitude, Longitude: Double; X, Y: Integer);
begin
  inherited;
  Operacao := MarkerOpcao.Nenhuma;
  if ClientDataSet1.State <> dsInsert then
    ClientDataSet1.Append;

  ClientDataSet1.FieldByName('la').AsFloat := Latitude;
  ClientDataSet1.FieldByName('lo').AsFloat := Longitude;
  ClientDataSet1.Post;

  if Boolean(actShowMenuLateral.Tag) then
    actShowMenuLateral.Execute;

  Text2.Text := 'Adicionando Novo Local';
  Mostrar;
end;

procedure TFMapGMaps.TMSFMXWebGMaps1MarkerClick(Sender: TObject;
  MarkerTitle: string; IdMarker: Integer; Latitude, Longitude: Double);
var
  i: Integer;
  vMarker: TMarker;
begin
  inherited;
  Operacao := MarkerOpcao.Editando;

  ClientDataSet1.First;
  if not ClientDataSet1.FindKey([TMSFMXWebGMaps1.Markers[IdMarker].Tag]) then
    showmessage('Fuu');

  Text2.Text := 'Editando Local';
  Mostrar;

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
