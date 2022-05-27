unit VideoRepositoryUnit;

interface

uses
    System.SysUtils, System.Generics.Collections, System.UITypes,
    FireDAC.Comp.Client,
    VideoUnit;

type
    TVideoRepository = class
    public
        class function Save(AVideo: TVideo): Integer;
        class procedure MarkById(AId: String);
        class procedure DeleteById(AId: String);
        class procedure DeleteByPlaylistId(APlaylistId: String);
        class function FindAll: TObjectList<TVideo>;
        class function FindActive: TObjectList<TVideo>;
        class function FindByPlaylistId(APlaylistId: String): TObjectList<TVideo>;
        class function FindByQueueId(AQueueId: String): TObjectList<TVideo>;
        class function FindActiveByQueueId(AQueueId: String): TObjectList<TVideo>;
        class function GetUnreadNumberByPlaylistId(APlaylistId: String): Integer;
        class function GetTotalNumberByPlaylistId(APlaylistId: String): Integer;
    end;

implementation

{ TVideoRepository }

uses
    DataConfigUnit;

class function TVideoRepository.Save(AVideo: TVideo): Integer;
var
    Connection: TFDConnection;
    SqlText: String;
begin

    Result := mrOk;

    Connection := TDataConfig.Connection;

    try

        try

            Connection.Open;

            SqlText := 'insert or ignore into videos (id, kind, playlist_id, channel_id, title, published_time, queue_id, status) ' +
                       'values ({id}, {kind}, {playlist_id}, {channel_id}, {title}, {published_time}, {queue_id}, {status})';
            SqlText := SqlText.Replace('{id}', QuotedStr(AVideo.Id))
                              .Replace('{kind}', QuotedStr(AVideo.Kind))
                              .Replace('{playlist_id}', QuotedStr(AVideo.PlaylistId))
                              .Replace('{channel_id}', QuotedStr(AVideo.ChannelId))
                              .Replace('{title}', QuotedStr(AVideo.Title.Replace('"', '')))
                              .Replace('{published_time}', QuotedStr(AVideo.PublishedTimeText))
                              .Replace('{queue_id}', QuotedStr(AVideo.QueueId))
                              .Replace('{status}', IntToStr(AVideo.Status));
            Connection.ExecSQL(SqlText);

            SqlText := 'update videos ' +
                       'set kind = {kind}, playlist_id = {playlist_id}, channel_id = {channel_id}, title = {title}, ' +
                       '    published_time = {published_time}' +
                       'where id = {id}';
            SqlText := SqlText.Replace('{id}', QuotedStr(AVideo.Id))
                              .Replace('{kind}', QuotedStr(AVideo.Kind))
                              .Replace('{playlist_id}', QuotedStr(AVideo.PlaylistId))
                              .Replace('{channel_id}', QuotedStr(AVideo.ChannelId))
                              .Replace('{title}', QuotedStr(AVideo.Title.Replace('"', '')))
                              .Replace('{published_time}', QuotedStr(AVideo.PublishedTimeText));
            Connection.ExecSQL(SqlText);

            Connection.Close;

        except
            on E: Exception do
                raise Exception.Create('TVideoRepository.Save'#13#10 + E.Message);
        end;

    finally
        Connection.Free;
    end;

end;

class procedure TVideoRepository.MarkById(AId: String);
var
    Connection: TFDConnection;
    SqlText: String;
begin

    Connection := TDataConfig.Connection;

    try

        try

            Connection.Open;

            SqlText := 'update videos set status = 1 - status where id = {id}';
            SqlText := SqlText.Replace('{id}', QuotedStr(AId));
            Connection.ExecSQL(SqlText);

            Connection.Close;

        except
            on E: Exception do
                raise Exception.Create('TVideoRepository.MarkById'#13#10 + E.Message);
        end;

    finally
        Connection.Free;
    end;

end;

class procedure TVideoRepository.DeleteById(AId: String);
var
    Connection: TFDConnection;
    SqlText: String;
begin

    Connection := TDataConfig.Connection;

    try

        try

            Connection.Open;

            SqlText := 'update videos set status = 2 where id = {id}';
            SqlText := SqlText.Replace('{id}', QuotedStr(AId));
            Connection.ExecSQL(SqlText);

            Connection.Close;

        except
            on E: Exception do
                raise Exception.Create('TVideoRepository.DeleteById'#13#10 + E.Message);
        end;

    finally
        Connection.Free;
    end;

end;

class procedure TVideoRepository.DeleteByPlaylistId(APlaylistId: String);
var
    Connection: TFDConnection;
    SqlText: String;
begin

    Connection := TDataConfig.Connection;

    try

        try

            Connection.Open;

            SqlText := 'update videos set status = 2 where playlist_id = {playlist_id}';
            SqlText := SqlText.Replace('{playlist_id}', QuotedStr(APlaylistId));
            Connection.ExecSQL(SqlText);

            Connection.Close;

        except
            on E: Exception do
                raise Exception.Create('TVideoRepository.DeleteByPlaylistId'#13#10 + E.Message);
        end;

    finally
        Connection.Free;
    end;

end;

class function TVideoRepository.FindAll: TObjectList<TVideo>;
var
    Connection: TFDConnection;
    Query: TFDQuery;
    SqlText: String;
begin

    Connection := TDataConfig.Connection;
    Query := TFDQuery.Create(nil);
    Query.Connection := Connection;

    Result := TObjectList<TVideo>.Create;

    try

        Connection.Open;

        SqlText :=
            'select v.*, s.channel_title ' +
            'from videos v ' +
            '     join sources s on (v.playlist_id = s.id) ' +
            'where v.status < 2 ' +
            'order by v.published_time';
        Query.Open(SqlText);

        while not Query.Eof do
        begin
            Result.Add(
                TVideo.Create(
                    Query.FieldByName('id').AsString,
                    Query.FieldByName('kind').AsString,
                    Query.FieldByName('playlist_id').AsString,
                    Query.FieldByName('channel_id').AsString,
                    Query.FieldByName('channel_title').AsString,
                    Query.FieldByName('title').AsString,
                    Query.FieldByName('published_time').AsString,
                    Query.FieldByName('queue_id').AsString,
                    Query.FieldByName('status').AsInteger));
            Query.Next;
        end;

        Connection.Close;

    finally
        Query.Free;
        Connection.Free;
    end;

end;

class function TVideoRepository.FindActive: TObjectList<TVideo>;
var
    Connection: TFDConnection;
    Query: TFDQuery;
    SqlText: String;
begin

    Connection := TDataConfig.Connection;
    Query := TFDQuery.Create(nil);
    Query.Connection := Connection;

    Result := TObjectList<TVideo>.Create;

    try

        Connection.Open;

        SqlText :=
            'select v.*, s.channel_title ' +
            'from videos v ' +
            '     join sources s on (v.playlist_id = s.id) ' +
            'where v.status < 1 ' +
            'order by v.published_time';
        Query.Open(SqlText);

        while not Query.Eof do
        begin
            Result.Add(
                TVideo.Create(
                    Query.FieldByName('id').AsString,
                    Query.FieldByName('kind').AsString,
                    Query.FieldByName('playlist_id').AsString,
                    Query.FieldByName('channel_id').AsString,
                    Query.FieldByName('channel_title').AsString,
                    Query.FieldByName('title').AsString,
                    Query.FieldByName('published_time').AsString,
                    Query.FieldByName('queue_id').AsString,
                    Query.FieldByName('status').AsInteger));
            Query.Next;
        end;

        Connection.Close;

    finally
        Query.Free;
        Connection.Free;
    end;

end;

class function TVideoRepository.FindByPlaylistId(APlaylistId: String): TObjectList<TVideo>;
var
    Connection: TFDConnection;
    Query: TFDQuery;
    SqlText: String;
begin

    Connection := TDataConfig.Connection;
    Query := TFDQuery.Create(nil);
    Query.Connection := Connection;

    Result := TObjectList<TVideo>.Create;

    try

        Connection.Open;

        SqlText :=
            'select v.*, s.channel_title ' +
            'from videos v ' +
            '     join sources s on (v.playlist_id = s.id) ' +
            'where v.status < 2  and v.playlist_id = {playlist_id}' +
            'order by v.published_time';
        SqlText := SqlText.Replace('{playlist_id}', QuotedStr(APlaylistId));
        Query.Open(SqlText);

        while not Query.Eof do
        begin
            Result.Add(
                TVideo.Create(
                    Query.FieldByName('id').AsString,
                    Query.FieldByName('kind').AsString,
                    Query.FieldByName('playlist_id').AsString,
                    Query.FieldByName('channel_id').AsString,
                    Query.FieldByName('channel_title').AsString,
                    Query.FieldByName('title').AsString,
                    Query.FieldByName('published_time').AsString,
                    Query.FieldByName('queue_id').AsString,
                    Query.FieldByName('status').AsInteger));
            Query.Next;
        end;

        Connection.Close;

    finally
        Query.Free;
        Connection.Free;
    end;

end;

class function TVideoRepository.FindByQueueId(AQueueId: String): TObjectList<TVideo>;
var
    Connection: TFDConnection;
    Query: TFDQuery;
    SqlText: String;
begin

    Connection := TDataConfig.Connection;
    Query := TFDQuery.Create(nil);
    Query.Connection := Connection;

    Result := TObjectList<TVideo>.Create;

    try

        Connection.Open;

        SqlText :=
            'select v.*, s.channel_title ' +
            'from videos v ' +
            '     join sources s on (v.playlist_id = s.id) ' +
            'where v.status < 2 and v.queue_id = {queue_id}' +
            'order by v.published_time';
        SqlText := SqlText.Replace('{queue_id}', QuotedStr(AQueueId));
        Query.Open(SqlText);

        while not Query.Eof do
        begin
            Result.Add(
                TVideo.Create(
                    Query.FieldByName('id').AsString,
                    Query.FieldByName('kind').AsString,
                    Query.FieldByName('playlist_id').AsString,
                    Query.FieldByName('channel_id').AsString,
                    Query.FieldByName('channel_title').AsString,
                    Query.FieldByName('title').AsString,
                    Query.FieldByName('published_time').AsString,
                    Query.FieldByName('queue_id').AsString,
                    Query.FieldByName('status').AsInteger));
            Query.Next;
        end;

        Connection.Close;

    finally
        Query.Free;
        Connection.Free;
    end;

end;

class function TVideoRepository.FindActiveByQueueId(AQueueId: String): TObjectList<TVideo>;
var
    Connection: TFDConnection;
    Query: TFDQuery;
    SqlText: String;
begin

    Connection := TDataConfig.Connection;
    Query := TFDQuery.Create(nil);
    Query.Connection := Connection;

    Result := TObjectList<TVideo>.Create;

    try

        Connection.Open;

        SqlText :=
            'select v.*, s.channel_title ' +
            'from videos v ' +
            '     join sources s on (v.playlist_id = s.id) ' +
            'where v.status < 1 ' +
            '  and s.category_id = {queue_id}';
        SqlText := SqlText.Replace('{queue_id}', QuotedStr(AQueueId));
        Query.Open(SqlText);

        while not Query.Eof do
        begin
            Result.Add(
                TVideo.Create(
                    Query.FieldByName('id').AsString,
                    Query.FieldByName('kind').AsString,
                    Query.FieldByName('playlist_id').AsString,
                    Query.FieldByName('channel_id').AsString,
                    Query.FieldByName('channel_title').AsString,
                    Query.FieldByName('title').AsString,
                    Query.FieldByName('published_time').AsString,
                    Query.FieldByName('queue_id').AsString,
                    Query.FieldByName('status').AsInteger));
            Query.Next;
        end;

        Connection.Close;

    finally
        Query.Free;
        Connection.Free;
    end;

end;

class function TVideoRepository.GetUnreadNumberByPlaylistId(APlaylistId: String): Integer;
var
    Connection: TFDConnection;
    Query: TFDQuery;
    SqlText: String;
begin

    Connection := TDataConfig.Connection;
    Query := TFDQuery.Create(nil);
    Query.Connection := Connection;

    Result := -1;

    try

        try

            Connection.Open;

            SqlText :=
                'select count(1) cnt from videos where status < 1 and playlist_id = {playlist_id}';
            SqlText := SqlText.Replace('{playlist_id}', QuotedStr(APlaylistId));
            Query.Open(SqlText);

            while not Query.Eof do
            begin
                Result := Query.FieldByName('cnt').AsInteger;
                Query.Next;
            end;

            Connection.Close;

        except
            on E: Exception do
                raise Exception.Create('TVideoRepository.GetUnreadNumberByPlaylistId'#13#10 + E.Message);
        end;

    finally
        Query.Free;
        Connection.Free;
    end;

end;

class function TVideoRepository.GetTotalNumberByPlaylistId(APlaylistId: String): Integer;
var
    Connection: TFDConnection;
    Query: TFDQuery;
    SqlText: String;
begin

    Connection := TDataConfig.Connection;
    Query := TFDQuery.Create(nil);
    Query.Connection := Connection;

    Result := -1;

    try

        try

            Connection.Open;

            SqlText :=
                'select count(1) cnt from videos where status < 2 and playlist_id = {playlist_id}';
            SqlText := SqlText.Replace('{playlist_id}', QuotedStr(APlaylistId));
            Query.Open(SqlText);

            while not Query.Eof do
            begin
                Result := Query.FieldByName('cnt').AsInteger;
                Query.Next;
            end;

            Connection.Close;

        except
            on E: Exception do
                raise Exception.Create('TVideoRepository.GetTotalNumberByPlaylistId'#13#10 + E.Message);
        end;

    finally
        Query.Free;
        Connection.Free;
    end;

end;

end.
