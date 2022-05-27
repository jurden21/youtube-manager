unit RegistryServiceUnit;

interface

uses
    System.Classes, System.SysUtils, System.Win.Registry, Winapi.Windows;

type
    TRegistryService = class
    public
        class function ReadInteger(const AKey, AName: String; const ADefault: Integer): Integer;
        class function ReadString(const AKey, AName, ADefault: String): String;
        class procedure WriteInteger(const AKey, AName: String; const AValue: Integer);
        class procedure WriteString(const AKey, AName: String; const AValue: String);
    end;

implementation

class function TRegistryService.ReadInteger(const AKey, AName: String; const ADefault: Integer): Integer;
var
    Registry: TRegistry;
begin
    Result := ADefault;
    Registry := TRegistry.Create;
    try
        Registry.RootKey := HKEY_CURRENT_USER;
        Registry.OpenKey(AKey, True);
        if Registry.ValueExists(AName)
        then Result := Registry.ReadInteger(AName);
    finally
        Registry.Free;
    end;
end;

class function TRegistryService.ReadString(const AKey, AName, ADefault: String): String;
var
    Registry: TRegistry;
begin
    Result := ADefault;
    Registry := TRegistry.Create;
    try
        Registry.RootKey := HKEY_CURRENT_USER;
        Registry.OpenKey(AKey, True);
        if Registry.ValueExists(AName)
        then Result := Registry.ReadString(AName);
    finally
        Registry.Free;
    end;
end;

class procedure TRegistryService.WriteInteger(const AKey, AName: String; const AValue: Integer);
var
    Registry: TRegistry;
begin
    Registry := TRegistry.Create;
    try
        Registry.RootKey := HKEY_CURRENT_USER;
        Registry.OpenKey(AKey, True);
        Registry.WriteInteger(AName, AValue);
    finally
        Registry.Free;
    end;
end;

class procedure TRegistryService.WriteString(const AKey, AName: String; const AValue: String);
var
    Registry: TRegistry;
begin
    Registry := TRegistry.Create;
    try
        Registry.RootKey := HKEY_CURRENT_USER;
        Registry.OpenKey(AKey, True);
        Registry.WriteString(AName, AValue);
    finally
        Registry.Free;
    end;
end;

end.
