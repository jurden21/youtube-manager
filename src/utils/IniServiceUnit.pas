unit IniServiceUnit;

interface

uses
    System.IniFiles, System.SysUtils;

type
    TIniService = class
    public
        class var IniFileName: String;
        class function GetIniFileName: String;
    public
        class function ReadDate(const ASection, AIdent: String; const ADefault: TDate): TDate;
        class function ReadDateTime(const ASection, AIdent: String; const ADefault: TDateTime): TDateTime;
        class function ReadInteger(const ASection, AIdent: String; const ADefault: Integer): Integer;
        class function ReadString(const ASection, AIdent, ADefault: String): String;
        class procedure WriteDate(const ASection, AIdent: String; const AValue: TDate);
        class procedure WriteDateTime(const ASection, AIdent: String; const AValue: TDateTime);
        class procedure WriteInteger(const ASection, AIdent: String; const AValue: Integer);
        class procedure WriteString(const ASection, AIdent, AValue: String);
    end;

implementation

{ TIniService }

class function TIniService.GetIniFileName: String;
begin
    if IniFileName <> ''
    then Result := IniFileName
    else Result := ChangeFileExt(ParamStr(0), '.ini');
end;

class function TIniService.ReadDate(const ASection, AIdent: String; const ADefault: TDate): TDate;
var
    IniFile: TIniFile;
begin
    IniFile := TIniFile.Create(GetIniFileName);
    try
        Result := IniFile.ReadDate(ASection, AIdent, ADefault);
    finally
        IniFile.Free;
    end;
end;

class function TIniService.ReadDateTime(const ASection, AIdent: String; const ADefault: TDateTime): TDateTime;
var
    IniFile: TIniFile;
begin
    IniFile := TIniFile.Create(GetIniFileName);
    try
        Result := IniFile.ReadDateTime(ASection, AIdent, ADefault);
    finally
        IniFile.Free;
    end;
end;

class function TIniService.ReadInteger(const ASection, AIdent: String; const ADefault: Integer): Integer;
var
    IniFile: TIniFile;
begin
    IniFile := TIniFile.Create(GetIniFileName);
    try
        Result := IniFile.ReadInteger(ASection, AIdent, ADefault);
    finally
        IniFile.Free;
    end;
end;

class function TIniService.ReadString(const ASection, AIdent, ADefault: String): String;
var
    IniFile: TIniFile;
begin
    IniFile := TIniFile.Create(GetIniFileName);
    try
        Result := IniFile.ReadString(ASection, AIdent, ADefault);
    finally
        IniFile.Free;
    end;
end;

class procedure TIniService.WriteDate(const ASection, AIdent: String; const AValue: TDate);
var
    IniFile: TIniFile;
begin
    IniFile := TIniFile.Create(GetIniFileName);
    try
        IniFile.WriteDate(ASection, AIdent, AValue);
    finally
        IniFile.Free;
    end;
end;

class procedure TIniService.WriteDateTime(const ASection, AIdent: String; const AValue: TDateTime);
var
    IniFile: TIniFile;
begin
    IniFile := TIniFile.Create(GetIniFileName);
    try

        IniFile.WriteDateTime(ASection, AIdent, AValue);

    finally
        IniFile.Free;
    end;
end;

class procedure TIniService.WriteInteger(const ASection, AIdent: String; const AValue: Integer);
var
    IniFile: TIniFile;
begin
    IniFile := TIniFile.Create(GetIniFileName);
    try
        IniFile.WriteInteger(ASection, AIdent, AValue);
    finally
        IniFile.Free;
    end;
end;

class procedure TIniService.WriteString(const ASection, AIdent, AValue: String);
var
    IniFile: TIniFile;
begin
    IniFile := TIniFile.Create(GetIniFileName);
    try
        IniFile.WriteString(ASection, AIdent, AValue);
    finally
        IniFile.Free;
    end;
end;

end.
