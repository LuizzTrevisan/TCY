unit Splash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects;

type
  TfrSplash = class(TFrame)
    Image3: TImage;
    AniIndicator1: TAniIndicator;
  private
  protected
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure threadTerminate(Sender : TObject);
  end;

var
  frSplash : TfrSplash;

implementation

{$R *.fmx}

uses MainMenu, Main;

{ TfrSplash }

constructor TfrSplash.Create(AOwner: TComponent);
var
  i : integer;
begin
  inherited;
  AniIndicator1.Enabled := true;
//  for I := 0 to 10 do begin
//    Application.ProcessMessages;
//    Sleep(100);
//  end;

  with TThread.CreateAnonymousThread(
      procedure begin
        frMainMenu := TfrMainMenu.Create(Application);
        frMainMenu.MenuAnimationIn.Start;
        frMainMenu.MenuAnimationOut.Start;
      end) do begin
    OnTerminate := threadTerminate;
    Start;
  end;

end;

procedure TfrSplash.threadTerminate(Sender: TObject);
begin
 // frMainMenu.Parent := FMain;
  frSplash.Destroy;
end;

end.
