unit ChannelControllerUnit;

interface

uses
    System.SysUtils, System.UITypes, System.Generics.Collections, SourceUnit;

type
    TChannelController = class
    private
        class function GetChannelByCustomUrl(ACustomUrl: String): String;
    public
        class function AddChannel(ALink, ACategoryId: String): Integer;
    end;

implementation

{ TChannelController }

uses
    ApiServiceUnit, SourceRepositoryUnit, ApiRequestUnit;

// https://www.youtube.com/channel/UCdI5EH48Quo0Cope7Jvg-Pg
// https://www.youtube.com/c/vsvoemdome
// https://www.youtube.com/user/techtomorrow
class function TChannelController.AddChannel(ALink, ACategoryId: String): Integer;
var
    ChannelId, PlaylistId, User: String;
begin

    Result := mrCancel;

    try

        if Pos('youtube.com/channel/', ALink) > 0
        then begin
            ChannelId := Copy(ALink, Pos('/channel/', ALink) + Length('/channel/'));
            PlaylistId := TApiService.AddChannel(ChannelId, ALink, ACategoryId);
        end
        else if Pos('youtube.com/c/', ALink) > 0
        then begin
            ChannelId := GetChannelByCustomUrl(Copy(ALink, Pos('/c/', ALink) + Length('/c/')));
            PlaylistId := TApiService.AddChannel(ChannelId, ALink, ACategoryId);
        end
        else if Pos('youtube.com/user/', ALink) > 0
        then begin
            User := Copy(ALink, Pos('/user/', ALink) + Length('/user/'));
            PlaylistId := TApiService.AddChannelByUser(User, ALink, ACategoryId);
        end
        else raise Exception.Create('Link is incorrect');

        TApiService.AddVideosBySource(PlaylistId);

        Result := mrOk;

    except
        on E: Exception do
            { TODO }
            // MessageDlg('AddChannel error:'#10#13 + E.Message, mtError, [mbOk], 0);
    end;

end;

class function TChannelController.GetChannelByCustomUrl(ACustomUrl: String): String;
begin
    Result := TApiService.GetChannelByCustomUrl(ACustomUrl);
end;

end.
