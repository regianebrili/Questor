unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Dialogs;

type
  TDM = class(TDataModule)
    MySQLDriverLink: TFDPhysMySQLDriverLink;
    FDConnection: TFDConnection;
    FDQuery_Client: TFDQuery;
    DS_Client: TDataSource;
    FDQuery_Car: TFDQuery;
    DS_Car: TDataSource;
    FDQuery_Sale: TFDQuery;
    DS_Sale: TDataSource;
    FDQuery: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetConnectionData();
    function LastRegister(table: string): Integer;
  end;

var
  DM: TDM;
  hostName, database, userName, password: string;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Client, Car, Sale;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  MySQLDriverLink.VendorLib := 'C:\Questor\libmySQL.dll';
  GetConnectionData();
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  FDConnection.Connected := False;
end;

function ReadConfig: TStringList;
var
  filePath: string;
  configFile: TStringList;
begin
  Result := TStringList.Create();
  try
    filePath := 'C:\Questor\config.txt';
    if FileExists(filePath) then
    begin
      configFile := TStringList.Create();
      try
        configFile.LoadFromFile(filePath);
        Result.Assign(ConfigFile);
      finally
        configFile.Free();
      end;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao acessar o arquivo: ' + E.Message);
  end;
end;

procedure TDM.GetConnectionData;
var
  connectionData: TStringList;
  key, value: string;
begin
  connectionData := ReadConfig;
  try
    for var I := 0 to connectionData.Count - 1 do
    begin
      if Pos('=', connectionData[I]) > 0 then
      begin
        key := Trim(Copy(connectionData[I], 1, Pos('=', connectionData[I]) - 1));
        value := Trim(Copy(connectionData[I], Pos('=', connectionData[I]) + 1, Length(connectionData[I])));
        FDConnection.Params.Values[key] := value;
      end;
    end;
  finally
    connectionData.Free();
  end;
end;

function TDM.LastRegister(table: string): Integer;
var
  query: string;
begin
  Result := 0;
  query := Format('SELECT id FROM %s ORDER BY id DESC LIMIT 1', [table]);
  try
    FDQuery.SQL.Text := query;
    FDQuery.Open;
    if not FDQuery.IsEmpty then
      Result := FDQuery.Fields[0].AsInteger
  except
    on E: Exception do
      ShowMessage('Erro ao obter o id do último registro da tabela: ' + E.Message);
  end;
end;

end.
