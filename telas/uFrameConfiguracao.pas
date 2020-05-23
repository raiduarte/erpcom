unit uFrameConfiguracao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, StdCtrls, DBGrids, Buttons,ushowmsg;

type

  { TFrameConfiguracao }

  TFrameConfiguracao = class(TFrame)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private

  public

  end;

implementation

{$R *.lfm}

{ TFrameConfiguracao }

procedure TFrameConfiguracao.SpeedButton1Click(Sender: TObject);
begin
if ushowmsg.msgconfirmacao('Tem certeza que deseja sair?') then
ushowmsg.msgsucesso('Ok estamos saindo');
end;

procedure TFrameConfiguracao.Button1Click(Sender: TObject);
begin
  ushowmsg.msgsucesso('O registro foi incluído com sucesso!');
end;

procedure TFrameConfiguracao.Button2Click(Sender: TObject);
begin
  ushowmsg.msgerro('Deu ruim!');
end;

procedure TFrameConfiguracao.Button3Click(Sender: TObject);
begin
  ushowmsg.msgatencao('Abre o olho!');
end;

procedure TFrameConfiguracao.Button4Click(Sender: TObject);
begin
  ushowmsg.msginformacao('Me diz uma coisa!');
end;

end.

