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



unit uFrameInicio;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, StdCtrls, DBGrids, Buttons;

type

  { TFrameInicio }

  TFrameInicio = class(TFrame)
    btnFeharFrame: TSpeedButton;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Shape1: TShape;
    procedure btnFeharFrameClick(Sender: TObject);
  private

  public

  end;

implementation

{$R *.lfm}

{ TFrameInicio }

procedure TFrameInicio.btnFeharFrameClick(Sender: TObject);
begin
  FreeAndNil(Self);
end;

initialization
  RegisterClass(TFrameInicio);
finalization;
  RegisterClass(TFrameInicio);
end.

