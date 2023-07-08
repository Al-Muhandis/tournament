unit frmtournamentform;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, ComCtrls, Menus, RxDBGridExportSpreadSheet, RxSortZeos, ZDataset, ZConnection,
  RxDBGrid, DBCtrls, rxlookup
  ;

type

  { TFrameTournament }

  TFrameTournament = class(TFrame)
    DBGrdTournaments: TRxDBGrid;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DBNvgtrTournaments: TDBNavigator;
    DtSrcScoreTable: TDataSource;
    DtSrcTournaments: TDataSource;
    miFullScreen: TMenuItem;
    miScreen1: TMenuItem;
    miScreen2: TMenuItem;
    PgCntrl: TPageControl;
    PgCntrlRounds: TPageControl;
    RxDBGrdScoreTable: TRxDBGrid;
    RxDBGrdScoreTable1: TRxDBGrid;
    RxDBGrdScoreTable2: TRxDBGrid;
    RxDBGrdScoreTable3: TRxDBGrid;
    RxDBGrdScoreTable4: TRxDBGrid;
    RxDBGridExportSpreadSheet1: TRxDBGridExportSpreadSheet;
    RxDBGridTeams: TRxDBGrid;
    RxLookupEdit1: TRxLookupEdit;
    RxSrtZs: TRxSortZeos;
    StringField1: TStringField;
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
    procedure ZQryScoreTableAfterInsert({%H-}DataSet: TDataSet);
    procedure ZQryScoreTableCalcFields({%H-}DataSet: TDataSet);
    procedure ZQryTournamentsAfterScroll({%H-}DataSet: TDataSet);
  private
    procedure SetToolBarVisible(AValue: Boolean);

  public
    procedure InitDB;
    procedure ApplyDB;
    property ToolBarVisible: Boolean write SetToolBarVisible;
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
  'q23  BOOLEAN DEFAULT (0), q24  BOOLEAN DEFAULT (0), q25  BOOLEAN DEFAULT (0), q26  BOOLEAN DEFAULT (0), q27  BOOLEAN DEFAULT (0), q28  BOOLEAN DEFAULT (0), q29  BOOLEAN DEFAULT (0), q30  BOOLEAN DEFAULT (0), q31  BOOLEAN DEFAULT (0), q32  BOOLEAN DEFAULT (0), q33  BOOLEAN DEFAULT (0), UNIQUE (tournament, team)ON CONFLICT IGNORE);';


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

procedure TFrameTournament.ZQryScoreTableCalcFields(DataSet: TDataSet);
begin
  ZQryScoreTableRound1.AsInteger:=ZQryScoreTableq1.AsInteger+ZQryScoreTableq2.AsInteger+ZQryScoreTableq3.AsInteger+
  ZQryScoreTableq4.AsInteger+ZQryScoreTableq5.AsInteger+ZQryScoreTableq6.AsInteger+ZQryScoreTableq7.AsInteger+
  ZQryScoreTableq8.AsInteger+ZQryScoreTableq9.AsInteger+ZQryScoreTableq10.AsInteger+ZQryScoreTableq11.AsInteger;
  ZQryScoreTableRound1Club.AsInteger:=11-ZQryScoreTableRound1.AsInteger;
  ZQryScoreTableRound2.AsInteger:=ZQryScoreTableq12.AsInteger+ZQryScoreTableq13.AsInteger+ZQryScoreTableq14.AsInteger+
  ZQryScoreTableq15.AsInteger+ZQryScoreTableq16.AsInteger+ZQryScoreTableq17.AsInteger+ZQryScoreTableq18.AsInteger+
  ZQryScoreTableq19.AsInteger+ZQryScoreTableq20.AsInteger+ZQryScoreTableq21.AsInteger+ZQryScoreTableq22.AsInteger;
  ZQryScoreTableRound2Club.AsInteger:=11-ZQryScoreTableRound2.AsInteger;
  ZQryScoreTableRound3.AsInteger:=ZQryScoreTableq23.AsInteger+ZQryScoreTableq24.AsInteger+ZQryScoreTableq25.AsInteger+
  ZQryScoreTableq26.AsInteger+ZQryScoreTableq27.AsInteger+ZQryScoreTableq28.AsInteger+ZQryScoreTableq29.AsInteger+
  ZQryScoreTableq30.AsInteger+ZQryScoreTableq31.AsInteger+ZQryScoreTableq32.AsInteger+ZQryScoreTableq33.AsInteger;
  ZQryScoreTableRound3Club.AsInteger:=11-ZQryScoreTableRound3.AsInteger;
  ZQryScoreTableResult.AsInteger:=ZQryScoreTableRound1.AsInteger+ZQryScoreTableRound2.AsInteger+ZQryScoreTableRound3.AsInteger;
end;

procedure TFrameTournament.ZQryTournamentsAfterScroll(DataSet: TDataSet);
begin
  ZQryScoreTable.SQL.Text:='select * from scores where tournament = '+ZQryTournamentsid.AsInteger.ToString;
  ZQryScoreTable.Open;
  Caption:=s_IntelGames+'. ['+ZQryTournamentstitle.AsString+']';
end;

procedure TFrameTournament.SetToolBarVisible(AValue: Boolean);
begin
  TlBrScoreTable.Visible:=AValue;
  TlBrTeams.Visible:=AValue;
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

