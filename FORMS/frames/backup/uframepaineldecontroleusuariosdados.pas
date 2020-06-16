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



unit uframepaineldecontroleusuariosdados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, BufDataset, Forms, Controls, ExtCtrls, Buttons,
  StdCtrls, DBCtrls, CheckLst, u_dm_painel_de_controle, UDF, LCLType,
  Graphics, DBGrids, StrUtils, ZDataset, Dialogs;

type

  { TFramePainelDeControleUsuariosDados }

  TFramePainelDeControleUsuariosDados = class(TFrame)
    btnCancelar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnVoltar: TSpeedButton;
    dtsProgrsAttr: TDataSource;
    dtsProgsDisp: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
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
    lblStatusBar: TLabel;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    PanelPermissoes: TPanel;
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
    btnAddPrograma: TSpeedButton;
    btnDelPrograma: TSpeedButton;
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

{ TFramePainelDeControleUsuariosDados }

procedure TFramePainelDeControleUsuariosDados.btnVoltarClick(Sender: TObject);
begin
  FreeAndNil(vParentPanel);
end;

procedure TFramePainelDeControleUsuariosDados.dtsUsuariosDataChange(Sender: TObject;
  Field: TField);
var
  SuperUsuario: Boolean;
begin
  SuperUsuario:=(dtsUsuarios.DataSet.FieldByName('superusuario').AsBoolean);
  Label2.Enabled:=not SuperUsuario OR (dtsUsuarios.DataSet.State=dsInsert);
  edtNome.Enabled:=not SuperUsuario OR (dtsUsuarios.DataSet.State=dsInsert);
  Label3.Enabled:=not SuperUsuario OR (dtsUsuarios.DataSet.State=dsInsert);
  edtUsuario.Enabled:=not SuperUsuario OR (dtsUsuarios.DataSet.State=dsInsert);
  PanelPermissoes.Visible:=not SuperUsuario;
end;

procedure TFramePainelDeControleUsuariosDados.dtsUsuariosStateChange(Sender: TObject);
var
  AltPermissoes: Boolean;
begin
  AltPermissoes:=(dtsUsuarios.DataSet.State=dsBrowse);
  DBGrid1.Enabled:=AltPermissoes;
  btnAddPrograma.Enabled:=AltPermissoes;
  btnDelPrograma.Enabled:=AltPermissoes;
  DBGrid2.Enabled:=AltPermissoes;

  ConfiguraButtons(dtsUsuarios.DataSet, [btnSalvar, btnCancelar, btnExcluir, btnVoltar], []);
end;

procedure TFramePainelDeControleUsuariosDados.edtNomeEnter(Sender: TObject);
begin
  DestacaCampo(Sender);
end;

procedure TFramePainelDeControleUsuariosDados.edtSenhaChange(Sender: TObject);
var
  S: String;
begin
  if(dtsUsuarios.DataSet.State=dsBrowse)then
    if(((edtSenha.Text<>EmptyStr) and (edtConfirmarSenha.Text<>EmptyStr)) and (edtSenha.Text=edtConfirmarSenha.Text))then begin
      S:=edtConfirmarSenha.Text;
      if(dtsUsuarios.DataSet.State=dsBrowse)then
        dtsUsuarios.DataSet.Edit;
      dtsUsuarios.DataSet.FieldByName('senha').AsString:=GeraSHA2(CONEXAO, S);
    end
  else if(dtsUsuarios.DataSet.State=dsInsert)then begin
    S:=edtConfirmarSenha.Text;
    dtsUsuarios.DataSet.FieldByName('senha').AsString:=GeraSHA2(CONEXAO, S);
  end;
end;


constructor TFramePainelDeControleUsuariosDados.Create(AOwner: TComponent);
begin
// ShowMessage(AOwner.GetParentComponent.Name);
  inherited Create(AOwner);
  vParentPanel:=(AOwner as TPanel);

  lblStatusBar.Caption:=EmptyStr;
end;

destructor TFramePainelDeControleUsuariosDados.Destroy;
begin
  inherited Destroy;
end;

procedure TFramePainelDeControleUsuariosDados.btnSalvarClick(Sender: TObject);
begin
  if(SalvarAlteracoes(USUARIOS)=true)then begin
    AlertaModal('Todas as alterações foram salvas com sucesso.', MB_ICONINFORMATION);
//    btnVoltarClick(Sender);
  end;
end;

procedure TFramePainelDeControleUsuariosDados.btnCancelarClick(Sender: TObject);
var
  estadoDB: TDataSetState;
begin
  estadoDB:=dtsUsuarios.DataSet.State;
  if(AlertaModal('Cancelar as alterações das informações realizadas atualmente?', MB_ICONQUESTION+MB_YESNO)=IDYES)then
    dtsUsuarios.DataSet.Cancel;

  if(estadoDB=dsInsert)then
    btnVoltarClick(Sender);
end;

initialization
  RegisterClass(TFramePainelDeControleUsuariosDados);
finalization;
  UnRegisterClass(TFramePainelDeControleUsuariosDados);
end.

