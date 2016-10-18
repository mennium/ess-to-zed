unit SyncDataUtils;

interface

uses
  Windows, Classes, SysUtils;

type

  ESyncFieldValueNullException = class(Exception);

  TSyncSourceFormat = (ssfFlatFile, ssfSQLServer, ssfOracle, ssfDB2);
  TSyncDataType = (sdtString, sdtInteger, sdtDateTime, sdtDouble);

  TSyncFieldDefs = class;

  TSyncFieldDef = class
  private
    FName: String;
    FDataType: TSyncDataType;
    FFieldDefs: TSyncFieldDefs;
  public
    property Name: String read FName write FName;
    property DataType: TSyncDataType read FDataType write FDataType;

    constructor Create(AFieldName: String; AFieldDefCollection: TSyncFieldDefs);
  end;

  TSyncFieldDefs = class
  end;

  TSyncField = class
  private
    FFieldDef: TSyncFieldDef;
    //FValue: array[..] of Char;
    FIsNull: Boolean;
    FData: Pointer;
  public
    property FieldDef: TSyncFieldDef read FFieldDef;

    constructor Create(AFieldDef: TSyncFieldDef);
    function AsInteger: Integer;
    function AsString: String;
    function AsDouble(Precision: Byte): Double;
    function AsDateTime(Format: String): TDateTime;
    procedure SetData(const Data);
  end;

implementation

{ TSyncFieldDef }

constructor TSyncFieldDef.Create(AFieldName: String;
  AFieldDefCollection: TSyncFieldDefs);
begin
  FName := AFieldName;
  FFieldDefs := FFieldDefs;

  inherited Create;
end;

{ TSyncField }

function TSyncField.AsDateTime(Format: String): TDateTime;
begin

end;

function TSyncField.AsDouble(Precision: Byte): Double;
begin

end;

function TSyncField.AsInteger: Integer;
begin

end;

function TSyncField.AsString: String;
begin
  if not Assigned(FData) then
    Result :=

  case FFieldDef.DataType of
    sdtInteger:
      begin
        New(PInteger(Ptr));
        Ptr := @Integer(Data);
      end;
    sdtDouble:
      begin
        New(PDouble(Ptr));
        Ptr := @Double(Data);
      end;
    sdtString:
      begin
        New(PChar(Ptr));
        Ptr := @String(Data);
      end;
    sdtDateTime:
      begin
        New(PDateTime(Ptr));
        Ptr := @TDateTime(Data);
      end;
  end;
end;

constructor TSyncField.Create(AFieldDef: TSyncFieldDef);
begin
  if Assigned(AFieldDef) then
    FFieldDef := AFieldDef;
  inherited Create;  
end;

procedure TSyncField.SetData(const Data);
var
  Ptr: Pointer;
begin
  case FFieldDef.DataType of
    sdtInteger:
      begin
        New(PInteger(Ptr));
        Ptr := @Integer(Data);
      end;
    sdtDouble:
      begin
        New(PDouble(Ptr));
        Ptr := @Double(Data);
      end;
    sdtString:
      begin
        New(PChar(Ptr));
        Ptr := @String(Data);
      end;
    sdtDateTime:
      begin
        New(PDateTime(Ptr));
        Ptr := @TDateTime(Data);
      end;
  end;

  if Assigned(FData) then
    Dispose(FData);
  FData := Ptr;  
end;


end.
 