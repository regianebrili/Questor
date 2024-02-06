object DM: TDM
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 640
  object MySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Questor\libmySQL.dll'
    Left = 56
    Top = 32
  end
  object FDConnection: TFDConnection
    ConnectionName = 'Questor_Taif'
    Params.Strings = (
      'Database=taif_company'
      'User_Name=root'
      'Password=15200601'
      'Server=localhost'
      'DriverID=MySQL')
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshMode]
    Left = 192
    Top = 32
  end
  object FDQuery_Client: TFDQuery
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshMode]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.RefreshMode = rmAll
    SQL.Strings = (
      '')
    Left = 56
    Top = 104
  end
  object DS_Client: TDataSource
    DataSet = FDQuery_Client
    Left = 192
    Top = 104
  end
  object FDQuery_Car: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      '')
    Left = 56
    Top = 176
  end
  object DS_Car: TDataSource
    DataSet = FDQuery_Car
    Left = 192
    Top = 176
  end
  object FDQuery_Sale: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      '')
    Left = 56
    Top = 256
  end
  object DS_Sale: TDataSource
    DataSet = FDQuery_Sale
    Left = 192
    Top = 256
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 304
    Top = 104
  end
end
