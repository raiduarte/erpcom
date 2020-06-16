{
  /////////// /////////// ///////////  /////////// ///////////   ///
         ///  ///         ///     ///  ///     ///        ///  /////
        ///   ///         ///    ///   ///     ///       ///     ///
       ///    /////////   ///   ///    ///     ///     ///       ///
      ///     ///         /// ////     ///     ///   ///         ///
     ///      ///         ///   ///    ///     ///  ///          ///
    ///       ///         ///    ///   ///     ///  ///          ///
  /////////// /////////// ////     /// ///////////  ///////////  ///

  by Zero21
}



unit UDF;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, sqldb, db, ExtCtrls, graphics, Buttons, Controls,
  StdCtrls, ZConnection, ZDataset, LCLType, ualertamodal, uShowSplash, DBCtrls,
  Math, Dialogs, fileinfo, winpeimagereader, elfreader, machoreader;

var
  FrameLogin            : TFrame;
  FramePrincipal        : TFrame;

const
  HASH                  = 224;  // hash_length for database Sha2
  COR_FUNDO_MENU        = $008E5F24;
  COR_FUNDO_MENU_FOCUS  = $00DEB892;

  aSemana: array[1..7] of String = ('Domingo',
                                    'Segunda-feira',
                                    'Terça-feira',
                                    'Quarta-feira',
                                    'Quinta-feira',
                                    'Sexta-feira',
                                    'Sábado');

  aMeses: array[0..11] of String = ('Janeiro',
                                    'Fevereiro',
                                    'Março',
                                    'Abril',
                                    'Maio',
                                    'Junho',
                                    'Julho',
                                    'Agosto',
                                    'Setembro',
                                    'Outubro',
                                    'Novembro',
                                    'Dezembro');

  aSemanaAbv: array[1..7] of String = ('Domingo',
                                    'Segunda',
                                    'Terça',
                                    'Quarta',
                                    'Quinta',
                                    'Sexta',
                                    'Sábado');

  aSemanaAbv2: array[1..7] of String = ('Dom',
                                    'Seg',
                                    'Ter',
                                    'Qua',
                                    'Qui',
                                    'Sex',
                                    'Sáb');

  aMesesAbv: array[1..12] of String = ('Jan',
                                    'Fev',
                                    'Mar',
                                    'Abr',
                                    'Mai',
                                    'Jun',
                                    'Jul',
                                    'Ago',
                                    'Set',
                                    'Out',
                                    'Nov',
                                    'Dez');

  MB_ICON_QUESTION              = MB_ICONQUESTION+MB_YESNO;
  MB_ICON_INFORMATION           = MB_ICONINFORMATION;
  MB_ICON_ERROR                 = MB_ICONERROR;
  MB_ICON_WARNING               = MB_ICONWARNING;

  MSG_DB_LOGIN_ERROR            = 'Usuário ou senha informados são inválidos'+#13+'Verifique se as suas credenciais de acesso estão corretas e tente novamente.';
  MSG_DB_EXCEPTION_IN_SAVE      = 'Não foi possível salvar as suas alterações, pois um erro de conexão com o banco de dados ou outra situação anormal ocorreu agora'+#13+#13+'Entre em contato com o Administrador do sistema para verificar este problema'+#13+#13+'A mensagem de erro retornada foi:'+#13;
  MSG_DB_DATA_SAVE_ALL          = 'Tudo foi salvo com sucesso';
  MSG_DB_EXIT_WITHOU_SAVE       = 'Existem alterações que ainda não foram salvas.'+#13+'Sair assim mesmo?';
  MSG_DB_CANCEL_UPDATES         = 'Cancelar as atualizações informadas?'+#13+'Este ação não poderá ser recuperada'+#13'Continuar assim mesmo?';
  MSG_DB_SAVE_WARNING           = 'Salvar tudo agora?';
  MSG_DB_DELETE_RECORD          = 'Excluir este registro e todas as demais informações contidas nela?'+#13+#13+'!!! ATENÇÃO !!!'+#13+'Esta ação não poderá ser desfeita'+#13+'Continuar assim mesmo?';

  BUTTONS_COLORS: array[0..3] of TColor = ($00408000, $0041B3FE, $000000CC, $00CC9900);

var
  CONEXAO         : TZConnection;

  APPLICATION_TITULO: String;

  USUARIO_LOGADO: Boolean;

var
  FileVerInfo: TFileVersionInfo;

procedure DBImportaImagem(const sArquivo: String; FDataSet: TDataSet;
  sCampo: String);
procedure DBImportaImagemFromTImage(Image: TImage; FDataSet: TDataSet;
  sCampo: String);
procedure DBExportaImagem(const FDataSet: TDataSet; sCampo: String;
  ComponentImage: TImage);

procedure DBExportaPNGImagem(const FDataSet: TDataSet; sCampo: String;
  ComponentImage: TImage);


function  CalculaIdade(const Data1, Data2: TDateTime): integer;
procedure ConfigActionButtons(FDataSet: TDataSet; buttons: array of TSpeedButton);
function  SalvarAlteracoes(FDataSet: TDataSet): Boolean;
procedure MeuMsgBox(const sMsg: String; Icon: Integer);
function  GeraSHA2(Conn: TZConnection; const sVar: String): String;
procedure ConfiguraButtons(FDataSet: TDataSet; buttons: array of TSpeedButton;
  condicoes: array of Boolean); overload;
function  GetVersionInfo(sVerOrBuild: String): String;
function  AlertaModal(Mensagem: String; MB_MODAL_ICON: Cardinal): Cardinal;
procedure ShowSplash(Mensagem: String; Evento: TNotifyEvent);
procedure DestacaCampo(Sender: TOBject);
procedure ConfiguraStatusBar(StatusBar: TLabel; FDataSet: TDataSet);
function CriaPanelBase(FramePontoDeMontagem: TFrame): TPanel;
function GeraUltimaID(Tabela, Campo: String): Integer;

implementation

procedure DBImportaImagem(const sArquivo: String; FDataSet: TDataSet;
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

procedure DBImportaImagemFromTImage(Image: TImage; FDataSet: TDataSet;
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

procedure DBExportaImagem(const FDataSet: TDataSet; sCampo: String;
  ComponentImage: TImage);
var
  MemoryStream : TMemoryStream;
  Jpg : TJpegImage;
const
  OffsetMemoryStream : Int64 = 0;
begin
  if(FDataSet.FieldByName(sCampo).AsVariant<>null)then
    try
      MemoryStream:=TMemoryStream.Create;
      Jpg:=TJPEGImage.Create;
      (FDataSet.FieldByName(sCampo) as TBlobField).SaveToStream(MemoryStream);
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

procedure DBExportaPNGImagem(const FDataSet: TDataSet; sCampo: String;
  ComponentImage: TImage);
var
  MemoryStream : TMemoryStream;
  Png : TPortableNetworkGraphic;
const
  OffsetMemoryStream : Int64 = 0;
begin
  if(FDataSet.FieldByName(sCampo).AsVariant<>null)then
    try
      MemoryStream:=TMemoryStream.Create;
      Png:=TPortableNetworkGraphic.Create;
      (FDataSet.FieldByName(sCampo) as TBlobField).SaveToStream(MemoryStream);
      MemoryStream.Position:=OffsetMemoryStream;
      Png.LoadFromStream(MemoryStream);
      ComponentImage.Picture.Assign(Png);
    finally
      MemoryStream.Free;
      Png.Free
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

procedure ConfigActionButtons(FDataSet: TDataSet; buttons: array of TSpeedButton);
var
  i: Integer;
begin
  for i:=0 to Length(buttons)-1 do begin
    if(((FDataSet.State in [dsEdit, dsInsert]) or (FDataSet.RecordCount>0)) and (buttons[i].Enabled))then
      buttons[i].Color:=BUTTONS_COLORS[i]
    else if((FDataSet.State=dsBrowse) or (buttons[i].Enabled=false))then
      buttons[i].Color:=clSilver
    else
  end;
end;


function SalvarAlteracoes(FDataSet: TDataSet): Boolean;
var
  id: Integer;
begin
  Result:=true;
  try
    id:=FDataSet.Fields.Fields[0].AsInteger;
    FDataSet.Post;
    FDataSet.Refresh;
    FDataSet.Locate(FDataSet.Fields.Fields[0].DisplayName, id, []);
  except
    on E: Exception do begin
      Result:=false;
      FDataSet.Cancel;
      MeuMsgBox(E.Message, MB_ICON_ERROR);
    end;
  end;
end;

procedure MeuMsgBox(const sMsg: String; Icon: Integer);
begin
  Application.MessageBox(PChar(sMsg), PChar(APPLICATION_TITULO), Icon);
end;

function GeraSHA2(Conn: TZConnection; const sVar: String): String;
var
  sql: String;
  dataset: TZQuery;
begin
  sql:='select sha2('+QuotedStr(sVar)+', 224) as HASH';
  dataset:=TZQuery.Create(nil);
  dataset.Connection:=Conn;
  dataset.SQL.Clear;
  dataset.SQL.Add(sql);
  dataset.Open;
  Result:=dataset.FieldByName('HASH').AsString;
  dataset.Close;
  dataset.Free;
end;

// procedure responsável pelo tratamento dos botões de comandos
// dataset = conector
// buttons = array contendo os botões de comandos
// condicoes = se não for passado, é ignorado. São condições opcionais para
//            os botões de comandos, quando informados, as condições default
//            são ignoradas
procedure ConfiguraButtons(FDataSet: TDataSet; buttons: array of TSpeedButton;
  condicoes: array of Boolean);
var
  i: Integer;
  aFlags: array[0..3] of Boolean;
begin
  if(FDataSet.State<>dsInactive)then begin
    if(Length(condicoes)=0)then begin
      aFlags[0]:=FDataSet.State in [dsEdit, dsInsert];
      aFlags[1]:=FDataSet.State in [dsEdit, dsInsert];
      aFlags[2]:=not aFlags[0];
      aFlags[3]:=not aFlags[0];

      for i:=0 to Length(buttons)-1 do begin
        buttons[i].Enabled:=aFlags[i];
        if(((FDataSet.State in [dsEdit, dsInsert]) or (FDataSet.RecordCount>0)) and (buttons[i].Enabled))then
          buttons[i].Color:=BUTTONS_COLORS[i]
        else if((FDataSet.State=dsBrowse) or (buttons[i].Enabled=false))then
          buttons[i].Color:=clSilver
      end;
    end
    else begin
      for i:=0 to Length(buttons)-1 do begin
        buttons[i].Enabled:=condicoes[i];
        if(buttons[i].Enabled)then
          buttons[i].Color:=BUTTONS_COLORS[buttons[i].Tag-1]
        else if((FDataSet.State=dsBrowse) or (buttons[i].Enabled=false))then
          buttons[i].Color:=clSilver
      end;
    end;
  end;
end;

function GetVersionInfo(sVerOrBuild: String): String;
begin
  FileVerInfo:=TFileVersionInfo.Create(nil);
  try
    FileVerInfo.ReadFileInfo;
    if(sVerOrBuild='V')then
      Result:=Copy(FileVerInfo.VersionStrings.Values['FileVersion'], 0, 3);
    if(sVerOrBuild='B')then
      Result:=Copy(FileVerInfo.VersionStrings.Values['FileVersion'], 5, 10)
  finally
    FileVerInfo.Free;
  end;
end;

function AlertaModal(Mensagem: String; MB_MODAL_ICON: Cardinal): Cardinal;
begin
  try
    FormAlertaModal:=TFormAlertaModal.Create(Application, Mensagem, MB_MODAL_ICON);
    FormAlertaModal.ShowModal;
  finally
    Result:=FormAlertaModal.GetModalResult;
    FreeAndNil(FormAlertaModal);
  end;
end;

procedure ShowSplash(Mensagem: String; Evento: TNotifyEvent);
begin
  try
    FormShowSplash:=TFormShowSplash.Create(Application);
    FormShowSplash.lblMensagem.Caption:=Mensagem;
    FormShowSplash.Show;
    FormShowSplash.Update;
  finally
    FreeAndNil(FormShowSplash);
  end;
end;

procedure DestacaCampo(Sender: TOBject);
const
  clFocused = $00FFE186;
begin
  if(Sender is TEdit)then
    if((Sender as TEdit).Focused)then begin
      (Sender as TEdit).Color:=clFocused;
//      (Sender as TEdit).Font.Color:=clWhite;
    end
    else begin
      (Sender as TEdit).Color:=clWhite;
//      (Sender as TEdit).Font.Color:=clBlack;
    end;

  if(Sender is TDBEdit)then
    if((Sender as TDBEdit).Focused)then begin
      (Sender as TDBEdit).Color:=clFocused;
//      (Sender as TDBEdit).Font.Color:=clWhite;
    end
    else begin
      (Sender as TDBEdit).Color:=clWhite;
//      (Sender as TDBEdit).Font.Color:=clBlack;
    end;
end;

procedure ConfiguraStatusBar(StatusBar: TLabel; FDataSet: TDataSet);
begin
  if(FDataSet.State<>dsInactive)then
    StatusBar.Caption:='Navegando em '+IntToStr(FDataSet.RecNo)+' de '+IntToStr(FDataSet.RecordCount);
end;

function CriaPanelBase(FramePontoDeMontagem: TFrame): TPanel;
var
  Panel: TPanel;
  n: Integer;
begin
  n:=0;
  Randomize;
  n:=RandomRange(n+4, n+10);
  Panel:=TPanel.Create(FramePontoDeMontagem);
  Panel.Parent:=FramePontoDeMontagem;
  Panel.Align:=alClient;
  Panel.Caption:=EmptyStr;
  Panel.Name:='vPanel'+IntToStr(n);
  Panel.BevelOuter:=bvNone;
  Result:=Panel;
end;

function GeraUltimaID(Tabela, Campo: String): Integer;
var
  DataSet: TZQuery;
  sql: String;
begin
  try
    sql:='SELECT MAX('+Campo+')+1 ID FROM '+Tabela;
    DataSet:=TZQuery.Create(nil);
    DataSet.Connection:=CONEXAO;
    DataSet.SQL.Add(sql);
    DataSet.Open;
    Result:=DataSet.FieldByName('ID').AsInteger;
    DataSet.Close;
    DataSet.Free;
  except
    on E: Exception do
      AlertaModal(E.Message, MB_ICONERROR);
  end;
end;


end.

