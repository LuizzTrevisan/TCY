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

class function TFrmMapGMaps.getMe: TFrmMapGMaps;
begin
  if not Assigned(frameGMaps) then
    frameGMaps := TFrmMapGMaps.Create(Application);

  Result := frameGMaps;
end;

end.
