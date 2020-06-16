{
  /////////// /////////// ///////////  /////////// ///////////   ///
         ///  ///         ///     ///  ///     ///        ///  /////
        ///   ///         ///    ///   ///     ///       ///     ///
       ///    /////////   ///   ///    ///     ///     ///       ///
      ///     ///         /// ////     ///     ///   ///         ///
     ///      ///         ///   ///    ///     ///  ///          ///
    ///       ///         ///    ///   ///     ///  ///          ///
  /////////// /////////// ////     /// ///////////  ///////////  ///

  by Zero21
}



program Lazaro;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, runtimetypeinfocontrols, tachartlazaruspkg, memdslaz,
  zcomponent, uPrincipal, rxnew, uFrameInicio, u_dm_principal, UDF, uframemenu,
  u_dm_painel_de_controle, uFramePrincipal, uFrameLogin,
  { you can add units after this }
  SysUtils, Math, Controls, uFramePainelDeControle,
  uframepaineldecontroleusuarios, ualertamodal, uframepaineldecontroleprogramas,
  uFramePaineDeControleLogsDeEventos, uShowSplash, uPainelDeControleProgramasSelecionaIcone;

{$R *.res}

var
  v, b: String;
begin

  v:=GetVersionInfo('V');
  b:=GetVersionInfo('B');

  RequireDerivedFormResource:=True;
  Application.Title:='Lazaro FX';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.

