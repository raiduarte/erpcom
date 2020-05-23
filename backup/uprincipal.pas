unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, DBCtrls, db;

type

  { TFormPrincipal }

  TFormPrincipal = class(TForm)
    DBText1: TDBText;
    DBText2: TDBText;
    Image1: TImage;
    Image2: TImage;
    lblData: TLabel;
    lblHora: TLabel;
    lblHome: TLabel;
    lblClientes: TLabel;
    lblConfigs: TLabel;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    PanelMain: TPanel;
    Panel2: TPanel;
    btnHome: TSpeedButton;
    btnClientes: TSpeedButton;
    btnConfigs: TSpeedButton;
    Timer1: TTimer;
    procedure btnClientesClick(Sender: TObject);
    procedure btnConfigsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure lblConfigsClick(Sender: TObject);
    procedure lblHomeMouseLeave(Sender: TObject);
    procedure lblHomeMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnHomeClick(Sender: TObject);
    procedure btnHomeMouseLeave(Sender: TObject);
    procedure btnHomeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Timer1Timer(Sender: TObject);
  private

  public
  procedure abrirconfiguracao;
  procedure abririnicio;
  procedure abrirclientes;

  end;

var
  FormPrincipal: TFormPrincipal;

const
  COR_FUNDO         = $008E5F24;
  COR_FUNDO_FOCUS   = $00DEB892;

implementation

uses
  uFrameInicio, uFrameClientes,
  u_dm_principal,uFrameConfiguracao,
  UDF_VARS;

{$R *.lfm}

{ TFormPrincipal }

procedure TFormPrincipal.btnHomeMouseLeave(Sender: TObject);
begin
  (Sender as TSpeedButton).Color:=COR_FUNDO;
  if((Sender as TSpeedButton).Tag=1)then
    lblHome.Color:=COR_FUNDO
  else if((Sender as TSpeedButton).Tag=2)then
    lblClientes.Color:=COR_FUNDO
  else if((Sender as TSpeedButton).Tag=3)then
    lblConfigs.Color:=COR_FUNDO;
end;

procedure TFormPrincipal.lblHomeMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Color:=COR_FUNDO;
  if((Sender as TLabel).Tag=1)then
    btnHome.Color:=COR_FUNDO
  else if((Sender as TLabel).Tag=2)then
    btnClientes.Color:=COR_FUNDO
  else if((Sender as TLabel).Tag=3)then
    btnConfigs.Color:=COR_FUNDO;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  dm_principal:=Tdm_principal.Create(Self);
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  //CLIENTES.Open;

  btnHomeClick(Sender);
end;

procedure TFormPrincipal.Image2Click(Sender: TObject);
begin
  lblHome.Visible:=not lblHome.Visible;
  lblClientes.Visible:=not lblClientes.Visible;
  lblConfigs.Visible:=not lblConfigs.Visible;
end;

procedure TFormPrincipal.btnClientesClick(Sender: TObject);
begin
  abrirclientes;
end;

procedure TFormPrincipal.btnConfigsClick(Sender: TObject);
begin
  abrirconfiguracao;
end;

procedure TFormPrincipal.lblHomeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  (Sender as TLabel).Color:=COR_FUNDO_FOCUS;
  if((Sender as TLabel).Tag=1)then
    btnHome.Color:=COR_FUNDO_FOCUS
  else if((Sender as TLabel).Tag=2)then
    btnClientes.Color:=COR_FUNDO_FOCUS
  else if((Sender as TLabel).Tag=3)then
    btnConfigs.Color:=COR_FUNDO_FOCUS;
end;

procedure TFormPrincipal.SpeedButton1Click(Sender: TObject);
begin
  lblHome.Visible:=not lblHome.Visible;
  lblClientes.Visible:=not lblClientes.Visible;
  lblConfigs.Visible:=not lblConfigs.Visible;
end;

procedure TFormPrincipal.btnHomeClick(Sender: TObject);
begin
  abririnicio;
end;

procedure TFormPrincipal.btnHomeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  (Sender as TSpeedButton).Color:=COR_FUNDO_FOCUS;
  if((Sender as TSpeedButton).Tag=1)then
    lblHome.Color:=COR_FUNDO_FOCUS
  else if((Sender as TSpeedButton).Tag=2)then
    lblClientes.Color:=COR_FUNDO_FOCUS
  else if((Sender as TSpeedButton).Tag=3)then
    lblConfigs.Color:=COR_FUNDO_FOCUS;
end;

procedure TFormPrincipal.Timer1Timer(Sender: TObject);
begin
  lblData.Caption:=FormatDateTime('dd/mm', Now);
  lblHora.Caption:=FormatDateTime('hh:mm:ss', Now);
  if(Timer1.Interval=1)then
    Timer1.Interval:=1000;
end;

procedure TFormPrincipal.abrirconfiguracao;
begin
if not(Assigned(FrameConfiguracao))then
  begin
      FrameConfiguracao:=TFrameConfiguracao.Create(PanelMain);
      FrameConfiguracao.Parent:=PanelMain;
  end
else
  FrameConfiguracao.BringToFront;
end;

procedure TFormPrincipal.abririnicio;
begin
if not(Assigned(FrameInicio))then
  begin
    FrameInicio:=TFrameInicio.Create(PanelMain);
    FrameInicio.Parent:=PanelMain;
  end
else
    FrameInicio.BringToFront;
end;

procedure TFormPrincipal.abrirclientes;
begin
if not(Assigned(FrameClientes))then
  begin
    FrameClientes:=TFrameClientes.Create(PanelMain);
    FrameClientes.Parent:=PanelMain;
  end
else
    FrameClientes.BringToFront;
end;

end.

