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



unit uFramePainelDeControle;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, BufDataset, Forms, Controls, ComCtrls, ExtCtrls,
  StdCtrls, Buttons, DBGrids,
  u_dm_painel_de_controle,
  uframepaineldecontroleusuarios,
  uframepaineldecontroleprogramas,
  UDF, uShowSplash, Dialogs;

var
  FramePainelDeControleUsuarios: TFramePainelDeControleUsuarios;
  FramePainelDeControleProgramas: TFramePainelDeControleProgramas;

type

  { TFramePainelDeControle }

  TFramePainelDeControle = class(TFrame)
    btnEditarUsuario: TSpeedButton;
    btnFeharFrame: TSpeedButton;
    btnEditarPrograma: TSpeedButton;
    btnExcluirUsuario: TSpeedButton;
    btnExcluirPrograma: TSpeedButton;
    btnNovoUsuario: TSpeedButton;
    btnNovoPrograma: TSpeedButton;
    DBGrid1: TDBGrid;
    dtsUsuarios: TDataSource;
    DBGrid2: TDBGrid;
    dtsProgramas: TDataSource;
    dtsPermissoes: TDataSource;
    edtPesquisar: TEdit;
    edtPesquisar1: TEdit;
    Image1: TImage;
    Label1: TLabel;
    lblStatusBar: TLabel;
    lblStatusBar1: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Shape1: TShape;
    sqlInsUsuarionome: TStringField;
    slqInsUsuarioocupacaoID: TLongintField;
    sqlInsUsuarioocupacaoID: TLongintField;
    sqlInsUsuariosenha: TStringField;
    sqlInsUsuariosuperusuario: TBooleanField;
    sqlInsUsuariousuario: TStringField;
    StringField1: TStringField;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure btnEditarProgramaClick(Sender: TObject);
    procedure btnEditarUsuarioClick(Sender: TObject);
    procedure btnFeharFrameClick(Sender: TObject);
    procedure btnNovoProgramaClick(Sender: TObject);
    procedure btnNovoUsuarioClick(Sender: TObject);
    procedure dtsProgramasDataChange(Sender: TObject; Field: TField);
    procedure dtsUsuariosDataChange(Sender: TObject; Field: TField);
  private
    vPanel: TPanel;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.lfm}

{ TFramePainelDeControle }

procedure TFramePainelDeControle.btnEditarUsuarioClick(Sender: TObject);
var
  nPanel: TPanel;
begin
  nPanel:=CriaPanelBase(Self);
  FramePainelDeControleUsuarios:=TFramePainelDeControleUsuarios.Create(nPanel);
  FramePainelDeControleUsuarios.Parent:=nPanel;
end;

procedure TFramePainelDeControle.btnEditarProgramaClick(Sender: TObject);
var
  nPanel: TPanel;
begin
  nPanel:=CriaPanelBase(Self);
  FramePainelDeControleProgramas:=TFramePainelDeControleProgramas.Create(nPanel);
  FramePainelDeControleProgramas.Parent:=nPanel;
end;

procedure TFramePainelDeControle.btnFeharFrameClick(Sender: TObject);
begin
  FreeAndNil(Self);
end;

procedure TFramePainelDeControle.btnNovoProgramaClick(Sender: TObject);
var
  nPanel: TPanel;
begin
  nPanel:=CriaPanelBase(Self);
  PROGRAMAS.Append;
  FramePainelDeControleProgramas:=TFramePainelDeControleProgramas.Create(nPanel);
  FramePainelDeControleProgramas.Parent:=nPanel;
end;

procedure TFramePainelDeControle.btnNovoUsuarioClick(Sender: TObject);
var
  nPanel: TPanel;
begin
  nPanel:=CriaPanelBase(Self);
  USUARIOS.Append;
  FramePainelDeControleUsuarios:=TFramePainelDeControleUsuarios.Create(nPanel);
  FramePainelDeControleUsuarios.Parent:=nPanel;
end;

procedure TFramePainelDeControle.dtsProgramasDataChange(Sender: TObject;
  Field: TField);
var
  PodeEditar: Boolean;
begin
  if(dtsProgramas.DataSet.State<>dsInactive)then begin
    DBExportaPNGImagem(dtsProgramas.DataSet, 'icone', Image1);

    PodeEditar:=dtsProgramas.DataSet.FieldByName('sistema').AsBoolean=false;
    ConfiguraButtons(dtsProgramas.DataSet, [btnNovoPrograma, btnEditarPrograma, btnExcluirPrograma], [true, PodeEditar, PodeEditar]);

    ConfiguraStatusBar(lblStatusBar1, dtsProgramas.DataSet);
  end;
end;

procedure TFramePainelDeControle.dtsUsuariosDataChange(Sender: TObject;
  Field: TField);
var
  PodeExcluir: Boolean;
begin
  //if(dtsUsuarios.DataSet.State<>dsInactive)then begin
    PodeExcluir:=dtsUsuarios.DataSet.FieldByName('superusuario').AsBoolean=false;

    ConfiguraButtons(dtsUsuarios.DataSet, [btnExcluirUsuario], [PodeExcluir]);

    ConfiguraStatusBar(lblStatusBar, dtsUsuarios.DataSet);
  //end;
end;

constructor TFramePainelDeControle.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  lblStatusBar.Caption:=EmptyStr;

  try
    FormShowSplash:=TFormShowSplash.Create(Self);
    FormShowSplash.lblMensagem.Caption:='Carregando as informações, aguarde um momento...';
    FormShowSplash.Show;
    FormShowSplash.Update;

    USUARIOS.Open;
    PROGRAMAS.Open;
    ICONES.Open;
  finally
    FreeAndNil(FormShowSplash);
  end;

end;

destructor TFramePainelDeControle.Destroy;
begin
  inherited Destroy;

  USUARIOS.Close;
  PROGRAMAS.Close;
  ICONES.Close;
  PROGS_USUARIO.Close;
  PROGS_DISPONIVEIS.Close;
end;


initialization
  RegisterClass(TFramePainelDeControle);
finalization;
  UnRegisterClass(TFramePainelDeControle);
end.

