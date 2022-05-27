unit SourceUnit;

interface

uses
    System.Json, System.SysUtils;

type
    TSource = class
    private
        FId: String;
        FKind: String;
        FTitle: String;
        FChannelId: String;
        FChannelTitle: String;
        FChannelCustomUrl: String;
        FLink: String;
        FCategoryId: String;
    public
        property Id: String read FId;
        property Kind: String read FKind;
        property Title: String read FTitle;
        property ChannelId: String read FChannelId;
        property ChannelTitle: String read FChannelTitle;
        property ChannelCustomUrl: String read FChannelCustomUrl;
        property Link: String read FLink;
        property CategoryId: String read FCategoryId;
        constructor Create(AId, AKind, ATitle, AChannelId, AChannelTitle, AChannelCustomUrl, ALink, ACategoryId: String);
    end;

implementation

{ TSource }

constructor TSource.Create(AId, AKind, ATitle, AChannelId, AChannelTitle, AChannelCustomUrl, ALink, ACategoryId: String);
begin
    FId := AId;
    FKind := AKind;
    FTitle := ATitle;
    FChannelId := AChannelId;
    FChannelTitle := AChannelTitle;
    FChannelCustomUrl := AChannelCustomUrl;
    FLink := ALink;
    FCategoryId := ACategoryId;
end;

end.
