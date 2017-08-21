unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.XPMan,
  Vcl.Menus, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ImgList, System.ImageList;

type
  TfrmMain = class(TForm)
    lvRoms: TListView;
    cbSystem: TComboBox;
    imgPS: TImage;
    MainMenu1: TMainMenu;
    imgNES: TImage;
    imgN64: TImage;
    imgSNES: TImage;
    lblNoteEmu: TLabel;
    File1: TMenuItem;
    Options1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    About1: TMenuItem;
    btnOpenEmuFolder: TButton;
    btnStart: TButton;
    btnRefresh: TButton;
    imlIcons: TImageList;
    lblFileNameDesc: TLabel;
    lblFileName: TLabel;
    lblFileSizeDesc: TLabel;
    lblFileSize: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cbSystemChange(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure lvRomsClick(Sender: TObject);
    procedure btnOpenEmuFolderClick(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses ShellApi, UOptions, IniFiles;

function ProcessAMsg: Boolean;
      { equivalent to TApplication.ProcessMessages }
      var
        Msg: TMsg;
        msg_proc: boolean;
      begin
        msg_proc := False;
        if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
          begin
            msg_proc := True;
            if Msg.Message <> WM_QUIT then
              begin
                TranslateMessage(Msg);
                DispatchMessage(Msg);
              end;
          end;
        ProcessAMsg := msg_proc;
      end;

    procedure ProcessMessage;
      begin
        while ProcessAMsg do;
      end;



//http://www.delphicorner.f9.co.uk/articles/wapi4.htm
function ExecNewProcess(ProgramName : String; Wait: Boolean; var ProcID:DWord):DWord;
var
  StartInfo : TStartupInfo;
  ProcInfo  : TProcessInformation;
  CreateOK  : Boolean;
  ErrorCode : DWord;
  Appdone   : DWord;
begin
    { fill with known state }
  ErrorCode:=0;
  FillChar(StartInfo,SizeOf(TStartupInfo),#0);
  FillChar(ProcInfo,SizeOf(TProcessInformation),#0);
  StartInfo.cb := SizeOf(TStartupInfo);

  CreateOK := CreateProcess(nil, PChar(ProgramName), nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+IDLE_PRIORITY_CLASS+SYNCHRONIZE,
              nil, nil, StartInfo, ProcInfo);
    { check to see if successful }
  if CreateOK then
    begin
        //may or may not be needed. Usually wait for child processes
      if Wait then
      begin
        repeat
          Appdone := WaitForSingleObject(ProcInfo.hProcess, INFINITE);
           ProcessMessage;
        until Appdone <> WAIT_TIMEOUT;
        CloseHandle(ProcInfo.hProcess);
        CloseHandle(ProcInfo.hThread);
      end
  else
    begin
      procid := ProcInfo.hProcess;
      ShowMessage('No emulator defined or wrong path');
     end;
      GetExitCodeProcess(ProcInfo.hProcess,ErrorCode);
      ExecNewProcess := ErrorCode;
    end;
end;

//http://stackoverflow.com/questions/1642220/getting-size-of-a-file-in-delphi-2010-or-later
function FileSize(const aFilename: String): Int64;
  var
    info: TWin32FileAttributeData;
  begin
    result := -1;

    if NOT GetFileAttributesEx(PWideChar(aFileName), GetFileExInfoStandard, @info) then
      EXIT;

    result := Int64(info.nFileSizeLow) or Int64(info.nFileSizeHigh shl 32);
  end;

//http://www.swissdelphicenter.ch/torry/showcode.php?id=421
procedure LV_InsertFiles(strPath: string; FileExt:string; ListView: TListView; ImageList: TImageList);
var
  i: Integer;
  Icon: TIcon;
  SearchRec: TSearchRec;
  ListItem: TListItem;
  FileInfo: SHFILEINFO;
begin
  // Create a temporary TIcon
  Icon := TIcon.Create;
  ListView.Items.BeginUpdate;
  try
    // search for the first file
    i := FindFirst(strPath + '*.' + FileExt, faAnyFile, SearchRec);
    while i = 0 do
    begin
      with ListView do
      begin
        // On directories and volumes
        if ((SearchRec.Attr and FaDirectory <> FaDirectory) and
          (SearchRec.Attr and FaVolumeId <> FaVolumeID)) then
        begin
          ListItem := ListView.Items.Add;
          //Get The DisplayName
          SHGetFileInfo(PChar(strPath + SearchRec.Name), 0, FileInfo,
            SizeOf(FileInfo), SHGFI_DISPLAYNAME);
          Listitem.Caption := FileInfo.szDisplayName;
          // Get The TypeName
          SHGetFileInfo(PChar(strPath + SearchRec.Name), 0, FileInfo,
            SizeOf(FileInfo), SHGFI_TYPENAME);
          ListItem.SubItems.Add(FileInfo.szTypeName);
          //Get The Icon That Represents The File
          SHGetFileInfo(PChar(strPath + SearchRec.Name), 0, FileInfo,
            SizeOf(FileInfo), SHGFI_ICON or SHGFI_SMALLICON);
          icon.Handle := FileInfo.hIcon;
          ListItem.ImageIndex := ImageList.AddIcon(Icon);
          // Destroy the Icon
          DestroyIcon(FileInfo.hIcon);
        end;
      end;
      i := FindNext(SearchRec);
    end;
  finally
    Icon.Free;
    ListView.Items.EndUpdate;
  end;
end;

procedure TfrmMain.btnOpenEmuFolderClick(Sender: TObject);
begin
    ShellExecute(handle,'open',PChar('.\emulators\'), '','',SW_SHOWNORMAL);
end;

procedure TfrmMain.btnRefreshClick(Sender: TObject);
begin
   cbSystemChange(Sender);
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
var procid:dword;
begin
 btnStart.Enabled:=false;
 case cbSystem.ItemIndex of
   0:ExecNewProcess(frmOptions.edtGBA.Text +' ".\games\GB\'+ lvRoms.Selected.Caption+'"',true,procid);
   1:ExecNewProcess(frmOptions.edtGBA.Text +' ".\games\GBC\'+ lvRoms.Selected.Caption+'"',true,procid);
   2:ExecNewProcess(frmOptions.edtGBA.Text +' ".\games\GBA\'+ lvRoms.Selected.Caption+'"',true,procid);
   3:ExecNewProcess(frmOptions.edtNDS.Text +' ".\games\NDS\'+ lvRoms.Selected.Caption+'"',true,procid);
   4:ExecNewProcess(frmOptions.edtNES.Text +' ".\games\NES\'+ lvRoms.Selected.Caption+'"',true,procid);
   5:ExecNewProcess(frmOptions.edtSNES.Text +' ".\games\SNES\'+ lvRoms.Selected.Caption+'"',true,procid);
   6:ExecNewProcess(frmOptions.edtN64.Text +' ".\games\N64\'+ lvRoms.Selected.Caption+'"',true,procid);
   7:ExecNewProcess(frmOptions.edtGC.Text +' -b -e ".\games\GC\'+ lvRoms.Selected.Caption+'"',true,procid);
   8:ExecNewProcess(frmOptions.edtGC.Text +' -b -e ".\games\WII\'+ lvRoms.Selected.Caption+'"',true,procid);
   9:ExecNewProcess(frmOptions.edtPSX.Text +' -nogui -loadbin ".\games\PSX\'+ lvRoms.Selected.Caption+'"',true,procid);
   10:ExecNewProcess(frmOptions.edtPS2.Text +' ".\games\PS2\'+ lvRoms.Selected.Caption+'" --nogui',true,procid);
   11:ExecNewProcess(frmOptions.edtPSP.Text +' ".\games\PSP\'+ lvRoms.Selected.Caption+'"',true,procid);
 end;
 btnSTart.Enabled:=true;
end;

procedure TfrmMain.cbSystemChange(Sender: TObject);
const Systems: array[0..11] of String = ('GB','GBC','GBA','NDS','NES','SNES','N64','GC','WII','PSX','PS2','PSP');
const FileExt: array[0..11] of String = ('gb','gbc','gba','nds','nes','s*c','*64','iso','iso','*','*','iso');
var ItemIndex: integer;
begin
  ItemIndex:=cbSystem.ItemIndex;
  lvRoms.Clear;
    LV_InsertFiles('.\games\'+Systems[ItemIndex]+'\',FileExt[ItemIndex],lvRoms,imlIcons);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var Ini: TIniFile;
begin
Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.ini' ) );
   try
     ini.WriteString('Paths','nestopia',frmOptions.edtNES.Text);
     ini.WriteString('Paths','project64',frmOptions.edtN64.Text);
     ini.WriteString('Paths','desmume',frmOptions.edtNDS.Text);
     ini.WriteString('Paths','epsxe',frmOptions.edtPSX.Text);
     ini.WriteString('Paths','pcsx2',frmOptions.edtPS2.Text);
     ini.WriteString('Paths','ppsspp',frmOptions.edtPSP.Text);
     ini.WriteString('Paths','zsnes',frmOptions.edtSNES.Text);
     ini.WriteString('Paths','vba',frmOptions.edtGBA.Text);
     ini.WriteString('Paths','dolphin',frmOptions.edtGC.Text);
   finally
     Ini.Free;
   end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
const Systems: array[0..11] of String = ('GB','GBC','GBA','NDS','NES','SNES','N64','GC','WII','PSX','PS2','PSP');
var I:integer;
begin
  if not directoryexists('.\games\') then
      createdir(PChar('.\games\'));
  if not directoryexists('.\emulators\') then
      createdir(PChar('.\emulators\'));
 for I := 0 to 11 do
   begin
    if not directoryexists('.\games\'+Systems[I]+'\') then
      createdir(PChar('.\games\'+Systems[I]+'\'));
   end;

   cbSystemChange(Sender);
   lvRomsClick(Sender);
end;

procedure TfrmMain.FormShow(Sender: TObject);
var    Ini: TIniFile;
begin
   Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.ini' ) );
   try
     frmOptions.edtNES.Text:=ini.ReadString('Paths','nestopia','');
     frmOptions.edtn64.Text:=ini.ReadString('Paths','project64','');
     frmOptions.edtNDS.Text:=ini.ReadString('Paths','desmume','');
     frmOptions.edtPSX.Text:=ini.ReadString('Paths','epsxe','');
     frmOptions.edtPS2.Text:=ini.ReadString('Paths','pcsx2','');
     frmOptions.edtPSP.Text:=ini.ReadString('Paths','ppsspp','');
     frmOptions.edtSNES.Text:=ini.ReadString('Paths','zsnes','');
     frmOptions.edtGBA.Text:=ini.ReadString('Paths','vba','');
     frmOptions.edtGC.Text:=ini.ReadString('Paths','dolphin','');
   finally
     Ini.Free;
   end;
end;

procedure TfrmMain.lvRomsClick(Sender: TObject);
const Systems: array[0..11] of String = ('GB','GBC','GBA','NDS','NES','SNES','N64','GC','WII','PSX','PS2','PSP');
var ItemIndex: integer;
begin
  ItemIndex:=cbSystem.ItemIndex;
  if lvRoms.ItemIndex = -1 then
    begin
      btnStart.Enabled := false;
      lblFileName.Caption:='';
      lblFileSize.Caption:='';
    end
  else
    begin
      btnStart.Enabled:=true;
      lblFileName.Caption:=lvRoms.Selected.Caption;
      lblFileSize.Caption:=inttostr(FileSize('.\games\'+Systems[ItemIndex]+'\'+lvRoms.Selected.Caption))+' Bytes';
    end;
end;

procedure TfrmMain.Options1Click(Sender: TObject);
begin
   frmOptions.ShowModal;
end;

end.
