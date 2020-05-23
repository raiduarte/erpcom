unit uMensagem;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, windows;

type

  { TfrmMensagem }

  TfrmMensagem = class(TForm)
    Image1: TImage;
    lblMsg: TLabel;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private

  public
    procedure msgsucesso(msg:string);
    procedure msgerro(msg:string);
    procedure msgafirmacao(msg:string);
    procedure msginformacao(msg:string);

  end;

  {
    0 = Afirmacao
    1 = sucesso
    2 = erro
    3 = interrogacao
    4 = Informacao
  }

var
  frmMensagem: TfrmMensagem;

implementation

{$R *.lfm}

{ TfrmMensagem }

procedure TfrmMensagem.SpeedButton1Click(Sender: TObject);
begin
  Free;
end;

procedure TfrmMensagem.FormCreate(Sender: TObject);
var
region : hrgn;
begin
  region:= CreateRoundRectRgn(0, 0, width, height, 20, 20);
  setwindowrgn(handle, region, true);
  Shape1.Color:= $008E5F24;
end;

procedure TfrmMensagem.msgsucesso(msg: string);
begin
  //ImageList1.getBitmap(1, Image1.Picture.Bitmap);
  if FileExists(ExtractFilePath(ParamStr(0))+'\img\sucesso.png') then
  Image1.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'\img\sucesso.png');
  lblMsg.Caption:= msg;
end;

procedure TfrmMensagem.msgerro(msg: string);
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\img\erro.png') then
  Image1.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'\img\erro.png');
  lblMsg.Caption:= msg;
end;

procedure TfrmMensagem.msgafirmacao(msg: string);
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\img\afirmacao.png') then
  Image1.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'\img\afirmacao.png');
  lblMsg.Caption:= msg;
end;

procedure TfrmMensagem.msginformacao(msg: string);
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\img\informacao.png') then
  Image1.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'\img\informacao.png');
  lblMsg.Caption:= msg;
end;

end.

