unit ChannelUnit;

interface

uses
    System.Json, System.SysUtils;

type
    TChannel = class
    private
        FId: String;
        FKind: String;
        FTitle: String;
        FPlaylistId: String;
        FCustomUrl: String;
        FLink: String;
        FCategoryId: String;
    public
        property Id: String read FId;
        property Kind: String read FKind;
        property Title: String read FTitle;
        property PlaylistId: String read FPlaylistId;
        property CustomUrl: String read FCustomUrl;
        property Link: String read FLink;
        property CategoryId: String read FCategoryId;
        constructor Create(AData: TJSONObject; ALink, ACategoryId: String);
    end;

implementation

{ TChannel }

{ https://developers.google.com/youtube/v3/docs/channels#resource-representation }

constructor TChannel.Create(AData: TJSONObject; ALink, ACategoryId: String);
begin
    AData.TryGetValue('id', FId);
    AData.TryGetValue('kind', FKind);
    AData.TryGetValue('snippet.title', FTitle);
    AData.TryGetValue('contentDetails.relatedPlaylists.uploads', FPlaylistId);
    AData.TryGetValue('snippet.customUrl', FCustomUrl);
    FLink := ALink;
    FCategoryId := ACategoryId;
end;

end.
