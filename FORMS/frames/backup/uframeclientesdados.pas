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



unit uFrameClientesDados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, ExtCtrls, StdCtrls, Buttons,
  DBCtrls, DBDateTimePicker, LCLType,
  UDF, udf_vars, u_dm_principal;

type

  { TFrameClientesDados }

  TFrameClientesDados = class(TFrame)
    DBText1: TDBText;
    edtSexo: TDBComboBox;
    edtNascimento: TDBDateTimePicker;
    edtNome: TDBEdit;
    dtsClientes: TDataSource;
    edtIdade: TDBEdit;
    edtCelular: TDBEdit;
    Image1: TImage;
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
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnVoltar: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure dtsClientesDataChange(Sender: TObject; Field: TField);
    procedure dtsClientesStateChange(Sender: TObject);
    procedure edtNascimentoChange(Sender: TObject);
  private

  public
    destructor Destroy; override;
  end;

implementation

{$R *.lfm}

{ TFrameClientesDados }

procedure TFrameClientesDados.btnVoltarClick(Sender: TObject);
begin
  //if(CLIENTES.State in [dsEdit, dsInsert])then begin
  //  if(Application.MessageBox(PChar('Existem alterações que ainda não foram salvas'+#13+'Continuar assim mesmo?'), PChar(Application.Title), MB_ICONQUESTION+MB_YESNO)=ID_YES)then
  //    CLIENTES.Cancel;
  //end
  //else begin
  //  FreeAndNil(FrameClientesDados);
  //  FrameClientes.Show;
  //end;
end;

procedure TFrameClientesDados.dtsClientesDataChange(Sender: TObject;
  Field: TField);
begin
  DBExportaImagem(dtsClientes, 'foto', Image1);
end;

procedure TFrameClientesDados.dtsClientesStateChange(Sender: TObject);
var
  PodeSalvar,
  PodeExcluir: Boolean;
begin
  lblStatusBar.Caption:=EmptyStr;
  //case(CLIENTES.State)of
  //  dsEdit:   lblStatusBar.Caption:='Editando...';
  //  dsInsert: lblStatusBar.Caption:='Editando novo registro...';
  //  dsBrowse: lblStatusBar.Caption:='Visualizando...';
  //end;
  //
  //PodeSalvar:=CLIENTES.State in [dsEdit, dsInsert];
  //PodeExcluir:=CLIENTES.State=dsBrowse;

  btnSalvar.Enabled:=PodeSalvar;
  btnCancelar.Enabled:=PodeSalvar;
  btnExcluir.Enabled:=PodeExcluir;

  ConfigActionButtons(dtsClientes, [btnSalvar, btnCancelar, btnExcluir]);
end;

procedure TFrameClientesDados.edtNascimentoChange(Sender: TObject);
begin
//  CLIENTES.FieldByName('idade').AsInteger:=CalculaIdade(CLIENTES.FieldByName('data_nascimento').AsDateTime, Now());
end;

procedure TFrameClientesDados.btnSalvarClick(Sender: TObject);
begin
  //try
  //  CLIENTES.Post;
  //  btnVoltarClick(Sender);
  //except
  //  on E: Exception do begin
  //    CLIENTES.Cancel;
  //    lblStatusBar.Caption:='Não foi possível salvas suas alterações. A mensagem de erro retornada foi : '+E.Message;
  //  end;
  //end;
end;

procedure TFrameClientesDados.btnCancelarClick(Sender: TObject);
begin
  //if(Application.MessageBox(PChar('Cancelar todas as alterações?'), PChar(Application.Title), MB_ICONQUESTION+MB_YESNO)=ID_YES)then
  //  CLIENTES.Cancel;
end;

procedure TFrameClientesDados.btnExcluirClick(Sender: TObject);
begin
  if(Application.MessageBox(PChar('Excluir o registro selecionado e todas as suas informações?'), PChar(Application.Title), MB_ICONQUESTION+MB_YESNO)=ID_YES)then
end;

destructor TFrameClientesDados.Destroy;
begin
end;

end.

