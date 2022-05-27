unit CategoryUnit;

interface

type
    TCategory = class
    private
        FId: String;
        FTitle: String;
        FUnread: Integer;
        FTotal: Integer;
    public
        property Id: String read FId;
        property Title: String read FTitle;
        property Unread: Integer read FUnread;
        property Total: Integer read FTotal;
        constructor Create(AId, ATitle: String; AUnread, ATotal: Integer);
    end;


implementation

{ TCategory }

constructor TCategory.Create(AId, ATitle: String; AUnread, ATotal: Integer);
begin
    FId := AId;
    FTitle := ATitle;
    FUnread := AUnread;
    FTotal := ATotal;
end;

end.
