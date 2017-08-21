program RomManager;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {frmMain},
  UOptions in 'UOptions.pas' {frmOptions};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Keima''s Rom Manager';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.Run;
end.
