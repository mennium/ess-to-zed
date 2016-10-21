program EssToZed;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  SyncSource in 'SyncSource.pas',
  SyncDataUtils in 'SyncDataUtils.pas',
  PPContainers in 'PPContainers.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
