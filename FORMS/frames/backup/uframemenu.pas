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



unit uframemenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, Buttons, StdCtrls,
  graphics, UDF, uShowSplash, u_dm_painel_de_controle, lazCollections, db;

type

  { TFrameMenu }

  TFrameMenu = class(TFrame)
    ImageList1: TImageList;
    PanelMenu: TPanel;
    Timer1: TTimer;
    procedure lblMyOnMouseLeave(Sender: TObject);
    procedure lblMyOnMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lblMyClick(Sender: TObject);
    procedure btnMyOnMouseLeave(Sender: TObject);
    procedure btnMyOnMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnMyClick(Sender: TObject);
    procedure EscondeLabelsMenu(PanelMainForm: TPanel);
    procedure Timer1Timer(Sender: TObject);
  private
    PanelFrame: TPanel;
  public
    constructor Create(AOwner: TComponent; Panel: TPanel);
    //constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
  end;

type
  TFrameClass = Class of TFrame;


var
  nItem,
  X, Y, Z   : Integer;
  Panels    : Array of TPanel;
  SpeedBtns : Array of TSpeedButton;
  Labels    : Array of TLabel;
  Shift     : TShiftState;
  bmp       : TBitmap;

  aFrameList: Array of TFrame;
  aFrames   : Array of String;
  FrameClass: TFrameClass;
  Frame     : TFrame;
  FrameName : String;

const
  tamanhoframe = 200;

implementation

{$R *.lfm}

{ TFrameMenu }

procedure TFrameMenu.Timer1Timer(Sender: TObject);
var
  MemoryStream : TMemoryStream;
  png: TPortableNetworkGraphic;
  nItens: Integer;
const
  OffSetMemoryStream : Int64 = 0;
begin
  nItem:=0;
//  aFrameList:=TStringList.Create;

  try
    FormShowSplash:=TFormShowSplash.Create(Self);
    FormShowSplash.lblMensagem.Caption:='Configurando o seu perfil de usuário';
    FormShowSplash.Show;
    FormShowSplash.Update;

    ACESSOS.Close;
    ACESSOS.ParamByName('usuarioID').AsInteger:=LOGIN.FieldByName('usuarioID').AsInteger;
    ACESSOS.Open;

    nItens:=ACESSOS.RecordCount;
    SetLength(aFrames   , nItens);
    SetLength(Panels    , nItens);
    SetLength(SpeedBtns , nItens);
    SetLength(Labels    , nItens);
    SetLength(aFrameList, nItens);
    ACESSOS.Last;
    while not(ACESSOS.BOF)do begin
      Panels[nItem]:=TPanel.Create(PanelMenu);
      Panels[nItem].Parent:=PanelMenu;
      Panels[nItem].Height:=32;
      Panels[nItem].Name:='Panel'+IntToStr(nItem)+'0';
      Panels[nItem].Align:=alTop;
      Panels[nItem].Color:=$008E5F24;
      Panels[nItem].BevelOuter:=bvNone;
      Panels[nItem].Caption:=EmptyStr;

      SpeedBtns[nItem]:=TSpeedButton.Create(Panels[nItem]);
      SpeedBtns[nItem].Parent:=Panels[nItem];
      try
        MemoryStream:=TMemoryStream.Create;
        png:=TPortableNetworkGraphic.Create;
        (ACESSOS.FieldByName('icone') as TBlobField).SaveToStream(MemoryStream);
        MemoryStream.Position:=OffsetMemoryStream;
        png.LoadFromStream(MemoryStream);
        SpeedBtns[nItem].Glyph.Assign(png);
      finally
        MemoryStream.Free;
        png.Free;
      end;
  //    ImageList1.GetBitmap(nItem, SpeedBtns[nItem].Glyph);
      SpeedBtns[nItem].Width:=39;
      SpeedBtns[nItem].Cursor:=crHandPoint;
      SpeedBtns[nItem].Align:=alLeft;
      SpeedBtns[nItem].ShowCaption:=false;
      SpeedBtns[nItem].Flat:=true;
      SpeedBtns[nItem].Transparent:=false;
      SpeedBtns[nItem].Color:=$008E5F24;
      SpeedBtns[nItem].Tag:=nItem;
      SpeedBtns[nItem].OnMouseLeave:=@btnMyOnMouseLeave;
      SpeedBtns[nItem].OnMouseMove:=@btnMyOnMouseMove;
      SpeedBtns[nItem].OnClick:=@btnMyClick;

      Labels[nItem]:=TLabel.Create(Panels[nItem]);
      Labels[nItem].Parent:=Panels[nItem];
      Labels[nItem].Name:='Label'+IntToStr(nItem)+'0';
      Labels[nItem].Cursor:=crHandPoint;
      Labels[nItem].Align:=alClient;
      Labels[nItem].Layout:=tlCenter;
      aFrames[nItem]:=ACESSOS.FieldByName('formulario').AsString;
      Labels[nItem].Caption:=' '+ACESSOS.FieldByName('programa').AsString;
      Labels[nItem].Color:=$008E5F24;
      Labels[nItem].Tag:=nItem;
      Labels[nItem].OnMouseLeave:=@lblMyOnMouseLeave;
      Labels[nItem].OnMouseMove:=@lblMyOnMouseMove;
      Labels[nItem].OnClick:=@lblMyClick;

      Inc(nItem, 1);
      ACESSOS.Prior;
    end;
  finally
    FreeAndNil(FormShowSplash);
  end;

  Timer1.Enabled:=false;
end;

constructor TFrameMenu.Create(AOwner: TComponent; panel: TPanel);
begin
  inherited Create(AOwner);
  PanelFrame:=panel;
end;

destructor TFrameMenu.Destroy;
var
  i: Integer;
begin
  for i:=0 to Pred(PanelFrame.ComponentCount) do
    if(PanelFrame.Components[i] is TFrame)then
      (PanelFrame.Components[i] as TFrame).Free;

  inherited Destroy;
  Frame.Free;
end;

procedure TFrameMenu.lblMyOnMouseLeave(Sender: TObject);
var
  i: Integer;
begin
  (Sender as TLabel).Color:=COR_FUNDO_MENU;
  for i:=Low(SpeedBtns) to High(SpeedBtns) do
  begin
    if(SpeedBtns[i].Tag=(Sender as TLabel).Tag)then
      SpeedBtns[i].Color:=COR_FUNDO_MENU;
  end;
end;

procedure TFrameMenu.lblMyOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  (Sender as TLabel).Color:=COR_FUNDO_MENU_FOCUS;
  for i:=Low(SpeedBtns) to High(SpeedBtns) do
  begin
    if(SpeedBtns[i].Tag=(Sender as TLabel).Tag)then
      SpeedBtns[i].Color:=COR_FUNDO_MENU_FOCUS;
  end;
end;

procedure TFrameMenu.lblMyClick(Sender: TObject);
var
  nTag,
  i: Integer;
  compName: String;
  flag: Boolean;
begin
  if(Sender is TLabel)then
    nTag:=(Sender as TLabel).Tag
  else if(Sender is TSpeedButton)then
    nTag:=(Sender as TSpeedButton).Tag;
  FrameName:=aFrames[nTag];

  flag:=false;
  for i:=0 to Pred(PanelFrame.ComponentCount) do
    if(PanelFrame.Components[i] is TFrame)then begin
      (PanelFrame.Components[i] as TFrame).SendToBack;
      compName:=(PanelFrame.Components[i] as TFrame).Name;
      if(compName=FrameName)then begin
        flag:=true;
        (PanelFrame.Components[i] as TFrame).Show;
        (PanelFrame.Components[i] as TFrame).BringToFront;
      end;
    end;
  if(flag=false)then begin
    FrameClass:=TFrameClass(FindClass(FrameName));
    Frame:=FrameClass.Create(PanelFrame);
    Frame.Parent:=PanelFrame;
    Frame.Name:=FrameName;
    Frame.BringToFront;
    Frame.Show;
  end;
end;

procedure TFrameMenu.btnMyOnMouseLeave(Sender: TObject);
var
  i: Integer;
begin
  (Sender as TSpeedButton).Color:=COR_FUNDO_MENU;
  for i:=Low(Labels) to High(Labels) do begin
    if(Labels[i].Tag=(Sender as TSpeedButton).Tag)then
      Labels[i].Color:=COR_FUNDO_MENU;
  end;
end;

procedure TFrameMenu.btnMyOnMouseMove(Sender: TObject;
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

procedure TFrameMenu.btnMyClick(Sender: TObject);
begin
  lblMyClick(Sender)
end;

procedure TFrameMenu.EscondeLabelsMenu(PanelMainForm: TPanel);
var
  i: Integer;
  f: Boolean;
begin
  for i:=Low(Labels) to High(Labels) do begin
    Labels[i].Visible:=not Labels[i].Visible;
    f:=Labels[i].Visible
  end;
  PanelMainForm.AutoSize:=not f;
  Self.AutoSize:=not f;
  if(PanelMainForm.AutoSize=false)then begin
    PanelMainForm.Width:=tamanhoframe;
    Self.Width:=tamanhoframe;
  end;
end;

end.


    //FrameName:=aFrames[(Sender as TLabel).Tag];
    //Frame:=FindComponent(FrameName) as TFrame;
    //FrameClass:=TFrameClass(FindClass(FrameName));
    //begin
    //  Frame:=FrameClass.Create(PanelFrame);
    //  Frame.Parent:=PanelFrame;
    //  Frame.Show;
    //  Frame.Name:=FrameName;
    //end

