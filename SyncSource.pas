unit SyncSource;

interface

implementation

type
  TSyncSource = class
  private
    FBOF: Boolean;
    FEOF: Boolean;
    
  public
    property BOF: Boolean read FBOF write FBOF;
    //procedure First;
    //procedure Next;
    //procedure Last;
  end;



end.
