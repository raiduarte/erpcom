unit ushowmsg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,umensagem;

var _frmmsg:TfrmMensagem;
procedure msgsucesso(msg:string);
procedure msgerro(msg:string);
procedure msgafirmacao(msg:string);
procedure msginformacao(msg:string);

implementation

procedure msgsucesso(msg:string);
begin
_frmmsg := TfrmMensagem.Create(nil);
_frmmsg.Show;
_frmmsg.msgsucesso(msg);
end;

procedure msgerro(msg:string);
begin
_frmmsg := TfrmMensagem.Create(nil);
_frmmsg.Show;
_frmmsg.msgerro(msg);
end;

procedure msgafirmacao(msg:string);
begin
_frmmsg := TfrmMensagem.Create(nil);
_frmmsg.Show;
_frmmsg.msgafirmacao(msg);
end;

procedure msginformacao(msg:string);
begin
_frmmsg := TfrmMensagem.Create(nil);
_frmmsg.msginformacao(msg);
_frmmsg.Show;
end;

end.

