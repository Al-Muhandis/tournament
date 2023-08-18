unit frmtournamentform;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, ComCtrls, Menus, RxDBGridExportSpreadSheet, RxSortZeos, ZDataset, ZConnection,
  RxDBGrid, DBCtrls, ExtCtrls, StdCtrls, Spin, rxlookup
  ;

type



  { TFrameTournament }

  TFrameTournament = class(TFrame)
    DBGrdTournaments: TRxDBGrid;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DBNvgtrTournaments: TDBNavigator;
    DtSrcScoreTable: TDataSource;
    DtSrcTeams: TDataSource;
    DtSrcTournaments: TDataSource;
    GrpBxRules: TGroupBox;
    GrpBxBet: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    miFullScreen: TMenuItem;
    miScreen1: TMenuItem;
    miScreen2: TMenuItem;
    PgCntrl: TPageControl;
    PgCntrlRounds: TPageControl;
    RdGrpQuestionCount: TRadioGroup;
    RxDBGrdScoreTable: TRxDBGrid;
    RxDBGrdScoreTable1: TRxDBGrid;
    RxDBGrdScoreTable2: TRxDBGrid;
    RxDBGrdScoreTable3: TRxDBGrid;
    RxDBGrdScoreTable4: TRxDBGrid;
    RxDBGridExportSpreadSheet1: TRxDBGridExportSpreadSheet;
    RxDBGridTeams: TRxDBGrid;
    RxLookupEdit1: TRxLookupEdit;
    RxSrtZs: TRxSortZeos;
    SpnEdtBet: TSpinEdit;
    StringField1: TStringField;
    TbShtOptions: TTabSheet;
    TbShtAllRounds: TTabSheet;
    TbShtResult: TTabSheet;
    TbShtRound1: TTabSheet;
    TbShtRound2: TTabSheet;
    TbShtRound3: TTabSheet;
    TbShtScoreTableAllRounds: TTabSheet;
    TbShtTeams: TTabSheet;
    TbShtTournament: TTabSheet;
    TlBrScoreTable: TToolBar;
    TlBrTeams: TToolBar;
    TlBrTournaments: TToolBar;
    ToolButton1: TToolButton;
    ZCnctn: TZConnection;
    ZQryScoreTable: TZQuery;
    ZQryScoreTablebet1round: TBooleanField;
    ZQryScoreTablebet2round: TBooleanField;
    ZQryScoreTablebet3round: TBooleanField;
    ZQryScoreTableid: TLargeintField;
    ZQryScoreTableq1: TBooleanField;
    ZQryScoreTableq10: TBooleanField;
    ZQryScoreTableq11: TBooleanField;
    ZQryScoreTableq12: TBooleanField;
    ZQryScoreTableq13: TBooleanField;
    ZQryScoreTableq14: TBooleanField;
    ZQryScoreTableq15: TBooleanField;
    ZQryScoreTableq16: TBooleanField;
    ZQryScoreTableq17: TBooleanField;
    ZQryScoreTableq18: TBooleanField;
    ZQryScoreTableq19: TBooleanField;
    ZQryScoreTableq2: TBooleanField;
    ZQryScoreTableq20: TBooleanField;
    ZQryScoreTableq21: TBooleanField;
    ZQryScoreTableq22: TBooleanField;
    ZQryScoreTableq23: TBooleanField;
    ZQryScoreTableq24: TBooleanField;
    ZQryScoreTableq25: TBooleanField;
    ZQryScoreTableq26: TBooleanField;
    ZQryScoreTableq27: TBooleanField;
    ZQryScoreTableq28: TBooleanField;
    ZQryScoreTableq29: TBooleanField;
    ZQryScoreTableq3: TBooleanField;
    ZQryScoreTableq30: TBooleanField;
    ZQryScoreTableq31: TBooleanField;
    ZQryScoreTableq32: TBooleanField;
    ZQryScoreTableq33: TBooleanField;
    ZQryScoreTableq4: TBooleanField;
    ZQryScoreTableq5: TBooleanField;
    ZQryScoreTableq6: TBooleanField;
    ZQryScoreTableq7: TBooleanField;
    ZQryScoreTableq8: TBooleanField;
    ZQryScoreTableq9: TBooleanField;
    ZQryScoreTableResult: TLongintField;
    ZQryScoreTableRound1: TLongintField;
    ZQryScoreTableRound1Club: TLongintField;
    ZQryScoreTableRound2: TLongintField;
    ZQryScoreTableRound2Club: TLongintField;
    ZQryScoreTableRound3: TLongintField;
    ZQryScoreTableRound3Club: TLongintField;
    ZQryScoreTableteam: TLargeintField;
    ZQryScoreTabletournament: TLargeintField;
    ZQryTeams: TZQuery;
    ZQryTeamsid: TLargeintField;
    ZQryTeamsname: TStringField;
    ZQryTournaments: TZQuery;
    ZQryTournamentsdate: TDateField;
    ZQryTournamentsid: TLargeintField;
    ZQryTournamentstitle: TStringField;
    procedure RdGrpQuestionCountClick(Sender: TObject);
    procedure SpnEdtBetChange(Sender: TObject);
    procedure ZQryScoreTableAfterInsert({%H-}DataSet: TDataSet);
    procedure ZQryScoreTableCalcFields({%H-}DataSet: TDataSet);
    procedure ZQryTournamentsAfterScroll({%H-}DataSet: TDataSet);
  private
    function GetQ11InRound: Boolean;
    function GetQuestionWithBet: Integer;
    procedure SetQ11InRound(AValue: Boolean);
    procedure SetQuestionWithBet(AValue: Integer);
    procedure SetToolBarVisible(AValue: Boolean);
    procedure UpdateColumns;
  public
    procedure InitDB;
    procedure ApplyDB;                                               
    function FieldFromQuestion(aQuestionNum: Integer): TBooleanField;
    function QuestionsInRound: Integer;
    property ToolBarVisible: Boolean write SetToolBarVisible;
    property Q11InRound: Boolean read GetQ11InRound write SetQ11InRound;
    property QuestionWithBet: Integer read GetQuestionWithBet write SetQuestionWithBet;
  end;

implementation

{$R *.lfm}

var
  AppDir: String;

const
  _SQLEval1=
  'CREATE TABLE IF NOT EXISTS teams (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING (128));';
  _SQLEval2=
  'CREATE TABLE IF NOT EXISTS tournaments (id INTEGER PRIMARY KEY AUTOINCREMENT, date  DATE, title STRING (256));';
  _SQLEval3=
  'CREATE TABLE IF NOT EXISTS scores (id INTEGER PRIMARY KEY AUTOINCREMENT, tournament INTEGER, team INTEGER, '+
  'q1 BOOLEAN DEFAULT (0), q2 BOOLEAN DEFAULT (0), q3 BOOLEAN DEFAULT (0), q4 BOOLEAN DEFAULT (0), q5 BOOLEAN DEFAULT (0), q6 BOOLEAN DEFAULT (0), q7 BOOLEAN DEFAULT (0), q8 BOOLEAN DEFAULT (0), q9 BOOLEAN DEFAULT (0), q10  BOOLEAN DEFAULT (0), q11  BOOLEAN DEFAULT (0), '+
  'q12  BOOLEAN DEFAULT (0), q13  BOOLEAN DEFAULT (0), q14  BOOLEAN DEFAULT (0), q15  BOOLEAN DEFAULT (0), q16  BOOLEAN DEFAULT (0), q17  BOOLEAN DEFAULT (0), q18  BOOLEAN DEFAULT (0), q19  BOOLEAN DEFAULT (0), q20  BOOLEAN DEFAULT (0), q21  BOOLEAN DEFAULT (0), q22  BOOLEAN DEFAULT (0), '+
  'q23  BOOLEAN DEFAULT (0), q24  BOOLEAN DEFAULT (0), q25  BOOLEAN DEFAULT (0), q26  BOOLEAN DEFAULT (0), q27  BOOLEAN DEFAULT (0), q28  BOOLEAN DEFAULT (0), q29  BOOLEAN DEFAULT (0), q30  BOOLEAN DEFAULT (0), q31  BOOLEAN DEFAULT (0), q32  BOOLEAN DEFAULT (0), q33  BOOLEAN DEFAULT (0), '+
  'bet1round  BOOLEAN DEFAULT (0), '+
  'bet2round  BOOLEAN DEFAULT (0), '+
  'bet3round  BOOLEAN DEFAULT (0), '+
  'UNIQUE (tournament, team) ON CONFLICT IGNORE);';


resourcestring
  s_IntelGames='Intellectual games';


{ TFrameTournament }

procedure TFrameTournament.ZQryScoreTableAfterInsert(DataSet: TDataSet);
var
  aField: TField;
begin
  ZQryScoreTabletournament.AsInteger:=ZQryTournamentsid.AsInteger;
  for aField in ZQryScoreTable.Fields do
    if aField is TBooleanField then
      TBooleanField(aField).AsBoolean:=False;
end;

procedure TFrameTournament.RdGrpQuestionCountClick(Sender: TObject);
begin
  Q11InRound:=TRadioGroup(Sender).ItemIndex=1;
end;

procedure TFrameTournament.SpnEdtBetChange(Sender: TObject);
var
  aCanBets: Boolean;
begin
  ZQryScoreTable.Refresh;
  aCanBets:=TSpinEdit(Sender).Value>0;
  ZQryScoreTablebet1round.Visible:=aCanBets;
  ZQryScoreTablebet2round.Visible:=aCanBets;
  ZQryScoreTablebet3round.Visible:=aCanBets;
end;

procedure TFrameTournament.ZQryScoreTableCalcFields(DataSet: TDataSet);
var
  aQInRound, aScore: Integer;

  { if bet is set then doubled a point if valid answer or decrement if not valid answer }
  procedure CorrectWithBet(IsBet: Boolean; aRound: Byte; var aRoundScore: Integer);
  begin
    if (SpnEdtBet.Value>0) and IsBet then
      if FieldFromQuestion(SpnEdtBet.Value+(aRound-1)*aQInRound).AsBoolean then
        Inc(aRoundScore)
      else
        Dec(aRoundScore);
  end;

begin
  aQInRound:=QuestionsInRound;
  aScore:=ZQryScoreTableq1.AsInteger+ZQryScoreTableq2.AsInteger+ZQryScoreTableq3.AsInteger+
    ZQryScoreTableq4.AsInteger+ZQryScoreTableq5.AsInteger+ZQryScoreTableq6.AsInteger+ZQryScoreTableq7.AsInteger+
    ZQryScoreTableq8.AsInteger+ZQryScoreTableq9.AsInteger+ZQryScoreTableq10.AsInteger+ZQryScoreTableq11.AsInteger;
  CorrectWithBet(ZQryScoreTablebet1round.AsBoolean, 1, aScore);
  ZQryScoreTableRound1.AsInteger:=aScore;
  ZQryScoreTableRound1Club.AsInteger:=aQInRound-aScore;
  aScore:=ZQryScoreTableq12.AsInteger+ZQryScoreTableq13.AsInteger+ZQryScoreTableq14.AsInteger+
    ZQryScoreTableq15.AsInteger+ZQryScoreTableq16.AsInteger+ZQryScoreTableq17.AsInteger+ZQryScoreTableq18.AsInteger+
    ZQryScoreTableq19.AsInteger+ZQryScoreTableq20.AsInteger+ZQryScoreTableq21.AsInteger+ZQryScoreTableq22.AsInteger;
  CorrectWithBet(ZQryScoreTablebet2round.AsBoolean, 2, aScore);
  ZQryScoreTableRound2.AsInteger:=aScore;
  ZQryScoreTableRound2Club.AsInteger:=aQInRound-aScore;
  aScore:=ZQryScoreTableq23.AsInteger+ZQryScoreTableq24.AsInteger+ZQryScoreTableq25.AsInteger+
    ZQryScoreTableq26.AsInteger+ZQryScoreTableq27.AsInteger+ZQryScoreTableq28.AsInteger+ZQryScoreTableq29.AsInteger+
    ZQryScoreTableq30.AsInteger+ZQryScoreTableq31.AsInteger+ZQryScoreTableq32.AsInteger+ZQryScoreTableq33.AsInteger;
  CorrectWithBet(ZQryScoreTablebet3round.AsBoolean, 3, aScore);
  ZQryScoreTableRound3.AsInteger:=aScore;
  ZQryScoreTableRound3Club.AsInteger:=aQInRound-ZQryScoreTableRound3.AsInteger;
  ZQryScoreTableResult.AsInteger:=ZQryScoreTableRound1.AsInteger+
    ZQryScoreTableRound2.AsInteger+ZQryScoreTableRound3.AsInteger;
end;

procedure TFrameTournament.ZQryTournamentsAfterScroll(DataSet: TDataSet);
begin
  ZQryScoreTable.SQL.Text:='select * from scores where tournament = '+ZQryTournamentsid.AsInteger.ToString;
  ZQryScoreTable.Open;
  Caption:=s_IntelGames+'. ['+ZQryTournamentstitle.AsString+']';
end;

function TFrameTournament.GetQ11InRound: Boolean;
begin
  Result:=RdGrpQuestionCount.ItemIndex=1
end;

function TFrameTournament.GetQuestionWithBet: Integer;
begin
  Result:=SpnEdtBet.Value;
end;

procedure TFrameTournament.SetQ11InRound(AValue: Boolean);
begin
  if AValue then
    RdGrpQuestionCount.ItemIndex:=1
  else
    RdGrpQuestionCount.ItemIndex:=0;
  ZQryScoreTableq11.Visible:=AValue;
  ZQryScoreTableq22.Visible:=AValue;
  ZQryScoreTableq33.Visible:=AValue;
  UpdateColumns;
end;

procedure TFrameTournament.SetQuestionWithBet(AValue: Integer);
begin
  SpnEdtBet.Value:=AValue;
end;

procedure TFrameTournament.SetToolBarVisible(AValue: Boolean);
begin
  TlBrScoreTable.Visible:=AValue;
  TlBrTeams.Visible:=AValue;
end;

procedure TFrameTournament.UpdateColumns;
var
  i, j: Integer;

  procedure UpdateGridCols(aRxDBGrd: TRxDBGrid; Is11Questions: Boolean);
  var
    aCol: TRxColumn;
  begin
    for aCol in aRxDBGrd.Columns do
      if aCol.FieldName.StartsWith('q') then
      begin
        Inc(i);
        if not Is11Questions and ((i mod 11) = 0) then
          Continue;
        Inc(j);
        aCol.Title.Caption:=j.ToString;
      end;
  end;

begin
  i:=0;
  j:=0;
  UpdateGridCols(RxDBGrdScoreTable, Q11InRound);
  i:=0;
  j:=0;
  UpdateGridCols(RxDBGrdScoreTable1, Q11InRound);
  UpdateGridCols(RxDBGrdScoreTable2, Q11InRound);
  UpdateGridCols(RxDBGrdScoreTable3, Q11InRound);
end;

function TFrameTournament.FieldFromQuestion(aQuestionNum: Integer): TBooleanField;
begin
  if not Q11InRound then
  begin
    if aQuestionNum>20 then
      Inc(aQuestionNum);
    if aQuestionNum>10 then
      Inc(aQuestionNum);
  end;
  Result:=ZQryScoreTable.FieldByName('q'+aQuestionNum.ToString) as TBooleanField;
end;

function TFrameTournament.QuestionsInRound: Integer;
begin
  if Q11InRound then
    Exit(11)
  else
    Exit(10);
end;

procedure TFrameTournament.InitDB;
begin
  ZCnctn.Disconnect;
  ZCnctn.Database:=AppDir+'tournaments.sqlite';
  ZCnctn.Connect;
  ZCnctn.ExecuteDirect(_SQLEval1);
  ZCnctn.ExecuteDirect(_SQLEval2);
  ZCnctn.ExecuteDirect(_SQLEval3);
  ZQryTournaments.Open;
  ZQryTeams.Open;
  ZQryScoreTable.SQL.Text:='select * from scores where tournament = '+ZQryTournamentsid.AsInteger.ToString;
  ZQryScoreTable.Open;
end;

procedure TFrameTournament.ApplyDB;
begin
  ZQryScoreTable.ApplyUpdates;
end;

initialization
  AppDir:=IncludeTrailingPathDelimiter(ExtractFileDir(ParamStr(0)));

end.

