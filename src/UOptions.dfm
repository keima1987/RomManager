object frmOptions: TfrmOptions
  Left = 370
  Top = 207
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 380
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object tbOptions: TTabControl
    Left = 0
    Top = 0
    Width = 470
    Height = 341
    Align = alTop
    MultiLine = True
    TabOrder = 0
    Tabs.Strings = (
      'Paths')
    TabIndex = 0
    object lblGBNotice: TLabel
      Left = 12
      Top = 268
      Width = 375
      Height = 13
      Caption = 
        'Will be used for Gameboy, Gameboy Color and Gameboy Advance Game' +
        's'
    end
    object lblVba: TLabel
      Left = 12
      Top = 245
      Width = 66
      Height = 13
      Caption = 'Visualb. Adv:'
    end
    object lblDesMume: TLabel
      Left = 12
      Top = 110
      Width = 53
      Height = 13
      Caption = 'Desmume:'
    end
    object lblPr64: TLabel
      Left = 12
      Top = 81
      Width = 53
      Height = 13
      Caption = 'Project 64:'
    end
    object lbljNes: TLabel
      Left = 12
      Top = 54
      Width = 48
      Height = 13
      Caption = 'nestopia:'
    end
    object lblePSXe: TLabel
      Left = 12
      Top = 135
      Width = 33
      Height = 13
      Caption = 'ePSXe:'
    end
    object lblpcsx2: TLabel
      Left = 12
      Top = 162
      Width = 31
      Height = 13
      Caption = 'pcsx2:'
    end
    object lbljpcsp: TLabel
      Left = 12
      Top = 189
      Width = 39
      Height = 13
      Caption = 'PPSSPP:'
    end
    object lblZSnes: TLabel
      Left = 12
      Top = 218
      Width = 35
      Height = 13
      Caption = 'ZSNES:'
    end
    object lblGCNotice: TLabel
      Left = 12
      Top = 316
      Width = 252
      Height = 13
      Caption = 'Note: Will be used for GameCube and Wii Games'
    end
    object lblDolphin: TLabel
      Left = 12
      Top = 290
      Width = 45
      Height = 13
      Caption = 'Dolphin:'
    end
    object lbl64bitnotice: TLabel
      Left = 12
      Top = 28
      Width = 275
      Height = 13
      Caption = 'NOTE: 64-Bit emulators won'#39't work on 32-Bit systems'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnGBA: TButton
      Tag = 8
      Left = 375
      Top = 240
      Width = 75
      Height = 25
      Caption = 'Browse...'
      TabOrder = 15
      OnClick = btnGBAClick
    end
    object btnN64: TButton
      Tag = 2
      Left = 375
      Top = 76
      Width = 75
      Height = 25
      Caption = 'Browse...'
      TabOrder = 3
      OnClick = btnN64Click
    end
    object btnNDS: TButton
      Tag = 3
      Left = 375
      Top = 103
      Width = 75
      Height = 25
      Caption = 'Browse...'
      TabOrder = 5
      OnClick = btnNDSClick
    end
    object btnNES: TButton
      Tag = 1
      Left = 375
      Top = 47
      Width = 75
      Height = 25
      Caption = 'Browse...'
      TabOrder = 1
      OnClick = btnNESClick
    end
    object btnPS2: TButton
      Tag = 5
      Left = 375
      Top = 157
      Width = 75
      Height = 25
      Caption = 'Browse...'
      TabOrder = 9
      OnClick = btnPS2Click
    end
    object btnPSP: TButton
      Tag = 6
      Left = 375
      Top = 184
      Width = 75
      Height = 25
      Caption = 'Browse...'
      TabOrder = 11
      OnClick = btnPSPClick
    end
    object btnPSX: TButton
      Tag = 4
      Left = 375
      Top = 130
      Width = 75
      Height = 25
      Caption = 'Browse...'
      TabOrder = 7
      OnClick = btnPSXClick
    end
    object btnSNES: TButton
      Tag = 7
      Left = 375
      Top = 212
      Width = 75
      Height = 25
      Caption = 'Browse...'
      TabOrder = 13
      OnClick = btnSNESClick
    end
    object btnGC: TButton
      Tag = 9
      Left = 375
      Top = 285
      Width = 75
      Height = 25
      Caption = 'Browse...'
      TabOrder = 17
      OnClick = btnGCClick
    end
    object edtGBA: TEdit
      Left = 84
      Top = 242
      Width = 285
      Height = 21
      TabOrder = 14
    end
    object edtNDS: TEdit
      Left = 84
      Top = 105
      Width = 285
      Height = 21
      TabOrder = 4
    end
    object edtNES: TEdit
      Left = 84
      Top = 51
      Width = 285
      Height = 21
      TabOrder = 0
    end
    object edtN64: TEdit
      Left = 84
      Top = 78
      Width = 285
      Height = 21
      TabOrder = 2
    end
    object edtPS2: TEdit
      Left = 84
      Top = 159
      Width = 285
      Height = 21
      TabOrder = 8
    end
    object edtPSP: TEdit
      Left = 84
      Top = 188
      Width = 285
      Height = 21
      TabOrder = 10
    end
    object edtPSX: TEdit
      Left = 84
      Top = 132
      Width = 285
      Height = 21
      TabOrder = 6
    end
    object edtSNES: TEdit
      Left = 84
      Top = 215
      Width = 285
      Height = 21
      TabOrder = 12
    end
    object edtGC: TEdit
      Left = 84
      Top = 287
      Width = 285
      Height = 21
      TabOrder = 16
    end
  end
  object btnOK: TButton
    Left = 199
    Top = 347
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
  object dlgOpenEmu: TOpenDialog
    Left = 408
  end
end
