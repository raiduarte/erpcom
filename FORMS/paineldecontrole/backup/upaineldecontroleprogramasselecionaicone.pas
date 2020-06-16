unit uPainelDeControleProgramasSelecionaIcone;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, DBGrids, u_dm_painel_de_controle, uShowSplash;

type

  { TFormPainelDeControleProgramasSelecionarIcone }

  TFormPainelDeControleProgramasSelecionarIcone = class(TForm)
    btnFechar: TSpeedButton;
    btnSelecionar: TSpeedButton;
    btnVoltar: TSpeedButton;
    dtsIcones: TDataSource;
    Label1: TLabel;
    Panel14: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    ScrollBox1: TScrollBox;
    Shape1: TShape;
    procedure btnFecharClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure myMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure myMouseLeave(Sender: TOBject);
    procedure myClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormPainelDeControleProgramasSelecionarIcone: TFormPainelDeControleProgramasSelecionarIcone;

  nTag: Integer;

const
  COR_FUNDO = clHighlight;
  COR_REALCE = $0095612D;

implementation

{$R *.lfm}

{ TFormPainelDeControleProgramasSelecionarIcone }

procedure TFormPainelDeControleProgramasSelecionarIcone.myMouseMove(
  Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if((Sender as TPanel).Color=clRed)then
    (Sender as TPanel).Color:=clRed
  else
    (Sender as TPanel).Color:=COR_REALCE;
end;

procedure TFormPainelDeControleProgramasSelecionarIcone.btnFecharClick(
  Sender: TObject);
begin
  nTag:=-1;
  Self.Close;
end;

procedure TFormPainelDeControleProgramasSelecionarIcone.btnSelecionarClick(
  Sender: TObject);
begin
  if(Sender is TPanel)then
    nTag:=(Sender as TPanel).Tag
  else if(Sender is TImage)then
    nTag:=(Sender as TImage).Tag;
  Self.Close;
end;

procedure TFormPainelDeControleProgramasSelecionarIcone.myMouseLeave(
  Sender: TOBject);
begin
  if((Sender as TPanel).Color=clRed)then
    (Sender as TPanel).Color:=clRed
  else
    (Sender as TPanel).Color:=COR_FUNDO;
end;

procedure TFormPainelDeControleProgramasSelecionarIcone.myClick(Sender: TObject);
var
  i: Integer;
begin
  for i:=0 to Pred(ScrollBox1.ComponentCount) do
    if(ScrollBox1.Components[i] is TPanel)then
      (ScrollBox1.Components[i] as TPanel).Color:=COR_FUNDO;

  (Sender as TPanel).Color:=clRed;
end;

procedure TFormPainelDeControleProgramasSelecionarIcone.FormShow(Sender: TObject
  );
var
  lin, col: SmallInt;
  posX, posY: SmallInt;
  P: TPanel;
  Img: TImage;
  MemoryStream: TMemoryStream;
  Png: TPortableNetworkGraphic;
const
  OffSetMemoryStream : Int64 = 0;
  linhas  = 22;
  colunas = 12;
begin
  try
    FormShowSplash:=TFormShowSplash.Create(Self);
    FormShowSplash.lblMensagem.Caption:='Preparando a biblioteca de ícones...';
    FormShowSplash.Show;
    FormShowSplash.Update;

    dtsIcones.DataSet.Open;
    dtsIcones.DataSet.First;
    ScrollBox1.DestroyComponents;
    posX:=0;
    posY:=0;
    for lin:=1 to linhas do begin
      for col:=1 to colunas do begin
        P:=TPanel.Create(ScrollBox1);
        P.Parent:=ScrollBox1;
        P.Left:=posX+1;
        P.Top:=posY+1;
        P.Caption:=dtsIcones.DataSet.FieldByName('iconeID').AsString;
        P.Font.Color:=clWhite;
        P.Width:=(ScrollBox1.Width div colunas)-1;
        P.Height:=(ScrollBox1.Height div linhas)-1;
        P.Alignment:=taRightJustify;
        P.OnClick:=@myClick;
        P.OnMouseMove:=@myMouseMove;
        P.OnMouseLeave:=@myMouseLeave;
        P.ShowHint:=true;
        P.Color:=COR_FUNDO;
        P.BevelColor:=clWhite;
        P.Width:=85;
        P.Height:=80;
        P.BorderSpacing.Around:=3;
        p.Cursor:=crHandPoint;
        P.Tag:=dtsIcones.DataSet.FieldByName('iconeID').AsInteger;

        posx:=posX+P.Width;
        try
          MemoryStream:=TMemoryStream.Create;
          Png:=TPortableNetworkGraphic.Create;
          (dtsIcones.DataSet.FieldByName('icone2') as TBlobField).SaveToStream(MemoryStream);
          MemoryStream.Position:=OffSetMemoryStream;
          Png.LoadFromStream(MemoryStream);

          Img:=TImage.Create(P);
          Img.Name:='Image';
          Img.Parent:=P;
          Img.Center:=true;
          Img.AutoSize:=true;
          Img.Transparent:=true;
          Img.Picture.Assign(Png);
          Img.Cursor:=crHandPoint;
          Img.Tag:=dtsIcones.DataSet.FieldByName('iconeID').AsInteger;
          Img.OnClick:=@myClick;
        finally
          MemoryStream.Free;
          Png.Free;
        end;
        dtsIcones.DataSet.Next;
        if(dtsIcones.DataSet.EOF)then
          Exit
      end;
      posX:=0;
      posY:=posY+P.Height+1;
      dtsIcones.DataSet.Next;
      if(dtsIcones.DataSet.EOF)then
        Exit
    end;

  finally
    FreeAndNil(FormShowSplash);
  end;
end;

end.

