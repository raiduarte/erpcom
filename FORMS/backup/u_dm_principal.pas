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
  Classes, SysUtils, db, ZConnection, ZDataset;

type

  { Tdm_principal }

  Tdm_principal = class(TDataModule)
    sqlClientesatendenteID: TLongintField;
    sqlClientesbairro: TStringField;
    sqlClientescelular: TStringField;
    sqlClientescep: TStringField;
    sqlClientesclienteID: TLongintField;
    sqlClientescomplemento: TStringField;
    sqlClientescpf: TStringField;
    sqlClientesdatahora_registro: TDateTimeField;
    sqlClientesdata_nascimento: TDateField;
    sqlClientesemail: TStringField;
    sqlClientesendereco: TStringField;
    sqlClientesfoto: TBlobField;
    sqlClientesidade: TLongintField;
    sqlClientesmunicipio: TStringField;
    sqlClientesnome: TStringField;
    sqlClientesnumero: TLongintField;
    sqlClientesresponsavel: TStringField;
    sqlClientesresponsavel_cpf: TStringField;
    sqlClientesresponsavel_titulo: TStringField;
    sqlClientessexo: TStringField;
    sqlClientestelfixo: TStringField;
    sqlClientesuf: TStringField;
    sqlProgramas: TZQuery;
    sqlPermissoes: TZQuery;
    ZConnection1: TZConnection;
    sqlUsuarios: TZQuery;
  private

  public

  end;

var
  dm_principal: Tdm_principal;

implementation

{$R *.lfm}

end.

