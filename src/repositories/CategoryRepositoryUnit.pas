unit CategoryRepositoryUnit;

interface

uses
    System.SysUtils, System.Generics.Collections, System.UITypes,
    FireDAC.Comp.Client,
    CategoryUnit;

type
    TCategoryRepository = class
    public
        class function FindAll: TObjectList<TCategory>;
        class function FindNotEmpty: TObjectList<TCategory>;
        class function FindById(AId: String): TCategory;
    end;

implementation

{ TCategoryRepository }

uses
    DataConfigUnit;

class function TCategoryRepository.FindAll: TObjectList<TCategory>;
var
    Connection: TFDConnection;
    Query: TFDQuery;
    SqlText: String;
begin

    Connection := TDataConfig.Connection;
    Query := TFDQuery.Create(nil);
    Query.Connection := Connection;

    Result := TObjectList<TCategory>.Create;

    try

        Connection.Open;

        SqlText :=
            'select ' +
            '    c.id, c.title, ' +
            '    (select count(1) from sources s, videos v where c.id = s.category_id and s.id = v.playlist_id and v.status < 1) unread, ' +
            '    (select count(1) from sources s, videos v where c.id = s.category_id and s.id = v.playlist_id and v.status < 2) total ' +
            'from categories c';
        Query.Open(SqlText);

        while not Query.Eof do
        begin
            Result.Add(
                TCategory.Create(
                    Query.FieldByName('id').AsString,
                    Query.FieldByName('title').AsString,
                    Query.FieldByName('unread').AsInteger,
                    Query.FieldByName('total').AsInteger));
            Query.Next;
        end;

        Connection.Close;

    finally
        Query.Free;
        Connection.Free;
    end;

end;

class function TCategoryRepository.FindNotEmpty: TObjectList<TCategory>;
var
    Connection: TFDConnection;
    Query: TFDQuery;
    SqlText: String;
begin

    Connection := TDataConfig.Connection;
    Query := TFDQuery.Create(nil);
    Query.Connection := Connection;

    Result := TObjectList<TCategory>.Create;

    try

        Connection.Open;

        SqlText :=
            'select ' +
            '    c.id, c.title, ' +
            '    (select count(1) from sources s, videos v where c.id = s.category_id and s.id = v.playlist_id and v.status < 1) unread, ' +
            '    (select count(1) from sources s, videos v where c.id = s.category_id and s.id = v.playlist_id and v.status < 2) total ' +
            'from categories c';
        Query.Open(SqlText);

        while not Query.Eof do
        begin
            if Query.FieldByName('total').AsInteger > 0
            then begin
                Result.Add(
                    TCategory.Create(
                        Query.FieldByName('id').AsString,
                        Query.FieldByName('title').AsString,
                        Query.FieldByName('unread').AsInteger,
                        Query.FieldByName('total').AsInteger));
            end;
            Query.Next;
        end;

        Connection.Close;

    finally
        Query.Free;
        Connection.Free;
    end;

end;

class function TCategoryRepository.FindById(AId: String): TCategory;
var
    Connection: TFDConnection;
    Query: TFDQuery;
    SqlText: String;
begin

    Connection := TDataConfig.Connection;
    Query := TFDQuery.Create(nil);
    Query.Connection := Connection;

    Result := nil;

    try

        Connection.Open;
        SqlText :=
            'select ' +
            '    c.id, c.title, ' +
            '    (select count(1) from sources s, videos v where c.id = s.category_id and s.id = v.playlist_id and v.status < 1) unread, ' +
            '    (select count(1) from sources s, videos v where c.id = s.category_id and s.id = v.playlist_id and v.status < 2) total ' +
            'from categories c ' +
            'where c.id = {id}';
        SqlText := SqlText.Replace('{id}', QuotedStr(AId));

        Query.Open(SqlText);

        while not Query.Eof do
        begin
            Result :=
                TCategory.Create(
                    Query.FieldByName('id').AsString,
                    Query.FieldByName('title').AsString,
                    Query.FieldByName('unread').AsInteger,
                    Query.FieldByName('total').AsInteger);
            Break;
        end;

        Connection.Close;

    finally
        Query.Free;
        Connection.Free;
    end;

end;

end.
