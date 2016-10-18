unit SyncDataUtils;

interface

type
  TSourceFormat = (sfFlatFile, sfSQLServer, sfOracle, sfDB2);
  TDataType = (dtInteger, dtString, dtDateTime, dtDouble);

  TDataField = class
  private
    FName: String;
    FDataType: TDataType;
  public
    property Name: String read FName write FName;
    property DataType: TDataType read FType write FType;

    function AsInteger: Integer;
    function AsString: String;
    function AsDouble: Double;
    function AsDateTime: DateTime;
  end;

implementation


end.
 