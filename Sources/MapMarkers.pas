unit MapMarkers;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Header, FMX.Objects, FMX.Edit;

type
  TfrMarkers = class(TFrame)
    Layout1: TLayout;
    Text1: TText;
    edTitle: TClearingEdit;
    edInfo2: TClearingEdit;
    edInfo1: TClearingEdit;
    Button1: TButton;
    Button2: TButton;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    procedure edInfo2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TfrMarkers.edInfo2Click(Sender: TObject);
begin
  Self.Repaint;
end;

end.
