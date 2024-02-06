unit Client;

interface

uses
  DataModule, Vcl.Dialogs, System.SysUtils;

type
  TClient = class
  private

  public
    procedure LoadData();
    procedure DataInsert();
  end;

implementation

procedure TClient.LoadData();
begin
  DataModule.DM.FDQuery_Client.SQL.Text := 'SELECT * FROM Client';
  DataModule.DM.FDQuery_Client.Open();
end;

procedure TClient.DataInsert();
var
  query: string;
  i, lastId: integer;
begin
  try
    lastId := DataModule.DM.LastRegister('Client');
    for i := lastId + 1 to lastId + 5 do
    begin
      query := Format('INSERT INTO Client (name, cpf) VALUES (''Cliente %d'', ''%.11d'')', [i, i]);
      DataModule.DM.FDConnection.ExecSQL(query);
    end;
    DataModule.DM.FDConnection.Commit();
    DataModule.DM.FDQuery_Client.Refresh();
    ShowMessage('Clientes inseridos com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao inserir clientes: ' + E.Message);
  end;
end;

end.
