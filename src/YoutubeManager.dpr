program YoutubeManager;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFormUnit in 'app\MainFormUnit.pas' {MainForm},
  SourcesFrameUnit in 'app\SourcesFrameUnit.pas' {SourcesFrame: TFrame},
  DataConfigUnit in 'configs\DataConfigUnit.pas',
  CategoryUnit in 'model\CategoryUnit.pas',
  ChannelUnit in 'model\ChannelUnit.pas',
  SourceUnit in 'model\SourceUnit.pas',
  VideoUnit in 'model\VideoUnit.pas',
  CategoryRepositoryUnit in 'repositories\CategoryRepositoryUnit.pas',
  ChannelRepositoryUnit in 'repositories\ChannelRepositoryUnit.pas',
  SourceRepositoryUnit in 'repositories\SourceRepositoryUnit.pas',
  VideoRepositoryUnit in 'repositories\VideoRepositoryUnit.pas',
  CategoryControllerUnit in 'controllers\CategoryControllerUnit.pas',
  ChannelControllerUnit in 'controllers\ChannelControllerUnit.pas',
  SourceControllerUnit in 'controllers\SourceControllerUnit.pas',
  VideoControllerUnit in 'controllers\VideoControllerUnit.pas',
  ApiRequestUnit in 'api\ApiRequestUnit.pas',
  ApiServiceUnit in 'api\ApiServiceUnit.pas',
  HttpClientUnit in 'app\HttpClientUnit.pas',
  AppConfigUnit in 'configs\AppConfigUnit.pas',
  IniServiceUnit in 'utils\IniServiceUnit.pas',
  RegistryServiceUnit in 'utils\RegistryServiceUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
