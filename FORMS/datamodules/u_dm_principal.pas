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



unit u_dm_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, u_dm_painel_de_controle, UDF, db, ZConnection, ZDataset;

type

  { Tdm_principal }

  Tdm_principal = class(TDataModule)
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  dm_principal: Tdm_principal;

implementation

{$R *.lfm}

{ Tdm_principal }

procedure Tdm_principal.DataModuleCreate(Sender: TObject);
begin
  CONEXAO:=ZConnection1;

  // instancia o dm_painel_de_controle
  dm_painel_de_controle:=Tdm_painel_de_controle.Create(Self);
end;

end.

