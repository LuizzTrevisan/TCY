unit uMapImage;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Objects,
  System.Generics.Collections, System.UITypes, System.Types, FMX.ExtCtrls,
  FMX.Graphics;

type
  TMarcador = class;

  TMarkerNotify = procedure(marker: TMarcador) of object;

  TMarcador = class(TImage)
  protected
    FLastPosition: TPointF;

    procedure Paint; override;
    procedure Click; override;
    procedure DoGesture(const EventInfo: TGestureEventInfo;
      var Handled: Boolean); override;
  public

    Caption: String;
    function X: Single;
    function Y: Single;
    constructor Create(AOwner: TComponent; X, Y: Single; Caption: String;
      Index: Integer); reintroduce;
  published
  end;

  TMapImage = class(TImage)
  private
    { Private declarations }
    FMarcadores: TList<TMarcador>;
    fOnSelectMarker: TMarkerNotify;
    fonMarkerMove: TMarkerNotify;
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
    property onSelectMarker: TMarkerNotify read fOnSelectMarker
      write fOnSelectMarker;
    property onMarkerMove: TMarkerNotify read fonMarkerMove write fonMarkerMove;
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

procedure TMarcador.Click;
begin
  inherited;
  if Assigned(TMapImage(Owner).onSelectMarker) then
    TMapImage(Owner).onSelectMarker(Self);

end;

constructor TMarcador.Create(AOwner: TComponent; X, Y: Single; Caption: String;
  Index: Integer);
var
  InStream: TResourceStream;
begin
  inherited Create(AOwner);
  Self.Parent := TFmxObject(AOwner);
  Self.Height := 60;
  Self.Width := 30;
  Self.Position.X := X;
  Self.Position.Y := Y;
  Self.Anchors := [];

  InStream := TResourceStream.Create(HInstance, 'PngImage_'+index.ToString(), RT_RCDATA);

  Self.MultiResBitmap.Items[0].Bitmap.LoadFromStream(InStream);
  Self.Scale.X := TMapImage(AOwner).MarcadorScale.X;
  Self.Scale.Y := TMapImage(AOwner).MarcadorScale.Y;
  Self.Caption := Caption;

  Self.TouchManager.InteractiveGestures := [TInteractiveGesture.Pan]
end;

procedure TMarcador.DoGesture(const EventInfo: TGestureEventInfo;
  var Handled: Boolean);
begin
  inherited;
  if (EventInfo.GestureID = System.UITypes.igiPan) then
  begin

    if not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags) then
    begin
      Self.Position.X := Self.Position.X +
        (EventInfo.Location.X - FLastPosition.X);

      Self.Position.Y := Self.Position.Y +
        (EventInfo.Location.Y - FLastPosition.Y);
    end;

    if (TInteractiveGestureFlag.gfEnd in EventInfo.Flags) then
      if Assigned(TMapImage(Owner).onMarkerMove) then
        TMapImage(Owner).onMarkerMove(Self);
    Handled := True;
  end;

  FLastPosition := EventInfo.Location;
end;

procedure TMarcador.Paint;
begin
  inherited;

  Canvas.Stroke.Kind := TBrushKind.bkSolid;
  Canvas.Stroke.Color := $FFA4C9DF;

  Canvas.StrokeThickness := 3;
  Canvas.Fill.Color := $FF000202;
  Self.Canvas.BeginScene();
  // Canvas.FillText(r, 'FillText', false, 100, [TFillTextFlag.ftRightToLeft],
  // TTextAlign.taCenter, TTextAlign.taCenter);


  // Self.Canvas.ClearRect(RectF(0, 0, 100, 20),clWhite);

  // Self.Canvas.Fill.Color := clWhite;
  // Self.Canvas.Fill.Kind  := TBrushKind.Solid;
  // Self.Canvas.Stroke.Color  := clLime;
  // Self.Canvas.Stroke.Kind  := TBrushKind.Solid;

  Self.Canvas.FillRect(RectF(-40, -10, 50, 0), 2, 2, AllCorners, 100,
    Canvas.Stroke);
  Self.Canvas.FillText(RectF(-40, -15, 50, 5), Self.Caption, false, 100, [],
    TTextAlign.Center);

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
