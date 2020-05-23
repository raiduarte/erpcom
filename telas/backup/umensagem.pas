unit uMensagem;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, RTTICtrls, LR_RRect, rxctrls, windows;

type

  { TfrmMensagem }

  TfrmMensagem = class(TForm)
    Image1: TImage;
    lblTitulo: TLabel;
    lblMsg: TLabel;
    RxSpeedButton1: TRxSpeedButton;
    RxSpeedButton2: TRxSpeedButton;
    RxSpeedButton3: TRxSpeedButton;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure RxSpeedButton3Click(Sender: TObject);
  private

  public
    procedure msgsucesso(msg:string);
    procedure msgerro(msg:string);
    procedure msgatencao(msg:string);
    procedure msginformacao(msg:string);
    function msgconfimacao(msg: string): Boolean;
    var resp:boolean;
  end;

  {
    0 = Atenção
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

procedure TfrmMensagem.FormCreate(Sender: TObject);
var
region : hrgn;
begin
  region:= CreateRoundRectRgn(0, 0, width, height, 20, 20);
  setwindowrgn(handle, region, true);
  Shape1.Brush.Color:= $008E5F24;
end;

procedure TfrmMensagem.FormPaint(Sender: TObject);
begin
with RxSpeedButton1 do
canvas.RoundRect(left,top,width+left,height+top,20,20);
end;

procedure TfrmMensagem.RxSpeedButton1Click(Sender: TObject);
begin
  Free;
end;

procedure TfrmMensagem.RxSpeedButton2Click(Sender: TObject);
begin
  resp:= true;
  Close;
end;

procedure TfrmMensagem.RxSpeedButton3Click(Sender: TObject);
begin
 resp:= false;
 Close;
end;

procedure TfrmMensagem.msgsucesso(msg: string);
begin
  //ImageList1.getBitmap(1, Image1.Picture.Bitmap);
  if FileExists(ExtractFilePath(ParamStr(0))+'\img\sucesso.png') then
  Image1.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'\img\sucesso.png');
  lblTitulo.Caption:= 'Sucesso';
  lblMsg.Caption:= msg;
end;

procedure TfrmMensagem.msgerro(msg: string);
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\img\erro.png') then
  Image1.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'\img\erro.png');
  lblTitulo.Caption:= 'Erro';
  lblMsg.Caption:= msg;
end;

procedure TfrmMensagem.msgatencao(msg: string);
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\img\afirmacao.png') then
  Image1.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'\img\afirmacao.png');
  lblTitulo.Caption:= 'Atenção';
  lblMsg.Caption:= msg;
end;

procedure TfrmMensagem.msginformacao(msg: string);
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\img\informacao.png') then
  Image1.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'\img\informacao.png');
  lblTitulo.Caption:= 'Informação';
  lblMsg.Caption:= msg;
end;

function TfrmMensagem.msgconfimacao(msg: string): Boolean;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\img\interrogacao.png') then
  Image1.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'\img\interrogacao.png');
  lblTitulo.Caption:= 'Pergunta';
  lblMsg.Caption:= msg;
  Shape2.Visible:= false;
  RxSpeedButton1.Visible:=false;
  RxSpeedButton2.Visible:=true;
  RxSpeedButton3.Visible:=true;
  Shape3.Visible:=true;
  Shape4.Visible:=true;
  result := resp;
end;

end.

