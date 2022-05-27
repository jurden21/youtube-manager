unit SourceRepositoryUnit;

interface

uses
    System.SysUtils, System.Generics.Collections, System.UITypes,
    FireDAC.Comp.Client,
    SourceUnit;

type
    TSourceRepository = class
    private
        class function GetConnection: TFDConnection;
    public
        class procedure Delete(APlaylistId: String);
        class function FindAll: TObjectList<TSource>;
        class function FindById(AId: String): TSource;
    end;

implementation

{ TSourceRepository }

class function TSourceRepository.GetConnection: TFDConnection;
begin
    Result := TFDConnection.Create(nil);
    Result.Params.Add('DriverID=SQLite');
    Result.Params.Add('Database=' + ChangeFileExt(ParamStr(0), '.db'));
end;

class procedure TSourceRepository.Delete(APlaylistId: String);
var
    Connection: TFDConnection;
    SqlText: String;
begin

    Connection := GetConnection;

    try

        try

            Connection.Open;

            SqlText := 'update sources set deleted = 1 where id = {id}';
            SqlText := SqlText.Replace('{id}', QuotedStr(APlaylistId));
            Connection.ExecSQL(SqlText);

            Connection.Close;

        except
            on E: Exception do
                raise Exception.Create('TSourceRepository.Delete'#13#10 + E.Message);
        end;

    finally
        Connection.Free;
    end;

end;

class function TSourceRepository.FindAll: TObjectList<TSource>;
var
    Connection: TFDConnection;
    Query: TFDQuery;
    SqlText: String;
begin

    Connection := GetConnection;
    Query := TFDQuery.Create(nil);
    Query.Connection := Connection;

    Result := TObjectList<TSource>.Create;

    try

        try

            Connection.Open;
            SqlText := 'select * from sources where deleted = 0 order by title';
            Query.Open(SqlText);

            while not Query.Eof do
            begin
                Result.Add(
                    TSource.Create(
                        Query.FieldByName('id').AsString,
                        Query.FieldByName('kind').AsString,
                        Query.FieldByName('title').AsString,
                        Query.FieldByName('channel_id').AsString,
                        Query.FieldByName('channel_title').AsString,
                        Query.FieldByName('channel_custom_url').AsString,
                        Query.FieldByName('link').AsString,
                        Query.FieldByName('category_id').AsString));
                Query.Next;
            end;

            Connection.Close;

        except
            on E: Exception do
                raise Exception.Create('TSourceRepository.FindAll'#13#10 + E.Message);

        end;

    finally
        Query.Free;
        Connection.Free;
    end;

end;

class function TSourceRepository.FindById(AId: String): TSource;
var
    Connection: TFDConnection;
    Query: TFDQuery;
    SqlText: String;
begin

    Connection := GetConnection;
    Query := TFDQuery.Create(nil);
    Query.Connection := Connection;

    Result := nil;

    try

        Connection.Open;
        SqlText := 'select * from sources where id = {id} order by title';
        SqlText := SqlText.Replace('{id}', QuotedStr(AId));

        Query.Open(SqlText);

        while not Query.Eof do
        begin
            Result :=
                TSource.Create(
                    Query.FieldByName('id').AsString,
                    Query.FieldByName('kind').AsString,
                    Query.FieldByName('title').AsString,
                    Query.FieldByName('channel_id').AsString,
                    Query.FieldByName('channel_title').AsString,
                    Query.FieldByName('channel_custom_url').AsString,
                    Query.FieldByName('link').AsString,
                    Query.FieldByName('category_id').AsString);
            Break;
        end;

        Connection.Close;

    finally
        Query.Free;
        Connection.Free;
    end;

end;

end.
