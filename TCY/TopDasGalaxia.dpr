program TopDasGalaxia;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Main in 'Sources\Main.pas' {FMain},
  MapGmaps in 'Sources\MapGmaps.pas' {FMapGMaps};

{$R *.res}


begin
  Application.Initialize;
  Application.CreateForm(TFMapGMaps, FMapGMaps);
  Application.Run;

end.
