unit MapGMaps;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.TMSWebGMapsWebBrowser, FMX.TMSWebGMaps;

type
  TFrmMapGMaps = class(TFrame)
    TMSFMXWebGMaps1: TTMSFMXWebGMaps;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function getMe : TFrmMapGMaps;
  end;

var
  frameGMaps :  TFrmMapGMaps;
implementation

{$R *.fmx}

{ TFrmMapGMaps }

procedure TFrmMapGMaps.Button1Click(Sender: TObject);
begin
  TMSFMXWebGMaps1.MapOptions.DefaultLatitude := 23;;
  TMSFMXWebGMaps1.MapOptions.DefaultLongitude := 44;;
end;

class function TFrmMapGMaps.getMe: TFrmMapGMaps;
begin
  if not Assigned(frameGMaps) then
    frameGMaps := TFrmMapGMaps.Create(Application);

  Result := frameGMaps;
end;

end.
