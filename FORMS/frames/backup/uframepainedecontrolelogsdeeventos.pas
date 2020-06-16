unit uFramePaineDeControleLogsDeEventos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, ExtCtrls, ComCtrls, StdCtrls, Buttons,
  DBGrids;

type

  { TFramePainelDeControleLogsdeEventos }

  TFramePainelDeControleLogsdeEventos = class(TFrame)
    btnEditarPrograma: TSpeedButton;
    btnEditarUsuario: TSpeedButton;
    btnExcluirPrograma: TSpeedButton;
    btnExcluirUsuario: TSpeedButton;
    btnFeharFrame: TSpeedButton;
    btnNovoPrograma: TSpeedButton;
    btnNovoUsuario: TSpeedButton;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    dtsPermissoes: TDataSource;
    dtsProgramas: TDataSource;
    dtsUsuarios: TDataSource;
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
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
  private

  public

  end;

implementation

{$R *.lfm}

initialization
  RegisterClass(TFramePainelDeControleLogsdeEventos);
finalization;
  UnRegisterClass(TFramePainelDeControleLogsdeEventos);
end.

