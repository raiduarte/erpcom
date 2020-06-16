unit uFramePaineDeControleLogsDeEventos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, ExtCtrls, ComCtrls, StdCtrls, Buttons,
  DBGrids;

type

  { TFramePainelDeControleLogsdeEventos }

  TFramePainelDeControleLogsdeEventos = class(TFrame)
    btnImprimir: TSpeedButton;
    btnVisualizar: TSpeedButton;
    btnFeharFrame: TSpeedButton;
    DBGrid1: TDBGrid;
    edtPesquisar: TEdit;
    Label1: TLabel;
    lblStatusBar: TLabel;
    Panel14: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Shape1: TShape;
    procedure btnFeharFrameClick(Sender: TObject);
  private

  public

  end;

implementation

{$R *.lfm}

{ TFramePainelDeControleLogsdeEventos }

procedure TFramePainelDeControleLogsdeEventos.btnFeharFrameClick(Sender: TObject
  );
begin
  FreeAndNil(Self);
end;

initialization
  RegisterClass(TFramePainelDeControleLogsdeEventos);
finalization;
  UnRegisterClass(TFramePainelDeControleLogsdeEventos);
end.

