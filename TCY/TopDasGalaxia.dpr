program TopDasGalaxia;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Main in 'Sources\Main.pas' {FMain},
  MapGmaps in 'Sources\MapGMaps.pas' {FMapGMaps};

{$R *.res}


begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.Run;

end.
