unit MapGMaps;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.TMSWebGMapsWebBrowser, FMX.TMSWebGMaps, Data.DB, Datasnap.DBClient;

type
  TFrmMapGMaps = class(TFrame)
    TMSFMXWebGMaps1: TTMSFMXWebGMaps;
    Button1: TButton;
    ClientDataSet1: TClientDataSet;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure TMSFMXWebGMaps1MapClick(Sender: TObject;
      Latitude, Longitude: Double; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
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

procedure TFrmMapGMaps.Button1Click(Sender: TObject);
var
  I: Integer;
begin

  ClientDataSet1.EmptyDataSet;
  for I := 0 to TMSFMXWebGMaps1.Markers.Count - 1 do begin
    ClientDataSet1.Append;
    ClientDataSet1.FieldByName('la').AsFloat := TMSFMXWebGMaps1.Markers
      [I].Latitude;
    ClientDataSet1.FieldByName('lo').AsFloat := TMSFMXWebGMaps1.Markers[I]
      .Longitude;
    ClientDataSet1.Post;
  end;
  ClientDataSet1.SaveToFile(GetHomePath + '/Te.txt');
end;

procedure TFrmMapGMaps.Button2Click(Sender: TObject);
begin
  TMSFMXWebGMaps1.MapOptions.DefaultLatitude := 23;;
  TMSFMXWebGMaps1.MapOptions.DefaultLongitude := 44;;

  ClientDataSet1.first;
  while not ClientDataSet1.eof do begin
    TMSFMXWebGMaps1.Markers.Add(ClientDataSet1.FieldByName('la').AsFloat,
      ClientDataSet1.FieldByName('lo').AsFloat,
      ' AOPAKSD ' + ClientDataSet1.FieldByName('la').AsFloat.ToString() + ' ' +
      ClientDataSet1.FieldByName('lo').AsFloat.ToString(), '', True, True, True,
      True, True, 0);

    ClientDataSet1.Next;
  end;

end;

constructor TFrmMapGMaps.Create(AOwner: TComponent);
begin
  inherited;
  ClientDataSet1.CreateDataSet;
  if FileExists(GetHomePath + '/Te.txt') then begin
    try
      ClientDataSet1.LoadFromFile(GetHomePath + '/Te.txt');
    except
      on E: Exception do
    end;
  end;
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
  TMSFMXWebGMaps1.Markers.Add(Latitude, Longitude,
    ' AOPAKSD ' + Latitude.ToString() + ' ' + Longitude.ToString(), '', True,
    True, True, True, True, 0);
end;

end.
