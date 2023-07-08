unit tournament_orm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dsqldbbroker
  ;

type

  { TBaseItem }

  TBaseItem = class
  private
    FInteger: Integer;
  public
    procedure Init; virtual; abstract;
  published
    property ID: Integer read FInteger write FInteger;
  end;

  { TTeam }

  TTeam = class(TBaseItem)
  private
    FName: String;
  published
    property Name: String read FName write FName;
  end;

  { TTournament }

  TTournament = class(TBaseItem)
  private
    FDate: TDate;
    FTitle: String;
  published
    property Date: TDate read FDate write FDate;
    property Title: String read FTitle write FTitle;
  end;

  { TScore }

  TScore = class(TBaseItem)
  private
    FQuestion: Integer;
    FTaken: Boolean;
    FTeam: Integer;
  published
    property Question: Integer read FQuestion write FQuestion;
    property Team: Integer read FTeam write FTeam;
    property Taken: Boolean read FTaken write FTaken;
  end;

  { TQuestion }

  TQuestion = class(TBaseItem)
  private
    FNumber: Integer;
    FRound: Integer;
    FText: String;
    FTournament: Integer;
  published
    property Tournament: Integer read FTournament write FTournament;
    property Round: Integer read FRound write FRound;
    property Number: Integer read FNumber write FNumber;
    property Text: String read FText write FText;
  end;

  
  TopQuestions = specialize TdGSQLdbEntityOpf<TQuestion>;
  TopScores = specialize TdGSQLdbEntityOpf<TScore>;
  TopTeams = specialize TdGSQLdbEntityOpf<TTeam>;
  TopTournaments = specialize TdGSQLdbEntityOpf<TTournament>;

  { TTournamentORM }

  TTournamentORM = class
  public type
  private
    Fcon: TdSQLdbConnector;
    FDatabase: String;
    FDriver: String;
    FLogDebug: Boolean;
    FLogFileName: String;
    FopQuestions: TopQuestions;
    FopScores: TopScores;
    FopTeams: TopTeams;
    FopTournaments: TopTournaments;
    function Con: TdSQLdbConnector;
    function GetopQuestions: TopQuestions;
    function GetopScores: TopScores;
    function GetopTeams: TopTeams;
    function GetopTournaments: TopTournaments;
    function GetTaken(aQuestion: Integer; aTeam: Integer): Boolean;
    function GetTaken(aTournament: Integer; aQuestionNumber: Integer;
      aTeam: Integer): Boolean;
    procedure SetTaken(aQuestion: Integer; aTeam: Integer; AValue: Boolean);
    procedure SetTaken(aTournament: Integer; aQuestionNumber: Integer;
      aTeam: Integer; AValue: Boolean);
  public
    constructor Create(const aDatabase, aDriver: String; aLogDebug: Boolean = false;
      const aLogFileName: String = '');
    destructor Destroy; override;
    function FindQuestion(aTournament: Integer; aNumber: Integer): Boolean;
    property Database: String read FDatabase write FDatabase;
    property Driver: String read FDriver write FDriver;
    property LogDebug: Boolean read FLogDebug write FLogDebug;
    property LogFileName: String read FLogFileName write FLogFileName;
    property Taken [aQuestion: Integer; aTeam: Integer]: Boolean read GetTaken write SetTaken;   
    property TakenTQT [aTournament: Integer; aQuestionNumber: Integer; aTeam: Integer]: Boolean read GetTaken write SetTaken;
    property opQuestions: TopQuestions read GetopQuestions;
    property opScores: TopScores read GetopScores;
    property opTeams: TopTeams read GetopTeams;
    property opTournaments: TopTournaments read GetopTournaments;
  end;

implementation

uses
  SQLite3Conn
  ;

{ TTournamentORM }

function TTournamentORM.Con: TdSQLdbConnector;
begin
  if not Assigned(Fcon) then
  begin
    Fcon := TdSQLdbConnector.Create(nil);
    Fcon.Database := FDatabase;
    Fcon.Driver := FDriver;
    Fcon.Logger.Active := FLogDebug;
    Fcon.Logger.FileName := FLogFileName;
  end;
  Result := Fcon;
end;

function TTournamentORM.GetopQuestions: TopQuestions;
begin
  if not Assigned(FopQuestions) then
  begin
    FopQuestions:=TopQuestions.Create(Con, 'questions');
    FopQuestions.Table.PrimaryKeys.Text:='id';
  end;
  Result:=FopQuestions;
end;

function TTournamentORM.GetopScores: TopScores;
begin
  if not Assigned(FopScores) then
  begin
    FopScores:=TopScores.Create(Con, 'scores');
    FopScores.Table.PrimaryKeys.Text:='id';
  end;
  Result:=FopScores;
end;

function TTournamentORM.GetopTeams: TopTeams;
begin
  if not Assigned(FopTeams) then
  begin
    FopTeams:=TopTeams.Create(Con, 'teams');
    FopTeams.Table.PrimaryKeys.Text:='id';
  end;
  Result:=FopTeams;
end;

function TTournamentORM.GetopTournaments: TopTournaments;
begin
  if not Assigned(FopTournaments) then
  begin
    FopTournaments:=TopTournaments.Create(Con, 'tournaments');
    FopTournaments.Table.PrimaryKeys.Text:='id';
  end;
  Result:=FopTournaments;
end;

function TTournamentORM.GetTaken(aQuestion: Integer; aTeam: Integer): Boolean;
begin
  opScores.Entity.Question:=aQuestion;
  opScores.Entity.Team:=aTeam;
  if opScores.Find('question = :question AND team = :team') then
    Result:=opScores.Entity.Taken
  else
    Result:=False;
end;

function TTournamentORM.GetTaken(aTournament: Integer; aQuestionNumber: Integer; aTeam: Integer): Boolean;
begin
  if not FindQuestion(aTournament, aQuestionNumber) then
    Exit(False);
  Result:=Taken[opQuestions.Entity.id, aTeam];
end;

procedure TTournamentORM.SetTaken(aQuestion: Integer; aTeam: Integer;
  AValue: Boolean);
begin

end;

procedure TTournamentORM.SetTaken(aTournament: Integer;
  aQuestionNumber: Integer; aTeam: Integer; AValue: Boolean);
begin

end;

constructor TTournamentORM.Create(const aDatabase, aDriver: String;
  aLogDebug: Boolean; const aLogFileName: String);
begin
  FDatabase:=aDatabase;
  FDriver:=aDriver;
  FLogDebug:=aLogDebug;
  FLogFileName:=aLogFileName;
end;

destructor TTournamentORM.Destroy;
begin
  FopTournaments.Free;
  FopTeams.Free;      
  FopScores.Free;
  FopQuestions.Free;
  Fcon.Free;
  inherited Destroy;
end;

function TTournamentORM.FindQuestion(aTournament: Integer; aNumber: Integer
  ): Boolean;
begin
  opQuestions.Entity.Tournament:=aTournament;
  opQuestions.Entity.Number:=aNumber;
  Result:=opQuestions.Find('tournament = :tournament AND number = :number');
end;

end.

