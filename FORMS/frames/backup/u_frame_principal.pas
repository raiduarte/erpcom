unit u_frame_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, StdCtrls, DBCtrls, uframemenu;

type

  { TFramePrincipal }

  TFramePrincipal = class(TFrame)
    DBText1: TDBText;
    DBText2: TDBText;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    lblData: TLabel;
    lblHora: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    PanelFrames: TPanel;
    Panel8: TPanel;
    PanelMenuLateral: TPanel;
    Shape1: TShape;
    Timer1: TTimer;
    procedure Image2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  FrameMenu: TFrameMenu;

implementation

{$R *.lfm}

{ TFramePrincipal }

procedure TFramePrincipal.Timer1Timer(Sender: TObject);
begin
  lblData.Caption:=FormatDateTime('dd/mm', Now);
  lblHora.Caption:=FormatDateTime('hh:mm:ss', Now);
  if(Timer1.Interval=1)then
    Timer1.Interval:=1000;
end;

procedure TFramePrincipal.Image2Click(Sender: TObject);
begin
  FrameMenu.EscondeLabelsMenu(PanelMenuLateral)
end;

end.

