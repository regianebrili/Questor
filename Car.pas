unit Car;

interface

uses
  DataModule, Vcl.Dialogs, System.SysUtils, System.Classes;

type
  TCar = class
  private
    function CreateListModels(): TStringList;
  public
    procedure LoadData();
    procedure DataInsert();
  end;

implementation

procedure TCar.LoadData();
begin
  DataModule.DM.FDQuery_Car.SQL.Text := 'SELECT * FROM Car';
  DataModule.DM.FDQuery_Car.Open();
end;

procedure TCar.DataInsert();
var
  query: string;
  i, lastId: integer;
  launchDate: TDateTime;
  models: TStringList;
begin
  try
    try
      Randomize;
      models := CreateListModels();
      lastId := DataModule.DM.LastRegister('Car');
      for i := 0 to 4 do
      begin
        launchDate := EncodeDate(2021, 1, 1) + Random(730);  // 2021 e 2022
        query := Format('INSERT INTO Car (model, launch_date) VALUES (''%s'', ''%s'')', [models[i], FormatDateTime('yyyy-mm-dd', launchDate)]);
        DataModule.DM.FDConnection.ExecSQL(query);
      end;
      DataModule.DM.FDConnection.Commit();
      DataModule.DM.FDQuery_Car.Refresh();
      ShowMessage('Carros inseridos com sucesso!');
    except
      on E: Exception do
        ShowMessage('Erro ao inserir carros: ' + E.Message);
    end;
  finally
    models.Free();
  end;
end;

function TCar.CreateListModels(): TStringList;
  var
    models: TStringList;
  begin
    try
      models := TStringList.Create();
      models.Add('Marea');
      models.Add('Uno');
      models.Add('Gol');
      models.Add('Celta');
      models.Add('Palio');

      Result := models;
    except
      on E: Exception do
        ShowMessage('Erro ao inserir carros: ' + E.Message);
    end;

  end;

end.
