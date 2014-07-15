program TopDasGalaxia;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Main in 'Sources\Main.pas' {FMain},
  MapGMaps in 'Sources\MapGMaps.pas' {FMapGMaps},
  MapImage in 'Sources\MapImage.pas' {FMain1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFMain1, FMain1);
  Application.Run;

end.
