unit AnalogClock;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Objects;

type
  TAnalogClock = class(TCircle)
  private
    { Private declarations }
    rrHour: TRoundRect;
    rrMin: TRoundRect;
    rrSec: TRoundRect;
    procedure UpdatePositionSize;
    procedure UpdateClock(Sender: TObject);
  protected
    { Protected declarations }
    procedure Resize; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

uses FMX.Layouts, System.UITypes, System.UIConsts;

constructor TAnalogClock.Create(AOwner: TComponent);
var
  I: Integer;
  TL: TLayout;
begin
  inherited;
  Parent := AOwner as TFmxObject;

  Position.X := 100;
  Position.Y := 100;
  Size.Width := 200;
  Size.Height := 200;
  Size.PlatformDefault := False;
  Stroke.Thickness := 1;

  rrHour := TRoundRect.Create(Self);
  rrHour.Parent := Self;
  rrHour.Stored := False;
  rrHour.Fill.Color := claBlack;
  rrHour.RotationCenter.Y := 1;
  rrHour.Size.PlatformDefault := False;

  rrMin := TRoundRect.Create(Self);
  rrMin.Parent := Self;
  rrMin.Stored := False;
  rrMin.Fill.Color := claBlack;
  rrMin.RotationCenter.Y := 1;
  rrMin.Size.PlatformDefault := False;

  rrSec := TRoundRect.Create(Self);
  rrSec.Parent := Self;
  rrSec.Stored := False;
  rrSec.Fill.Color := claCrimson;
  rrSec.RotationCenter.Y := 1;
  rrSec.Size.PlatformDefault := False;

  for I := 1 to 12 do
  begin
    TL := TLayout.Create(Self);
    TL.Parent := Self;
    TL.Stored := False;
    TL.StyleName := 'clocknumber';
    TL.Align := TAlignLayout.Center;
    TL.RotationAngle := I * 30;
    TL.Size.Width := 50;
    TL.Size.Height := Self.Size.Height;
    TL.Size.PlatformDefault := False;
    with TText.Create(TL) do
    begin
      Parent := TL;
      Stored := False;
      Align := TAlignLayout.Top;
      RotationAngle := -I * 30;
      Text := IntToStr(I);
      TextSettings.Font.Size := Self.Size.Height / 8;
      TextSettings.Font.Style := [];
    end;
  end;

  UpdatePositionSize;

  with TTimer.Create(Self) do
  begin
    Interval := 1000;
    OnTimer := UpdateClock;
    Enabled := true;
  end;

end;

procedure TAnalogClock.UpdatePositionSize;
var
  I, J: Integer;
begin
  rrHour.Size.Width := 8;
  rrMin.Size.Width := 8;
  rrSec.Size.Width := 5;

  rrHour.Size.Height := trunc(Self.Size.Height / 2 * 0.5);
  rrHour.Position.X := (Self.Size.Width / 2) - (rrHour.Size.Width / 2);
  rrHour.Position.Y := (Self.Size.Height / 2) - rrHour.Size.Height;

  rrMin.Size.Height := trunc(Self.Size.Height / 2 * 0.8);
  rrMin.Position.X := (Self.Size.Width / 2) - (rrMin.Size.Width / 2);
  rrMin.Position.Y := (Self.Size.Height / 2) - rrMin.Size.Height;

  rrSec.Size.Height := trunc(Self.Size.Height / 2 * 0.8);
  rrSec.Position.X := (Self.Size.Width / 2) - (rrSec.Size.Width / 2);
  rrSec.Position.Y := (Self.Size.Height / 2) - rrSec.Size.Height;

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TLayout then
    begin
      for J := 0 to TLayout(Self.Components[I]).ComponentCount - 1 do
      begin
        TLayout(Self.Components[I]).Size.Height := Self.Size.Height;
        if TLayout(Self.Components[I]).Components[J] is TText then
        begin
          TText(TLayout(Self.Components[I]).Components[J]).Font.Size :=
            Self.Size.Height / 8;
        end;
      end;
    end;
  end;

end;

procedure TAnalogClock.Resize;
begin
  inherited Resize;
  if Assigned(rrHour) then
    UpdatePositionSize;
end;

procedure TAnalogClock.UpdateClock(Sender: TObject);
begin
  rrHour.RotationAngle := (30 * StrToInt(FormatDateTime('h', now))) + (6 * (StrToInt(FormatDateTime('n', now)) / 12));
  rrMin.RotationAngle := 6 * StrToInt(FormatDateTime('n', now));
  rrSec.RotationAngle := 6 * StrToInt(FormatDateTime('ss', now));
end;

procedure Register;
begin
  RegisterComponents('Samples', [TAnalogClock]);
end;

end.
