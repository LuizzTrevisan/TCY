unit MapGmaps;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Main, System.Actions, FMX.ActnList, FMX.Objects, FMX.Effects, FMX.Layouts,
  CacheLayout, System.Sensors, FMX.Edit, FMX.TMSWebGMapsWebBrowser,
  FMX.TMSWebGMaps, System.Sensors.Components, Data.DB, Datasnap.DBClient,
  FMX.ListBox;

type
  TFMapGMaps = class(TFMain)
    LocationSensor1: TLocationSensor;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1la: TFloatField;
    ClientDataSet1lo: TFloatField;
    ClientDataSet1Title: TStringField;
    Timer1: TTimer;
    TMSFMXWebGMaps1: TTMSFMXWebGMaps;
    rectMarkers: TRectangle;
    rectMarkersTop: TRectangle;
    Image3: TImage;
    AniIndicator1: TAniIndicator;
    Edit1: TEdit;
    Rectangle2: TRectangle;
    Button1: TButton;
    Button2: TButton;
    Text2: TText;
    GlowEffect7: TGlowEffect;
    GlowEffect8: TGlowEffect;
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
    procedure Timer1Timer(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
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
  ClientDataSet1.Edit;
  ClientDataSet1Title.AsString := Edit1.Text;
  ClientDataSet1.Post;
  // ClientDataSet1.FieldByName('Info1').AsString := frMarkers1.edInfo1.Text;
  // ClientDataSet1.FieldByName('Info2').AsString := frMarkers1.edInfo2.Text;

  TMSFMXWebGMaps1.Markers.Add(ClientDataSet1.FieldByName('la').AsFloat,
    ClientDataSet1lo.AsFloat, ClientDataSet1Title.AsString, '', True, True,
    True, False, True, 0).MapLabel.Text := 'MapLabel:' +
    ClientDataSet1Title.AsString;

  ClientDataSet1.SaveToFile(GetHomePath + '/Te.txt');

  Ocultar;
  Text2.Text := 'Clique no Mapa para Adicionar um Local';
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
    ClientDataSet1.LoadFromFile(GetHomePath + '/Te.txt');
    ClientDataSet1.First;
    while not ClientDataSet1.eof do begin
      TMSFMXWebGMaps1.Markers.Add(ClientDataSet1.FieldByName('la').AsFloat,
        ClientDataSet1.FieldByName('lo').AsFloat,
        ClientDataSet1.FieldByName('Title').AsString, '', True, True, True,
        False, True, 0).MapLabel.Text := 'MapLabel:' +
        ClientDataSet1.FieldByName('Title').AsString;
      showmessage('add');
      ClientDataSet1.Next;
    end;
  end;

end;

procedure TFMapGMaps.FormCreate(Sender: TObject);
begin
  inherited;
  ClientDataSet1.Close;
  ClientDataSet1.CreateDataSet;

end;

procedure TFMapGMaps.FormResize(Sender: TObject);
begin
  inherited;
  Button1.Width := Self.Width / 2 - 5;
  Button2.Width := Button1.Width - 5;
end;

procedure TFMapGMaps.Image3Click(Sender: TObject);
begin
  inherited;
  if not LocationSensor1.Active then begin
    LocationSensor1.Active := True;
    AniIndicator1.Enabled := True;
  end;
end;

procedure TFMapGMaps.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
begin
  inherited;
  LocationSensor1.Active := False;
  AniIndicator1.Enabled := False;
  AniIndicator1.Visible := False;

  txtStatus.Text := newlocation.Latitude.ToString() + ' ' + newlocation.Longitude.ToString();
end;

procedure TFMapGMaps.Mostrar;
begin
  rectMarkers.Height := 133;
end;

procedure TFMapGMaps.Ocultar;
begin
  rectMarkers.Height := rectMarkersTop.Height;
end;

procedure TFMapGMaps.Timer1Timer(Sender: TObject);
begin
  inherited;
  Timer1.Enabled := False;
  CarregarMarcadores;
end;

procedure TFMapGMaps.TMSFMXWebGMaps1MapClick(Sender: TObject;
  Latitude, Longitude: Double; X, Y: Integer);
begin
  inherited;
  ClientDataSet1.Append;
  ClientDataSet1.FieldByName('la').AsFloat := Latitude;
  ClientDataSet1.FieldByName('lo').AsFloat := Longitude;
  ClientDataSet1.Post;

  if rectMenuLateral.Visible then
    actShowMenuLateral.Execute;

  Text2.Text := 'Adicionando Novo Local';
  Mostrar;

end;

procedure TFMapGMaps.TMSFMXWebGMaps1MarkerClick(Sender: TObject;
  MarkerTitle: string; IdMarker: Integer; Latitude, Longitude: Double);
begin
  inherited;
  Text2.Text := 'Editando Local';
  Mostrar;

end;

procedure TFMapGMaps.TMSFMXWebGMaps1MarkerDragEnd(Sender: TObject;
  MarkerTitle: string; IdMarker: Integer; Latitude, Longitude: Double);
begin
  inherited;

  ClientDataSet1.First;
  ClientDataSet1.Locate('la;lo', VarArrayOf([Latitude, Longitude]), []);
  ClientDataSet1.Edit;
  ClientDataSet1.FieldByName('la').AsFloat := Latitude;
  ClientDataSet1.FieldByName('lo').AsFloat := Longitude;
  ClientDataSet1.Post;

  ClientDataSet1.SaveToFile(GetHomePath + '/Te.txt');

end;

end.
