unit PPContainers;

interface

uses
  Classes;

type
  TCustomList = class
  private
    procedure FreeListItems;
    function GetCount: Integer;
  protected
    FList: TList;
  public
    property Count: Integer read GetCount;

    constructor Create;
    destructor Destroy; override;
    procedure Clear(AFreeItems: Boolean = False);
    function Add(AObject: TObject): Integer;
    procedure Copy(ATargetList: TCustomList);
  end;

implementation

{TCustomList}
constructor TCustomList.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TCustomList.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

function TCustomList.GetCount: Integer;
begin
  Result := FList.Count;
end;

procedure TCustomList.FreeListItems;
var
  I: Integer;
  Obj: TObject;
begin
  for I := FList.Count - 1 downto 0 do
  begin
    Obj := TObject(FList.Items[I]);
    FList.Remove(FList.Items[I]);
    Obj.Free;
  end;
end;

procedure TCustomList.Clear(AFreeItems: Boolean = False);
begin
  if AFreeItems then
    FreeListItems;

  FList.Clear;
end;

function TCustomList.Add(AObject: TObject): Integer;
begin
  Result := -1;
  if FList.IndexOf(AObject) = -1 then
    Result := FList.Add(AObject);
end;

procedure TCustomList.Copy(ATargetList: TCustomList);
var
  I: Integer;
begin
  ATargetList.Clear;
  for I := 0 to FList.Count - 1 do
  begin
    ATargetList.Add(TObject(FList.Items[I]));
  end;
end;

end.
