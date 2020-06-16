program Layout;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, runtimetypeinfocontrols, tachartlazaruspkg, zcomponent,
  uPrincipal, rxnew, uFrameInicio, uFrameClientes, uFrameClientesDados,
  u_dm_principal, UDF_VARS
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.

