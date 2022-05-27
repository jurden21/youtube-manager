unit DataConfigUnit;

interface

uses
    System.SysUtils, FireDAC.Comp.Client;

type
    TDataConfig = class
    public
        class function Connection: TFDConnection;
    end;

implementation

{ TDataConfig }

class function TDataConfig.Connection: TFDConnection;
begin
    Result := TFDConnection.Create(nil);
    Result.Params.Add('DriverID=SQLite');
    Result.Params.Add('Database=' + ChangeFileExt(ParamStr(0), '.db'));
end;

end.
