unit discord;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  fphttpclient, fpjson, jsonparser,
  opensslsockets, sslsockets;

const
  DS_CHANNEL = 'channel';
  DS_USERNAME = 'username';
  DS_AVATAR_URL = 'avatar_url';
  DS_CONTENT = 'content';
  DS_EMBEDS = 'embeds';
  DS_EMBEDS_AUTORH = 'author';
  DS_EMBEDS_AUTHOR_NAME = 'name';
  DS_EMBEDS_AUTHOR_URL = 'url';
  DS_EMBEDS_AUTHOR_ICONURL = 'icon_url';
  DS_EMBEDS_TITLE = 'title';
  DS_EMBEDS_URL = 'url';
  DS_EMBEDS_DESCRIPTION = 'description';
  DS_EMBEDS_COLOR = 'color';
  DS_EMBEDS_FIELDS = 'fields';
  DS_EMBEDS_FIELDS_NAME = 'name';
  DS_EMBEDS_FIELDS_VALUE = 'value';
  DS_EMBEDS_FIELDS_inline = 'inline';
  DS_EMBEDS_THUMBNAIL = 'thumbnail';
  DS_EMBEDS_THUMBNAIL_URL = 'url';
  DS_EMBEDS_IMAGE = 'image';
  DS_EMBEDS_IMAGE_URL = 'url';
  DS_EMBEDS_FOOTER = 'footer';
  DS_EMBEDS_FOOTER_TEXT = 'text';
  DS_EMBEDS_FOOTER_ICONURL = 'icon_url';

type

  { TDiscordEmbedsFooter }

  TDiscordEmbedsFooter = class
  private
    FIconUrl: string;
    FObject: TJSONObject;
    FText: string;
    procedure SetIconUrl(const AValue: string);
    procedure SetText(const AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    function GetObject: TJSONObject; inline;
    property Text: string read FText write SetText;
    property IconUrl: string read FIconUrl write SetIconUrl;
  end;

  { TDiscrodEmbedsThumbNail }

  TDiscrodEmbedsThumbNail = class
  private
    FObject: TJSONObject;
    FUrl: string;
    procedure SetUrl(const AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    property URL: string read FUrl write SetUrl;
    function GetObject: TJSONObject; inline;
  end;

  { TDiscrodEmbedsImage }

  TDiscrodEmbedsImage = TDiscrodEmbedsThumbNail;

  { TDiscrodEmbedsAuthor }

  TDiscrodEmbedsAuthor = class
  private
    FIconUrl: string;
    FObject: TJSONObject;
    FName: string;
    FUrl: string;
    procedure SetIconUrl(const AValue: string);
    procedure SetName(const AValue: string);
    procedure SetUrl(const AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    property Name: string read FName write SetName;
    property URL: string read FUrl write SetUrl;
    property IconUrl: string read FIconUrl write SetIconUrl;
    function GetObject: TJSONObject; inline;
  end;

  { TDiscordEmbedsField }

  TDiscordEmbedsField = class
  private
    FObject: TJSONObject;
    FName: string;
    FValue: string;
    FInline: boolean;
    procedure SetInline(const AValue: boolean);
    procedure SetName(const AValue: string);
    procedure SetValue(const AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    property Name: string read FName write SetName;
    property Value: string read FValue write SetValue;
    property mInline: boolean read FInline write SetInline;
    function GetObject: TJSONObject; inline;
  end;

  { TDiscordEmbeds }

  TDiscordEmbeds = class
  private
    FObject: TJSONObject;
    FFieldsArray: TJSONArray;
    FTitle: string;
    FURL: string;
    FDescription: string;
    FColor: integer;
    procedure SetColor(AValue: integer);
    procedure SetDescription(const AValue: string);
    procedure SetTitle(const AValue: string);
    procedure SetUrl(const AValue: string);
    procedure AddRec(const ARecName: string; AJSONData: TJSONData);
    function GetObject: TJSONObject; inline;
  public
    constructor Create;
    destructor Destroy; override;
    property Title: string read FTitle write SetTitle;
    property URL: string read FURL write SetUrl;
    property Description: string read FDescription write SetDescription;
    property Color: integer read FColor write SetColor;
    procedure AddField(ADiscrodEmbedsField: TDiscordEmbedsField);
    procedure SetAuthor(ADiscrodEmbedsAuthor: TDiscrodEmbedsAuthor); inline;
    procedure SetThumbNail(ADiscordEmbedsThumbNail: TDiscrodEmbedsThumbNail); inline;
    procedure SetImage(ADiscordEmbedsImage: TDiscrodEmbedsImage); inline;
    procedure SetFooter(ADiscordEmbedsFooter: TDiscordEmbedsFooter); inline;
  end;

  { TDiscordMessage }

  TDiscordMessage = class
  private
    FWebhookUrl: string;
    FIconURL: string;
    FContent: string;
    FUserName: string;
    FChannel: string;
    FObject: TJSONObject;
    FEmbedsArray: TJSONArray;
    function GetJSONMessage: string;
    procedure SetChannel(const AValue: string);
    procedure SetIconURL(const AValue: string);
    procedure SetContent(const AValue: string);
    procedure SetUserName(const AValue: string);
    procedure AddRec(const ARecName: string; AJSONArray: TJSONArray);
  public
    constructor Create(const AWebhookURL: string);
    destructor Destroy; override;
    function SendMessage: boolean;
    procedure AddEmbeds(AEmbeds: TDiscordEmbeds);
    property UserName: string read FUserName write SetUserName;
    property JSONMessage: string read GetJSONMessage;
    property Content: string read FContent write SetContent;
    property AvatarURL: string read FIconURL write SetIconURL;
    property Channel: string read FChannel write SetChannel;
  end;

implementation

{ TDiscordEmbedsFooter }

procedure TDiscordEmbedsFooter.SetIconUrl(const AValue: string);
begin
  if FIconUrl = AValue then
    Exit;
  FIconUrl := AValue;
  FObject.Add(DS_EMBEDS_FOOTER_ICONURL, FIconUrl);
end;

procedure TDiscordEmbedsFooter.SetText(const AValue: string);
begin
  if FText = AValue then
    Exit;
  FText := AValue;
  FObject.Add(DS_EMBEDS_FOOTER_TEXT, FText);
end;

constructor TDiscordEmbedsFooter.Create;
begin
  FObject := TJSONObject.Create;
end;

destructor TDiscordEmbedsFooter.Destroy;
begin
  inherited Destroy;
end;

function TDiscordEmbedsFooter.GetObject: TJSONObject;
begin
  Result := FObject;
end;

{ TDiscrodEmbedsThumbNail }

procedure TDiscrodEmbedsThumbNail.SetUrl(const AValue: string);
begin
  if FUrl = AValue then
    Exit;
  FUrl := AValue;
  FObject.Add(DS_EMBEDS_THUMBNAIL_URL, FUrl);
end;

constructor TDiscrodEmbedsThumbNail.Create;
begin
  FObject := TJSONObject.Create;
end;

destructor TDiscrodEmbedsThumbNail.Destroy;
begin
  inherited Destroy;
end;

function TDiscrodEmbedsThumbNail.GetObject: TJSONObject;
begin
  Result := FObject;
end;

{ TDiscrodEmbedsAuthor }

procedure TDiscrodEmbedsAuthor.SetIconUrl(const AValue: string);
begin
  if FIconUrl = AValue then
    Exit;
  FIconUrl := AValue;
  FObject.Add(DS_EMBEDS_AUTHOR_ICONURL, FIconUrl);
end;

procedure TDiscrodEmbedsAuthor.SetName(const AValue: string);
begin
  if FName = AValue then
    Exit;
  FName := AValue;
  FObject.Add(DS_EMBEDS_AUTHOR_NAME, FName);
end;

procedure TDiscrodEmbedsAuthor.SetUrl(const AValue: string);
begin
  if FUrl = AValue then
    Exit;
  FUrl := AValue;
  FObject.Add(DS_EMBEDS_AUTHOR_URL, FUrl);
end;

constructor TDiscrodEmbedsAuthor.Create;
begin
  FObject := TJSONObject.Create;
end;

destructor TDiscrodEmbedsAuthor.Destroy;
begin
  inherited Destroy;
end;

function TDiscrodEmbedsAuthor.GetObject: TJSONObject;
begin
  Result := FObject;
end;

{ TDiscordEmbeds }

procedure TDiscordEmbeds.SetColor(AValue: integer);
begin
  if FColor = AValue then
    Exit;
  FColor := AValue;
  FObject.Add(DS_EMBEDS_COLOR, FColor);
end;

procedure TDiscordEmbeds.SetDescription(const AValue: string);
begin
  if FDescription = AValue then
    Exit;
  FDescription := AValue;
  FObject.Add(DS_EMBEDS_DESCRIPTION, FDescription);
end;

procedure TDiscordEmbeds.SetTitle(const AValue: string);
begin
  if FTitle = AValue then
    Exit;
  FTitle := AValue;
  FObject.Add(DS_EMBEDS_TITLE, FTitle);
end;

procedure TDiscordEmbeds.SetUrl(const AValue: string);
begin
  if FURL = AValue then
    Exit;
  FURL := AValue;
  FObject.Add(DS_EMBEDS_URL, FURL);
end;

procedure TDiscordEmbeds.AddRec(const ARecName: string; AJSONData: TJSONData);
var
  JSONData: TJSONData;
begin
  if AJSONData.JSONType = jtArray then
  begin
    JSONData := TJSONArray(FObject.Find(ARecName));
    if Assigned(JSONData) then
      JSONData := TJSONArray(AJSONData)
    else
      FObject.Add(ARecName, TJSONArray(AJSONData));
  end;
  if AJSONData.JSONType = jtObject then
  begin
    JSONData := TJSONObject(FObject.Find(ARecName));
    if Assigned(JSONData) then
      JSONData := TJSONObject(AJSONData)
    else
      FObject.Add(ARecName, TJSONObject(AJSONData));
  end;
end;

function TDiscordEmbeds.GetObject: TJSONObject;
begin
  Result := FObject;
end;

constructor TDiscordEmbeds.Create;
begin
  FObject := TJSONObject.Create;
end;

destructor TDiscordEmbeds.Destroy;
begin
  inherited Destroy;
end;

procedure TDiscordEmbeds.AddField(ADiscrodEmbedsField: TDiscordEmbedsField);
begin
  if not Assigned(FFieldsArray) then
  begin
    FFieldsArray := TJSONArray.Create;
    AddRec(DS_EMBEDS_FIELDS, FFieldsArray);
  end;
  FFieldsArray.Add(ADiscrodEmbedsField.GetObject);
end;

procedure TDiscordEmbeds.SetAuthor(ADiscrodEmbedsAuthor: TDiscrodEmbedsAuthor);
begin
  FObject.Add(DS_EMBEDS_AUTORH, ADiscrodEmbedsAuthor.GetObject);
end;

procedure TDiscordEmbeds.SetThumbNail(ADiscordEmbedsThumbNail: TDiscrodEmbedsThumbNail);
begin
  FObject.Add(DS_EMBEDS_THUMBNAIL, ADiscordEmbedsThumbNail.GetObject);
end;

procedure TDiscordEmbeds.SetImage(ADiscordEmbedsImage: TDiscrodEmbedsImage);
begin
  FObject.Add(DS_EMBEDS_IMAGE, ADiscordEmbedsImage.GetObject);
end;

procedure TDiscordEmbeds.SetFooter(ADiscordEmbedsFooter: TDiscordEmbedsFooter);
begin
  FObject.Add(DS_EMBEDS_FOOTER, ADiscordEmbedsFooter.GetObject);
end;

{ TDiscordEmbedsField }

procedure TDiscordEmbedsField.SetInline(const AValue: boolean);
begin
  if FInline = AValue then
    Exit;
  FInline := AValue;
  FObject.Add(DS_EMBEDS_FIELDS_inline, FInline);
end;


procedure TDiscordEmbedsField.SetName(const AValue: string);
begin
  if FName = AValue then
    Exit;
  FName := AValue;
  FObject.Add(DS_EMBEDS_FIELDS_NAME, FName);
end;

procedure TDiscordEmbedsField.SetValue(const AValue: string);
begin
  if FValue = AValue then
    Exit;
  FValue := AValue;
  FObject.Add(DS_EMBEDS_FIELDS_VALUE, FValue);
end;

constructor TDiscordEmbedsField.Create;
begin
  FObject := TJSONObject.Create;
end;

destructor TDiscordEmbedsField.Destroy;
begin
  inherited Destroy;
end;

function TDiscordEmbedsField.GetObject: TJSONObject;
begin
  Result := FObject;
end;

{ TDiscordMessage }

function TDiscordMessage.GetJSONMessage: string;
begin
  Result := FObject.AsJSON;
end;

procedure TDiscordMessage.SetChannel(const AValue: string);
begin
  if FChannel = AValue then
    Exit;
  FChannel := AValue;
  FObject.Add(DS_CHANNEL, AValue);
end;

procedure TDiscordMessage.SetIconURL(const AValue: string);
begin
  if FIconURL = AValue then
    Exit;
  FIconURL := AValue;
  FObject.Add(DS_AVATAR_URL, AValue);
end;

procedure TDiscordMessage.SetContent(const AValue: string);
begin
  if FContent = AValue then
    Exit;
  FContent := AValue;
  FObject.Add(DS_CONTENT, AValue);
end;

procedure TDiscordMessage.SetUserName(const AValue: string);
begin
  if FUserName = AValue then
    Exit;
  FUserName := AValue;
  FObject.Add(DS_USERNAME, AValue);
end;

procedure TDiscordMessage.AddRec(const ARecName: string; AJSONArray: TJSONArray);
var
  JSONArray: TJSONArray;
begin
  JSONArray := TJSONArray(FObject.Find(ARecName));
  if Assigned(JSONArray) then
    JSONArray := AJSONArray
  else
    FObject.Add(ARecName, AJSONArray);
end;

constructor TDiscordMessage.Create(const AWebhookURL: string);
begin
  FWebhookUrl := AWebhookURL;
  FObject := TJSONObject.Create;
end;

destructor TDiscordMessage.Destroy;
begin
  FreeAndNil(FObject);
  inherited Destroy;
end;

function TDiscordMessage.SendMessage: boolean;
var
  HttpClient: TFPHTTPClient;
begin
  Result := True;
  HttpClient := TFPHTTPClient.Create(nil);
  try
    HttpClient.AddHeader('Content-Type', 'application/json');
    HttpClient.RequestBody := TRawByteStringStream.Create(JSONMessage);
    HttpClient.Post(FWebhookUrl);
    if HttpClient.ResponseStatusCode <> 204 then
      Result := False;
  finally
    HttpClient.RequestBody.Free;
    HttpClient.Free;
  end;
end;

procedure TDiscordMessage.AddEmbeds(AEmbeds: TDiscordEmbeds);
begin
  if not Assigned(FEmbedsArray) then
  begin
    FEmbedsArray := TJSONArray.Create;
    AddRec(DS_EMBEDS, FEmbedsArray);
  end;
  FEmbedsArray.Add(AEmbeds.GetObject);
end;

end.
