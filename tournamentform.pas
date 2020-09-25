unit tournamentform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, RxDBGrid, rxlookup, RxSortZeos,
  ZConnection, ZDataset, DBGrids, ComCtrls, DBCtrls, ExtCtrls, Menus, ActnList
  ;

type

  { TFrm }

  TFrm = class(TForm)
    ActnSwitchFullScreen: TAction;
    ActnLst: TActionList;
    DBNvgtrTournaments: TDBNavigator;
    DtSrcTournaments: TDataSource;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DtSrcTeams: TDataSource;
    DtSrcScoreTable: TDataSource;
    MenuItem1: TMenuItem;
    PgCntrlRounds: TPageControl;
    PgCntrl: TPageControl;
    PppMnTray: TPopupMenu;
    RxDBGrdScoreTable: TRxDBGrid;
    RxDBGrdScoreTable1: TRxDBGrid;
    RxDBGrdScoreTable2: TRxDBGrid;
    RxDBGrdScoreTable3: TRxDBGrid;
    RxDBGrdScoreTable4: TRxDBGrid;
    DBGrdTournaments: TRxDBGrid;
    RxDBGridTeams: TRxDBGrid;
    RxLookupEdit1: TRxLookupEdit;
    RxSrtZs: TRxSortZeos;
    StringField1: TStringField;
    TbShtResult: TTabSheet;
    TbShtRound3: TTabSheet;
    TbShtRound2: TTabSheet;
    TbShtRound1: TTabSheet;
    TbShtAllRounds: TTabSheet;
    TbShtTournament: TTabSheet;
    TbShtTeams: TTabSheet;
    TbShtScoreTableAllRounds: TTabSheet;
    TlBrTeams: TToolBar;
    TlBrScoreTable: TToolBar;
    TlBrTournaments: TToolBar;
    ToolButton1: TToolButton;
    TryIcn: TTrayIcon;
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
    procedure ActnSwitchFullScreenExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var {%H-}CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ZQryScoreTableAfterInsert({%H-}DataSet: TDataSet);
    procedure ZQryScoreTableCalcFields({%H-}DataSet: TDataSet);
    procedure ZQryTournamentsAfterScroll({%H-}DataSet: TDataSet);
  private
    FOriginalBounds: TRect;
    FOriginalWindowState: TWindowState;
    //FORM: TTournamentORM;
    //function GetORM: TTournamentORM;
    procedure SwitchFullScreen(aMonitor: SmallInt = -1);
  protected
    //property ORM: TTournamentORM read GetORM;
  public
  end;

var
  Frm: TFrm;
  AppDir: String;

implementation



{$R *.lfm}

{ TFrm }
{
function TFrm.GetORM: TTournamentORM;
begin
  if not Assigned(FORM) then
    FORM:=TTournamentORM.Create('tournaments.sqlite', 'sqlite3');
  Result:=FORM;
end;
}
procedure TFrm.SwitchFullScreen(aMonitor: SmallInt);
begin
  if Visible=False then
    Show;
  if BorderStyle <> bsNone then begin
    // To full screen
    FOriginalWindowState := WindowState;
    FOriginalBounds := BoundsRect;
    TlBrScoreTable.Visible:=False;
    TlBrTeams.Visible:=False;
    BorderStyle := bsNone;
    if (Screen.MonitorCount=1) or (aMonitor=-1) then
      BoundsRect := Screen.MonitorFromWindow(Handle, mdNearest).BoundsRect
    else
      BoundsRect:=Screen.Monitors[aMonitor].BoundsRect;
  end else begin
    // From full screen
    BorderStyle := bsSizeable;
    if FOriginalWindowState = wsMaximized then
      WindowState := wsMaximized
    else
      BoundsRect := FOriginalBounds;
    TlBrScoreTable.Visible:=True;
    TlBrTeams.Visible:=True;
  end;
end;

procedure TFrm.FormDestroy(Sender: TObject);
begin
  //FORM.Free;
end;

procedure TFrm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  ZQryScoreTable.ApplyUpdates;
  //ZCnctn.Commit;
end;

procedure TFrm.FormCreate(Sender: TObject);
begin
  ZCnctn.Disconnect;
  ZCnctn.Database:=AppDir+'tournaments.sqlite';
  ZCnctn.Connect;
  //ZQryScores.Open;
  ZQryTournaments.Open;
  ZQryTeams.Open;
  ZQryScoreTable.SQL.Text:='select * from scores where tournament = '+ZQryTournamentsid.AsInteger.ToString;
  ZQryScoreTable.Open;
end;

procedure TFrm.ActnSwitchFullScreenExecute(Sender: TObject);
begin
  SwitchFullScreen();
end;

procedure TFrm.ZQryScoreTableAfterInsert(DataSet: TDataSet);
begin
  ZQryScoreTabletournament.AsInteger:=ZQryTournamentsid.AsInteger;
  ZQryScoreTableq1.AsBoolean:=False;    
  ZQryScoreTableq2.AsBoolean:=False;
  ZQryScoreTableq3.AsBoolean:=False;
  ZQryScoreTableq4.AsBoolean:=False;
  ZQryScoreTableq5.AsBoolean:=False;
  ZQryScoreTableq6.AsBoolean:=False;
  ZQryScoreTableq7.AsBoolean:=False;
  ZQryScoreTableq8.AsBoolean:=False;
  ZQryScoreTableq9.AsBoolean:=False;
  ZQryScoreTableq10.AsBoolean:=False;
  ZQryScoreTableq11.AsBoolean:=False;
  ZQryScoreTableq12.AsBoolean:=False;
  ZQryScoreTableq13.AsBoolean:=False;
  ZQryScoreTableq14.AsBoolean:=False;
  ZQryScoreTableq15.AsBoolean:=False;
  ZQryScoreTableq16.AsBoolean:=False;
  ZQryScoreTableq17.AsBoolean:=False;
  ZQryScoreTableq18.AsBoolean:=False;
  ZQryScoreTableq19.AsBoolean:=False;
  ZQryScoreTableq20.AsBoolean:=False;
  ZQryScoreTableq21.AsBoolean:=False;
  ZQryScoreTableq22.AsBoolean:=False;
  ZQryScoreTableq23.AsBoolean:=False;
  ZQryScoreTableq24.AsBoolean:=False;
  ZQryScoreTableq25.AsBoolean:=False;
  ZQryScoreTableq26.AsBoolean:=False;
  ZQryScoreTableq27.AsBoolean:=False;
  ZQryScoreTableq28.AsBoolean:=False;
  ZQryScoreTableq29.AsBoolean:=False;
  ZQryScoreTableq30.AsBoolean:=False;
  ZQryScoreTableq31.AsBoolean:=False; 
  ZQryScoreTableq32.AsBoolean:=False;
  ZQryScoreTableq33.AsBoolean:=False;
end;

procedure TFrm.ZQryScoreTableCalcFields(DataSet: TDataSet);
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

procedure TFrm.ZQryTournamentsAfterScroll(DataSet: TDataSet);
begin
  ZQryScoreTable.SQL.Text:='select * from scores where tournament = '+ZQryTournamentsid.AsInteger.ToString;
  ZQryScoreTable.Open;
  Caption:='Интеллектуальные игры. ['+ZQryTournamentstitle.AsString+']';
end;

initialization
  AppDir:=IncludeTrailingPathDelimiter(ExtractFileDir(ParamStr(0)));

end.

