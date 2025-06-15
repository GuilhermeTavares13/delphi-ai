object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 426
  ClientWidth = 691
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 40
    Top = 304
    Width = 43
    Height = 15
    Caption = 'API Key:'
  end
  object Label2: TLabel
    Left = 13
    Top = 333
    Width = 70
    Height = 15
    Caption = 'Your Prompt:'
  end
  object Label3: TLabel
    Left = 30
    Top = 19
    Width = 53
    Height = 15
    Caption = 'Response:'
  end
  object edtAPIKey: TEdit
    Left = 89
    Top = 304
    Width = 121
    Height = 23
    TabOrder = 0
  end
  object memoPrompt: TMemo
    Left = 89
    Top = 333
    Width = 594
    Height = 52
    Lines.Strings = (
      '')
    TabOrder = 1
  end
  object btnSendPrompt: TButton
    Left = 89
    Top = 391
    Width = 101
    Height = 25
    Caption = 'Send'
    TabOrder = 2
    OnClick = btnSendPromptClick
  end
  object memoResponse: TMemo
    Left = 89
    Top = 16
    Width = 594
    Height = 249
    Lines.Strings = (
      '')
    ReadOnly = True
    TabOrder = 3
  end
  object RESTClient1: TRESTClient
    BaseURL = 'https://generativelanguage.googleapis.com'
    Params = <>
    SynchronizedEvents = False
    Left = 528
    Top = 280
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 448
    Top = 280
  end
  object RESTResponse1: TRESTResponse
    Left = 616
    Top = 280
  end
end
