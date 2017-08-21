unit UOptions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TfrmOptions = class(TForm)
    tbOptions: TTabControl;
    lblGBNotice: TLabel;
    lblVba: TLabel;
    lblDesMume: TLabel;
    lblPr64: TLabel;
    lbljNes: TLabel;
    lblePSXe: TLabel;
    lblpcsx2: TLabel;
    lbljpcsp: TLabel;
    lblZSnes: TLabel;
    lblGCNotice: TLabel;
    lblDolphin: TLabel;
    lbl64bitnotice: TLabel;
    btnGBA: TButton;
    btnN64: TButton;
    btnNDS: TButton;
    btnNES: TButton;
    btnPS2: TButton;
    btnPSP: TButton;
    btnPSX: TButton;
    btnSNES: TButton;
    btnGC: TButton;
    edtGBA: TEdit;
    edtNDS: TEdit;
    edtNES: TEdit;
    edtN64: TEdit;
    edtPS2: TEdit;
    edtPSP: TEdit;
    edtPSX: TEdit;
    edtSNES: TEdit;
    edtGC: TEdit;
    btnOK: TButton;
    dlgOpenEmu: TOpenDialog;
    procedure btnNESClick(Sender: TObject);
    procedure btnN64Click(Sender: TObject);
    procedure btnNDSClick(Sender: TObject);
    procedure btnPSXClick(Sender: TObject);
    procedure btnPS2Click(Sender: TObject);
    procedure btnPSPClick(Sender: TObject);
    procedure btnSNESClick(Sender: TObject);
    procedure btnGBAClick(Sender: TObject);
    procedure btnGCClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

{$R *.dfm}

procedure TfrmOptions.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOptions.btnGBAClick(Sender: TObject);
begin
  dlgOpenEmu.Filter:='Visual Boy Advance executable|VisualBoyAdvance.exe';
      if dlgOpenEmu.Execute then
        edtGBA.Text:=dlgOpenEmu.FileName;
end;

procedure TfrmOptions.btnGCClick(Sender: TObject);
begin
 dlgOpenEmu.Filter:='dolphin executable|dolphin.exe';
      if dlgOpenEmu.Execute then
        edtGC.Text:=dlgOpenEmu.FileName;
end;

procedure TfrmOptions.btnN64Click(Sender: TObject);
begin
 dlgOpenEmu.Filter:='project64 executable|project64.exe';
      if dlgOpenEmu.Execute then
        edtN64.Text:=dlgOpenEmu.FileName;
end;

procedure TfrmOptions.btnNDSClick(Sender: TObject);
begin
 dlgOpenEmu.Filter:='desmume executable|desmume*.exe';
      if dlgOpenEmu.Execute then
        edtNDS.Text:=dlgOpenEmu.FileName;
end;

procedure TfrmOptions.btnNESClick(Sender: TObject);
begin
 dlgOpenEmu.Filter:='nestopia executable|nestopia.exe';
      if dlgOpenEmu.Execute then
        edtNES.Text:=dlgOpenEmu.FileName;
end;

procedure TfrmOptions.btnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOptions.btnPS2Click(Sender: TObject);
begin
dlgOpenEmu.Filter:='pcsx executable|pcsx2.exe';
      if dlgOpenEmu.Execute then
        edtPS2.Text:=dlgOpenEmu.FileName;
end;

procedure TfrmOptions.btnPSPClick(Sender: TObject);
begin
dlgOpenEmu.Filter:='PPSSPP executable|PPSSPPWindows*.exe';
      if dlgOpenEmu.Execute then
        edtPSP.Text:=dlgOpenEmu.FileName;
end;

procedure TfrmOptions.btnPSXClick(Sender: TObject);
begin
 dlgOpenEmu.Filter:='ePSXe executable|ePSXe.exe';
      if dlgOpenEmu.Execute then
        edtPSX.Text:=dlgOpenEmu.FileName;
end;

procedure TfrmOptions.btnSNESClick(Sender: TObject);
begin
 dlgOpenEmu.Filter:='ZSNES executable|zsnesw.exe';
      if dlgOpenEmu.Execute then
        edtSNES.Text:=dlgOpenEmu.FileName;
end;

end.
