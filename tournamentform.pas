unit tournamentform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, RxDBGrid,
  RxDBGridExportSpreadSheet, DBGrids, ComCtrls, DBCtrls, ExtCtrls, Menus, ActnList, IniPropStorage, frmtournamentform
  , PropertyStorage;

type

  { TFrm }

  TFrm = class(TForm)
    ActnScreen2: TAction;
    ActnScreen1: TAction;
    ActnSwitchFullScreen: TAction;
    ActnLst: TActionList;
    FrmTrnmnt: TFrameTournament;
    IniPrpStrg: TIniPropStorage;
    MenuItem1: TMenuItem;
    miFullScreen: TMenuItem;
    miScreen1: TMenuItem;
    miScreen2: TMenuItem;
    PppMnTray: TPopupMenu;
    TbShtOptions: TTabSheet;
    TryIcn: TTrayIcon;
    procedure ActnScreen1Execute({%H-}Sender: TObject);
    procedure ActnSwitchFullScreenExecute({%H-}Sender: TObject);
    procedure FormClose({%H-}Sender: TObject; var {%H-}CloseAction: TCloseAction);
    procedure FormCreate({%H-}Sender: TObject);
    procedure IniPrpStrgRestoringProperties(Sender: TObject);
    procedure IniPrpStrgSavingProperties(Sender: TObject);
  private
    FOriginalBounds: TRect;
    FOriginalWindowState: TWindowState;
    procedure SwitchFullScreen(aMonitor: SmallInt = -1);
  public
  end;

var
  Frm: TFrm;

implementation

{$R *.lfm}

procedure TFrm.SwitchFullScreen(aMonitor: SmallInt);
begin
  if Visible=False then
    Show;
  if BorderStyle <> bsNone then begin
    // To full screen
    FOriginalWindowState := WindowState;
    FOriginalBounds := BoundsRect;
    FrmTrnmnt.ToolBarVisible:=False;
    BorderStyle := bsNone;
    if (Screen.MonitorCount=1) or (aMonitor=-1) then
      BoundsRect := Screen.MonitorFromWindow(Handle, mdNearest).BoundsRect
    else
      BoundsRect:=Screen.Monitors[aMonitor].BoundsRect;
  end
  else begin
    // From full screen
    BorderStyle := bsSizeable;
    if FOriginalWindowState = wsMaximized then
      WindowState := wsMaximized
    else
      BoundsRect := FOriginalBounds;
    FrmTrnmnt.ToolBarVisible:=True;
  end;
end;

procedure TFrm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FrmTrnmnt.ApplyDB;
end;

procedure TFrm.FormCreate(Sender: TObject);
begin
  FrmTrnmnt.InitDB;   
  FrmTrnmnt.Q11InRound:=True;
end;

procedure TFrm.IniPrpStrgRestoringProperties(Sender: TObject);
begin
  FrmTrnmnt.Q11InRound:=     TIniPropStorage(Sender).ReadBoolean('Q11InRound', True);
  FrmTrnmnt.QuestionWithBet:=TIniPropStorage(Sender).ReadInteger('QWithBet', 0);
end;

procedure TFrm.IniPrpStrgSavingProperties(Sender: TObject);
begin
  TIniPropStorage(Sender).WriteBoolean('Q11InRound', FrmTrnmnt.Q11InRound);
  TIniPropStorage(Sender).WriteInteger('QWithBet',   FrmTrnmnt.QuestionWithBet);
end;

procedure TFrm.ActnSwitchFullScreenExecute(Sender: TObject);
begin
  SwitchFullScreen();
end;

procedure TFrm.ActnScreen1Execute(Sender: TObject);
begin
  SwitchFullScreen(0);
end;

end.

