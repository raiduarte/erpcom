unit uShowSplash;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TFormShowSplash }

  TFormShowSplash = class(TForm)
    Image1: TImage;
    ImageList1: TImageList;
    lblMensagem: TLabel;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormShowSplash: TFormShowSplash;

implementation

{$R *.lfm}

{ TFormShowSplash }

procedure TFormShowSplash.FormCreate(Sender: TObject);
begin
  Image1.Picture:=nil;
  ImageList1.GetBitmap(2, Image1.Picture.Bitmap);
end;

end.

