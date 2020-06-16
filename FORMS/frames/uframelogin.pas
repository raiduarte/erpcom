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



unit uFrameLogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, Buttons, StdCtrls, math,
  udf_vars, UDF, uShowSplash, u_dm_painel_de_controle, uFramePrincipal, LCLType,
  Dialogs;

type

  { TFrameLogin }

  TFrameLogin = class(TFrame)
    btnConfirmar: TSpeedButton;
    edtSenha: TLabeledEdit;
    edtUsuario: TLabeledEdit;
    Image1: TImage;
    Image2: TImage;
    lblData: TLabel;
    lblHora: TLabel;
    lblMensagem: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure ExibirAlerta(Sender: TOBject; LabelMensagem: TLabel; Mensagem: String);
    procedure edtUsuarioChange(Sender: TObject);
    procedure edtUsuarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FrameResize(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.lfm}

{ TFrameLogin }

procedure TFrameLogin.Timer1Timer(Sender: TObject);
var
  dataext: String;
begin
  dataext:=aSemanaAbv[DayOfWeek(Now())]+', '+FormatDateTime('dd', Now())+' de '+aMeses[StrToInt(FormatDateTime('mm', Now()))]+' de '+FormatDateTime('yyyy', Now());
  lblHora.Caption:=FormatDateTime('hh:mm', Now());
  lblData.Caption:=dataext;//   FormatDateTime('dd/mm', Now());
  if(Timer1.Interval=1)then
    Timer1.Interval:=1000;
end;

procedure TFrameLogin.Timer2Timer(Sender: TObject);
begin
  lblMensagem.Visible:=not lblMensagem.Visible;
end;

constructor TFrameLogin.Create(AOwner: TComponent);
var
  i: Integer;
  dir_path, file_path, image_jpg: String;
const
  CENARIO_DIR = 'CENARIO';
begin
  inherited Create(AOwner);
  file_path:=EmptyStr;
  while(FileExists(file_path)=false)do begin
    Randomize;
    i:=RandomRange(1, 20);
    image_jpg:=IntToStr(i)+'.jpg';
    dir_path:=ExtractFilePath(ParamStr(0))+CENARIO_DIR+'\';
    file_path:=ExtractFilePath(ParamStr(0))+CENARIO_DIR+'\'+image_jpg;
    if(DirectoryExists(dir_path))then
      if(FileExists(file_path))then begin
        Image1.Picture:=nil;
        Image1.Picture.LoadFromFile(file_path);
      end;
  end;
end;

destructor TFrameLogin.Destroy;
begin
  FrameLogin.Free;
  inherited Destroy;
end;

procedure TFrameLogin.FrameResize(Sender: TObject);
begin
  edtUsuario.Top := (Self.Height div 2) - (edtUsuario.Height div 2);
  edtUsuario.Left := (Self.Width div 2) - (edtUsuario.Width div 2);

  edtSenha.Top:=(self.Height div 2) - (edtSenha.height div 2)+50;
  edtSenha.Left:=(self.Width div 2) - (edtSenha.width div 2);

  btnConfirmar.Top:=edtSenha.Top+35;
  btnConfirmar.Left:=edtSenha.Left+edtSenha.Width-25;

  lblMensagem.Top:=edtSenha.Top+60;
  lblMensagem.Left:=edtSenha.Left;

  lblHora.Top:=Self.Height-220;
  lblHora.left:=Self.Width-250;

  lblData.Top:=Self.Height-100;
  lblData.Left:=Self.Width-250;
end;

procedure TFrameLogin.edtUsuarioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(Key=VK_RETURN)then
    btnConfirmarClick(Sender);
end;

procedure TFrameLogin.ExibirAlerta(Sender: TOBject; LabelMensagem: TLabel;
  Mensagem: String);
begin
  LabelMensagem.Caption:=Mensagem;
end;

procedure TFrameLogin.edtUsuarioChange(Sender: TObject);
begin
  if(Timer2.Enabled=true)then begin
    Timer2.Enabled:=false;
    lblMensagem.Visible:=false;
  end;
end;

procedure TFrameLogin.btnConfirmarClick(Sender: TObject);
var
  usuario,
  senha: String;
begin
  usuario:=edtUsuario.Text;
  senha:=edtSenha.Text;
  LOGIN.Close;
  LOGIN.ParamByName('usuario').AsString:=usuario;
  LOGIN.ParamByName('senha').AsString:=GeraSHA2(CONEXAO, senha);
  LOGIN.Open;
  USUARIO_LOGADO:=LOGIN.RecordCount=1;
  lblMensagem.Visible:=USUARIO_LOGADO=false;
  Timer2.Enabled:=USUARIO_LOGADO=false;
  if(USUARIO_LOGADO=true)then begin
    FramePrincipal:=TFramePrincipal.Create(Self.Parent);
    FramePrincipal.Parent:=Self.Parent;
    FramePrincipal.Show;
    FrameLogin.Hide;
    FrameLogin:=nil;
    FrameLogin.Free;
  end;
end;

end.

