unit uFrameClientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, ExtCtrls, StdCtrls, DBGrids, LCLType,
  Buttons, Windows, Graphics;

type

  { TFrameClientes }

  TFrameClientes = class(TFrame)
    dtsClientes: TDataSource;
    DBGrid1: TDBGrid;
    edtPesquisar: TEdit;
    Label1: TLabel;
    lblStatusBar: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Shape1: TShape;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    procedure btnExcluirClick(Sender: TObject);
    procedure dtsClientesDataChange(Sender: TObject; Field: TField);
    procedure edtPesquisarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnEditarClick(Sender: TObject);
  private

  public

  end;

implementation

uses
  u_dm_principal,
  uFrameClientesDados,
  UDF;

{$R *.lfm}

{ TFrameClientes }

procedure TFrameClientes.dtsClientesDataChange(Sender: TObject; Field: TField);
var
  PodeEditar: Boolean;
begin
  lblStatusBar.Caption:=IntToStr(dtsClientes.DataSet.RecNo)+' de '+IntToStr(dtsClientes.DataSet.RecordCount);

//  PodeEditar:=CLIENTES.RecordCount>0;
  btnEditar.Enabled:=PodeEditar;
  btnExcluir.Enabled:=PodeEditar;

  ConfigActionButtons(dtsClientes, [btnEditar, btnExcluir]);
end;

procedure TFrameClientes.btnExcluirClick(Sender: TObject);
begin
  if(Application.MessageBox(PChar('Excluir o registro selecionado e todas as suas informações?'), PChar(Application.Title), MB_ICONQUESTION+MB_YESNO)=ID_YES)then
end;

procedure TFrameClientes.edtPesquisarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  s: String;
begin
  if(Key=VK_RETURN)then begin
    s:=(Sender as TEdit).Text+'%';
    if((Sender as TEdit).Text=EmptyStr)then
      Exit;
    CLIENTES.ParamByName('nome').AsString:=s;
    CLIENTES.Refresh;
    if(CLIENTES.RecordCount=0)then
      lblStatusBar.Caption:='Nenhum registro foi localizado'
    else
      DBGrid1.SetFocus;
  end;
end;

procedure TFrameClientes.btnEditarClick(Sender: TObject);
begin
  if(CLIENTES.RecordCount>0)then begin
    FrameClientes.Hide;
    FrameClientesDados:=TFrameClientesDados.Create(FrameClientes.Parent);
    FrameClientesDados.Parent:=FrameClientes.Parent;
  end;
end;

end.

