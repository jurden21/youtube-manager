unit SourceControllerUnit;

interface

uses
    System.Generics.Collections, SourceUnit;

type
    TSourceController = class
    public
        class procedure AddVideos(ASourceId: String);
        class procedure Delete(ASourceId: String);
        class function FindAll: TObjectList<TSource>;
        class function FindById(AId: String): TSource;
    end;

implementation

uses
    SourceRepositoryUnit, ApiServiceUnit, VideoRepositoryUnit;

{ TSourceController }

class procedure TSourceController.AddVideos(ASourceId: String);
begin
    TApiService.AddVideosBySource(ASourceId);
end;

class procedure TSourceController.Delete(ASourceId: String);
begin
    TVideoRepository.DeleteByPlaylistId(ASourceId);
    TSourceRepository.Delete(ASourceId);
end;

class function TSourceController.FindAll: TObjectList<TSource>;
begin
    Result := TSourceRepository.FindAll;
end;

class function TSourceController.FindById(AId: String): TSource;
begin
    Result := TSourceRepository.FindById(AId);
end;

end.
