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



unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, UDF;

type

  { TFormPrincipal }

  TFormPrincipal = class(TForm)
    procedure FormClose(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  u_dm_principal,
  uFrameLogin;

{$R *.lfm}

{ TFormPrincipal }

procedure TFormPrincipal.FormClose(Sender: TObject);
begin
  FreeAndNil(dm_principal);
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  APPLICATION_TITULO:=Application.Title;
  Caption:=APPLICATION_TITULO;

  dm_principal:=Tdm_principal.Create(Self);
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  FrameLogin:=TFrameLogin.Create(FormPrincipal);
  FrameLogin.Parent:=FormPrincipal;
end;

end.

