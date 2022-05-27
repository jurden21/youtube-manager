unit ApiServiceUnit;

interface

uses
    System.Classes, System.SysUtils, System.Json, System.Generics.Collections;

type
    TApiService = class
    public
        class function AddChannel(AId, ALink, ACategoryId: String): String;
        class function AddChannelByUser(AUser, ALink, ACategoryId: String): String;
        class procedure AddVideosBySource(ASourceId: String);
        class function GetChannelByCustomUrl(ACustomUrl: String): String;
    end;

implementation

uses
    HttpClientUnit, ChannelUnit, ChannelRepositoryUnit, ApiRequestUnit, VideoUnit, VideoRepositoryUnit,
    SourceRepositoryUnit, SourceUnit;

{ TApiService }

class function TApiService.AddChannel(AId, ALink, ACategoryId: String): String;
var
    Response: String;
    JsonObject: TJSONObject;
    Channel: TChannel;
begin

    Result := '';

    JsonObject := nil;
    Channel := nil;

    try
        Response := THttpClient.Get(TApiRequest.ChannelsList(AId, ''));
        JsonObject := TJsonObject.ParseJSONValue(Response, False, True) as TJSONObject;
        Channel := TChannel.Create((JsonObject.Values['items'] as TJSONArray).Items[0] as TJSONObject, ALink, ACategoryId);
        Result := Channel.PlaylistId;
        TChannelRepository.Save(Channel);
    finally
        Channel.Free;
        JsonObject.Free;
    end;

end;

class function TApiService.AddChannelByUser(AUser, ALink, ACategoryId: String): String;
var
    Response: String;
    JsonObject: TJSONObject;
    Channel: TChannel;
begin

    Result := '';

    JsonObject := nil;
    Channel := nil;

    try
        Response := THttpClient.Get(TApiRequest.ChannelsList('', AUser));
        JsonObject := TJsonObject.ParseJSONValue(Response, False, True) as TJSONObject;
        Channel := TChannel.Create((JsonObject.Values['items'] as TJSONArray).Items[0] as TJSONObject, ALink, ACategoryId);
        Result := Channel.PlaylistId;
        TChannelRepository.Save(Channel);
    finally
        Channel.Free;
        JsonObject.Free;
    end;

end;

class procedure TApiService.AddVideosBySource(ASourceId: String);
var
    Source: TSource;
    Response: String;
    JsonObject: TJSONObject;
    JsonArray: TJSONArray;
    PageToken: String;
    Index: Integer;
    Video: TVideo;
begin

    JsonObject := nil;
    PageToken := '';
    Source := TSourceRepository.FindById(ASourceId);

    try

        repeat

            try
                Response := THttpClient.Get(TApiRequest.PlaylistItemsList(Source.Id, PageToken));
                JsonObject := TJsonObject.ParseJSONValue(Response, False, True) as TJSONObject;
                if not JsonObject.TryGetValue('nextPageToken', PageToken)
                then PageToken := '';
                JsonArray := JsonObject.Values['items'] as TJSONArray;
                for Index := 0 to JsonArray.Count - 1 do
                begin
                    Video := TVideo.Create(JsonArray.Items[Index] as TJSONObject);
                    TVideoRepository.Save(Video);
                    Video.Free;
                end;
            finally
                JsonObject.Free;
            end;

        until PageToken = '';

    finally
        Source.Free;
    end;

end;

class function TApiService.GetChannelByCustomUrl(ACustomUrl: String): String;
var
    Response: String;
    JsonObject: TJSONObject;
    JsonArray: TJSONArray;
begin

    Result := '';

    JsonObject := nil;

    try
        Response := THttpClient.Get(TApiRequest.SearchList('channel', ACustomUrl));
        JsonObject := TJsonObject.ParseJSONValue(Response, False, True) as TJSONObject;
        JsonArray := JsonObject.Values['items'] as TJSONArray;
        if JsonArray.Count > 0
        then JsonArray.Items[0].TryGetValue('id.channelId', Result)
        else raise Exception.Create('Can''t find channel');
    finally
        JsonObject.Free
    end;

end;

end.
