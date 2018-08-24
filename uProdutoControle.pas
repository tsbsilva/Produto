unit uProdutoControle;
 
interface
 
uses
 
Windows, SysUtils, Classes, Controls, Forms, ComCtrls, uControle, SqlExpr, Data.DB;
 
type
 
TProdutoControle = class
 
private
 
FCodigo : String;
 
FDescricao : String;
 
 
Fcontrole :TControle;

 
public
 
  
 
constructor Create(pConexaoControle:TControle);
 
destructor Destroy; override;
function GetNewCodigoProduto: Integer;
function JaCadastrado: boolean;
 
//
 
function InsereProduto : Boolean;
 
function AlteraProduto : Boolean;
 
function ExcluirProduto : Boolean;
 
function PesquisaProduto: TControle;

//


property Codigo : String read FCodigo write FCodigo;
 
property Descricao : String read FDescricao write FDescricao;


 
  
 
end;
 
  
 
implementation
 
{ DateHourPSE }
 
function TProdutoControle.AlteraProduto: Boolean;
begin
  FControle.SQLC.Close;
  FControle.SQLC.SQL.Clear;
  FControle.SQLC.SQL.Add(' UPDATE produto ');
  FControle.SQLC.SQL.Add(' SET descricao = :descricao ');
  FControle.SQLC.SQL.Add(' where codigo = :codigo ');
  FControle.SQLC.ParamByName('codigo').AsString := Self.Codigo;
  FControle.SQLC.ParamByName('descricao').AsString := Self.Descricao;
  try
   FControle.SQLC.ExecSQL;
   Result := True;
  except
    Result := False;
  end;
end;
 
  
 
constructor TProdutoControle.Create(pConexaoControle:TControle);
begin
 Fcontrole := pConexaoControle;
end;
 
  
 
destructor TProdutoControle.Destroy;
begin
inherited;
end;

function TProdutoControle.ExcluirProduto: Boolean;
begin
  Fcontrole.SQLC.Close;
  FControle.SQLC.SQL.Clear;
  FControle.SQLC.SQL.Add(' DELETE FROM PRODUTO P ');
  FControle.SQLC.SQL.Add(' WHERE P.CODIGO = :CODIGO ');
  FControle.SQLC.ParamByName('CODIGO').AsString := Self.Codigo;

  try
   FControle.SQLC.ExecSQL;
   Result := True;
   except
     Result := False;
   end
end;

function TProdutoControle.GetNewCodigoProduto: Integer;
var
 vCodigo: Integer;
begin
  FControle.SQLC.Close;
  FControle.SQLC.SQL.Clear;
  FControle.SQLC.SQL.Add('select max(codigo) as qt from produto');
  FControle.SQLC.OPen;

  if FControle.SQLC.FieldByName('qt').asinteger <= 0 then
   Result := 1
  else
   Result := FControle.SQLC.FieldByName('qt').asinteger + 1;
end;

function TProdutoControle.JaCadastrado: boolean;
begin
  Result := False;
  FControle.SQLC.Close;
  FControle.SQLC.SQL.Clear;
  FControle.SQLC.SQL.Add('select codigo  from produto where codigo = :codigo');
  FControle.SQLC.ParamByName('CODIGO').AsString := Self.Codigo;
  FControle.SQLC.OPen;

  if FControle.SQLC.FieldByName('codigo').asinteger > 0 then
   Result := True;
end;

  

function TProdutoControle.InsereProduto: Boolean;

begin




  FControle.SQLC.Close;
  FControle.SQLC.SQL.Clear;
  FControle.SQLC.SQL.Add(' INSERT INTO PRODUTO ');
  FControle.SQLC.SQL.Add(' (CODIGO, ');
  FControle.SQLC.SQL.Add(' DESCRICAO) ');
  FControle.SQLC.SQL.Add(' VALUES (' + Self.Codigo + ',');
  FControle.SQLC.SQL.Add(''''+ Self.Descricao +''')');
  try
    FControle.SQLC.ExecSQL;
    Result := True;
   except
     Result := False;
   end;
end;
 
  
 
function TProdutoControle.PesquisaProduto: TControle;
begin
FControle.SQLC.Close;
FControle.SQLC.SQL.Clear;
FControle.SQLC.SQL.Add(' SELECT codigo, ');
FControle.SQLC.SQL.Add(' descricao ');
FControle.SQLC.SQL.Add(' FROM produto order by codigo ');
FControle.SQLC.ExecSQL;


 Fcontrole.ClientDataSet.EmptyDataSet;

 FControle.SQLC.Open;
 while not FControle.SQLC.Eof do
 begin
  Fcontrole.ClientDataSet.Insert;
  Fcontrole.ClientDataSet.FieldByName('codigo').asstring := FControle.SQLC.FieldByName('codigo').asstring;
  Fcontrole.ClientDataSet.FieldByName('descricao').asstring := FControle.SQLC.FieldByName('descricao').asstring;

  Fcontrole.ClientDataSet.Post;
   FControle.SQLC.Next
 end;
 
 Fcontrole.ClientDataSet.ProviderName := Fcontrole.Provider.Name;
 Fcontrole.Provider.DataSet := FControle.SQLC;
 Fcontrole.DATASOURCE.DataSet := Fcontrole.ClientDataSet;


Result := Fcontrole;

end;

end.
