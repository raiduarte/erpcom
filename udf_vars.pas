unit UDF_VARS;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, sqldb, db, ExtCtrls, graphics, Buttons;

var
  FrameInicio       : TFrame;
  FrameClientes     : TFrame;
  FrameClientesDados: TFrame;
  FrameConfiguracao : TFrame;

const
  BUTTONS_COLORS: array[0..2] of TColor = ($00408000, $0041B3FE, $000000CC);

procedure DBImportaImagem(const sArquivo: String; FDataSet: TSQLQuery;
  sCampo: String);
procedure DBImportaImagemFromTImage(Image: TImage; FDataSet: TSQLQuery;
  sCampo: String);
procedure DBExportaImagem(Const FDataSource: TDataSource; sCampo: String;
  ComponentImage: TImage);
function CalculaIdade(const Data1, Data2: TDateTime): integer;
procedure ConfigButtons(dataset: TDataSource; buttons: array of TSpeedButton);


implementation

procedure DBImportaImagem(const sArquivo: String; FDataSet: TSQLQuery;
  sCampo: String);
var
  MemoryStream : TMemoryStream;
  Jpg : TJpegImage;
const
  OffsetMemoryStream : Int64 = 0;
begin
  MemoryStream:=TMemoryStream.Create;
  Jpg:=TJPEGImage.Create;
  Jpg.LoadFromFile(sArquivo);
  Jpg.SaveToStream(MemoryStream);
  MemoryStream.Position:=OffsetMemoryStream;
  (FDataSet.FieldByName(sCampo) as TBlobField).BlobType:=ftBlob;
  (FDataSet.FieldByName(sCampo) as TBlobField).LoadFromStream(MemoryStream);
  MemoryStream.Free;
  Jpg.Free;
end;

procedure DBImportaImagemFromTImage(Image: TImage; FDataSet: TSQLQuery;
  sCampo: String);
var
  MemoryStream : TMemoryStream;
  Jpg : TJpegImage;
const
  OffsetMemoryStream : Int64 = 0;
begin
  MemoryStream:=TMemoryStream.Create;
  Jpg:=TJPEGImage.Create;
  Jpg.Assign(Image.Picture.Graphic);
  Jpg.SaveToStream(MemoryStream);
  MemoryStream.Position:=OffsetMemoryStream;
  (FDataSet.FieldByName(sCampo) as TBlobField).BlobType:=ftBlob;
  (FDataSet.FieldByName(sCampo) as TBlobField).LoadFromStream(MemoryStream);
  MemoryStream.Free;
  Jpg.Free;
end;

procedure DBExportaImagem(const FDataSource: TDataSource; sCampo: String;
  ComponentImage: TImage);
var
  MemoryStream : TMemoryStream;
  Jpg : TJpegImage;
const
  OffsetMemoryStream : Int64 = 0;
begin
  if(FDataSource.DataSet.FieldByName(sCampo).AsVariant<>null)then
    try
      MemoryStream:=TMemoryStream.Create;
      Jpg:=TJPEGImage.Create;
      (FDataSource.DataSet.FieldByName(sCampo) as TBlobField).SaveToStream(MemoryStream);
      MemoryStream.Position:=OffsetMemoryStream;
      Jpg.LoadFromStream(MemoryStream);
      ComponentImage.Picture.Assign(Jpg);
    finally
      MemoryStream.Free;
      Jpg.Free
    end
  else
    ComponentImage.Picture.Graphic:=nil
end;

function CalculaIdade(const Data1, Data2: TDateTime): integer;
var
  D1, M1, A1,
  D2, M2, A2: Word;
begin
  DecodeDate(Data1, A1, M1, D1);
  DecodeDate(Data2, A2, M2, D2);

  Result := A2 - A1;

  if (M1 > M2) or ((M1 = M2) and (D1 > D2)) then
    Dec(Result);
end;

procedure ConfigButtons(dataset: TDataSource; buttons: array of TSpeedButton);
var
  i: Integer;
begin
  for i:=0 to Length(buttons)-1 do begin
    if(((dataset.State in [dsEdit, dsInsert]) or (dataset.DataSet.RecordCount>0)) and (buttons[i].Enabled))then
      buttons[i].Color:=BUTTONS_COLORS[i]
    else if((dataset.State=dsBrowse) or (buttons[i].Enabled=false))then
      buttons[i].Color:=clSilver
    else
  end;
end;


end.

