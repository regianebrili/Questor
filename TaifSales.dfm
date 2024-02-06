object FQuestor: TFQuestor
  Left = 0
  Top = 0
  Caption = 'Avalia'#231#227'o T'#233'cnica - Questor'
  ClientHeight = 614
  ClientWidth = 940
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnActivate = FormActivate
  OnClose = FormClose
  TextHeight = 15
  object PDada: TPanel
    Left = 8
    Top = 8
    Width = 593
    Height = 598
    TabOrder = 0
    object LClients: TLabel
      Left = 24
      Top = 65
      Width = 36
      Height = 15
      Caption = 'Clients'
    end
    object LCars: TLabel
      Left = 24
      Top = 334
      Width = 23
      Height = 15
      Caption = 'Cars'
    end
    object LSales: TLabel
      Left = 314
      Top = 65
      Width = 26
      Height = 15
      Caption = 'Sales'
    end
    object DBGrid_Clients: TDBGrid
      AlignWithMargins = True
      Left = 16
      Top = 92
      Width = 273
      Height = 229
      DataSource = DM.DS_Client
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'id'
          Title.Caption = 'Id'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = 'Name'
          Width = 100
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'cpf'
          Title.Caption = 'CPF'
          Width = 100
          Visible = True
        end>
    end
    object DBGrid_Cars: TDBGrid
      Left = 16
      Top = 360
      Width = 273
      Height = 217
      DataSource = DM.DS_Car
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Title.Caption = 'Id'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'model'
          Title.Caption = 'Model'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'launch_date'
          Title.Caption = 'Launch Date'
          Width = 100
          Visible = True
        end>
    end
    object DBGrid_Sales: TDBGrid
      Left = 306
      Top = 87
      Width = 265
      Height = 490
      DataSource = DM.DS_Sale
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = 'Client'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'model'
          Title.Caption = 'Car'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sale_date'
          Title.Caption = 'Sale Date'
          Width = 80
          Visible = True
        end>
    end
    object BtInput: TButton
      Left = 16
      Top = 16
      Width = 145
      Height = 25
      Caption = 'Inserir Dados'
      TabOrder = 3
      OnClick = BtInputClick
    end
    object BtRandomInput: TButton
      Left = 218
      Top = 16
      Width = 145
      Height = 25
      Caption = 'Inserir Dados Aleat'#243'rios'
      TabOrder = 4
      OnClick = BtRandomInputClick
    end
    object BtRandomSales: TButton
      Left = 426
      Top = 16
      Width = 145
      Height = 25
      Caption = 'Inserir Vendas Aleat'#243'rias'
      TabOrder = 5
      OnClick = BtRandomSalesClick
    end
  end
  object PDraw: TPanel
    Left = 616
    Top = 8
    Width = 313
    Height = 349
    TabOrder = 1
    object BtDraw: TButton
      Left = 8
      Top = 16
      Width = 289
      Height = 25
      Caption = 'Sortear Vencedores'
      TabOrder = 0
      OnClick = BtDrawClick
    end
    object MWinners: TMemo
      Left = 8
      Top = 47
      Width = 289
      Height = 259
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object BtLosers: TButton
      Left = 8
      Top = 312
      Width = 289
      Height = 25
      Caption = 'Apagar Perdedores'
      TabOrder = 2
      OnClick = BtLosersClick
    end
  end
  object PSelects: TPanel
    Left = 616
    Top = 363
    Width = 313
    Height = 243
    TabOrder = 2
    object BtMareaSales: TButton
      Left = 8
      Top = 10
      Width = 289
      Height = 25
      Caption = 'Quantidade de Vendas do Carro Marea'
      TabOrder = 0
      OnClick = BtMareaSalesClick
    end
    object BtUnoSales: TButton
      Left = 8
      Top = 41
      Width = 289
      Height = 25
      Caption = 'Quantidade de Vendas do Carro Uno por Cliente'
      TabOrder = 1
      OnClick = BtUnoSalesClick
    end
    object BtWithoutPurchases: TButton
      Left = 8
      Top = 207
      Width = 289
      Height = 25
      Caption = 'Quantidade de Clientes que n'#227'o efetuaram compra'
      TabOrder = 2
      OnClick = BtWithoutPurchasesClick
    end
    object MUnoSales: TMemo
      Left = 8
      Top = 72
      Width = 289
      Height = 129
      ScrollBars = ssVertical
      TabOrder = 3
    end
  end
end
