unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, discord;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button2Click(Sender: TObject);
var
  Discord: TDiscordMessage;
begin
  Discord := TDiscordMessage.Create(Edit1.Text);
  try
    Discord.Content := 'TEST Simple Message';
    Discord.UserName := 'Web Hook Lazarus Bot';
    Discord.AvatarURL := 'https://a.fsdn.com/allura/p/lazarus/icon?1552026857?&w=90';
    Discord.SendMessage;
  finally
    FreeAndNil(Discord);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Discord: TDiscordMessage;
  Embeds: TDiscordEmbeds;
  Field: TDiscordEmbedsField;
  Footer: TDiscordEmbedsFooter;
  Image: TDiscrodEmbedsImage;
  Thumb: TDiscrodEmbedsThumbNail;
  Author: TDiscrodEmbedsAuthor;
begin
  Discord := TDiscordMessage.Create(Edit1.Text);
  try
    Discord.Content := '';
    Discord.UserName := 'Web Hook Lazarus Bot';
    Discord.AvatarURL := 'https://a.fsdn.com/allura/p/lazarus/icon?1552026857?&w=90';
    // first
    Embeds := TDiscordEmbeds.Create;
    Embeds.Title := 'Lazarus';

    Embeds.URL := 'https://www.lazarus-ide.org/';
    Embeds.Description := 'Lazarus is a Delphi compatible cross-platform IDE for Rapid Application Development.';
    Embeds.Color := $0000FF;
    // Image
    Image := TDiscrodEmbedsImage.Create;
    Image.URL := 'https://wiki.lazarus.freepascal.org/images/5/5d/Windows_10.png';
    Embeds.SetImage(Image);
    FreeAndNil(image);

    // thumb
    Thumb := TDiscrodEmbedsThumbNail.Create;
    Thumb.URL := 'https://www.freepascal.org/pic/lazarus_produced_logo.gif';
    Embeds.SetThumbNail(Thumb);
    FreeAndNil(Thumb);

    // Author
    Author := TDiscrodEmbedsAuthor.Create;
    Author.Name := 'Lazarus and Free Pascal Team';
    Author.IconUrl := 'https://a.fsdn.com/allura/p/lazarus/icon?1552026857?&w=90';
    Embeds.SetAuthor(Author);
    FreeAndNil(Author);

    // footer
    Footer := TDiscordEmbedsFooter.Create;
    Footer.Text := 'It supports the creation of self-standing graphical and console applications and runs on Linux, FreeBSD, MacOSX and Windows.';
    Footer.IconUrl := 'https://a.fsdn.com/allura/p/lazarus/icon?1552026857?&w=90';
    Embeds.SetFooter(Footer);
    FreeAndNil(Footer);


    // field 1
    Field := TDiscordEmbedsField.Create;
    Field.Name := 'Version';
    Field.Value := '2.0.6';
    Field.mInline := False;
    Embeds.AddField(Field);
    FreeAndNil(Field);
    // field 2
    Field := TDiscordEmbedsField.Create;
    Field.Name := 'Forum';
    Field.Value := format('[%s](%s)', ['Link', 'https://forum.lazarus.freepascal.org/index.php?action=forum']);
    Field.mInline := True;
    Embeds.AddField(Field);
    FreeAndNil(Field);
    // field 2
    Field := TDiscordEmbedsField.Create;
    Field.Name := 'Wiki';
    Field.Value := format('[%s](%s)', ['Link', 'https://wiki.freepascal.org/']);
    Field.mInline := True;

    Embeds.AddField(Field);
    FreeAndNil(Field);
    Discord.AddEmbeds(Embeds);
    FreeAndNil(Embeds);


    // second
    Embeds := TDiscordEmbeds.Create;
    Embeds.Title := 'Free Pascal';
    Embeds.URL := 'https://www.freepascal.org/';
    Embeds.Description := 'Free Pascal is a 32, 64 and 16 bit professional Pascal compiler.';
    Embeds.Color := $FF0000;

    Discord.AddEmbeds(Embeds);

    FreeAndNil(Embeds);

    Discord.SendMessage;
  finally
    FreeAndNil(Discord);
  end;
end;

end.

