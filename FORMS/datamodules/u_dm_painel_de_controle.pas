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



unit u_dm_painel_de_controle;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, memds, ZConnection, ZDataset, ZSqlUpdate;

type

  { Tdm_painel_de_controle }

  Tdm_painel_de_controle = class(TDataModule)
    dtsAcessos: TDataSource;
    dtsProgsUsuario: TDataSource;
    dtsIcones: TDataSource;
    dtsProgramas: TDataSource;
    dtsPermissoes: TDataSource;
    dtsProgrsDisponiveis: TDataSource;
    dtsUsuarios: TDataSource;
    dtsLogin: TDataSource;
    sqlAcessosposicao: TLongintField;
    sqlIconesicone: TBlobField;
    sqlIconesicone2: TBlobField;
    sqlIconesiconeID: TLongintField;
    sqlLoginnome: TStringField;
    sqlLoginsenha: TStringField;
    sqlLoginsituacao: TSmallintField;
    sqlLoginsuperusuario: TSmallintField;
    sqlLoginusuario: TStringField;
    sqlLoginusuarioID: TLongintField;
    sqlAcessosFORMULARIO: TStringField;
    sqlAcessosICONE: TBlobField;
    sqlAcessospermissaoID: TLongintField;
    sqlAcessospode_adicionar: TSmallintField;
    sqlAcessospode_alterar: TSmallintField;
    sqlAcessospode_excluir: TSmallintField;
    sqlAcessospode_imprimir: TSmallintField;
    sqlAcessospode_ler: TSmallintField;
    sqlAcessosPROGRAMA: TStringField;
    sqlAcessosprogramaID: TLongintField;
    sqlAcessossituacao: TSmallintField;
    sqlAcessosusuarioID: TLongintField;
    sqlOcupacaoocupacao: TStringField;
    sqlOcupacaoocupacaoID: TLongintField;
    sqlPermissoes: TZQuery;
    sqlPermissoesFORMULARIO: TStringField;
    sqlPermissoesICONE: TBlobField;
    sqlPermissoespermissaoID: TLongintField;
    sqlPermissoespode_adicionar: TSmallintField;
    sqlPermissoespode_alterar: TSmallintField;
    sqlPermissoespode_excluir: TSmallintField;
    sqlPermissoespode_imprimir: TSmallintField;
    sqlPermissoespode_ler: TSmallintField;
    sqlPermissoesprogramaID: TLongintField;
    sqlPermissoessituacao: TSmallintField;
    sqlPermissoesusuarioID: TLongintField;
    sqlProgramas: TZQuery;
    sqlProgramasformulario: TStringField;
    sqlProgramashint: TStringField;
    sqlProgramasicone: TBlobField;
    sqlProgramasprograma: TStringField;
    sqlProgramasprogramaID: TLongintField;
    sqlProgramassistema: TSmallintField;
    sqlProgrsDisponiveis: TZQuery;
    sqlProgrsDisponiveisformulario: TStringField;
    sqlProgrsDisponiveishint: TStringField;
    sqlProgrsDisponiveisicone: TBlobField;
    sqlProgrsDisponiveisprograma: TStringField;
    sqlProgrsDisponiveisprogramaID: TLongintField;
    sqlProgrsDisponiveissistema: TSmallintField;
    sqlProgsUsuario: TZQuery;
    sqlProgsUsuariopermissaoID: TLongintField;
    sqlProgsUsuariopode_adicionar: TSmallintField;
    sqlProgsUsuariopode_alterar: TSmallintField;
    sqlProgsUsuariopode_excluir: TSmallintField;
    sqlProgsUsuariopode_imprimir: TSmallintField;
    sqlProgsUsuariopode_ler: TSmallintField;
    sqlProgsUsuarioposicao: TLongintField;
    sqlProgsUsuarioPROGRAMA: TStringField;
    sqlProgsUsuarioprogramaID: TLongintField;
    sqlProgsUsuariosituacao: TSmallintField;
    sqlProgsUsuariousuarioID: TLongintField;
    sqlUsuarios: TZQuery;
    sqlLogin: TZQuery;
    sqlUsuariosnome: TStringField;
    sqlUsuariossenha: TStringField;
    sqlUsuariossituacao: TSmallintField;
    sqlUsuariossuperusuario: TSmallintField;
    sqlUsuariosusuario: TStringField;
    sqlUsuariosusuarioID: TLongintField;
    StringField1: TStringField;
    updUsuarios: TZUpdateSQL;
    sqlAcessos: TZQuery;
    sqlIcones: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public

  end;

var
  dm_painel_de_controle: Tdm_painel_de_controle;

var
  USUARIOS,
  PROGRAMAS,
  ICONES,
  ACESSOS,
  PERMISSOES_DE_USUARIO,
  PERMISSOES_DISPONIVEIS,
  LOGIN: TZQuery;

implementation

uses
  u_dm_principal;

var
  Posicao: TBookMark;

{$R *.lfm}

{ Tdm_painel_de_controle }

procedure Tdm_painel_de_controle.DataModuleCreate(Sender: TObject);
begin
  // atriibui os conecotres as variáveis
  USUARIOS                :=sqlUsuarios;
  PROGRAMAS               :=sqlProgramas;
  ICONES                  :=sqlIcones;
  ACESSOS                 :=sqlAcessos;
  PERMISSOES_DE_USUARIO   :=sqlProgsUsuario;
  PERMISSOES_DISPONIVEIS  :=sqlProgrsDisponiveis;
  LOGIN                   :=sqlLogin;
end;

procedure Tdm_painel_de_controle.DataModuleDestroy(Sender: TObject);
begin

end;

end.

