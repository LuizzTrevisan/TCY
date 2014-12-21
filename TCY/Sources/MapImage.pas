unit MapImage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Math,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Main, System.Actions, FMX.ActnList, FMX.Objects,
  FMX.Effects, FMX.ListBox, FMX.Layouts, FMX.ListView.Types, FMX.ListView,
  FMX.Edit, uMapImage, FMX.ExtCtrls, FMX.Ani, FMX.Controls.Presentation,
  System.Sensors, System.Sensors.Components, Data.DB, Datasnap.DBClient;

type

  // serve saber a acao que sera executa coom o marcador
  MarkerOpcao = (Nenhuma, Adicionando, Editando);

  TFMapImage = class(TFMain)
    RectZoom: TRectangle;
    sbMais: TSpeedButton;
    sbMenos: TSpeedButton;
    rectMarkers: TRectangle;
    RectOpcoes: TRectangle;
    btAdicionar: TButton;
    btRemover: TButton;
    EdtDescricao: TEdit;
    lvMarcadores: TListView;
    rectMarkersTop: TRectangle;
    txtAjuda: TText;
    GPSLocation: TImage;
    GpsAnimation: TFloatAnimation;
    ShowList: TImage;
    MapImage1: TMapImage;
    cbCategorias: TComboBox;
    LocationSensor1: TLocationSensor;
    Button3: TButton;
    edtlat: TEdit;
    edtlong: TEdit;
    atu: TButton;
    cdsDados: TClientDataSet;
    cdsDadosla: TFloatField;
    cdsDadoslo: TFloatField;
    cdsDadosTitle: TStringField;
    cdsDadosIndex: TIntegerField;
    cdsDadoscategoria: TIntegerField;
    btnMenuPopUp: TSpeedButton;
    procedure sbMaisClick(Sender: TObject);
    procedure sbMenosClick(Sender: TObject);
    procedure MapImage1Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure MapImage1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btAdicionarClick(Sender: TObject);
    procedure MapImage1SelectMarker(marker: TMarcador);
    procedure MapImage1MarkerMove(marker: TMarcador);
    procedure LocationSensor1LocationChanged(Sender: TObject;
      const OldLocation, NewLocation: TLocationCoord2D);
    procedure Button3Click(Sender: TObject);
    procedure atuClick(Sender: TObject);
    procedure cdsDadosBeforePost(DataSet: TDataSet);
    procedure btRemoverClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GPSLocationClick(Sender: TObject);
    procedure cdsDadosBeforeDelete(DataSet: TDataSet);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure cdsDadosAfterDelete(DataSet: TDataSet);
    procedure btnMenuPopUpClick(Sender: TObject);
  private
    { Private declarations }
    Operacao: MarkerOpcao;
    procedure ZoomImage(Size, X, Y: Single);
    procedure CarregarMarcadores;
    procedure MostrarBarraEdicaoInsercaoMarcador;
    procedure OcultarBarraEdicaoInsercaoMarcador;

  public
    { Public declarations }
    FLastPosition: TPointF;
    FLastDistance: Integer;
    procedure AtualizaLocalGPS;
  end;

var
  FMapImage: TFMapImage;

implementation

{$R *.fmx}

procedure TFMapImage.AtualizaLocalGPS;
const

  // essa procedure atualiza o local na tela com base na localziação atual do GPS.
  // para isso faz um calculo proporcional em relacao a distancia percorrida no GPS
  // Conversao da cordenada do GPS em relacao a cordenada X, y da imagem.


  // diferenca entre a cordenada inicial e a cordenada final (latitude, longitude)

  totWid = 0.009452;
  totHeig = 0.005901;
  // LongIni =  -52.680848; // -52.676524 casa
  // latIni = -26.215312;  //final -26.218189

  // 4 cordenadas da imagem.
  LongIni = -52.695230; // final   -52.685778
  latIni = -26.199538; // final -26.193637

var
  dif: Single;
begin
  inherited;

  // posiciona o ponto com base na coordenada do gps

  dif := edtlong.Text.ToSingle() - LongIni;
  MapImage1.Circle.X := (dif / totWid) * MapImage1.Width;

  dif := edtlat.Text.ToSingle() - latIni;
  MapImage1.Circle.Y := MapImage1.Height - (dif / totHeig) * MapImage1.Height;
end;

procedure TFMapImage.atuClick(Sender: TObject);
begin
  inherited;

  // testes  botao com visible false
  AtualizaLocalGPS;
end;

procedure TFMapImage.btAdicionarClick(Sender: TObject);
begin
  inherited;


  // MarkerOpcao = enumerator

  // seta a operacao atual do Marker
  if Operacao = MarkerOpcao.Nenhuma then
    Operacao := MarkerOpcao.Adicionando;

  // salva as informações do ponto atual
  cdsDados.Edit;
  cdsDadosTitle.AsString := EdtDescricao.Text;
  cdsDadoscategoria.AsInteger := cbCategorias.ItemIndex;
  cdsDados.Post;

  // salva em banco de dados as informacoes
  cdsDados.SaveToFile(GetHomePath + '/MapaUtfpr.wmap');

  OcultarBarraEdicaoInsercaoMarcador;
  txtAjuda.Text := 'Clique no Mapa para Adicionar um Marcador';
  Operacao := MarkerOpcao.Nenhuma;
end;

procedure TFMapImage.btnMenuPopUpClick(Sender: TObject);
begin
  inherited;

//no android nao funciona
//  if MessageDlg('REMOVE',TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNO],0,TMsgDlgBtn.mbYes ) = 1   then begin

//    cdsDados.First;
//    while not cdsDados.Eof do
//      cdsDados.Delete;
//
//    cdsDados.SaveToFile(GetHomePath + '/MapaUtfpr.wmap');

//  end;
end;

procedure TFMapImage.btRemoverClick(Sender: TObject);
begin
  inherited;
  // apaga o marker
  // no after delete salva no banco de dados.
  cdsDados.Delete;
  OcultarBarraEdicaoInsercaoMarcador;
  txtAjuda.Text := 'Clique no Mapa para Adicionar um Marcador';

  Operacao :=  MarkerOpcao.Nenhuma;

end;

procedure TFMapImage.Button3Click(Sender: TObject);
begin
  inherited;

  // testes do GPS


  // LocationSensor1.Active := not LocationSensor1.Active;
  // Button3.Text := LocationSensor1.Active.ToString();

end;

procedure TFMapImage.CarregarMarcadores;
begin
  Operacao := MarkerOpcao.Adicionando;

  // carregar os makers no cds.
  if FileExists(GetHomePath + '/MapaUtfpr.wmap') then
  begin
    try
      cdsDados.LoadFromFile(GetHomePath + '/MapaUtfpr.wmap');
    except
      on e : exception  do begin
          cdsDados.Close;
          cdsDados.CreateDataSet;
          showmessage(e.Message);
      end;
    end;
  end
  else
  begin
    cdsDados.Close;
    cdsDados.CreateDataSet;
    cdsDados.EmptyDataSet;
  end;

  // no Before Post adiciona o maker na tela.
  if (cdsDados.RecordCount > 0) then
  begin

    cdsDados.First;
    while not cdsDados.Eof do
    begin
      cdsDados.Edit;
      cdsDados.Post;
      cdsDados.Next;
    end;
  end;

end;

procedure TFMapImage.cdsDadosAfterDelete(DataSet: TDataSet);
begin
  inherited;
  // salva em banco de dados as informacoes
  cdsDados.SaveToFile(GetHomePath + '/MapaUtfpr.wmap');

end;

procedure TFMapImage.cdsDadosBeforeDelete(DataSet: TDataSet);
var
  i: Integer;
begin
  inherited;

  // busca o marcador na tela pela TAG para deletar.
  for i := 0 to MapImage1.Marcadores.Count - 1 do
    if MapImage1.Marcadores[i].Tag = cdsDadosIndex.AsInteger then
    begin
      // delete eh padrao da classe TObjectList
      MapImage1.Marcadores.Delete(i);
      Break;
    end;
end;

procedure TFMapImage.cdsDadosBeforePost(DataSet: TDataSet);
var
  vMarker: TMarcador;
  i: Integer;
begin
  inherited;

  // quando eh operacao de adicionar marcador,  cria um Marcador e adiciona ao conjunto de marcadores do componente MapImage
  if Operacao = MarkerOpcao.Adicionando then
  begin

    // cria o marker com as informacoes necessaruias
    vMarker := TMarcador.Create(MapImage1, cdsDadosla.AsFloat,
      cdsDadoslo.AsFloat, cdsDadosTitle.AsString, cdsDadoscategoria.AsInteger);

    // adiciona o maker a lista
    MapImage1.Marcadores.Add(vMarker);

    // quando está adicionando um novo ponto, busca o maior index
    if cdsDadosIndex.AsInteger <= 0 then
    begin
      Operacao := MarkerOpcao.Nenhuma;
      cdsDados.Edit;
      // -2 porque o proprio marcador ja esta adicionado a lista
      if MapImage1.Marcadores.Count >= 2 then
        // busca index do ultimo marcador da lista  e adiciona
        cdsDadosIndex.AsInteger := MapImage1.Marcadores
          [MapImage1.Marcadores.Count - 2].Tag + 1
      else
        cdsDadosIndex.AsInteger := 1;

      // ClientDataSet1.Post;
      Operacao := MarkerOpcao.Adicionando;
    end;

    // atribui ao marcador adiciona a lista o index que foi gerado para ele
    vMarker.Tag := cdsDadosIndex.AsInteger;

  end
  else if Operacao = MarkerOpcao.Editando then
  begin

    // busca o marcador e atualiza seus dados
    for i := 0 to MapImage1.Marcadores.Count - 1 do
      if MapImage1.Marcadores[i].Tag = cdsDadosIndex.AsInteger then
      begin
        MapImage1.Marcadores[i].Caption := cdsDadosTitle.AsString;
        Break;
      end;
  end;
end;

procedure TFMapImage.FormShow(Sender: TObject);
begin
  inherited;
  CarregarMarcadores;
  OcultarBarraEdicaoInsercaoMarcador;
end;

procedure TFMapImage.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  inherited;

  RectZoom.Visible := True;
end;

procedure TFMapImage.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  inherited;

  RectZoom.Visible := False;
end;

procedure TFMapImage.GPSLocationClick(Sender: TObject);
begin
  inherited;
  // Ativa e desativa o sensor de localizacao do aparelho
  // no evento LocationChanged´atualiza o local no Mapa
  LocationSensor1.Active := not LocationSensor1.Active;
  // GpsAnimation.Enabled := LocationSensor1.Active;
end;


// nao deixava arrastar o mapa para fora do limite da tela.. Nao usa mais por causa do zoom
{ procedure TFMapImage.VerificaPosicaoTamanhoMinimo;
  begin
  if Rectangle2.Position.X > 0 then
  Rectangle2.Position.X := 0;

  if Rectangle2.Position.Y > 0 then
  Rectangle2.Position.Y := 0;
  if Rectangle2.Height < minHeight then
  Rectangle2.Height := minHeight;

  if Rectangle2.Width < minWidth then
  Rectangle2.Width := minWidth;

  if Rectangle2.Width > maxWidth then
  Rectangle2.Width := maxWidth;

  if Rectangle2.Height > maxHeight then
  Rectangle2.Height := maxHeight;

  if Rectangle2.Position.Y < RectClient.Height - Rectangle2.Height then
  Rectangle2.Position.Y := RectClient.Height - Rectangle2.Height;

  if Rectangle2.Position.X < RectClient.Width - Rectangle2.Width then
  Rectangle2.Position.X := RectClient.Width - Rectangle2.Width;

  end; }

procedure TFMapImage.ZoomImage(Size, X, Y: Single);
var
  pos: TPosition;
  eventDistance: Single;
begin
  /// aumenta ou diminui a escala da imagem
  eventDistance := Size / 100;

  pos := MapImage1.Position;

  // tamanho minimo do mapa
  if (MapImage1.Scale.X + eventDistance <= 0.1) then
  begin
    MapImage1.Scale.X := 0.1;
    MapImage1.Scale.Y := 0.1;
  end
  else
  begin
    MapImage1.Scale.X := MapImage1.Scale.X + eventDistance;
    MapImage1.Scale.Y := MapImage1.Scale.Y + eventDistance;
  end;

  /// deixa a imagem centralizada
  MapImage1.Position.X := ((MapImage1.Position.X * MapImage1.Scale.X) / 2) *
    MapImage1.Scale.X;
  MapImage1.Position.Y := ((MapImage1.Position.Y * MapImage1.Scale.Y) / 2) *
    MapImage1.Scale.X;

   //tentando posicionar a imagem no meio

  // MapImage1.Bitmap.BitmapScale := MapImage1.Bitmap.BitmapScale  + eventDistance;
  // MapImage1.BitmapScale.Y := MapImage1.BitmapScale.Y  + eventDistance;

  {
    Rectangle2.Width := Rectangle2.Width + widthDistance;
    Rectangle2.Height := Rectangle2.Height + heightDistance;

    if (Rectangle2.Width < maxWidth) and (Rectangle2.Height < maxHeight) then
    begin
    Rectangle2.Position.X := Rectangle2.Position.X -
    ((X / Self.Width) * widthDistance);

    Rectangle2.Position.Y := Rectangle2.Position.Y -
    ((Y / Self.Height) * heightDistance);
    end;

    VerificaPosicaoTamanhoMinimo;
  }
end;

procedure TFMapImage.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
begin

  //atualiza as cordenadas do GPS
  edtlat.Text := NewLocation.Latitude.ToString();
  edtlong.Text := NewLocation.Longitude.ToString();
  AtualizaLocalGPS;
end;

procedure TFMapImage.MapImage1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  inherited;


  //no componente, escolhe os eventos que ele vai responder(LongTap, Pan, etc)


  // dedo pressionado
  if (EventInfo.GestureID = System.UITypes.igiLongTap) then
  begin
    // nao propaga o evento
    Handled := True;

    txtAjuda.Text := 'Adicionando Novo Marcador';
    EdtDescricao.Text := '';

    cbCategorias.DropDown;
    MostrarBarraEdicaoInsercaoMarcador;
    EdtDescricao.SetFocus;
  end;

  // Ao arrastar o dedo sobre a imagem
  if (EventInfo.GestureID = igiPan) then
  begin
    // nao propaga o evento para os objetos pais
    Handled := True;

    // se nao é o inicio do evento de arrastar
    if not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags) then
    begin
      // clacula a distancia que o dedo percorreu
      MapImage1.Position.X := MapImage1.Position.X +
        (EventInfo.Location.X - FLastPosition.X);

      MapImage1.Position.Y := MapImage1.Position.Y +
        (EventInfo.Location.Y - FLastPosition.Y);
    end;

    // Salva a posicao que o dedo estava para fazer o calculo
    // da distancia percorrida
    FLastPosition := EventInfo.Location;

  end;

end;

procedure TFMapImage.MapImage1MarkerMove(marker: TMarcador);
begin
  inherited;
  Operacao := MarkerOpcao.Editando;

  // Atualiza sua nova possicao no ClientDataSet e salva as informacoes
  cdsDados.First;
  cdsDados.FindKey([marker.Tag]);
  cdsDados.Edit;
  cdsDados.FieldByName('la').AsFloat := marker.X;
  cdsDados.FieldByName('lo').AsFloat := marker.Y;
  cdsDados.Post;

  cdsDados.SaveToFile(GetHomePath + '/MapaUtfpr.wmap');
end;

procedure TFMapImage.MapImage1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  inherited;


  //atualiza no cds as posicoes, que serao utilizadas no before post.

  Operacao := MarkerOpcao.Nenhuma;
  if cdsDados.State <> dsInsert then
    cdsDados.Append;

  cdsDados.FieldByName('la').AsFloat := X;
  cdsDados.FieldByName('lo').AsFloat := Y;

  if Boolean(actShowMenuLateral.Tag) then
    actShowMenuLateral.Execute;

  // Utilizado parat testes no ambiente Windows
{$IFDEF WIN32}
  txtAjuda.Text := 'Adicionando Novo Marcador';
  EdtDescricao.Text := '';
  MostrarBarraEdicaoInsercaoMarcador;
{$ENDIF}
end;

procedure TFMapImage.MapImage1SelectMarker(marker: TMarcador);
begin
  inherited;

  // carrega os dados do marcador selecionado para a edicao
  Operacao := MarkerOpcao.Editando;

  cdsDados.First;
  cdsDados.FindKey([marker.Tag]);
  txtAjuda.Text := 'Editando Marcador';

  EdtDescricao.Text := cdsDadosTitle.AsString;
  MostrarBarraEdicaoInsercaoMarcador;

  Operacao :=  MarkerOpcao.Nenhuma;
end;

procedure TFMapImage.MostrarBarraEdicaoInsercaoMarcador;
begin
  rectMarkers.Height := 140;
end;

procedure TFMapImage.OcultarBarraEdicaoInsercaoMarcador;
begin
  rectMarkers.Height := rectMarkersTop.Height
end;

procedure TFMapImage.sbMaisClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  ZoomImage(20, Self.Width / 2, Self.Height / 2);

  // aumentava ou diminuia taamanho dos marcadores
  // MapImage1.MarcadorScale.Y := MapImage1.MarcadorScale.Y - 0.1;
  // MapImage1.MarcadorScale.X := MapImage1.MarcadorScale.X - 0.1;
  // for i := 0 to MapImage1.Marcadores.Count - 1 do
  // begin
  // MapImage1.Marcadores[i].Scale.X := MapImage1.MarcadorScale.X;
  // MapImage1.Marcadores[i].Scale.Y := MapImage1.MarcadorScale.Y;
  // end;
end;

procedure TFMapImage.sbMenosClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  ZoomImage(-20, Self.Width / 2, Self.Height / 2);

  // MapImage1.MarcadorScale.Y := MapImage1.MarcadorScale.Y + 0.1;
  // MapImage1.MarcadorScale.X := MapImage1.MarcadorScale.X + 0.1;
  // for i := 0 to MapImage1.Marcadores.Count - 1 do
  // begin
  // MapImage1.Marcadores[i].Scale.X := MapImage1.MarcadorScale.X;
  // MapImage1.Marcadores[i].Scale.Y := MapImage1.MarcadorScale.Y;
  // end;
end;

end.
