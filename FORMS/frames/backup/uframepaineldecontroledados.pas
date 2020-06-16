unit uFramePainelDeControleDados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, BufDataset, Forms, Controls, ExtCtrls, Buttons,
  StdCtrls, DBCtrls, CheckLst, u_dm_painel_de_controle, UDF, udf_vars, LCLType,
  Graphics, StrUtils, ZDataset;

type

  { TFramePainelDeControleDados }

  TFramePainelDeControleDados = class(TFrame)
    btnCancelar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnVoltar: TSpeedButton;
    dtsOcupacao: TDataSource;
    DBText1: TDBText;
    dtsUsuarios: TDataSource;
    edtConfirmarSenha: TEdit;
    edtNome: TDBEdit;
    edtSenha: TEdit;
    edtUsuario: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblStatusBar: TLabel;
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
    sqlInsUsuario: TBufDataset;
    sqlInsUsuarionome: TStringField;
    sqlInsUsuarioocupacaoID: TLongintField;
    sqlInsUsuariosenha: TStringField;
    sqlInsUsuariosuperusuario: TBooleanField;
    sqlInsUsuariousuario: TStringField;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure dtsUsuariosDataChange(Sender: TObject; Field: TField);
    procedure dtsUsuariosStateChange(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure edtNomeEnter(Sender: TObject);
    procedure edtOcupacaoChange(Sender: TObject);
    procedure edtSenhaChange(Sender: TObject);
    procedure edtUsuarioChange(Sender: TObject);
  private
    Dados: Array[0..2] of String;
  public
    constructor Create(AOwner: TComponent);
  end;

implementation

const
  A_NOME    = 0;
  A_USUARIO = 1;
  A_FUCNAO  = 2;
  A_SENHA   = 3;

{$R *.lfm}

{ TFramePainelDeControleDados }

procedure TFramePainelDeControleDados.btnVoltarClick(Sender: TObject);
begin
  FreeAndNil(Self);
end;

procedure TFramePainelDeControleDados.dtsUsuariosDataChange(Sender: TObject;
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

procedure TFramePainelDeControleDados.dtsUsuariosStateChange(Sender: TObject);
begin
  ConfigButtons(dtsUsuarios, [btnSalvar, btnCancelar, btnExcluir, btnVoltar]);
end;

procedure TFramePainelDeControleDados.edtNomeChange(Sender: TObject);
begin
  Dados[A_NOME]:=(Sender as TDBEdit).Text;
end;

procedure TFramePainelDeControleDados.edtNomeEnter(Sender: TObject);
begin
  DestacaCampo(Sender);
end;

procedure TFramePainelDeControleDados.edtOcupacaoChange(Sender: TObject);
begin
  Dados[A_NOME]:=(Sender as TDBLookupComboBox).KeyValue;
end;

procedure TFramePainelDeControleDados.edtSenhaChange(Sender: TObject);
var
  S: String;
begin
  S:=edtConfirmarSenha.Text;
  if(dtsUsuarios.DataSet.State=dsBrowse)then
    dtsUsuarios.DataSet.Edit;
  dtsUsuarios.DataSet.FieldByName('senha').AsString:=GeraSHA2(CONEXAO, S);

  //if(dtsUsuarios.DataSet.State=dsBrowse)then
  //  if(((edtSenha.Text<>EmptyStr) and (edtConfirmarSenha.Text<>EmptyStr)) and (edtSenha.Text=edtConfirmarSenha.Text))then begin
  //    S:=edtConfirmarSenha.Text;
  //    if(dtsUsuarios.DataSet.State=dsBrowse)then
  //      dtsUsuarios.DataSet.Edit;
  //    dtsUsuarios.DataSet.FieldByName('senha').AsString:=GeraSHA2(CONEXAO, S);
  //  end
  //else if(dtsUsuarios.DataSet.State=dsInsert)then begin
  //  S:=edtConfirmarSenha.Text;
  //  dtsUsuarios.DataSet.FieldByName('senha').AsString:=GeraSHA2(CONEXAO, S);
  //end;
end;

procedure TFramePainelDeControleDados.edtUsuarioChange(Sender: TObject);
begin
  Dados[A_USUARIO]:=(Sender as TDBEdit).Text;
end;

constructor TFramePainelDeControleDados.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  lblStatusBar.Caption:=EmptyStr;
end;

procedure TFramePainelDeControleDados.btnSalvarClick(Sender: TObject);
begin
  if(SalvarAlteracoes(USUARIOS)=true)then
    btnVoltarClick(Sender);
end;

procedure TFramePainelDeControleDados.btnCancelarClick(Sender: TObject);
var
  estadoDB: TDataSetState;
begin
  estadoDB:=dtsUsuarios.DataSet.State;
  if(AlertaModal('Cancelar as alterações das informações realizadas atualmente?', MB_ICONQUESTION+MB_YESNO)=IDYES)then
    USUARIOS.Cancel;

  if(estadoDB=dsInsert)then
    btnVoltarClick(Sender);
end;

initialization
  RegisterClass(TFramePainelDeControleDados);
finalization;
  UnRegisterClass(TFramePainelDeControleDados);
end.

