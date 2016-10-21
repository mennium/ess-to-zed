unit SyncDataUtils;

interface

uses
  Windows, Classes, SysUtils, PPContainers;

type

  ESyncFieldValueNullException = class(Exception);

  TSyncSourceFormat = (ssfFlatFile, ssfActiveDirectory, ssfSQLServer, ssfOracle, ssfDB2, ssfSybase, ssfMySQL);
  TSyncFieldType = (sftString, sftBoolean, sftTinyInt, sftSmallInt, sftInteger, sftBigInt,
                    sftDateTime, sftDate, sftTime, sftTinyDecimal, sftSmallDecimal, sftDecimal,
                    sftBigDecimal);

  TSyncFieldDefs = class;

  TSyncFieldDef = class
  private
    FName: String;
    FFieldType: TSyncFieldType;
    FFieldDefs: TSyncFieldDefs;
  public
    property Name: String read FName write FName;
    property FieldType: TSyncFieldType read FFieldType write FFieldType;

    constructor Create(AFieldName: String; AFieldDefCollection: TSyncFieldDefs);
  end;

  TSyncFieldDefs = class(TCustomList)
  private
    function GetItem(I: Integer): TSyncFieldDef;
  public
    property Items[Index: Integer]: TSyncFieldDef read GetItem;

    function Add(ASyncFieldDef: TSyncFieldDef): Integer;
    function FieldDefByName(AFieldName: String): TSyncFieldDef;
  end;

  TSyncField = class
  private
    FFieldDef: TSyncFieldDef;
    FIsNull: Boolean;
  public
    property FieldDef: TSyncFieldDef read FFieldDef;

    constructor Create(AFieldDef: TSyncFieldDef);
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

{ TSyncFieldDefs }

function TSyncFieldDefs.GetItem(I: Integer): TSyncFieldDef;
begin
  Result := TSyncFieldDef(FList.Items[I]);
end;

function TSyncFieldDefs.Add(ASyncFieldDef: TSyncFieldDef): Integer;
begin
  Result := -1;

  if FList.IndexOf(ASyncFieldDef) = -1 then
  begin
    Result := FList.Add(ASyncFieldDef);
  end;
end;

function TSyncFieldDefs.FieldDefByName(AFieldName: String): TSyncFieldDef;
var
  I: Integer;
  FieldDef: TSyncFieldDef;
begin
  Result := nil;

  for I := 0 to FList.Count - 1 do
  begin
    FieldDef := TSyncFieldDef(FList.Items[I]);

    if UpperCase(FieldDef.Name) = UpperCase(AFieldName) then
    begin
      Result := FieldDef;
      Break;
    end;
  end;
end;

{ TSyncField }

constructor TSyncField.Create(AFieldDef: TSyncFieldDef);
begin
  if Assigned(AFieldDef) then
    FFieldDef := AFieldDef;
  inherited Create;
end;

end.
 