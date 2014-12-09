unit uMapImage;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Objects,
  System.Generics.Collections, System.Types, FMX.ExtCtrls,
  FMX.Graphics;

type

  TMarcador = class(TImage)
  protected
    procedure Paint; override;
  public
    Caption: String;
    function X: Single;
    function Y: Single;
    constructor Create(AOwner: TComponent; X, Y: Single; Caption: String);
      reintroduce;
  end;

  TMapImage = class(TImage)
  private
    { Private declarations }
    FMarcadores: TList<TMarcador>;
  protected
    { Protected declarations }
    // function GetMarcador(Index: Integer) : TMarcador;
    // procedure SetMarcador(Index: Integer; Value : TMarcador);
    function GetMarcadores: TList<TMarcador>;
  public
    { Public declarations }
    MarcadorScale: TPosition;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // property Marcadores[Index: Integer]: TMarcador read GetMarcador write SetMarcador;
    Property Marcadores: TList<TMarcador> read GetMarcadores;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TCY', [TMapImage]);
end;

{ TMapImage }

constructor TMapImage.Create(AOwner: TComponent);
begin
  inherited;
  FMarcadores := TList<TMarcador>.Create();
  MarcadorScale := TPosition.Create(PointF(1, 1));
end;

destructor TMapImage.Destroy;
begin
  FreeAndNil(FMarcadores);
  inherited;
end;

function TMapImage.GetMarcadores: TList<TMarcador>;
begin
  Result := FMarcadores;
end;

// function TMapImage.GetMarcador(Index: Integer): TMarcador;
// begin
// Result := FMarcadores[Index];
// end;
//
//
// procedure TMapImage.SetMarcador(Index: Integer; Value: TMarcador);
// begin
// FMarcadores.Insert(Index, Value);
// end;

{ TMarcador }

constructor TMarcador.Create(AOwner: TComponent; X, Y: Single; Caption: String);
var
  InStream: TResourceStream;
begin
  inherited Create(AOwner);
  Self.Parent := TFmxObject(AOwner);
  Self.Height := 60;
  Self.Width := 20;
  Self.Position.X := X;
  Self.Position.Y := Y;
  Self.Anchors := [];
  InStream := TResourceStream.Create(HInstance, 'PngImage_1', RT_RCDATA);
  Self.MultiResBitmap.Items[0].Bitmap.LoadFromStream(InStream);
  Self.Scale.X := TMapImage(AOwner).MarcadorScale.X;
  Self.Scale.Y := TMapImage(AOwner).MarcadorScale.Y;
  Self.Caption := Caption;

end;

procedure TMarcador.Paint;
begin
  inherited;
  Self.Canvas.BeginScene();
//  Self.Canvas.ClearRect(RectF(0, 0, 100, 20),clWhite);

//  Self.Canvas.Fill.Color := clWhite;
//  Self.Canvas.Fill.Kind  := TBrushKind.Solid;
//  Self.Canvas.Stroke.Color  := clLime;
//  Self.Canvas.Stroke.Kind  := TBrushKind.Solid;
  Self.Canvas.FillText(RectF(0, 0, 100, 50), Self.Caption, False, 100,
    [TFillTextFlag.RightToLeft], TTextAlign.Leading);
//  Self.Canvas.DrawRect(RectF(0, 0, 100, 50), 2,2,AllCorners,100,self.Canvas.Stroke);
  Self.Canvas.EndScene();
end;

function TMarcador.X: Single;
begin
  Result := Self.Position.X;
end;

function TMarcador.Y: Single;
begin
  Result := Self.Position.Y;
end;

end.
