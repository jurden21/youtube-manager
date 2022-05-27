unit AppConfigUnit;

interface

type
    TAppConfig = class
    public
        const QUEUE_CATEGORY = 0;
        const CATEGORY_BACKGROUND = $00FFCCCC;
        const CATEGORY_FOREGROUND = $00800000;
        const TAG_BACKGROUND = $00CCFFCC;
        const TAG_FOREGROUND = $00008000;
        const SOURCE_BACKGROUND = $00CCFFCC;
        const SOURCE_FOREGROUND = $00008000;
        const VIDEO_BACKGROUND = $00CCCCFF;
        const VIDEO_FOREGROUND = $0000080;
    public
        class function GetGoogleApiKey: String;
    end;

implementation

{ TAppConfig }

uses
    IniServiceUnit;

class function TAppConfig.GetGoogleApiKey: String;
begin
    Result := TIniService.ReadString('GoogleApi', 'Key', '');
end;

end.
