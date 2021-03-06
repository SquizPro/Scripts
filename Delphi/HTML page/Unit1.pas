unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    mmo1: TMemo;
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

const
  EnterTXT  =   'C:\1\1.txt';
  ExitTXT   =   'C:\1\Final.txt';

//----------------------------------------Ruru >> Eng translite
function Transliterate(s: string): string;
var
 i: integer;
 t: UTF8String;
begin
 for i:=1 to Length(s) do
  begin
   case s[i] of
        '?': t:=t+'a';
        '?': t:=t+'b';
        '?': t:=t+'v';
        '?': t:=t+'g';
        '?': t:=t+'d';
        '?': t:=t+'e';
        '?': t:=t+'ye';
        '?': t:=t+'zh';
        '?': t:=t+'z';
        '?': t:=t+'i';
        '?': t:=t+'y';
        '?': t:=t+'k';
        '?': t:=t+'l';
        '?': t:=t+'m';
        '?': t:=t+'n';
        '?': t:=t+'o';
        '?': t:=t+'p';
        '?': t:=t+'r';
        '?': t:=t+'s';
        '?': t:=t+'t';
        '?': t:=t+'u';
        '?': t:=t+'f';
        '?': t:=t+'ch';
        '?': t:=t+'z';
        '?': t:=t+'ch';
        '?': t:=t+'sh';
        '?': t:=t+'ch';
        '?': t:=t+'';
        '?': t:=t+'y';
        '?': t:=t+'';
        '?': t:=t+'e';
        '?': t:=t+'yu';
        '?': t:=t+'ya';
        '?': T:=T+'A';
        '?': T:=T+'B';
        '?': T:=T+'V';
        '?': T:=T+'G';
        '?': T:=T+'D';
        '?': T:=T+'E';
        '?': T:=T+'Ye';
        '?': T:=T+'Zh';
        '?': T:=T+'Z';
        '?': T:=T+'I';
        '?': T:=T+'Y';
        '?': T:=T+'K';
        '?': T:=T+'L';
        '?': T:=T+'M';
        '?': T:=T+'N';
        '?': T:=T+'O';
        '?': T:=T+'P';
        '?': T:=T+'R';
        '?': T:=T+'S';
        '?': T:=T+'T';
        '?': T:=T+'U';
        '?': T:=T+'F';
        '?': T:=T+'Ch';
        '?': T:=T+'Z';
        '?': T:=T+'Ch';
        '?': T:=T+'Sh';
        '?': T:=T+'Ch';
        '?': T:=T+'''';
        '?': T:=T+'Y';
        '?': T:=T+'''';
        '?': T:=T+'E';
        '?': T:=T+'Yu';
        '?': T:=T+'Ya';
        ' ': T:=T+'_';
        '.': T:=T+'_';
        ',': T:=T+'_';
      else t:=t+s[i];
   end;
  end;
 Result:=t;
end;

//-------------------Format txt file for HTML text <p>
procedure Format_txt;
var
  Str, CopyStr: TStringList;
  i: cardinal;
begin
  Str:= TStringList.Create;
  CopyStr:= TStringList.Create;
  Str.LoadFromFile(AnsiToUtf8(EnterTXT));
  for i:=0 to Str.Count-1 do begin
  CopyStr.Add('<p>'+ Copy(Str[i],0,Length(Str[i])) +'</p>')
  end;
  Str.Free;
  CopyStr.SaveToFile(AnsiToUtf8(ExitTXT));
  CopyStr.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Str, CopyStr, NewStrBuffer, StrBuf, Category: TStringList;
  i, j: cardinal;
  PageName, PageNameRU: UTF8String;
begin
Randomize;
  Str:= TStringList.Create;
  Str.LoadFromFile(ExitTXT);
  CopyStr:= TStringList.Create;
  CopyStr.LoadFromFile('C:\1\new_page.html');
  Category:= TStringList.Create;

  for i:=0 to Str.Count-1 do begin
    if Pos('<h1>', Str[i])  > 0 then begin
      PageName:= Copy(Str[i],1,Length(Str[i]));
      TrimRight(PageName);
      Delete(PageName, Pos('<h1>',PageName), 4);
      mmo1.Lines.Add(PageName);
      Delete(PageName, Pos('</h1>',PageName), 5);
      mmo1.Lines.Add(PageName);
      PageNameRU:=PageName;
      PageName:= Transliterate(PageName);
      Category.Add('<li><a href="http://sovstroy2016.ru/pages/'+PageName+'.html">'+PagenameRU+'</a></li>');
      NewStrBuffer:= TStringList.Create;
      NewStrBuffer.LoadFromFile('C:\1\TOP_page.html');
      NewStrBuffer.Add(AnsiToUtf8('<header>'));
      NewStrBuffer.Add(AnsiToUtf8(Str[i]));
      NewStrBuffer.Add(AnsiToUtf8('</header>'));
      NewStrBuffer.Add(AnsiToUtf8('<section>'));
        for j:= i+1 to Str.count-1 do begin
        if Pos('<h1>', Str[j]) > 0 then Break;
         NewStrBuffer.Add(AnsiToUtf8(Str[j]));
        end;
      StrBuf:= TStringList.Create;
      StrBuf.LoadFromFile('C:\1\Down_page.html');
      for j:=0 to StrBuf.Count-1 do begin
      NewStrBuffer.Add(AnsiToUtf8(StrBuf[j]));
      end;
      StrBuf.Free;
      for j:=(NewStrBuffer.Count-15) to NewStrBuffer.Count-1 do begin
      if Pos('<a href', NewStrBuffer[j]) > 0 then begin
      NewStrBuffer[j]:= AnsiToUtf8('<a href="http://sovstroy2016.ru">???????</a>');
      end;
      end;
      NewStrBuffer.SaveToFile('C:\1\1\'+PageName+'.html');
      NewStrBuffer.Free;
    end;
  end;


  Category.SaveToFile(AnsiToUtf8('C:\1\1\Fundament.html'));
  Category.Free;
  Str.Free;
  CopyStr.SaveToFile(AnsiToUtf8('C:\1\1\'+IntToStr(Random(1000))+'.html'));
  CopyStr.Free;
end;

end.
