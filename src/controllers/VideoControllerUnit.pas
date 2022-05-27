unit VideoControllerUnit;

interface

uses
    System.SysUtils, System.Generics.Collections, VideoUnit;

type
    TVideoController = class
    public
        class procedure Mark(AId: String);
        class procedure Delete(AId: String);
        class function GetVideosByPlaylist(APlaylistId: String): TObjectList<TVideo>;
        class function GetVideosByQueue(AQueueId: String): TObjectList<TVideo>;
        class function GetUnviewedVideosByQueue(AQueueId: String): TObjectList<TVideo>;
        class function GetUnreadNumberByPlaylist(PlaylistId: String): Integer;
        class function GetTotalNumberByPlaylist(PlaylistId: String): Integer;
    end;

implementation

{ TVideoController }

uses
    VideoRepositoryUnit, ApiServiceUnit;

class procedure TVideoController.Mark(AId: String);
begin
    TVideoRepository.MarkById(AId);
end;

class procedure TVideoController.Delete(AId: String);
begin
    TVideoRepository.DeleteById(AId);
end;

class function TVideoController.GetVideosByPlaylist(APlaylistId: String): TObjectList<TVideo>;
begin
    if APlaylistId = ''
    then raise Exception.Create('PlaylistId should have value');
    Result := TVideoRepository.FindByPlaylistId(APlaylistId);
end;

class function TVideoController.GetVideosByQueue(AQueueId: String): TObjectList<TVideo>;
begin
    if AQueueId = ''
    then Result := TVideoRepository.FindAll
    else Result := TVideoRepository.FindByQueueId(AQueueId);
end;

class function TVideoController.GetUnviewedVideosByQueue(AQueueId: String): TObjectList<TVideo>;
begin
    if AQueueId = ''
    then Result := TVideoRepository.FindActive
    else Result := TVideoRepository.FindActiveByQueueId(AQueueId);
end;

class function TVideoController.GetUnreadNumberByPlaylist(PlaylistId: String): Integer;
begin
    Result := TVideoRepository.GetUnreadNumberByPlaylistId(PlaylistId);
end;

class function TVideoController.GetTotalNumberByPlaylist(PlaylistId: String): Integer;
begin
    Result := TVideoRepository.GetTotalNumberByPlaylistId(PlaylistId);
end;

end.
