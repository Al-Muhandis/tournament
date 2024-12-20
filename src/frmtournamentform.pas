unit frmtournamentform;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, ComCtrls, Menus, RxDBGridExportSpreadSheet, RxSortZeos, ZDataset, ZConnection,
  RxDBGrid, DBCtrls, ExtCtrls, StdCtrls, Spin
  ;

type

  TBetOptionChanged = procedure (aQuestionNum: Integer) of object;

  { TFrameTournament }

  TFrameTournament = class(TFrame)
    DBGrdTournaments: TRxDBGrid;
    DBLkpCmbBx: TDBLookupComboBox;
    DBNvgtr: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DBNvgtrTournaments: TDBNavigator;
    DtSrcScoreTable: TDataSource;
    DtSrcTeams: TDataSource;
    DtSrcTournaments: TDataSource;
    GrpBxRules: TGroupBox;
    GrpBxBet: TGroupBox;
    LblBetNumInRound: TLabel;
    LblBet0IsOff: TLabel;
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
    RxDBGrdScoreTableTotal: TRxDBGrid;
    RxDBGrdExprtSprdSht: TRxDBGridExportSpreadSheet;
    RxDBGridTeams: TRxDBGrid;
    RxSrtZs: TRxSortZeos;
    SpnEdtBet: TSpinEdit;
    ZQryScoreTableteamname: TStringField;
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
    ZQryScoreTableq34: TBooleanField;
    ZQryScoreTableq35: TBooleanField;
    ZQryScoreTableq36: TBooleanField;
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
    procedure DBLkpCmbBxSelect({%H-}Sender: TObject);
    procedure RdGrpQuestionCountClick(Sender: TObject);
    procedure SpnEdtBetChange(Sender: TObject);
    procedure ZQryScoreTableAfterInsert({%H-}DataSet: TDataSet);
    procedure ZQryScoreTableCalcFields({%H-}DataSet: TDataSet);
  private
    FOnBetOptionChanged: TBetOptionChanged;
    procedure DoQuestionWithBetChanged(aQuestionWithBet: Integer);
    function GetQInRound: Byte;
    function GetQuestionWithBet: Integer;
    procedure SetQInRound(AValue: Byte);
    procedure SetQuestionWithBet(AValue: Integer);
    procedure SetToolBarVisible(AValue: Boolean);
    procedure UpdateColumns;
    procedure UpdateScore;
  public
    procedure InitDB;
    procedure ApplyDB;                                               
    function FieldFromQuestion(aQuestionNum: Integer): TBooleanField;
    function BetFieldFromQuestion(aQuestionNum: Integer): TBooleanField;
    function QuestionsInRound: Integer;                              
    function RoundFromQuestion(aQuestion: Integer): Integer;
    property ToolBarVisible: Boolean write SetToolBarVisible;
    property QInRound: Byte read GetQInRound write SetQInRound;
    property QuestionWithBet: Integer read GetQuestionWithBet write SetQuestionWithBet;
    property OnBetOptionChanged: TBetOptionChanged read FOnBetOptionChanged write FOnBetOptionChanged;
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
  'q12  BOOLEAN DEFAULT (0), q13  BOOLEAN DEFAULT (0), q14  BOOLEAN DEFAULT (0), q15  BOOLEAN DEFAULT (0), '+
  'q16  BOOLEAN DEFAULT (0), q17  BOOLEAN DEFAULT (0), q18  BOOLEAN DEFAULT (0), q19  BOOLEAN DEFAULT (0), '+
  'q20  BOOLEAN DEFAULT (0), q21  BOOLEAN DEFAULT (0), q22  BOOLEAN DEFAULT (0), '+
  'q23  BOOLEAN DEFAULT (0), q24  BOOLEAN DEFAULT (0), q25  BOOLEAN DEFAULT (0), q26  BOOLEAN DEFAULT (0), '+
  'q27  BOOLEAN DEFAULT (0), q28  BOOLEAN DEFAULT (0), q29  BOOLEAN DEFAULT (0), q30  BOOLEAN DEFAULT (0), '+
  'q31  BOOLEAN DEFAULT (0), q32  BOOLEAN DEFAULT (0), q33  BOOLEAN DEFAULT (0), q34  BOOLEAN DEFAULT (0), '+
  'q35  BOOLEAN DEFAULT (0), q36  BOOLEAN DEFAULT (0), '+
  'bet1round  BOOLEAN DEFAULT (0), '+
  'bet2round  BOOLEAN DEFAULT (0), '+
  'bet3round  BOOLEAN DEFAULT (0), '+
  'UNIQUE (tournament, team) ON CONFLICT IGNORE);';

{ TFrameTournament }

procedure TFrameTournament.ZQryScoreTableAfterInsert(DataSet: TDataSet);
var
  aField: TField;
  aTour: LongInt;
begin
  if DBLkpCmbBx.KeyValue<>Null then
    aTour:=DBLkpCmbBx.KeyValue
  else
    aTour:=-1;
  ZQryScoreTabletournament.AsInteger:=aTour;
  for aField in ZQryScoreTable.Fields do
    if aField is TBooleanField then
      TBooleanField(aField).AsBoolean:=False;
end;

procedure TFrameTournament.RdGrpQuestionCountClick(Sender: TObject);
begin
  QInRound:=TRadioGroup(Sender).ItemIndex+10;
end;

procedure TFrameTournament.DBLkpCmbBxSelect(Sender: TObject);
begin
  UpdateScore;
end;

procedure TFrameTournament.SpnEdtBetChange(Sender: TObject);
begin
  DoQuestionWithBetChanged(TSpinEdit(Sender).Value);
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
    ZQryScoreTableq8.AsInteger+ZQryScoreTableq9.AsInteger+ZQryScoreTableq10.AsInteger+ZQryScoreTableq11.AsInteger+
    ZQryScoreTableq12.AsInteger;
  CorrectWithBet(ZQryScoreTablebet1round.AsBoolean, 1, aScore);
  ZQryScoreTableRound1.AsInteger:=aScore;
  ZQryScoreTableRound1Club.AsInteger:=aQInRound-aScore;
  aScore:=ZQryScoreTableq13.AsInteger+ZQryScoreTableq14.AsInteger+ZQryScoreTableq15.AsInteger+
    ZQryScoreTableq16.AsInteger+ZQryScoreTableq17.AsInteger+ZQryScoreTableq18.AsInteger+ZQryScoreTableq19.AsInteger+
    ZQryScoreTableq20.AsInteger+ZQryScoreTableq21.AsInteger+ZQryScoreTableq22.AsInteger+ZQryScoreTableq23.AsInteger+
    ZQryScoreTableq24.AsInteger;
  CorrectWithBet(ZQryScoreTablebet2round.AsBoolean, 2, aScore);
  ZQryScoreTableRound2.AsInteger:=aScore;
  ZQryScoreTableRound2Club.AsInteger:=aQInRound-aScore;
  aScore:=ZQryScoreTableq25.AsInteger+ZQryScoreTableq26.AsInteger+ZQryScoreTableq27.AsInteger+
    ZQryScoreTableq28.AsInteger+ZQryScoreTableq29.AsInteger+ZQryScoreTableq30.AsInteger+ZQryScoreTableq31.AsInteger+
    ZQryScoreTableq32.AsInteger+ZQryScoreTableq33.AsInteger+ZQryScoreTableq34.AsInteger+ZQryScoreTableq35.AsInteger
    +ZQryScoreTableq36.AsInteger;
  CorrectWithBet(ZQryScoreTablebet3round.AsBoolean, 3, aScore);
  ZQryScoreTableRound3.AsInteger:=aScore;
  ZQryScoreTableRound3Club.AsInteger:=aQInRound-ZQryScoreTableRound3.AsInteger;
  ZQryScoreTableResult.AsInteger:=ZQryScoreTableRound1.AsInteger+
    ZQryScoreTableRound2.AsInteger+ZQryScoreTableRound3.AsInteger;
end;

procedure TFrameTournament.DoQuestionWithBetChanged(aQuestionWithBet: Integer);
var
  aCanBets: Boolean;
begin
  ZQryScoreTable.Refresh;
  aCanBets:=aQuestionWithBet>0;
  ZQryScoreTablebet1round.Visible:=aCanBets;
  ZQryScoreTablebet2round.Visible:=aCanBets;
  ZQryScoreTablebet3round.Visible:=aCanBets;
  if Assigned(FOnBetOptionChanged) then
    FOnBetOptionChanged(aQuestionWithBet);
end;

function TFrameTournament.GetQInRound: Byte;
begin
  Result:=RdGrpQuestionCount.ItemIndex+10
end;

function TFrameTournament.GetQuestionWithBet: Integer;
begin
  Result:=SpnEdtBet.Value;
end;

procedure TFrameTournament.SetQInRound(AValue: Byte);
begin
  case AValue of
    10: RdGrpQuestionCount.ItemIndex:=0;
    11: RdGrpQuestionCount.ItemIndex:=1;
    12: RdGrpQuestionCount.ItemIndex:=2;
  else
    RdGrpQuestionCount.ItemIndex:=1;
  end;
  ZQryScoreTableq12.Visible:=AValue>11;
  ZQryScoreTableq24.Visible:=AValue>11;
  ZQryScoreTableq36.Visible:=AValue>11;
  ZQryScoreTableq11.Visible:=AValue>10;
  ZQryScoreTableq23.Visible:=AValue>10;
  ZQryScoreTableq35.Visible:=AValue>10;
  UpdateColumns;
end;

procedure TFrameTournament.SetQuestionWithBet(AValue: Integer);
begin
  SpnEdtBet.Value:=AValue;
  DoQuestionWithBetChanged(AValue);
end;

procedure TFrameTournament.SetToolBarVisible(AValue: Boolean);
begin
  TlBrScoreTable.Visible:=AValue;
  TlBrTeams.Visible:=AValue;
end;

procedure TFrameTournament.UpdateColumns;
var
  i, j: Integer;

  procedure UpdateGridCols(aRxDBGrd: TRxDBGrid; aQInRound: Byte);
  var
    aCol: TRxColumn;
    a: Integer;
  begin
    for aCol in aRxDBGrd.Columns do
      if aCol.FieldName.StartsWith('q') then
      begin
        Inc(i);
        a:=i mod 12;
        if (aQInRound=10) and ((a = 0) or (a=11)) or
          ((aQInRound=11) and (a=0)) then
          Continue;
        Inc(j);
        aCol.Title.Caption:=j.ToString;
      end;
  end;

begin
  i:=0;
  j:=0;
  UpdateGridCols(RxDBGrdScoreTable, QInRound);
  i:=0;
  j:=0;
  UpdateGridCols(RxDBGrdScoreTable1, QInRound);
  UpdateGridCols(RxDBGrdScoreTable2, QInRound);
  UpdateGridCols(RxDBGrdScoreTable3, QInRound);
end;

procedure TFrameTournament.UpdateScore;
var
  aTour: Integer;
begin
  if DBLkpCmbBx.KeyValue=Null then
    aTour:=-1
  else
    aTour:=DBLkpCmbBx.KeyValue;
  ZQryScoreTable.SQL.Text:='select * from scores where tournament = '+aTour.ToString;
  ZQryScoreTable.Open;
end;

function TFrameTournament.FieldFromQuestion(aQuestionNum: Integer): TBooleanField;
var
  aDiv, aMod: Integer;
begin
  Dec(aQuestionNum);
  aMod:=aQuestionNum mod QInRound;
  aDiv:=aQuestionNum div QInRound;
  aQuestionNum:=aDiv*12+aMod;
  Inc(aQuestionNum);
  Result:=ZQryScoreTable.FieldByName('q'+aQuestionNum.ToString) as TBooleanField;
end;

function TFrameTournament.BetFieldFromQuestion(aQuestionNum: Integer): TBooleanField;
begin
  case RoundFromQuestion(aQuestionNum) of
    1: Result:=ZQryScoreTablebet1round;
    2: Result:=ZQryScoreTablebet2round;
    3: Result:=ZQryScoreTablebet3round;
  else
    Result:=nil;
  end;
end;

function TFrameTournament.QuestionsInRound: Integer;
begin
  Result:=GetQInRound;
end;

function TFrameTournament.RoundFromQuestion(aQuestion: Integer): Integer;
begin
  Result:=((aQuestion-1) div QuestionsInRound) + 1
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
  UpdateScore;
end;

procedure TFrameTournament.ApplyDB;
begin
  ZQryScoreTable.ApplyUpdates;
end;

initialization
  AppDir:=IncludeTrailingPathDelimiter(ExtractFileDir(ParamStr(0)));

end.

