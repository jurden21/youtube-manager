unit HttpClientUnit;

interface

uses
    System.Classes, System.SysUtils, IdHTTP, IdSSLOpenSSL;

type
    THttpClient = class
    public
        class function Get(AUrl: String): String;
    end;

implementation

uses
    AppConfigUnit;

class function THttpClient.Get(AUrl: String): String;
var
    HttpClient: TIdHTTP;
    SSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    Stream: TStringStream;
begin

    HttpClient := TIdHTTP.Create(nil);
    SSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    HttpClient.IOHandler := SSLIOHandlerSocketOpenSSL;
    Stream := TStringStream.Create('', TEncoding.UTF8);

    try
        HttpClient.Request.Accept := 'application/json';
        HttpClient.Get(AUrl.Replace('{KEY}', TAppConfig.GetGoogleApiKey), Stream);
        Stream.Position := 0;
        Result := Stream.DataString;
    finally
        Stream.Free;
        SSLIOHandlerSocketOpenSSL.Free;
        HttpClient.Free;
    end;

end;

end.
