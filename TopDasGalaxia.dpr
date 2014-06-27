program TopDasGalaxia;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Main in 'Sources\Main.pas' {Form1},
  MapGMaps in 'Sources\MapGMaps.pas' {FrmMapGMaps: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
