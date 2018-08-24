unit uConexaoBanco;

interface

uses

  SqlExpr, inifiles, SysUtils, Forms, dialogs;
type

   TConexaoBanco = class
      private
       FConexaoBanco : TSQLConnection;
      public
       constructor Create;
       destructor  Destroy; override;
       function GetConexao : TSQLConnection;
       property ConexaoBanco : TSQLConnection   read GetConexao;
   end;

implementation

{ TConexaoBanco }


constructor TConexaoBanco.Create;

var
  ArquivoINI,
  Servidor,
  Caminho,
  DriverName,
  UserName,
  PassWord : String;
  LocalServer : Integer;
  Configuracoes : TIniFile;

begin
   ArquivoINI := ExtractFilePath(Application.ExeName) + '\config.ini';

   if not FileExists(ArquivoINI) then
   begin
     Showmessage('Arquivo de Config não Encontrado!');
     Exit;
    end;

   Configuracoes := TIniFile.Create(ArquivoINI);
   Try
     Servidor   := Configuracoes.ReadString('Dados', 'Servidor',   Servidor);
     Caminho    := Configuracoes.ReadString('Dados', 'DataBase',   Caminho);
     DriverName := Configuracoes.ReadString('Dados', 'DriverName', DriverName);
     UserName   := Configuracoes.ReadString('Dados', 'UserName',   UserName);
     PassWord   := Configuracoes.ReadString('Dados', 'PassWord',   PassWord);
   Finally
     Configuracoes.Free;
   end;

   try
     FConexaoBanco := TSQLConnection.Create(Application);
     FConexaoBanco.ConnectionName := 'FBConnection';
     FConexaoBanco.DriverName     := 'Firebird';
     FConexaoBanco.LibraryName    := 'dbxfb.dll';
     FConexaoBanco.VendorLib      := 'fbclient.dll';
     FConexaoBanco.GetDriverFunc  := 'getSQLDriverINTERBASE';
     FConexaoBanco.LoginPrompt    := False;
     FConexaoBanco.Connected  := False;
     FConexaoBanco.Params.Values['DataBase']   := Servidor + ':' + Caminho;
     FConexaoBanco.Params.Values['User_Name']  := UserName;
     FConexaoBanco.Params.Values['Password']   := PassWord;
     FConexaoBanco.Connected  := True;
   except
     Showmessage('Erro ao Conectar o Banco de dados. Verifique as preferencias do sistema!');
   end;
end;



destructor TConexaoBanco.Destroy;
begin
  FConexaoBanco.Free;
  inherited;
end;



function TConexaoBanco.GetConexao: TSQLConnection;
begin
  Result := FConexaoBanco;
end;

end.
