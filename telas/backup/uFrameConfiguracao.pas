unit uFrameConfiguracao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, StdCtrls, DBGrids, Buttons,ushowmsg;

type

  { TFrameConfiguracao }

  TFrameConfiguracao = class(TFrame)
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  private

  public

  end;

implementation

{$R *.lfm}

{ TFrameConfiguracao }

procedure TFrameConfiguracao.SpeedButton1Click(Sender: TObject);
begin
{ ushowmsg.msgsucesso('O registro foi incluído com sucesso!');
 ushowmsg.msgerro('Deu ruim!');
 ushowmsg.msgatencao('Abre o olho!');
 ushowmsg.msginformacao('Me diz uma coisa!'); }
if ushowmsg.msgconfirmacao('Tem certeza que deseja sair?') then
ushowmsg.msgconfirmacao('Ok estamos saindo');
end;

end.

