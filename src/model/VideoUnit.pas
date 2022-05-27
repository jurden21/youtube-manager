unit VideoUnit;

interface

uses
    System.Json, System.SysUtils;

type
    TVideo = class
    private
        FId: String;
        FKind: String;
        FPlaylistId: String;
        FChannelId: String;
        FChannelTitle: String;       // read-only
        FTitle: String;
        FPublishedTimeText: String;
        FQueueId: String;
        FStatus: Integer;
    public
        property Id: String read FId;
        property Kind: String read FKind;
        property PlaylistId: String read FPlaylistId;
        property ChannelId: String read FChannelId;
        property ChannelTitle: String read FChannelTitle;
        property Title: String read FTitle;
        property PublishedTimeText: String read FPublishedTimeText;
        property QueueId: String read FQueueId;
        property Status: Integer read FStatus;
        constructor Create(AData: TJSONObject); overload;
        constructor Create(AId, AKind, APlaylistId, AChannelId, AChannelTitle, ATitle, APublishedTimeText, AQueueId: String; AStatus: Integer); overload;
    end;

implementation

{ TVideo }

constructor TVideo.Create(AData: TJSONObject);
var
    PublishedAt: String;
begin
    AData.TryGetValue('snippet.resourceId.videoId', FId);
    AData.TryGetValue('snippet.resourceId.kind', FKind);
    AData.TryGetValue('snippet.playlistId', FPlaylistId);
    AData.TryGetValue('snippet.channelId', FChannelId);
    FChannelTitle := '';
    AData.TryGetValue('snippet.title', FTitle);
    AData.TryGetValue('snippet.publishedAt', PublishedAt);
    FPublishedTimeText := Copy(PublishedAt, 1, 10) + ' ' + Copy(PublishedAt, 12, 8);
    FQueueId := '';
    FStatus := 0;
end;

constructor TVideo.Create(AId, AKind, APlaylistId, AChannelId,AChannelTitle, ATitle, APublishedTimeText, AQueueId: String; AStatus: Integer);
begin
    FId := AId;
    FKind := AKind;
    FPlaylistId := APlaylistId;
    FChannelId := AChannelId;
    FChannelTitle := AChannelTitle;
    FTitle := ATitle;
    FPublishedTimeText := APublishedTimeText;
    FQueueId := AQueueId;
    FStatus := AStatus;
end;

end.
