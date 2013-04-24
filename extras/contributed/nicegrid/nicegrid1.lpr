program nicegrid1;

{$mode objfpc}
{$h+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils,
  fpg_base, fpg_main, fpg_form,
  main1;


procedure MainProc;
var
  frm: TfrmMain;
begin
  fpgApplication.Initialize;
  frm := TfrmMain.Create(nil);
  try
    frm.Show;
    fpgApplication.Run;
  finally
    frm.Free;
  end;
end;

begin
  MainProc;
end.

