program YoutubeManager;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFormUnit in 'app\MainFormUnit.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
