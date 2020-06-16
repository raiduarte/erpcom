unit ualertamodal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, LCLType;

type

  { TFormAlertaModal }

  TFormAlertaModal = class(TForm)
    btnCancelar: TSpeedButton;
    btnNao: TSpeedButton;
    btnOk: TSpeedButton;
    btnSim: TSpeedButton;
    Image1: TImage;
    ImageList1: TImageList;
    lblMensagem: TLabel;
    Panel1: TPanel;
    PanelOk: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PanelSim: TPanel;
    PanelNao: TPanel;
    PanelCancel: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnNaoClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnSimClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    ResultModalButtons: Cardinal;
    modalIcon: Cardinal;
  public
    function GetModalResult: Cardinal;
    constructor Create(AOwner: TComponent; Msg: String;
      MB_ICON_MODAL: Cardinal);
  end;

var
  FormAlertaModal: TFormAlertaModal;

implementation

{$R *.lfm}

{ TFormAlertaModal }

procedure TFormAlertaModal.FormShow(Sender: TObject);
const
  ICO_OK          = 0;
  ICO_CANCEL      = 1;
  ICO_INFORMATION = 2;
  ICO_QUESTION    = 3;
  ICO_ALERT       = 4;
  ICO_POWEROFF    = 5;
var
  nIcon: Integer;
begin
  if(modalIcon=MB_ICONINFORMATION)then
    nIcon:=2
  else if(modalIcon=MB_ICONQUESTION+MB_YESNO)then
    nIcon:=3
  else if(modalIcon=MB_ICONQUESTION+MB_YESNOCANCEL)then
    nIcon:=3
  else if(modalIcon=MB_ICONASTERISK or MB_ICONEXCLAMATION or MB_ICONHAND)then
    nIcon:=4
  else if(modalIcon=MB_ICONSTOP)then
    nIcon:=1
  else if(modalIcon=MB_ICONERROR)then
    nIcon:=6;

  Image1.Picture:=nil;
  ImageList1.GetBitmap(nIcon, Image1.Picture.Bitmap);

  PanelCancel.Visible:=modalIcon=MB_ICONQUESTION + MB_YESNOCANCEL;
  PanelNao.Visible:=modalIcon=MB_YESNO + MB_ICONQUESTION;
  PanelSim.Visible:=PanelNao.Visible;
  PanelOk.Visible:=modalIcon in [MB_ICONINFORMATION, MB_ICONEXCLAMATION, MB_ICONHAND];

end;

function TFormAlertaModal.GetModalResult: Cardinal;
begin
  Result:=ResultModalButtons;
end;

constructor TFormAlertaModal.Create(AOwner: TComponent; Msg: String;
  MB_ICON_MODAL: Cardinal
  );
begin
  inherited Create(AOwner);

  lblMensagem.Caption:=Msg;
  modalIcon:=MB_ICON_MODAL;
end;

procedure TFormAlertaModal.btnSimClick(Sender: TObject);
begin
  ResultModalButtons:=IDYES;
  Self.Close
end;

procedure TFormAlertaModal.btnNaoClick(Sender: TObject);
begin
  ResultModalButtons:=IDNO;
  Self.Close
end;

procedure TFormAlertaModal.btnOkClick(Sender: TObject);
begin
  ResultModalButtons:=IDOK;
  Self.Close
end;

procedure TFormAlertaModal.btnCancelarClick(Sender: TObject);
begin
  ResultModalButtons:=IDCANCEL;
  Self.Close
end;

end.

