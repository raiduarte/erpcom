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



unit uFrameMenuBarAdministracao;

{$mode objfpc}{$H+}

interface

uses
  Classes, Messages, SysUtils, Forms, Controls, ExtCtrls, Buttons, StdCtrls,
  graphics, UDF;

type

  { TFrameMenuBarAdmin }

  TFrameMenuBarAdmin = class(TFrame)
    ImageList1: TImageList;
    PanelMenu: TPanel;
    Timer1: TTimer;

    procedure lblMyOnMouseLeave(Sender: TObject);
    procedure lblMyOnMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnMyOnMouseLeave(Sender: TObject);
    procedure btnMyOnMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    procedure EscondeLabelsMenu(PanelMainForm: TPanel);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  i, X, Y,
  tamanho   : Integer;
  Panels    : Array of TPanel;
  SpeedBtns : Array of TSpeedButton;
  Labels    : Array of TLabel;
  Shift     : TShiftState;
  bmp       : TBitmap;

implementation

{$R *.lfm}

{ TFrameMenuBarAdmin }

procedure TFrameMenuBarAdmin.Timer1Timer(Sender: TObject);
const
  Itens     : Array[0..8] of String = ('Registro', 'Mmebros', 'Células', 'Visitantes', 'Agenda de Compromissos', 'Aniversariantes', 'Controle Patrimonial', 'Configurações', 'Painel de Controle');
begin

  tamanho:=250;
  SetLength(Panels, Length(Itens));
  SetLength(SpeedBtns, Length(Itens));
  SetLength(Labels, Length(Itens));
  for i:=High(Itens) downto 0 do begin
    Panels[i]:=TPanel.Create(PanelMenu);
    Panels[i].Parent:=PanelMenu;
    Panels[i].Height:=32;
    Panels[i].Name:='Panel'+IntToStr(i)+'0';
    Panels[i].Align:=alTop;
    Panels[i].Color:=$008E5F24;
    Panels[i].BevelOuter:=bvNone;
    Panels[i].Caption:=EmptyStr;

    SpeedBtns[i]:=TSpeedButton.Create(Panels[i]);
    SpeedBtns[i].Parent:=Panels[i];
    ImageList1.GetBitmap(i, SpeedBtns[i].Glyph);
    SpeedBtns[i].Width:=39;
    SpeedBtns[i].Cursor:=crHandPoint;
    SpeedBtns[i].Align:=alLeft;
    SpeedBtns[i].ShowCaption:=false;
    SpeedBtns[i].Flat:=true;
    SpeedBtns[i].Transparent:=false;
    SpeedBtns[i].Color:=$008E5F24;
    SpeedBtns[i].Tag:=i;
    SpeedBtns[i].OnMouseLeave:=@btnMyOnMouseLeave;
    SpeedBtns[i].OnMouseMove:=@btnMyOnMouseMove;
//    SpeedBtns[i].OnClick:=;

    Labels[i]:=TLabel.Create(Panels[i]);
    Labels[i].Parent:=Panels[i];
    Labels[i].Name:='Label'+IntToStr(i)+'0';
    Labels[i].Cursor:=crHandPoint;
    Labels[i].Align:=alClient;
    Labels[i].Layout:=tlCenter;
    Labels[i].Caption:=' '+Itens[i];
    Labels[i].Color:=$008E5F24;
    Labels[i].Tag:=i;
    Labels[i].OnMouseLeave:=@lblMyOnMouseLeave;
    Labels[i].OnMouseMove:=@lblMyOnMouseMove;
//    Labels[i].OnClick:=;
  end;

  Timer1.Enabled:=false;
end;

procedure TFrameMenuBarAdmin.lblMyOnMouseLeave(Sender: TObject);
var
  i: Integer;
begin
  (Sender as TLabel).Color:=COR_FUNDO_MENU;
  for i:=Low(SpeedBtns) to High(SpeedBtns) do begin
    if(SpeedBtns[i].Tag=(Sender as TLabel).Tag)then
      SpeedBtns[i].Color:=COR_FUNDO_MENU;
  end;
end;

procedure TFrameMenuBarAdmin.lblMyOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  (Sender as TLabel).Color:=COR_FUNDO_MENU_FOCUS;
  for i:=Low(SpeedBtns) to High(SpeedBtns) do begin
    if(SpeedBtns[i].Tag=(Sender as TLabel).Tag)then
      SpeedBtns[i].Color:=COR_FUNDO_MENU_FOCUS;
  end;
end;

procedure TFrameMenuBarAdmin.btnMyOnMouseLeave(Sender: TObject);
var
  i: Integer;
begin
  (Sender as TSpeedButton).Color:=COR_FUNDO_MENU;
  for i:=Low(Labels) to High(Labels) do begin
    if(Labels[i].Tag=(Sender as TSpeedButton).Tag)then
      Labels[i].Color:=COR_FUNDO_MENU;
  end;
end;

procedure TFrameMenuBarAdmin.btnMyOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  (Sender as TSpeedButton).Color:=COR_FUNDO_MENU_FOCUS;
  for i:=Low(Labels) to High(Labels) do begin
    if(Labels[i].Tag=(Sender as TSpeedButton).Tag)then
      Labels[i].Color:=COR_FUNDO_MENU_FOCUS;
  end;
end;

procedure TFrameMenuBarAdmin.EscondeLabelsMenu(PanelMainForm: TPanel);
var
  i: Integer;
  l: Boolean;
begin
  for i:=Low(Labels) to High(Labels) do begin
    Labels[i].Visible:=not Labels[i].Visible;
    l:=Labels[i].Visible
  end;
  PanelMainForm.AutoSize:=not l;
  Self.AutoSize:=not l;
  if(PanelMainForm.AutoSize=false)then begin
    PanelMainForm.Width:=tamanho;
    Self.Width:=tamanho;
  end;
end;

initialization
  RegisterClass(TLabel);
  RegisterClass(TSpeedButton);
finalization
  UnRegisterClass(TLabel);
  UnRegisterClass(TSpeedButton);

end.

