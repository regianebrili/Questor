unit TaifSales;

interface

uses
  Vcl.Forms, Data.DB, Vcl.Controls, Vcl.Grids, Vcl.DBGrids, System.Classes,
  Vcl.StdCtrls, Vcl.Dialogs, System.SysUtils, Vcl.ExtCtrls,
  DataModule, Client, Car, Sale;

type
  TFQuestor = class(TForm)
    BtRandomInput: TButton;
    PDada: TPanel;
    DBGrid_Clients: TDBGrid;
    LClients: TLabel;
    LCars: TLabel;
    DBGrid_Cars: TDBGrid;
    LSales: TLabel;
    DBGrid_Sales: TDBGrid;
    BtInput: TButton;
    BtMareaSales: TButton;
    BtDraw: TButton;
    BtUnoSales: TButton;
    BtWithoutPurchases: TButton;
    MWinners: TMemo;
    MUnoSales: TMemo;
    PDraw: TPanel;
    PSelects: TPanel;
    BtLosers: TButton;
    BtRandomSales: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure BtRandomInputClick(Sender: TObject);
    procedure BtInputClick(Sender: TObject);
    procedure BtMareaSalesClick(Sender: TObject);
    procedure BtWithoutPurchasesClick(Sender: TObject);
    procedure BtUnoSalesClick(Sender: TObject);
    procedure BtDrawClick(Sender: TObject);
    procedure BtLosersClick(Sender: TObject);
    procedure BtRandomSalesClick(Sender: TObject);
  private
    { Private declarations }
    procedure InserirDadosBD(Option: boolean = false);
    procedure ExecutarSql();
  public
    { Public declarations }
  end;

var
  FQuestor: TFQuestor;
  Client: TClient;
  Car: TCar;
  Sale: TSale;

implementation

{$R *.dfm}

procedure TFQuestor.FormActivate(Sender: TObject);
begin
  ExecutarSql();
end;

procedure TFQuestor.BtInputClick(Sender: TObject);
begin
  InserirDadosBD();
end;

procedure TFQuestor.BtLosersClick(Sender: TObject);
begin
  Sale.DeleteLosers();
  DataModule.DM.FDQuery_Sale.Refresh();
end;

procedure TFQuestor.BtRandomInputClick(Sender: TObject);
begin
  InserirDadosBD(true);
end;

procedure TFQuestor.BtRandomSalesClick(Sender: TObject);
begin
  Sale.RandomDataInsertion();
end;

procedure TFQuestor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DataModule.DM.FDConnection.Close();
end;

procedure TFQuestor.InserirDadosBD(Option: boolean = false);
begin
  Client.DataInsert();
  Car.DataInsert();
  if Option then
    Sale.RandomDataInsertion()
  else
    Sale.DataInsertion();
end;

procedure TFQuestor.BtDrawClick(Sender: TObject);
var
  winners: TStringList;
  i: Integer;
begin
  try
    winners := Sale.Draw();

    for i := 0 to winners.Count -1 do
      MWinners.Lines.Add(winners[i]);

    winners.Free();
    except
      on E: Exception do
        ShowMessage('Erro efetuar o sorteio: ' + E.Message);
  end;
end;

procedure TFQuestor.BtMareaSalesClick(Sender: TObject);
var
  mareaSales: Integer;
begin
  mareaSales := Sale.MareaSales();
  ShowMessage('Total de Vendas do carro Marea é de ' + mareaSales.ToString());
end;

procedure TFQuestor.BtUnoSalesClick(Sender: TObject);
var
  totalSalesbyClient: TStringList;
  i: Integer;
begin
  try
    MUnoSales.Lines.Clear();
    totalSalesbyClient := Sale.TotalSalesbyClient();

    for i := 0 to totalSalesbyClient.Count -1 do
      MUnoSales.Lines.Add(totalSalesbyClient[i]);

    totalSalesbyClient.Free();
    except
      on E: Exception do
        ShowMessage('Erro ao inserir carros: ' + E.Message);
  end;

end;

procedure TFQuestor.BtWithoutPurchasesClick(Sender: TObject);
var
  clientsWithoutPurchasing: Integer;
begin
  clientsWithoutPurchasing := Sale.ClientsWithoutPurchasing();
  ShowMessage('Total de Clientes que não compraram carros é de ' + clientsWithoutPurchasing.ToString());
end;

procedure TFQuestor.ExecutarSql();
begin
  Client.LoadData();
  Car.LoadData();
  Sale.LoadData();
end;

end.
