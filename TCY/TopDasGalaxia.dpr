program TopDasGalaxia;







{$R *.dres}

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Main in 'Sources\Main.pas' {FMain},
  MapGMaps in 'Sources\MapGMaps.pas' {FMapGMaps},
  MapImage in 'Sources\MapImage.pas' {FMapImage},
  uMapImage in 'MapImage\Sources\uMapImage.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.Run;

end.
