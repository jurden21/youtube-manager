unit ApiRequestUnit;

interface

uses
    System.SysUtils, System.StrUtils;

type
    TApiRequest = class
    private
        const API_URL = 'https://youtube.googleapis.com/youtube/v3/';
        const MAX_RESULTS = 50;
        class function ChannelPart: String;
        class function PlaylistItemsPart: String;
        class function SearchPart: String;
    public
        class function ChannelsList(AId, AUserName: String): String;
        class function PlaylistItemsList(APlaylistId, APageToken: String): String;
        class function SearchList(AType, AQ: String): String;
    end;

implementation

uses
    IniServiceUnit;

{ TApiRequest }

// parts: auditDetails brandingSettings contentDetails contentOwnerDetails id localizations snippet statistics status topicDetails
class function TApiRequest.ChannelPart: String;
begin
    Result := 'contentDetails,snippet';
end;

// https://developers.google.com/youtube/v3/docs/channels/list
class function TApiRequest.ChannelsList(AId, AUserName: String): String;
begin
    Result := API_URL + 'channels?' +
              'part=' + ChannelPart + '&' +
              IfThen(AId <> '', 'id=' + AId + '&') +
              IfThen(AUserName <> '', 'forUsername=' + AUserName + '&') +
              'key=' + TIniService.ReadString('GoogleApi', 'Key', '');
end;

// parts: contentDetails id snippet status
class function TApiRequest.PlaylistItemsPart: String;
begin
    Result := 'snippet';
end;

// https://developers.google.com/youtube/v3/docs/playlistItems/list
class function TApiRequest.PlaylistItemsList(APlaylistId, APageToken: String): String;
begin
    Result := API_URL + 'playlistItems?' +
              'part=' + PlaylistItemsPart + '&' +
              'maxResults=' + MAX_RESULTS.ToString + '&' +
              'playlistId=' + APlaylistId + '&' +
              IfThen(APageToken <> '', 'pageToken=' + APageToken + '&') +
              'key=' + TIniService.ReadString('GoogleApi', 'Key', '');
end;

// parts: snippet
class function TApiRequest.SearchPart: String;
begin
    Result := 'snippet';
end;

// https://developers.google.com/youtube/v3/docs/search/list
class function TApiRequest.SearchList(AType, AQ: String): String;
begin
    Result := API_URL + 'search?' +
              'part=' + SearchPart + '&' +
              'type=' + AType + '&' +
              'q=' + AQ + '&' +
              'maxResults=' + MAX_RESULTS.ToString + '&' +
              'key=' + TIniService.ReadString('GoogleApi', 'Key', '');
end;

end.
