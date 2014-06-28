program TopDasGalaxia;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Main in 'Sources\Main.pas' {FMain},
  MapGMaps in 'Sources\MapGMaps.pas' {FrmMapGMaps: TFrame},
  MainMenu in 'Sources\MainMenu.pas' {frMainMenu: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
