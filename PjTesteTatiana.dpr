program PjTesteTatiana;

uses
  Forms,
  uConexaoBanco in 'uConexaoBanco.pas',
  uControle in 'uControle.pas',
  uProdutoControle in 'uProdutoControle.pas',
  unProduto in 'unProduto.pas' {frmProduto};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmProduto, frmProduto);
  Application.Run;
end.
