unit MapGMaps;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.TMSWebGMapsCommon, FMX.Types, FMX.Graphics, FMX.Controls,
  FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.TMSWebGMapsWebBrowser,
  FMX.TMSWebGMaps, Data.DB, Datasnap.DBClient, FMX.Gestures, MapMarkers,
  FMX.Objects, System.Sensors, System.Sensors.Components;

type
  TFrmMapGMaps = class(TFrame)
    TMSFMXWebGMaps1: TTMSFMXWebGMaps;
    ClientDataSet1: TClientDataSet;
    frMarkers1: TfrMarkers;
    procedure TMSFMXWebGMaps1MapClick(Sender: TObject;
      Latitude, Longitude: Double; X, Y: Integer);
    procedure TMSFMXWebGMaps1MarkerDragEnd(Sender: TObject; MarkerTitle: string;
      IdMarker: Integer; Latitude, Longitude: Double);
    procedure frMarkers1Button1Click(Sender: TObject);
    procedure frMarkers1Button2Click(Sender: TObject);
    procedure TMSFMXWebGMaps1MarkerClick(Sender: TObject; MarkerTitle: string;
      IdMarker: Integer; Latitude, Longitude: Double);
    procedure frMarkers1Resize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function getMe: TFrmMapGMaps;
    constructor Create(AOwner: TComponent); override;

  end;

var
  frameGMaps: TFrmMapGMaps;

implementation

{$R *.fmx}
{ TFrmMapGMaps }

constructor TFrmMapGMaps.Create(AOwner: TComponent);
begin
  inherited;

  ClientDataSet1.CreateDataSet;
  if FileExists(GetHomePath + '/Te.txt') then begin
    try
      ClientDataSet1.LoadFromFile(GetHomePath + '/Te.txt');
      ClientDataSet1.first;
      while not ClientDataSet1.eof do begin
        TMSFMXWebGMaps1.Markers.Add(ClientDataSet1.FieldByName('la').AsFloat,
          ClientDataSet1.FieldByName('lo').AsFloat,
          ClientDataSet1.FieldByName('title').AsString, '', True, True, True,
          True, False, 0);
        ClientDataSet1.Next;
      end;
    except
      on E: Exception do
        ClientDataSet1.EmptyDataSet;
    end;
  end;

//  LocationSensor1.Active := True;

//  TMSFMXWebGMaps1.MapOptions.DefaultLatitude :=  LocationSensor1.Sensor.Latitude;
//  TMSFMXWebGMaps1.MapOptions.DefaultLongitude :=  LocationSensor1.Sensor.Longitude;

end;

procedure TFrmMapGMaps.frMarkers1Button1Click(Sender: TObject);
begin
  ClientDataSet1.Edit;
  ClientDataSet1.FieldByName('Title').AsString := frMarkers1.edTitle.Text;
  ClientDataSet1.FieldByName('Info1').AsString := frMarkers1.edInfo1.Text;
  ClientDataSet1.FieldByName('Info2').AsString := frMarkers1.edInfo2.Text;

  TMSFMXWebGMaps1.Markers.Add(ClientDataSet1.FieldByName('la').AsFloat,
    ClientDataSet1.FieldByName('lo').AsFloat,
    ClientDataSet1.FieldByName('Title').AsString, '', True, True, True,
    False, True, 0);

  ClientDataSet1.SaveToFile(GetHomePath + '/Te.txt');

  frMarkers1.Visible := False;
end;

procedure TFrmMapGMaps.frMarkers1Button2Click(Sender: TObject);
begin
  ClientDataSet1.Delete;
  frMarkers1.Visible := False;
end;

procedure TFrmMapGMaps.frMarkers1Resize(Sender: TObject);
begin
   frMarkers1.Button1.Width := frMarkers1.Rectangle3.Width / 2;
   frMarkers1.Button2.Width := frMarkers1.Rectangle3.Width / 2;
end;

class function TFrmMapGMaps.getMe: TFrmMapGMaps;
begin
  if not Assigned(frameGMaps) then
    frameGMaps := TFrmMapGMaps.Create(Application);

  Result := frameGMaps;
end;

procedure TFrmMapGMaps.TMSFMXWebGMaps1MapClick(Sender: TObject;
  Latitude, Longitude: Double; X, Y: Integer);
begin

  ClientDataSet1.Append;
  ClientDataSet1.FieldByName('la').AsFloat := Latitude;
  ClientDataSet1.FieldByName('lo').AsFloat := Longitude;
  ClientDataSet1.Post;

  frMarkers1.Visible := True;
end;

procedure TFrmMapGMaps.TMSFMXWebGMaps1MarkerClick(Sender: TObject;
  MarkerTitle: string; IdMarker: Integer; Latitude, Longitude: Double);
begin
  frMarkers1.Visible := True;

end;

procedure TFrmMapGMaps.TMSFMXWebGMaps1MarkerDragEnd(Sender: TObject;
  MarkerTitle: string; IdMarker: Integer; Latitude, Longitude: Double);
begin

  ClientDataSet1.first;
  ClientDataSet1.Locate('la;lo', VarArrayOf([Latitude, Longitude]), []);
  ClientDataSet1.Edit;
  ClientDataSet1.FieldByName('la').AsFloat := Latitude;
  ClientDataSet1.FieldByName('lo').AsFloat := Longitude;
  ClientDataSet1.Post;

  ClientDataSet1.SaveToFile(GetHomePath + '/Te.txt');

end;

end.
