unit uControle;

interface

uses
   Windows, Messages, SysUtils, Classes,  Controls, Forms, Dialogs,
   Variants, Contnrs,  DBXFirebird, SqlExpr,  StrUtils, inifiles,
   uConexaoBanco, Data.DB, Datasnap.Provider, Datasnap.DBClient;
type
  TControle = class
    private
      FConexao  : TConexaoBanco;
      FSQL : TSQLQuery;
      FDataSource: TDataSource;
      FClientDataSet: TClientDataSet;
      FProvider: TDataSetProvider;
    public
     constructor Create;
     destructor  Destroy; override;
     property SQLC : TSQLQuery read FSQL write FSQL;
     property DATASOURCE : TDataSource read FDataSource write FDataSource;
     property ClientDataSet : TClientDataSet read FClientDataSet write FClientDataSet;
     property Provider : TDataSetProvider read FProvider write FProvider;
  end;

implementation

{ TControle }
constructor TControle.Create;
begin
  FConexao  := TConexaoBanco.Create;
  FSQL := TSQLQuery.Create(Application);
  FSQL.SQLConnection := FConexao.ConexaoBanco;
  FSQL.FieldDefs.Clear;
  FSQL.FieldDefs.add('codigo',ftInteger);
  FSQL.FieldDefs.add('descricao',ftString,100);
  FSQL.FieldDefs.Create(FSQL);

  FDataSource := TDataSource.Create(Application);
  FProvider := TDataSetProvider.Create(Application);
  FClientDataSet := TClientDataSet.Create(Application);
  FClientDataSet.Close;
  FClientDataSet.FieldDefs.Clear;
  FClientDataSet.FieldDefs.add('codigo',ftInteger);
  FClientDataSet.FieldDefs.add('descricao',ftString,100);
  FClientDataSet.CreateDataSet;
end;

destructor TControle.Destroy;
begin
  inherited;
end;

end.
