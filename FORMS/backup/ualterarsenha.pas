unit uAlterarSenha;                      {
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



{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, DBCtrls, u_dm_painel_de_controle, UDF, Windows, db;

type

  { TFormAlterarSenha }

  TFormAlterarSenha = class(TForm)
    btnFechar: TSpeedButton;
    btnSalvar: TSpeedButton;
    DBText1: TDBText;
    dtsLogin: TDataSource;
    edtSenhaAtual: TLabeledEdit;
    edtNovaSenha: TLabeledEdit;
    edtConfirmarSenha: TLabeledEdit;
    Image1: TImage;
    Label1: TLabel;
    lblMensagem: TLabel;
    Panel1: TPanel;
    Panel3: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    procedure btnFecharClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure dtsLoginStateChange(Sender: TObject);
    procedure edtConfirmarSenhaKeyPress(Sender: TObject; var Key: char);
    procedure edtNovaSenhaChange(Sender: TObject);
    procedure edtSenhaAtualChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: char);
  private

  public

  end;

var
  FormAlterarSenha: TFormAlterarSenha;

implementation

{$R *.lfm}

{ TFormAlterarSenha }

procedure TFormAlterarSenha.FormKeyPress(Sender: TObject; var Key: char);
begin
  if(Key=#27)then begin
    Key:=#0;
    Close
  end;
end;

procedure TFormAlterarSenha.btnFecharClick(Sender: TObject);
begin
  Close
end;

procedure TFormAlterarSenha.btnSalvarClick(Sender: TObject);
begin
  if(AlertaModal('Confirmar alteração da senha do usuário?', MB_ICONQUESTION+MB_YESNO)=IDYES)then begin
    if(SalvarAlteracoes(LOGIN)=true)then begin
      Self.Hide;
      AlertaModal('Senha de usuário alterada com sucesso', MB_ICONINFORMATION);
      Self.Close;
    end
  end
  else
    AlertaModal('A senha de acesso não foi alterada', MB_ICONSTOP)

  //if(SalvarAlteracoes(LOGIN)=true)then begin
  //  Self.Hide;
  //  AlertaModal('Senha de usuário alterada com sucesso', MB_ICONINFORMATION);
  //  Self.Close;
  //end;
end;

procedure TFormAlterarSenha.dtsLoginStateChange(Sender: TObject);
begin
  btnSalvar.Enabled:=(LOGIN.State=dsEdit);

  ConfiguraButtons(dtsLogin, [btnSalvar], []);
end;

procedure TFormAlterarSenha.edtConfirmarSenhaKeyPress(Sender: TObject;
  var Key: char);
begin
  if(Key=#13)then begin
    Key:=#0;
    btnSalvarClick(Sender);
  end;
end;

procedure TFormAlterarSenha.edtNovaSenhaChange(Sender: TObject);
begin
  if(edtNovaSenha.Text=edtConfirmarSenha.Text)then begin
    LOGIN.Edit;
    LOGIN.FieldByName('senha').AsString:=GeraSHA2(CONEXAO, edtConfirmarSenha.Text);
  end
  else
    LOGIN.Cancel;
end;

procedure TFormAlterarSenha.edtSenhaAtualChange(Sender: TObject);
var
  PodeEditar: Boolean;
  S: String;
begin
  S:=(Sender as TLabeledEdit).Text;
  PodeEditar:=LOGIN.FieldByName('senha').AsString=GeraSHA2(CONEXAO, S);

  edtNovaSenha.Enabled:=PodeEditar;
  edtConfirmarSenha.Enabled:=PodeEditar;
end;

procedure TFormAlterarSenha.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if(LOGIN.State=dsEdit)then
    LOGIN.Cancel;
end;

end.

