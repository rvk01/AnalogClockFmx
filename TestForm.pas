unit TestForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  AnalogClock;

type
  TForm8 = class(TForm)
    AnalogClock1: TAnalogClock;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.fmx}

procedure TForm8.FormCreate(Sender: TObject);
var
  AC: TAnalogClock;
begin
  AC := TAnalogClock.Create(Self);
  AC.Parent := Self;
  AC.Size.Width := 300;
  AC.Size.Height := 300;
  AC.Position.X := 10;
  AC.Position.Y := 10;
end;

end.
