{*********************************************************************
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Autor: Brovin Y.D.
 * E-mail: y.brovin@gmail.com
 *
 ********************************************************************}

unit FGX.ColorsPanel;

interface

uses
  System.Types, System.Classes, FMX.Controls, System.UITypes, FMX.Graphics, FMX.Types, FGX.Colors.Presets, FGX.Types;

type

  { TfgCustomColorsPanel }

  TfgOnGetColor = procedure (Sender: TObject; const Column, Row: Integer; var Color: TAlphaColor) of object;
  TfgOnColorSelected = procedure (Sender: TObject; const AColor: TAlphaColor) of object;
  TfgOnPaintCell = procedure (Sender: TObject; Canvas: TCanvas; const Column, Row: Integer; const Frame: TRectF;
    const AColor: TAlphaColor; Corners: TCorners; var Done: Boolean) of object;

  TfgColorsPresetKind = (WebSafe, X11, Custom);

  TfgCustomColorsPanel = class (TControl)
  private
    FCellSize: TfgSingleSize;
    FBorderRadius: Single;
    FStrokeBrush: TStrokeBrush;
    FColorsPreset: TfgColorsPreset;
    FPresetKind: TfgColorsPresetKind;
    FOnGetColor: TfgOnGetColor;
    FOnColorSelected: TfgOnColorSelected;
    FOnPaintCell: TfgOnPaintCell;
    function IsBorderRadiusStored: Boolean;
    function IsCellSizeStored: Boolean;
    procedure SetColorCellSize(const Value: TfgSingleSize);
    procedure SetBorderColor(const Value: TStrokeBrush);
    procedure SetBorderRadius(const Value: Single);
    procedure SetColorsPreset(const Value: TfgColorsPreset);
    procedure SetPresetKind(const Value: TfgColorsPresetKind);
  protected
    { Events }
    procedure DoGetColor(const Column, Row: Integer; var Color: TAlphaColor); virtual;
    procedure DoColorSelected(const AColor: TAlphaColor); virtual;
    procedure DoPaintCell(const Column, Row: Integer; const Frame: TRectF; const AColor: TAlphaColor; Corners: TCorners;
                          var Done: Boolean); virtual;
    procedure DoBorderStrokeChanged(Sender: TObject); virtual;
    procedure DoCellSizeChanged(Sender: TObject); virtual;
    { Sizes }
    function GetDefaultSize: TSizeF; override;
    function GetBorderFrame: TRectF; virtual;
    function GetCellFrame(const Column, Row: Integer): TRectF; virtual;
    { Painting }
    procedure Paint; override;
    procedure DrawCell(const Column, Row: Integer; const Frame: TRectF; const Color: TAlphaColor); virtual;
    function GetColor(const Column, Row: Integer): TAlphaColor; virtual;
    { Mouse Events }
    procedure MouseClick(Button: TMouseButton; Shift: TShiftState; X: Single; Y: Single); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ColumnsCount: Integer;
    function RowsCount: Integer;
    property ColorsPreset: TfgColorsPreset read FColorsPreset write SetColorsPreset;
  public
    property BorderRadius: Single read FBorderRadius write SetBorderRadius stored IsBorderRadiusStored;
    property PresetKind: TfgColorsPresetKind read FPresetKind write SetPresetKind default TfgColorsPresetKind.WebSafe;
    property Stroke: TStrokeBrush read FStrokeBrush write SetBorderColor;
    property CellSize: TfgSingleSize read FCellSize write SetColorCellSize stored IsCellSizeStored;
    property OnGetColor: TfgOnGetColor read FOnGetColor write FOnGetColor;
    property OnColorSelected: TfgOnColorSelected read FOnColorSelected write FOnColorSelected;
    property OnPaintCell: TfgOnPaintCell read FOnPaintCell write FOnPaintCell;
  end;

  { TfgColorsPanel }

  TfgColorsPanel = class (TfgCustomColorsPanel)
  published
    property Stroke;
    property BorderRadius;
    property PresetKind;
    property CellSize;
    property OnGetColor;
    property OnColorSelected;
    property OnPaintCell;
    { inherited }
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnKeyDown;
    property OnKeyUp;
    property OnCanFocus;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

implementation

uses
  System.Math, System.SysUtils, System.UIConsts, System.TypInfo, FGX.Graphics, FGX.Consts;

{ TfgCustomColorsPanel }

function TfgCustomColorsPanel.ColumnsCount: Integer;
begin
  if not SameValue(CellSize.Width - 1, 0, EPSILON_SINGLE) then
    Result := Floor(Width / (CellSize.Width - 1))
  else
    Result := 0;
end;

constructor TfgCustomColorsPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCellSize := TfgSingleSize.Create(18, 18, TfgEqualityComparators.SingleEquality);
  FCellSize.OnChange := DoCellSizeChanged;
  FBorderRadius := 0;
  FStrokeBrush := TStrokeBrush.Create(TBrushKind.Solid, TAlphaColorRec.Black);
  FStrokeBrush.OnChanged := DoBorderStrokeChanged;
  SetAcceptsControls(False);
  { Set Default Preset }
  SetLength(FColorsPreset, Length(COLORS_PRESET_WEB_SAFE));
  System.Move(COLORS_PRESET_WEB_SAFE[1], FColorsPreset[0], SizeOf(COLORS_PRESET_WEB_SAFE));
end;

destructor TfgCustomColorsPanel.Destroy;
begin
  FreeAndNil(FCellSize);
  FreeAndNil(FStrokeBrush);
  inherited Destroy;
end;

procedure TfgCustomColorsPanel.DoBorderStrokeChanged(Sender: TObject);
begin
  Repaint;
end;

procedure TfgCustomColorsPanel.DoCellSizeChanged(Sender: TObject);
begin
  Repaint;
end;

procedure TfgCustomColorsPanel.DoColorSelected(const AColor: TAlphaColor);
begin
  if Assigned(FOnColorSelected) then
    FOnColorSelected(Self, AColor);
end;

procedure TfgCustomColorsPanel.DoGetColor(const Column, Row: Integer; var Color: TAlphaColor);
begin
  if Assigned(FOnGetColor) then
    FOnGetColor(Self, Column, Row, Color);
end;

procedure TfgCustomColorsPanel.DoPaintCell(const Column, Row: Integer; const Frame: TRectF; const AColor: TAlphaColor;
  Corners: TCorners; var Done: Boolean);
begin
  if Assigned(FOnPaintCell) then
    FOnPaintCell(Self, Canvas, Column, Row, Frame, AColor, Corners, Done);
end;

procedure TfgCustomColorsPanel.DrawCell(const Column, Row: Integer; const Frame: TRectF; const Color: TAlphaColor);
var
  Corners: TCorners;
  Done: Boolean;
begin
  Assert(InRange(Column, 1, ColumnsCount));
  Assert(InRange(Row, 1, RowsCount));

  Canvas.Fill.Kind := TBrushKind.Solid;
  Canvas.Fill.Color := Color;
  Corners := [];
  if (Column = 1) and (Row = 1) then
    Corners := Corners + [TCorner.TopLeft];
  if (Column = ColumnsCount) and (Row = 1) then
    Corners := Corners + [TCorner.TopRight];
  if (Column = ColumnsCount) and (Row = RowsCount) then
    Corners := Corners + [TCorner.BottomRight];
  if (Column = 1) and (Row = RowsCount) then
    Corners := Corners + [TCorner.BottomLeft];

  Done := False;
  DoPaintCell(Column, Row, Frame, Color, Corners, Done);
  if not Done then
    Canvas.FillRect(Frame, BorderRadius, BorderRadius, Corners, AbsoluteOpacity);
  Canvas.DrawRect(Frame, BorderRadius, BorderRadius, Corners, AbsoluteOpacity, Stroke);
end;

function TfgCustomColorsPanel.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(85, 34);
end;

function TfgCustomColorsPanel.GetCellFrame(const Column, Row: Integer): TRectF;
var
  Left: Single;
  Top: Single;
begin
  Assert(InRange(Column, 1, ColumnsCount));
  Assert(InRange(Row, 1, RowsCount));

  Left := (Column - 1) * CellSize.Width - Stroke.Thickness * (Column - 1);
  Top := (Row - 1) * CellSize.Height - Stroke.Thickness * (Row - 1);

  Result := TRectF.Create(TPointF.Create(Left, Top), CellSize.Width, CellSize.Height);
  Result.Inflate(-Stroke.Thickness / 2, -Stroke.Thickness / 2);
end;

function TfgCustomColorsPanel.GetBorderFrame: TRectF;
var
  HalfThickness: Single;
begin
  HalfThickness := FStrokeBrush.Thickness / 2;
  Result := TRectF.Create(HalfThickness, HalfThickness, Width - HalfThickness, Height - HalfThickness);
end;

function TfgCustomColorsPanel.GetColor(const Column, Row: Integer): TAlphaColor;
var
  ColorIndex: Integer;
  PresetTmp: TfgColorsPreset;
begin
  ColorIndex := (Row - 1) * ColumnsCount + Column;
  case PresetKind of
    WebSafe:
    begin
      SetLength(PresetTmp, Length(COLORS_PRESET_WEB_SAFE));
      System.Move(COLORS_PRESET_WEB_SAFE[1], PresetTmp[0], SizeOf(COLORS_PRESET_WEB_SAFE));
    end;
    X11:
    begin
      SetLength(PresetTmp, Length(COLORS_PRESET_X11));
      System.Move(COLORS_PRESET_X11[1], PresetTmp[0], SizeOf(COLORS_PRESET_X11));
    end;
    Custom:
      PresetTmp := FColorsPreset;
  else
    Result := TAlphaColorRec.Null;
  end;

  if ColorIndex <= High(PresetTmp) then
    Result := PresetTmp[ColorIndex].Value
  else
    Result := TAlphaColorRec.Null;
  DoGetColor(Column, Row, Result);
end;

function TfgCustomColorsPanel.IsBorderRadiusStored: Boolean;
begin
  Result := not SameValue(BorderRadius, 0, EPSILON_SINGLE);
end;

function TfgCustomColorsPanel.IsCellSizeStored: Boolean;
begin
  Result := not SameValue(FCellSize.Width, 18, EPSILON_SINGLE) or not SameValue(FCellSize.Height, 18, EPSILON_SINGLE);
end;

procedure TfgCustomColorsPanel.MouseClick(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited MouseClick(Button, Shift, X, Y);

  GetColor(Round(X / CellSize.Width), Round(Y / CellSize.Height));
end;

procedure TfgCustomColorsPanel.Paint;
var
  Column: Integer;
  Row: Integer;
  Color: TAlphaColor;
begin
  if ColumnsCount > 0 then
  begin
    for Row := 1 to RowsCount do
      for Column := 1 to ColumnsCount do
      begin
        Color := GetColor(Column, Row);
        DrawCell(Column, Row, GetCellFrame(Column, Row), Color);
      end;
  end;
end;

function TfgCustomColorsPanel.RowsCount: Integer;
begin
  Result := Floor(Height / (CellSize.Height - 1));
end;

procedure TfgCustomColorsPanel.SetBorderColor(const Value: TStrokeBrush);
begin
  if FStrokeBrush.Equals(Value) then
  begin
    FStrokeBrush.Assign(Value);
    Repaint;
  end;
end;

procedure TfgCustomColorsPanel.SetBorderRadius(const Value: Single);
begin
  if not SameValue(BorderRadius, Value, EPSILON_SINGLE) then
  begin
    FBorderRadius := Value;
    Repaint;
  end;
end;

procedure TfgCustomColorsPanel.SetColorCellSize(const Value: TfgSingleSize);
begin
  Assert(Value.Width >= 5);
  Assert(Value.Height >= 5);

  if CellSize <> Value then
  begin
    FCellSize.Assign(Value);
    Repaint;
  end;
end;

procedure TfgCustomColorsPanel.SetPresetKind(const Value: TfgColorsPresetKind);
begin
  if PresetKind <> Value then
  begin
    FPresetKind := Value;
    Repaint;
  end;
end;

procedure TfgCustomColorsPanel.SetColorsPreset(const Value: TfgColorsPreset);
begin
  FColorsPreset := Value;
  Repaint;
end;

initialization
  RegisterFmxClasses([TfgCustomColorsPanel, TfgColorsPanel]);
end.
