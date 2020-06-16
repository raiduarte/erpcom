unit uframepaineldecontroleprogramasdados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, ExtCtrls, Buttons, StdCtrls, DBCtrls,
  Dialogs, u_dm_painel_de_controle, UDF, LCLType;

type

  { TFramePainelDeControleProgramasDados }

  TFramePainelDeControleProgramasDados = class(TFrame)
    btnCancelar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnVoltar: TSpeedButton;
    DBText1: TDBText;
    dtsIcones: TDataSource;
    dtsProgramas: TDataSource;
    edtNome: TDBEdit;
    edtUsuario: TDBEdit;
    edtUsuario1: TDBEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblStatusBar: TLabel;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
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
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    vParentPanel: TPanel;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.lfm}

{ TFramePainelDeControleProgramasDados }

procedure TFramePainelDeControleProgramasDados.btnVoltarClick(Sender: TObject);
begin
  FreeAndNil(Self);
end;

procedure TFramePainelDeControleProgramasDados.btnSalvarClick(Sender: TObject);
begin
  if(SalvarAlteracoes(PROGRAMAS)=true)then
     btnVoltarClick(Sender);
end;

procedure TFramePainelDeControleProgramasDados.btnCancelarClick(Sender: TObject
  );
var
  estadoDB: TDataSetState;
begin
  estadoDB:=dtsProgramas.DataSet.State;
  if(AlertaModal('Cancelar as alterações das informações realizadas atualmente?', MB_ICONQUESTION+MB_YESNO)=IDYES)then
    dtsProgramas.DataSet.Cancel;

  if(estadoDB=dsInsert)then
    btnVoltarClick(Sender);
end;

procedure TFramePainelDeControleProgramasDados.SpeedButton1Click(Sender: TObject
  );
begin
  if(OpenDialog1.Execute)then begin
    if(dtsProgramas.DataSet.State=dsBrowse)then
       dtsProgramas.Edit;
    dtsProgramas.DataSet.FieldByName('formulario').AsString:=OpenDialog1.FileName;
  end;
end;

constructor TFramePainelDeControleProgramasDados.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  vParentPanel:=(AOwner as TPanel);

  lblStatusBar.Caption:=EmptyStr;
end;

destructor TFramePainelDeControleProgramasDados.Destroy;
begin
  inherited Destroy;
end;

end.

