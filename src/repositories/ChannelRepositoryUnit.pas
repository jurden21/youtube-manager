unit ChannelRepositoryUnit;

interface

uses
    System.SysUtils, System.Generics.Collections, System.UITypes,
    FireDAC.Comp.Client,
    ChannelUnit;

type
    TChannelRepository = class
    private
        class function GetConnection: TFDConnection;
    public
        class function Save(AChannel: TChannel): Integer;
    end;

implementation

{ TChannelRepository }

class function TChannelRepository.GetConnection: TFDConnection;
begin
    Result := TFDConnection.Create(nil);
    Result.Params.Add('DriverID=SQLite');
    Result.Params.Add('Database=' + ChangeFileExt(ParamStr(0), '.db'));
end;

class function TChannelRepository.Save(AChannel: TChannel): Integer;
var
    Connection: TFDConnection;
    SqlText: String;
begin

    Result := mrOk;

    Connection := GetConnection;

    try

        try

            Connection.Open;

            SqlText := 'insert or ignore into sources (id, kind, title, channel_id, channel_title, channel_custom_url, link) ' +
                       'values ({id}, {kind}, {title}, {channel_id}, {channel_title}, {channel_custom_url}, {link})';
            SqlText := SqlText.Replace('{id}', QuotedStr(AChannel.PlaylistId))
                              .Replace('{kind}', QuotedStr(AChannel.Kind))
                              .Replace('{title}', QuotedStr(AChannel.Title))
                              .Replace('{channel_id}', QuotedStr(AChannel.Id))
                              .Replace('{channel_title}', QuotedStr(AChannel.Title))
                              .Replace('{channel_custom_url}', QuotedStr(AChannel.CustomUrl))
                              .Replace('{link}', QuotedStr(AChannel.Link));
            Connection.ExecSQL(SqlText);

            SqlText := 'update sources ' +
                       'set kind = {kind}, title = {title}, channel_id = {channel_id}, channel_title = {channel_title}, ' +
                       '    channel_custom_url = {channel_custom_url}, link = {link} ' +
                       'where id = {id}';
            SqlText := SqlText.Replace('{id}', QuotedStr(AChannel.PlaylistId))
                              .Replace('{kind}', QuotedStr(AChannel.Kind))
                              .Replace('{title}', QuotedStr(AChannel.Title))
                              .Replace('{channel_id}', QuotedStr(AChannel.Id))
                              .Replace('{channel_title}', QuotedStr(AChannel.Title))
                              .Replace('{channel_custom_url}', QuotedStr(AChannel.CustomUrl))
                              .Replace('{link}', QuotedStr(AChannel.Link));
            Connection.ExecSQL(SqlText);

            Connection.Close;

        except
            on E: Exception do
                raise Exception.Create('TChannelRepository.Save'#13#10 + E.Message);
        end;

    finally
        Connection.Free;
    end;

end;

end.
