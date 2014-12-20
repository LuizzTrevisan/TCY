unit uMapImage;


//componente que herda da classe TImage.


interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Objects,
  System.Generics.Collections, System.UITypes, System.Types, FMX.ExtCtrls,
  FMX.Graphics;

type



  //Objeto da apresenta a posicao atual
  TCircle = class(Timage)


    //quando usa as cordenadas deste componente, tem que considerar o tamanho (Width,heigth) pra fica no meio, no local correto.
    function GetX: Single;
    function GetY: Single;

    procedure SetX(const Value: Single);
    procedure SetY(const Value: Single);
  public
    property X: Single read GetX write SetX;
    property Y: Single read GetY write SetY;
    constructor Create(AOwner: TComponent);
  end;


  //classe do marcador
  TMarcador = class(Timage)
  private
    fCaption: String;

    //mesma correcao do componente TCircle, pra fica na posicao correta
    function GetX: Single;
    function GetY: Single;
    procedure SetX(const Value: Single);
    procedure SetY(const Value: Single);
    procedure SetCaption(const Value: String);

  protected

    //usado quando move um ponto ja adicionado, para calcular a distancia movida
    FLastPosition: TPointF;

    procedure Paint; override; //considera o evendo do ancestral, e adiciona o desenho da descricao no ponto
    procedure Click; override; //sobreescreve o evento antigo


    procedure DoGesture(const EventInfo: TGestureEventInfo;
      var Handled: Boolean); override;



  public

    property Caption: String read fCaption write SetCaption;
    constructor Create(AOwner: TComponent; X, Y: Single; ACaption: String;
      Categoria: Integer); reintroduce;
  published
    property X: Single read GetX write SetX;
    property Y: Single read GetY write SetY;
  end;

  //declaracao padrao da procedure.
  //poder criar procedures que tenham como parametro um marcador.
  TMarkerNotify = procedure(marker: TMarcador) of object;


  //classe do componente TMapImage
  TMapImage = class(Timage)
  private
    { Private declarations }


    //dentro da classe, tem um lista de marcadores da classe TMarcador
    FMarcadores: TObjectList<TMarcador>;

    //evento que retorna quando seleciona um marcador (retornar o proprio marker selecionado)
    fOnSelectMarker: TMarkerNotify;
    fonMarkerMove: TMarkerNotify;

    fCircle: TCircle;

  protected
    { Protected declarations }
    // function GetMarcador(Index: Integer) : TMarcador;
    // procedure SetMarcador(Index: Integer; Value : TMarcador);
  public
    { Public declarations }

    //nao usa mais
    //MarcadorScale: TPosition;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // property Marcadores[Index: Integer]: TMarcador read GetMarcador write SetMarcador;
    Property Marcadores: TObjectList<TMarcador> read FMarcadores
      write FMarcadores;
  published

    property Circle: TCircle read FCircle;
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
  FMarcadores := TObjectList<TMarcador>.Create();
  //MarcadorScale := TPosition.Create(PointF(1, 1));


  //nao adiciona o componente no .dfm (fmx) em tempo de projeto.
  if not (csDesigning in ComponentState) then begin
    fCircle := TCircle.Create(Self);
    fCircle.Name := 'LocalAtualGPS';
  end;
end;

destructor TMapImage.Destroy;
begin
  FreeAndNil(FMarcadores);
  inherited;
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

  //chama o evento atribuido no objeto na tela
  if Assigned(TMapImage(Owner).onSelectMarker) then
    TMapImage(Owner).onSelectMarker(Self);

end;

constructor TMarcador.Create(AOwner: TComponent; X, Y: Single; ACaption: String;
  Categoria: Integer);
var
  InStream: TResourceStream;
begin
  inherited Create(AOwner);

  Self.Parent := TFmxObject(AOwner);
  Self.Height := 60;
  Self.Width := 30;
  Self.X := X;
  Self.Y := Y;
  Self.Anchors := [];

  InStream := TResourceStream.Create(HInstance,
    'PngImage_' + Categoria.ToString(), RT_RCDATA);

  Self.MultiResBitmap.Items[0].Bitmap.LoadFromStream(InStream);
 // Self.Scale.X := TMapImage(AOwner).MarcadorScale.X;
//  Self.Scale.Y := TMapImage(AOwner).MarcadorScale.Y;
  Self.Caption := ACaption;

  //adiciona os eventos que o objeto ira responder
  Self.TouchManager.InteractiveGestures := [TInteractiveGesture.Pan,
    TInteractiveGesture.LongTap];

end;

procedure TMarcador.DoGesture(const EventInfo: TGestureEventInfo;
  var Handled: Boolean);
begin
  inherited;
  //bloqueia a propagacao para o owner;
  if (EventInfo.GestureID = System.UITypes.igiLongTap) then
    Handled := True;

  //ajusta as coordenadas do marcador que esta sendo mexido
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

function TMarcador.GetX: Single;
begin
  Result := Self.Position.X + (Self.Width / 2);
end;

function TMarcador.GetY: Single;
begin
  Result := Self.Position.Y + Self.Height;
end;

procedure TMarcador.SetCaption(const Value: String);
begin
  fCaption := Value;
  TMapImage(Self.Owner).Repaint;
end;

procedure TMarcador.SetX(const Value: Single);
begin
  Self.Position.X := Value - (Self.Width / 2);
end;

procedure TMarcador.SetY(const Value: Single);
begin
  Self.Position.Y := Value - (Self.Height);
end;

procedure TMarcador.Paint;
var
  vRect: TRectF;
  vTextWidth: Single;
begin
  inherited;

  //desenha o texto em cima do ponto
  Canvas.Stroke.Kind := TBrushKind.bkSolid;
  Canvas.Stroke.Color := $FFA4C9DF;

  Canvas.StrokeThickness := 3;
  Canvas.Fill.Color := $FF000202;
  Self.Canvas.BeginScene();
  // Canvas.FillText(r, 'FillText', false, 100, [TFillTextFlag.ftRightToLeft],
  // TTextAlign.taCenter, TTextAlign.taCenter);

  vTextWidth := Self.Canvas.TextWidth(Self.Caption) + 2;

  vRect := RectF(10 - (vTextWidth / 2), -15, (vTextWidth / 2) + 10, 4);

  // Self.Canvas.ClearRect(RectF(0, 0, 100, 20),clWhite);

  // Self.Canvas.Fill.Color := clWhite;
  // Self.Canvas.Fill.Kind  := TBrushKind.Solid;
  // Self.Canvas.Stroke.Color  := clLime;
  // Self.Canvas.Stroke.Kind  := TBrushKind.Solid;

  Self.Canvas.FillRect(vRect, 2, 2, AllCorners, 100, Canvas.Stroke);
  Self.Canvas.FillText(vRect, Self.Caption, false, 100, [], TTextAlign.Center);

  Self.Canvas.EndScene();
end;

{ TCircle }

constructor TCircle.Create(AOwner: TComponent);
var
  InStream: TResourceStream;
begin
  inherited Create(AOwner);


  Self.Parent := TFmxObject(AOwner);
  Self.Height := 15;
  Self.Width := 15;
  Self.Anchors := [];

  //carregar o resource (imagem do circulo)
  //ai adiciona a imagem no resources do componente
  InStream := TResourceStream.Create(HInstance, 'MapCircle', RT_RCDATA);
  Self.MultiResBitmap.Items[0].Bitmap.LoadFromStream(InStream);

  // Self.Scale.X := TMapImage(AOwner).MarcadorScale.X;
  // Self.Scale.Y := TMapImage(AOwner).MarcadorScale.Y;

end;

function TCircle.GetX: Single;
begin
  Result := Self.Position.X + (Self.Width / 2);
end;

function TCircle.GetY: Single;
begin
  Result := Self.Position.Y + Self.Height;
end;

procedure TCircle.SetX(const Value: Single);
begin
  Self.Position.X := Value - (Self.Width / 2);
end;

procedure TCircle.SetY(const Value: Single);
begin
  Self.Position.Y := Value - (Self.Height);
end;

end.
