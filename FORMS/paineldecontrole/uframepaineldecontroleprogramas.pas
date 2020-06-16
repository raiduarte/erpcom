unit uframepaineldecontroleprogramas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, ExtCtrls, Buttons, StdCtrls, DBCtrls,
  Dialogs, u_dm_painel_de_controle, UDF,
  uPainelDeControleProgramasSelecionaIcone, LCLType, DBGrids, fpimage,
  fpreadjpeg, fpreadpng, fpreadbmp, fpreadgif, fpreadtiff, fpwritebmp, Graphics;

type

  { TFramePainelDeControleProgramas }

  TFramePainelDeControleProgramas = class(TFrame)
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
    btnSelecionaIcone: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnSelecionaIconeClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure dtsProgramasStateChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    vParentPanel: TPanel;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.lfm}

{ TFramePainelDeControleProgramas }

procedure TFramePainelDeControleProgramas.btnVoltarClick(Sender: TObject);
begin
  if(dtsProgramas.DataSet.State in [dsEdit, dsInsert])then
    if(AlertaModal('Existem informações que ainda não foram salvas.'+#13+'Continuar assim mesmo?', MB_ICONQUESTION+MB_YESNO)=IDYES)then begin
      dtsProgramas.DataSet.Cancel;
      FreeAndNil(vParentPanel)
    end
  else
    FreeAndNil(vParentPanel);
end;

procedure TFramePainelDeControleProgramas.dtsProgramasStateChange(
  Sender: TObject);
begin
  ConfiguraButtons(dtsProgramas.DataSet, [btnSalvar, btnCancelar, btnExcluir], []);
end;

procedure TFramePainelDeControleProgramas.btnSalvarClick(Sender: TObject);
var
  estadoDB: TDataSetState;
begin
  estadoDB:=dtsProgramas.DataSet.State;

  if(estadoDB=dsInsert)then
    dtsProgramas.DataSet.FieldByName('programaID').AsInteger:=GeraUltimaID('sis_programas', 'programaID');
  if(SalvarAlteracoes(dtsProgramas.DataSet)=true)then begin
     btnVoltarClick(Sender);
  end;
end;

procedure TFramePainelDeControleProgramas.btnSelecionaIconeClick(Sender: TObject
  );
begin
  try
    FormPainelDeControleProgramasSelecionarIcone:=TFormPainelDeControleProgramasSelecionarIcone.Create(Self);
    FormPainelDeControleProgramasSelecionarIcone.ShowModal;
  finally
    Image1.Picture:=nil;
ShowMessage(IntToStr(FormPainelDeControleProgramasSelecionarIcone.nTag));
    dtsIcones.DataSet.Locate('iconeID', FormPainelDeControleProgramasSelecionarIcone.nTag, []);
    DBExportaPNGImagem(dtsIcones.DataSet, 'icone', Image1);
    if(dtsProgramas.DataSet.State=dsBrowse)then begin
      dtsProgramas.DataSet.Edit;
    end;
    FreeAndNil(FormPainelDeControleProgramasSelecionarIcone);
  end;
end;

procedure TFramePainelDeControleProgramas.btnCancelarClick(Sender: TObject
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

procedure TFramePainelDeControleProgramas.SpeedButton1Click(Sender: TObject
  );
begin
  if(OpenDialog1.Execute)then begin
    if(dtsProgramas.DataSet.State=dsBrowse)then
       dtsProgramas.Edit;
    dtsProgramas.DataSet.FieldByName('formulario').AsString:=OpenDialog1.FileName;
  end;
end;

constructor TFramePainelDeControleProgramas.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  vParentPanel:=(AOwner as TPanel);

  dtsIcones.DataSet.Open;

  lblStatusBar.Caption:=EmptyStr;
end;

destructor TFramePainelDeControleProgramas.Destroy;
begin
  inherited Destroy;
end;

end.


