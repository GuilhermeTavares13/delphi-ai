unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.StdCtrls,
  System.JSON;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edtAPIKey: TEdit;
    Label2: TLabel;
    memoPrompt: TMemo;
    btnSendPrompt: TButton;
    memoResponse: TMemo;
    Label3: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure btnSendPromptClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnSendPromptClick(Sender: TObject);
var
  LJson, LBody: TJSONObject;
  LContent, LParts: TJSONArray;
  LPart: TJSONObject;
  LResponseJson: TJSONValue;
  LResponseText: string;
begin
  if (Trim(edtAPIKey.Text) = '') or
  (Trim(memoPrompt.Text) = '') then
  begin
    ShowMessage('API Key is Empty or Prompt not provided');
    Exit;
  end;

  memoResponse.Clear;
  Self.Update;

  try
    RESTRequest1.Params.Clear;
    RESTRequest1.Resource := 'v1beta/models/gemini-1.5-flash-latest:generateContent';
    RESTRequest1.Params.AddItem('key', edtAPIKey.Text, TRESTRequestParameterKind.pkQuery);

    LBody := TJSONObject.Create;
    try
      LContent := TJSONArray.Create;
      LParts := TJSONArray.Create;
      LPart := TJSONObject.Create;

      LPart.AddPair('text', TJSONString.Create(memoPrompt.Text));
      LParts.Add(LPart);

      LContent.Add(TJSONObject.Create.AddPair('parts', LParts));
      LBody.AddPair('contents', LContent);


      RESTRequest1.Body.Add(LBody.ToString, TRESTContentType.ctAPPLICATION_JSON);

    except

      LBody.Free;
      raise;
    end;
    RESTRequest1.Execute;

    memoResponse.Lines.Add('---');

    if RESTResponse1.StatusCode = 200 then
    begin
      LResponseJson := TJSONObject.ParseJSONValue(RESTResponse1.Content);
      try
        LResponseText := LResponseJson.GetValue<TJSONArray>('candidates')
                                   .Items[0].GetValue<TJSONObject>('content')
                                   .GetValue<TJSONArray>('parts')
                                   .Items[0].GetValue<string>('text');

        memoResponse.Lines.Add(LResponseText);
      finally
        LResponseJson.Free;
      end;
    end
    else
    begin
      memoResponse.Lines.Add('Error:');
      memoResponse.Lines.Add(RESTResponse1.Content);
    end;

  except
    on E: Exception do
    begin
      memoResponse.Lines.Add('Error: ' + E.Message);
    end;
  end;
end;

end.
