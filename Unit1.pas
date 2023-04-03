unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Clipbrd, WinInet,
  System.Net.HttpClient;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Clipboard.AsText := Edit3.Text;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  dwConnectionTypes: DWORD;
  HttpClient: THttpClient;
  Response: IHTTPResponse;
  RandomNumber: Integer;
  RandomOrgAPI: string;
begin
  if (Edit1.Text = '') or (Edit2.Text = '') then
  begin
    MessageBox(0,'Please, fill all the fields!','ALERT',MB_OK);
 Exit;
  end;

      if ( StrToInt(Edit1.Text) >= StrToInt(Edit2.Text)) then
    begin
    MessageBox(0,'The MIN cannot be greater than the MAX!','ALERT',MB_OK);
         Exit;
         end;

  dwConnectionTypes := INTERNET_CONNECTION_MODEM or INTERNET_CONNECTION_LAN or INTERNET_CONNECTION_PROXY;
  if InternetGetConnectedState(@dwConnectionTypes, 0) then

    RandomOrgAPI := 'https://www.random.org/integers/?num=1&min=' + Edit1.Text + '&max=' + Edit2.Text + '&col=1&base=10&format=plain&rnd=new'

    else
    begin
       MessageBox(0,'NO CONNECTION TO THE INTERNET','ALERT',MB_OK);
    Exit;
    end;
  try
    HttpClient := THttpClient.Create;
    HttpClient.CustomHeaders['User-Agent'] := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36';
    HttpClient.CustomHeaders['X-Random-API-Key'] := '1853e49e-667f-4e59-9051-b03abdcc8368';
    Response := HttpClient.Get(RandomOrgAPI);
    RandomNumber := StrToInt(Response.ContentAsString.Trim);
    Edit3.Text := IntToStr(RandomNumber);
  except
    on E: Exception do
      ShowMessage(E.ClassName + ': ' + E.Message);
  end;


end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 MessageBox(0, 'Keep in mind that you have to be connected to the internet to work', 'IMPORTANT', MB_OK);
end;

end.

