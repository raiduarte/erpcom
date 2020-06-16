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



unit uFramePrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, ExtCtrls, StdCtrls, DBCtrls, Buttons,
  u_dm_painel_de_controle, uAlterarSenha, UDF, uPrincipal, shellapi, LCLType;

type

  { TFramePrincipal }

  TFramePrincipal = class(TFrame)
    btnSair: TSpeedButton;
    btnInfo: TSpeedButton;
    dtsLogin: TDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    lblData: TLabel;
    lblHora: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    PanelFrames: TPanel;
    Panel8: TPanel;
    PanelMenuLateral: TPanel;
    Shape1: TShape;
    btnAlterarSenha: TSpeedButton;
    btnFerramentas: TSpeedButton;
    btnLogOff: TSpeedButton;
    btnCalendario: TSpeedButton;
    btnHome: TSpeedButton;
    Timer1: TTimer;
    procedure btnAlterarSenhaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnLogOffClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    mousePos: TPoint;
  public
    constructor Create(AOwner: TComponent); override;
  end;


implementation

uses
  uframemenu;

var
  FrameMenu: TFrameMenu;

{$R *.lfm}

{ TFramePrincipal }

procedure TFramePrincipal.Timer1Timer(Sender: TObject);
begin
  lblData.Caption:=FormatDateTime('dd/mm', Now);
  lblHora.Caption:=FormatDateTime('hh:mm:ss', Now);
  if(Timer1.Interval=1)then
    Timer1.Interval:=1000;
end;

constructor TFramePrincipal.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FrameMenu:=TFrameMenu.Create(PanelMenuLateral, PanelFrames);
  //FrameMenu:=TFrameMenu.Create(PanelFrames);
  FrameMenu.Parent:=PanelMenuLateral;
end;

procedure TFramePrincipal.Image2Click(Sender: TObject);
begin
  FrameMenu.EscondeLabelsMenu(PanelMenuLateral)
end;

procedure TFramePrincipal.btnAlterarSenhaClick(Sender: TObject);
begin
  try
    mousePos:=Mouse.CursorPos;

    FormAlterarSenha:=TFormAlterarSenha.Create(Self);
    FormAlterarSenha.Top:=mousePos.Y+30;
    FormAlterarSenha.Left:=mousePos.X-180;
    FormAlterarSenha.ShowModal;
  finally
    FreeAndNil(FormAlterarSenha);
  end;
end;

procedure TFramePrincipal.btnSairClick(Sender: TObject);
begin
  if(AlertaModal('Encerrar o sistema agora?', MB_ICONQUESTION+MB_YESNO)=IDYES)then
    FormPrincipal.Close;
end;

procedure TFramePrincipal.btnLogOffClick(Sender: TObject);
begin
  if(AlertaModal('Fazer logoff da sua conta de acesso agora?', MB_ICONQUESTION+MB_YESNO)=IDYES)then begin
    ShellExecute(Handle, 'OPEN', PChar(ParamStr(0)), nil, nil, SW_SHOWNORMAL);
    FormPrincipal.Close;
  end;
end;

end.

