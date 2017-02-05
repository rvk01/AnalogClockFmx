program TestApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  TestForm in 'TestForm.pas' {Form8};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm8, Form8);
  Application.Run;
end.
