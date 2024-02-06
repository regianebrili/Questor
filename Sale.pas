unit Sale;

interface

uses
  DataModule, Vcl.Dialogs, System.SysUtils,
  System.Generics.Collections, System.Classes,
  FireDAC.Stan.Param;

type
  TSale = class
  private
    function LoadClients(): TList<Integer>;
    function LoadCars(): TList<Integer>;
  public
    procedure LoadData();
    procedure RandomDataInsertion();
    procedure DataInsertion();
    procedure DeleteLosers();
    function MareaSales(): Integer;
    function ClientsWithoutPurchasing(): Integer;
    function TotalSalesbyClient(): TStringList;
    function Draw(): TStringList;
  end;

implementation

procedure TSale.LoadData();
begin
  DataModule.DM.FDQuery_Sale.SQL.Text :=
    'SELECT client.id AS Client, client.name, car.model, sale.sale_date, sale.id AS SaleId FROM sale JOIN car ON sale.car_id = car.id JOIN client ON sale.client_id = client.id';
  DataModule.DM.FDQuery_Sale.Open();
end;

procedure TSale.RandomDataInsertion();
var
  query: string;
  i, clientSelected, carSelected: integer;
  clients, cars: TList<Integer>;
  saleDate: TDateTime;
begin
  try
    Randomize;
    clients := LoadClients();
    cars := LoadCars();
    for i := 1 to 5 do
    begin
      saleDate := EncodeDate(2021, 1, 1) + Random(730);
      clientSelected := Random(clients.Count);
      carSelected := Random(cars.Count);
      query := Format('INSERT INTO Sale (client_id, car_id, sale_date) VALUES (''%d'', ''%d'', ''%s'')',
                        [clients[clientSelected], cars[carSelected], FormatDateTime('yyyy-mm-dd', saleDate)]);
      DataModule.DM.FDConnection.ExecSQL(query);
    end;
    DataModule.DM.FDConnection.Commit();
    DataModule.DM.FDQuery_Sale.Refresh();
    ShowMessage('Vendas inseridas com sucesso!');

  except
    on E: Exception do
      ShowMessage('Erro ao inserir vendas: ' + E.Message);
  end;
end;

procedure TSale.DataInsertion();
var
  query: string;
  i, firstIdClient, firstIdCar: integer;
  saleDate: TDateTime;
begin
  try
    Randomize;
    firstIdClient := DataModule.DM.LastRegister('Client') - 5;
    firstIdCar := DataModule.DM.LastRegister('Car') - 5;
    for I := 1 to 5 do
    begin
      saleDate := EncodeDate(2021, 1, 1) + Random(730);
      query := Format('INSERT INTO Sale (client_id, car_id, sale_date) VALUES (''%d'', ''%d'', ''%s'')',
                        [firstIdClient + I, firstIdCar + I, FormatDateTime('yyyy-mm-dd', saleDate)]);
      DataModule.DM.FDConnection.ExecSQL(query);
    end;

    DataModule.DM.FDQuery_Sale.Refresh();
    ShowMessage('Vendas inseridas com sucesso!');

  except
    on E: Exception do
      ShowMessage('Erro ao inserir vendas: ' + E.Message);
  end;
end;

function TSale.LoadClients(): TList<Integer>;
var
  clientsList: TList<Integer>;
begin
  clientsList := TList<Integer>.Create();
  try
    DataModule.DM.FDQuery.SQL.Text := 'SELECT id FROM client';
    DataModule.DM.FDQuery.Open;

    while not DataModule.DM.FDQuery.Eof do
    begin
      clientsList.Add(DataModule.DM.FDQuery.FieldByName('id').AsInteger);
      DataModule.DM.FDQuery.Next;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao criar lista de clientes: ' + E.Message);
  end;
  Result := clientsList;
end;

function TSale.LoadCars(): TList<Integer>;
var
  carsList: TList<Integer>;
begin
  carsList := TList<Integer>.Create();
  try
    DataModule.DM.FDQuery.SQL.Text := 'SELECT id FROM Car';
    DataModule.DM.FDQuery.Open;

    while not DataModule.DM.FDQuery.Eof do
    begin
      carsList.Add(DataModule.DM.FDQuery.FieldByName('id').AsInteger);
      DataModule.DM.FDQuery.Next;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao criar lista de carros: ' + E.Message);
  end;
  Result := carsList;
end;

function TSale.MareaSales(): Integer;
begin
  Result := 0;
  try
    DataModule.DM.FDQuery.SQL.Text := 'SELECT count(*) AS TotalSales FROM sale JOIN car ON car.id = sale.car_id WHERE car.model = :Car';
    DataModule.DM.FDQuery.ParamByName('Car').AsString := 'Marea';
    DataModule.DM.FDQuery.Open();

    Result := DataModule.DM.FDQuery.FieldByName('TotalSales').AsInteger;
  except
    on E: Exception do
      ShowMessage('Erro ao calcular total de vendas: ' + E.Message);
  end;
end;

function TSale.ClientsWithoutPurchasing(): Integer;
begin
  Result := 0;
  try
    DataModule.DM.FDQuery.SQL.Text := 'SELECT COUNT(*) AS ClientsWithoutPurchasing FROM client WHERE id NOT IN (SELECT DISTINCT client_id FROM sale)';
    DataModule.DM.FDQuery.Open();

    Result := DataModule.DM.FDQuery.FieldByName('ClientsWithoutPurchasing').AsInteger;
  except
    on E: Exception do
      ShowMessage('Erro ao calcular total de clientes sem compra: ' + E.Message);
  end;
end;

function TSale.TotalSalesbyClient(): TStringList;
var
  clients: TStringList;
begin
  clients := TStringList.Create();
  try
    DataModule.DM.FDQuery.SQL.Text := 'SELECT client.name Client, COUNT(*) TotalSales FROM client JOIN sale ON client.id = sale.client_id JOIN car ON car.id = sale.car_id WHERE car.model = "Uno" GROUP BY client.name';
    DataModule.DM.FDQuery.Open();
    DataModule.DM.FDQuery.First();

    while not DataModule.DM.FDQuery.Eof do
    begin
      clients.Add(DataModule.DM.FDQuery.FieldByName('Client').AsString + ' = ' +
                  DataModule.DM.FDQuery.FieldByName('TotalSales').AsString + ' unidade(s)');
      DataModule.DM.FDQuery.Next();
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao obter lista de vendas do Uno por cliente: ' + E.Message);
  end;
  Result := clients;
end;

function TSale.Draw(): TStringList;
var
  winners: TStringList;
begin
  winners := TStringList.Create();
  try
    DataModule.DM.FDQuery.SQL.Text :=
      'SELECT DISTINCT ClientId, Name, Cpf FROM (' +
      ' SELECT client.id ClientId, client.name Name, client.cpf Cpf' +
      ' FROM sale' +
      ' JOIN client ON sale.client_id = client.id' +
      ' JOIN car ON sale.car_id = car.id' +
      ' WHERE launch_date >= "2021-01-01"' +
      ' AND launch_date < "2022-01-01"' +
      ' AND LEFT(client.cpf, 1) = "0"' +
      ' AND client.id NOT IN (' +
      '   SELECT client_id' +
      '   FROM sale' +
      '		JOIN car ON sale.car_id = car.id' +
      '		WHERE car.model = "Marea"' +
      '		GROUP BY client_id, car.model' +
      '		HAVING count(*) > 1' +
      '		)' +
      '	  ORDER BY sale_date' +
      '   LIMIT 15' +
      ' ) winners';

    DataModule.DM.FDQuery.Open();
    DataModule.DM.FDQuery.First();

    while not DataModule.DM.FDQuery.Eof do
    begin
      winners.Add(DataModule.DM.FDQuery.FieldByName('ClientId').AsString + ' - ' +
                  DataModule.DM.FDQuery.FieldByName('Name').AsString + ' - ' +
                  DataModule.DM.FDQuery.FieldByName('Cpf').AsString);
      DataModule.DM.FDQuery.Next();
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao obter lista de vendas do Uno por cliente: ' + E.Message);
  end;

  Result := winners;
end;

procedure TSale.DeleteLosers();
var
  winners: TStringList;
  losers: TStringList;
  i: Integer;
  query: string;
  isWinner: boolean;
begin
  winners := Draw();
  LoadData();
  losers := TStringList.Create();

  while not DataModule.DM.FDQuery_Sale.Eof do
  begin
    isWinner := false;
    var cliente := DataModule.DM.FDQuery_Sale.FieldByName('Client').AsString;

    for i := 0 to winners.Count - 1 do
    begin
      if DataModule.DM.FDQuery_Sale.FieldByName('Client').AsString = Trim(Copy(winners[i], 1, Pos('-', winners[i]) - 1)) then
        isWinner := true;
    end;

    if not isWinner then
      losers.Add(DataModule.DM.FDQuery_Sale.FieldByName('SaleId').AsString);
    DataModule.DM.FDQuery_Sale.Next();
  end;

  for i := 0 to losers.Count -1 do
    begin
      query := Format('DELETE FROM Sale WHERE id = %d', [StrToInt(losers[i])]);
      DataModule.DM.FDConnection.ExecSQL(query);
    end;
end;


end.
