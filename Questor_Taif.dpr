program Questor_Taif;

uses
  Vcl.Forms,
  TaifSales in 'TaifSales.pas' {FQuestor},
  DataModule in 'DataModule.pas' {DM: TDataModule},
  Client in 'Client.pas',
  Car in 'Car.pas',
  Sale in 'Sale.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFQuestor, FQuestor);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
