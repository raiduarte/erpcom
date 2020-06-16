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



unit uframepaineldecontroleusuarios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, BufDataset, Forms, Controls, ExtCtrls, Buttons,
  StdCtrls, DBCtrls, CheckLst, u_dm_painel_de_controle, UDF, LCLType,
  Graphics, DBGrids, StrUtils, ZDataset, Dialogs, ComCtrls;

type

  { TFramePainelDeControleUsuarios }

  TFramePainelDeControleUsuarios = class(TFrame)
    btnAddPrograma: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnDelPrograma: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnVoltar: TSpeedButton;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    dtsProgsUsuario: TDataSource;
    dtsProgsDisp: TDataSource;
    DBText1: TDBText;
    dtsUsuarios: TDataSource;
    edtConfirmarSenha: TEdit;
    edtNome: TDBEdit;
    edtSenha: TEdit;
    edtUsuario: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblStatusBar: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel11: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    ScrollBox1: TScrollBox;
    Shape1: TShape;
    Shape2: TShape;
    slqInsUsuarionome: TStringField;
    slqInsUsuariosenha: TStringField;
    slqInsUsuariousuario: TStringField;
    sqlInsUsuarionome: TStringField;
    sqlInsUsuarioocupacaoID: TLongintField;
    sqlInsUsuariosenha: TStringField;
    sqlInsUsuariosuperusuario: TBooleanField;
    sqlInsUsuariousuario: TStringField;
    sqlProgsAttrpermissaoID: TLongintField;
    sqlProgsAttrpode_adicionar: TSmallintField;
    sqlProgsAttrpode_alterar: TSmallintField;
    sqlProgsAttrpode_excluir: TSmallintField;
    sqlProgsAttrpode_imprimir: TSmallintField;
    sqlProgsAttrpode_ler: TSmallintField;
    sqlProgsAttrposicao: TLongintField;
    sqlProgsAttrPROGRAMA: TStringField;
    sqlProgsAttrprogramaID: TLongintField;
    sqlProgsAttrsituacao: TSmallintField;
    sqlProgsAttrusuarioID: TLongintField;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure AtualizaGridEsquerdo(sListaIDs: String);
    function AtualizaListaDeIDs(const usuarioID: Integer): String;
    procedure AdicionarPermissao(const usuarioID, programaID: Integer);
    procedure dtsProgsDispDataChange(Sender: TObject; Field: TField);
    procedure dtsProgsUsuarioDataChange(Sender: TObject; Field: TField);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure RemoverPermissao(const permissaoID: Integer);
    procedure btnDelProgramaClick(Sender: TObject);
    procedure btnAddProgramaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure dtsUsuariosDataChange(Sender: TObject; Field: TField);
    procedure dtsUsuariosStateChange(Sender: TObject);
    procedure edtNomeEnter(Sender: TObject);
    procedure edtSenhaChange(Sender: TObject);
  private
    vParentPanel: TPanel;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.lfm}

{ TFramePainelDeControleUsuarios }

procedure TFramePainelDeControleUsuarios.btnVoltarClick(Sender: TObject);
begin
  if(dtsUsuarios.DataSet.State in [dsEdit, dsInsert])then
    if(AlertaModal('Existem informações que ainda não foram salvas.'+#13+'Continuar assim mesmo?', MB_ICONQUESTION+MB_YESNO)=IDYES)then begin
      dtsUsuarios.DataSet.Cancel;
      FreeAndNil(vParentPanel)
    end
  else
    FreeAndNil(vParentPanel);
end;

procedure TFramePainelDeControleUsuarios.dtsUsuariosDataChange(Sender: TObject;
  Field: TField);
var
  SuperUsuario: Boolean;
begin
  SuperUsuario:=(dtsUsuarios.DataSet.FieldByName('superusuario').AsBoolean);
  Label2.Enabled:=not SuperUsuario OR (dtsUsuarios.DataSet.State=dsInsert);
  edtNome.Enabled:=not SuperUsuario OR (dtsUsuarios.DataSet.State=dsInsert);
  Label3.Enabled:=not SuperUsuario OR (dtsUsuarios.DataSet.State=dsInsert);
  edtUsuario.Enabled:=not SuperUsuario OR (dtsUsuarios.DataSet.State=dsInsert);
end;

procedure TFramePainelDeControleUsuarios.dtsUsuariosStateChange(Sender: TObject);
begin
  ConfiguraButtons(dtsUsuarios.DataSet, [btnSalvar, btnCancelar, btnExcluir], []);
end;

procedure TFramePainelDeControleUsuarios.edtNomeEnter(Sender: TObject);
begin
  DestacaCampo(Sender);
end;

procedure TFramePainelDeControleUsuarios.edtSenhaChange(Sender: TObject);
begin
//  if(dtsUsuarios.DataSet.State=dsBrowse)then
//    if(((edtSenha.Text<>EmptyStr) and (edtConfirmarSenha.Text<>EmptyStr)) and (edtSenha.Text=edtConfirmarSenha.Text))then begin
    if(edtSenha.Text=edtConfirmarSenha.Text)then begin
      if(dtsUsuarios.DataSet.State=dsBrowse)then
        dtsUsuarios.DataSet.Edit;
    end
end;


constructor TFramePainelDeControleUsuarios.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  vParentPanel:=(AOwner as TPanel);
  lblStatusBar.Caption:=EmptyStr;
end;

destructor TFramePainelDeControleUsuarios.Destroy;
begin
  inherited Destroy;

  PROGS_USUARIO.Close;
  PROGS_DISPONIVEIS.Close;
end;

procedure TFramePainelDeControleUsuarios.btnSalvarClick(Sender: TObject);
var
  estadoBD: TDataSetState;
begin
  estadoBD:=dtsUsuarios.DataSet.State;
  if(estadoBD=dsEdit)then begin
    dtsUsuarios.DataSet.FieldByName('senha').AsString:=GeraSHA2(CONEXAO, edtConfirmarSenha.Text);
    if(SalvarAlteracoes(dtsUsuarios.DataSet)=true)then begin
//      dtsProgsUsuario.DataSet.Refresh;
//      btnVoltarClick(Sender);
      AlertaModal('Informações atualizadas com sucesso', MB_ICONINFORMATION);
    end;
  end
  else if(estadoBD=dsInsert)then begin
    dtsUsuarios.DataSet.FieldByName('usuarioID').AsInteger:=GeraUltimaID('sis_usuarios', 'usuarioID');
    dtsUsuarios.DataSet.FieldByName('senha').AsString:=GeraSHA2(CONEXAO, edtConfirmarSenha.Text);
    if(SalvarAlteracoes(dtsUsuarios.DataSet))then begin
//      btnVoltarClick(Sender);
      AlertaModal('A nova conta de usuário está configurada e pronta para uso', MB_ICONINFORMATION);
    end;
  end;
end;

procedure TFramePainelDeControleUsuarios.btnCancelarClick(Sender: TObject);
var
  estadoDB: TDataSetState;
begin
  estadoDB:=dtsUsuarios.DataSet.State;
  if(AlertaModal('Cancelar as alterações das informações realizadas atualmente?', MB_ICONQUESTION+MB_YESNO)=IDYES)then
    dtsUsuarios.DataSet.Cancel;

  if(estadoDB=dsInsert)then
    btnVoltarClick(Sender);
end;

procedure TFramePainelDeControleUsuarios.AtualizaGridEsquerdo(sListaIDs: String);
var
  sql: String;
begin
  sql:='SELECT * FROM sis_programas WHERE programaID NOT IN ('+sListaIDs+')';
  PROGS_DISPONIVEIS.Close;
  PROGS_DISPONIVEIS.SQL.Clear;
  PROGS_DISPONIVEIS.SQL.Add(sql);
  PROGS_DISPONIVEIS.Open;
end;

function TFramePainelDeControleUsuarios.AtualizaListaDeIDs(const
  usuarioID: Integer): String;
var
  dataset: TZQuery;
  sql, lista: String;
begin
  sql:='SELECT * FROM sis_permissoes WHERE usuarioID = :usuarioID;';
  dataset:=TZQuery.Create(Self);
  dataset.Connection:=CONEXAO;
  dataset.SQL.Clear;
  dataset.SQL.Add(sql);
  dataset.ParamByName('usuarioID').AsInteger:=usuarioID;
  dataset.Open;
  dataset.First;
  if(dataset.RecordCount>1)then begin
    while not(dataset.EOF)do begin
      lista:=dataset.FieldByName('programaID').AsString+Ifthen(dataset.RecordCount>1, ','+lista);
      dataset.Next;
    end;
    if(Length(lista)>=1)then
      lista:=Copy(lista, 0, Length(lista)-1);
  end
  else
    lista:='1';
  dataset.Close;
  dataset.Free;
  Result:=lista;
end;

procedure TFramePainelDeControleUsuarios.AdicionarPermissao(const usuarioID,
  programaID: Integer);
var
  dataset: TZQuery;
  sql: String;
begin
  sql:='INSERT INTO sis_permissoes (usuarioID, programaID) VALUES (:usuarioID, :programaID);';
  dataset:=TZQuery.Create(Self);
  dataset.Connection:=CONEXAO;
  dataset.SQL.Clear;
  dataset.SQL.Add(sql);
  dataset.ParamByName('usuarioID').AsInteger:=usuarioID;
  dataset.ParamByName('programaID').AsInteger:=programaID;
  dataset.ExecSQL;
  DBGrid1.DataSource.DataSet.Refresh;
  dataset.Close;
  dataset.Free;

  AtualizaGridEsquerdo(AtualizaListaDeIDs(usuarioID));

  DBGrid1.DataSource.DataSet.Refresh;
  DBGrid2.DataSource.DataSet.Refresh;
end;

procedure TFramePainelDeControleUsuarios.dtsProgsDispDataChange(
  Sender: TObject; Field: TField);
begin
  btnAddPrograma.Enabled:=(dtsProgsDisp.DataSet.RecordCount>0) and
    (dtsUsuarios.DataSet.FieldByName('superusuario').AsBoolean=false)
end;

procedure TFramePainelDeControleUsuarios.dtsProgsUsuarioDataChange(
  Sender: TObject; Field: TField);
begin
  btnDelPrograma.Enabled:=(dtsProgsUsuario.DataSet.RecordCount>0) and
    (dtsUsuarios.DataSet.FieldByName('superusuario').AsBoolean=false) and
      (dtsProgsUsuario.DataSet.FieldByName('programaID').AsInteger<>1);
end;

procedure TFramePainelDeControleUsuarios.PageControl1Change(Sender: TObject);
begin
  if(PageControl1.ActivePageIndex=1)then begin
//    PROGS_USUARIO.ParamByname('usuarioID').AsInteger:=dtsUsuarios.DataSet.FieldByName('usuarioID').AsInteger;
    PROGS_USUARIO.Open;
//    PROGS_USUARIO.Refresh;
    AtualizaGridEsquerdo(AtualizaListaDeIDs(dtsUsuarios.DataSet.FieldByName('usuarioID').AsInteger));
  end;
end;

procedure TFramePainelDeControleUsuarios.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:=dtsUsuarios.DataSet.State=dsBrowse;
end;

procedure TFramePainelDeControleUsuarios.RemoverPermissao(const
  permissaoID: Integer);
var
  dataset: TZQuery;
  sql: String;
begin
  sql:='DELETE FROM sis_permissoes WHERE permissaoID = :permissaoID;';
  dataset:=TZQuery.Create(Self);
  dataset.Connection:=CONEXAO;
  dataset.SQL.Clear;
  dataset.SQL.Add(sql);
  dataset.ParamByName('permissaoID').AsInteger:=permissaoID;
  dataset.ExecSQL;
  dataset.Close;
  dataset.Free;

  AtualizaGridEsquerdo(AtualizaListaDeIDs(DBGrid1.DataSource.DataSet.FieldByName('usuarioID').AsInteger));

  DBGrid1.DataSource.DataSet.Refresh;
  DBGrid2.DataSource.DataSet.Refresh;
end;

procedure TFramePainelDeControleUsuarios.btnDelProgramaClick(Sender: TObject);
begin
  RemoverPermissao(DBGrid1.DataSource.DataSet.FieldByName('permissaoID').AsInteger)
end;

procedure TFramePainelDeControleUsuarios.btnAddProgramaClick(Sender: TObject);
var
  usuarioID,
  programaID: Integer;
begin
  usuarioID:=dtsUsuarios.DataSet.FieldByName('usuarioID').AsInteger;
  programaID:=DBGrid2.DataSource.DataSet.FieldByName('programaID').AsInteger;
  AdicionarPermissao(usuarioID, programaID)
end;

initialization
  RegisterClass(TFramePainelDeControleUsuarios);
finalization;
  UnRegisterClass(TFramePainelDeControleUsuarios);
end.

