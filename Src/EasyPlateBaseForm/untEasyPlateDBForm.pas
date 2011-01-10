{-------------------------------------------------------------------------------
//                       EasyComponents For Delphi 7
//                         一轩软研第三方开发包                         
//                         @Copyright 2010 hehf                      
//                   ------------------------------------                       
//                                                                              
//           本开发包是公司内部使用,作为开发工具使用任何,何海锋个人负责开发,任何
//       人不得外泄,否则后果自负.        
//
//            使用权限以及相关解释请联系何海锋  
//                
//                                                               
//            网站地址：http://www.YiXuan-SoftWare.com                                  
//            电子邮件：hehaifeng1984@126.com 
//                      YiXuan-SoftWare@hotmail.com    
//            QQ      ：383530895
//            MSN     ：YiXuan-SoftWare@hotmail.com                                   
//------------------------------------------------------------------------------
//单元说明：
//    本单元是工程数据集窗体的基本单元
//
//主要实现：
//-----------------------------------------------------------------------------}
unit untEasyPlateDBForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untEasyPlateDBBaseForm, DB, DBClient, ImgList, untEasyToolBar,
  untEasyToolBarStylers, untReconcileError;

type
  TfrmEasyPlateDBForm = class(TfrmEasyPlateDBBaseForm)
    dkpDBForm: TEasyDockPanel;
    tlbDBForm: TEasyToolBar;
    tlbStyDBForm: TEasyToolBarOfficeStyler;
    btnNew: TEasyToolBarButton;
    imgTlbDBForm: TImageList;
    btnEdit: TEasyToolBarButton;
    btnCancel: TEasyToolBarButton;
    btnDelete: TEasyToolBarButton;
    btnCopy: TEasyToolBarButton;
    btnFind: TEasyToolBarButton;
    btnPrint: TEasyToolBarButton;
    btnExit: TEasyToolBarButton;
    btnRefresh: TEasyToolBarButton;
    btnSave: TEasyToolBarButton;
    cdsMain: TClientDataSet;
    procedure btnExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure cdsMainReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure __ReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FMainClientDataSet: TClientDataSet;         //绑定数据的ClientDataSet
    FMainSQL          : string;                 //窗体初始化时执行的SQL语句
    FDeleteMark: String;                    //删除标志

    FISSaveSuccessMsg     : Boolean;        //当保存成功时是否提示信息
    FISDeleteSuccessMsg   : Boolean;        //当删除时提示信息
    FISBtnNotVisibleHotKey: Boolean;        //按钮在非可视状态下是否接收快捷键
    FISCanHotKey          : Boolean;
    
    FEasyDataState        : TDataSetState; //数据集状态

    FNotNullFieldList     : TStrings;      //非空和非复制字段列表
    FNotCopyFieldList     : TStrings;
    FNotNullFieldColor    : TColor;        //非空字段颜色
    //设置非空字段的颜色的过程
    procedure SetNotNullFieldColor; virtual;
    procedure SetEasyDataState(const Value: TDataSetState);
    procedure SetEasyMainClientDataSet(const Value: TClientDataSet);
    function GetEasyMainClientDataSet: TClientDataSet;

    procedure DoShow; override;
    //改变按钮输入状态的过程
    procedure SetAllControlStatus; virtual;
    //当数据集无记录时
    procedure SetBtnStatus_NoRecord; virtual;
    procedure SetSQL(AValue: string);
    procedure DoSetSQL(const Value: string); virtual;
    procedure DoSave(sender : TObject);

    function Append: Boolean; virtual;
    function Edit: Boolean; virtual;
    function Save: Boolean; virtual;
    function Cancel: Boolean; virtual;
    function Copy: Boolean; virtual;
    function Print: Boolean;virtual;

    //Save
    function BeforeSave(DataSet: TDataSet): Boolean; virtual;
    function AfterSave(DataSet: TDataSet): Boolean; virtual;
    function SaveError(DataSet: TDataSet): Boolean; virtual;

    // 删除数据的过程，含状态控制 ，包含Delete
    function DeleteClick(DataSet: TDataSet):Boolean;virtual;
    // 删除数据的过程，不含状态控制
    function Delete(AClientDataSet: TClientDataSet; ShowHint: Boolean): Boolean; virtual;
    function BeforeDelete(DataSet: TDataSet): Boolean; virtual;
    function ExecuteDelete(AClientDataSet: TClientDataSet): Boolean; virtual;
    function AfterDelete(DataSet: TDataSet): Boolean; virtual;
    function SetDeleteMark(AClientDataSet: TClientDataSet): Boolean; virtual;
    function GetMainClientDataSet: TClientDataSet;
    procedure SetClientDataSet(const Value: TClientDataSet);
    function GetMainSQL: string;
    procedure SetMainSQL(const Value: string);
    function GetNotNullFieldColor: TColor;
    procedure SetNullFieldColor(const Value: TColor);
    function GetMainDeleteMark: string;
    procedure SetMainDeleteMark(const Value: string);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    //非空和非复制字段处理
    procedure AddNotNullField(FieldName: string);
    procedure AddNotNullFields(FieldList: array of string);
    procedure AddNotCopyField(FieldName: string);
    procedure AddNotCopyFields(FieldList: array of string);
    //非空字段的颜色
    property NotNullFieldColor: TColor read GetNotNullFieldColor write SetNullFieldColor;
    //必须指定EasyMainClientDataSet
    property EasyMainClientDataSet: TClientDataSet read GetEasyMainClientDataSet
                                    write SetEasyMainClientDataSet;
    //操作提示
    property ISSaveSuccessMsg : Boolean read FISSaveSuccessMsg write FISSaveSuccessMsg;
    property ISDeleteSuccessMsg : Boolean read FISDeleteSuccessMsg write FISDeleteSuccessMsg;
    property ISBtnNotVisibleHotKey : Boolean read FISBtnNotVisibleHotKey write FISBtnNotVisibleHotKey;
    property ISCanHotKey : Boolean read FISCanHotKey write FISCanHotKey;
    //数据删除标志
    property MainDeleteMark: string read GetMainDeleteMark write SetMainDeleteMark;
    //初始化数据集信息
    property MainClientDataSet: TClientDataSet read GetMainClientDataSet write SetClientDataSet;
    property MainSQL: string read GetMainSQL write SetMainSQL;
  end;

var
  frmEasyPlateDBForm: TfrmEasyPlateDBForm;

implementation

{$R *.dfm}

uses
   untEasyUtilMethod, untEasyDBConnection, untEasyBaseConst;

{ TfrmEasyPlateDBForm }

procedure TfrmEasyPlateDBForm.AddNotCopyField(FieldName: string);
begin

end;

procedure TfrmEasyPlateDBForm.AddNotCopyFields(FieldList: array of string);
begin

end;

procedure TfrmEasyPlateDBForm.AddNotNullField(FieldName: string);
begin

end;

procedure TfrmEasyPlateDBForm.AddNotNullFields(FieldList: array of string);
begin

end;

function TfrmEasyPlateDBForm.AfterDelete(DataSet: TDataSet): Boolean;
begin
  Result := True;
end;

function TfrmEasyPlateDBForm.AfterSave(DataSet: TDataSet): Boolean;
begin

end;

function TfrmEasyPlateDBForm.Append: Boolean;
begin

end;

function TfrmEasyPlateDBForm.BeforeDelete(DataSet: TDataSet): Boolean;
begin
  Result := True;
end;

function TfrmEasyPlateDBForm.BeforeSave(DataSet: TDataSet): Boolean;
begin

end;

function TfrmEasyPlateDBForm.Cancel: Boolean;
begin

end;

function TfrmEasyPlateDBForm.Copy: Boolean;
begin

end;

constructor TfrmEasyPlateDBForm.Create(AOwner: TComponent);
begin
  inherited;
  FEasyDataState := dsInactive;
  if not Assigned(FNotNullFieldList) then
    FNotNullFieldList := TStringList.Create;
  if not Assigned(FNotCopyFieldList) then
    FNotCopyFieldList := TStringList.Create;
  //打开数据集
  if MainSQL <> '' then
  begin
    if DMEasyDBConnection.EasyNetType = 'CAS' then
    begin
      MainClientDataSet.Data := EasyRDMDisp.EasyGetRDMData(MainSQL);
      if not MainClientDataSet.Active then
        FEasyDataState := dsInactive;
      if MainClientDataSet.RecordCount > 0 then
        FEasyDataState := dsBrowse
      else
        SetBtnStatus_NoRecord;
    end;
  end;  
end;

function TfrmEasyPlateDBForm.Delete(AClientDataSet: TClientDataSet;
  ShowHint: Boolean): Boolean;
var
  bCanContinue : Boolean;
begin
  Result := False;
  bCanContinue := True;
  //判断当前用户的操作权限
  if not GetUserRight then
  begin
    bCanContinue := False;
    EasyErrorHint(EasyErrorHint_NRight);
    Exit;
  end
  else
  begin
    if bCanContinue then
    begin
      if BeforeDelete(AClientDataSet) then
      begin
        //如果执行成功提示 和 显示信息
        if ISDeleteSuccessMsg and ShowHint then
        begin
          if MessageDlg(EasyHint_ConfirmDelete, mtWarning, [mbYes, mbNo], 0) = mrYes then
          begin
            if Trim(MainDeleteMark) <> '' then
              Result := SetDeleteMark(MainClientDataSet)
            else
              Result := ExecuteDelete(MainClientDataSet);
          end;
        end
        else
        begin
          if Trim(MainDeleteMark) <> '' then
            Result := SetDeleteMark(MainClientDataSet)
          else
            Result := ExecuteDelete(MainClientDataSet);
        end;
      end;
    end;
  end;
  if Result then
    AfterDelete(MainClientDataSet);
end;

function TfrmEasyPlateDBForm.DeleteClick(DataSet: TDataSet): Boolean;
begin
  Result := False;
  if Delete(MainClientDataSet, True) then
  begin
    if MainClientDataSet.RecordCount > 0 then
      FEasyDataState := dsBrowse
    else
      SetBtnStatus_NoRecord;
    Result := True;
  end;
end;

destructor TfrmEasyPlateDBForm.Destroy;
begin

  inherited;
end;

procedure TfrmEasyPlateDBForm.DoSave(sender: TObject);
begin

end;

procedure TfrmEasyPlateDBForm.DoSetSQL(const Value: string);
begin

end;

procedure TfrmEasyPlateDBForm.DoShow;
begin
  inherited;
  SetNotNullFieldColor;
end;

function TfrmEasyPlateDBForm.Edit: Boolean;
begin

end;

function TfrmEasyPlateDBForm.ExecuteDelete(
  AClientDataSet: TClientDataSet): Boolean;
begin

end;

function TfrmEasyPlateDBForm.GetEasyMainClientDataSet: TClientDataSet;
begin
  Result := FMainClientDataSet;
end;

function TfrmEasyPlateDBForm.Print: Boolean;
begin

end;

function TfrmEasyPlateDBForm.Save: Boolean;
begin

end;

function TfrmEasyPlateDBForm.SaveError(DataSet: TDataSet): Boolean;
begin

end;

procedure TfrmEasyPlateDBForm.SetAllControlStatus;
  procedure SetEditButtons;
  begin
    btnNew.Enabled := False;
    btnEdit.Enabled := False;
    btnDelete.Enabled := False;
    btnCancel.Enabled := True;
    btnSave.Enabled := True;
    btnCopy.Enabled := False;
    btnFind.Enabled := False;
    btnPrint.Enabled := False;
  end;

  procedure SetBrowseButtons;
  begin
    btnNew.Enabled := True;
    btnEdit.Enabled := True;
    btnDelete.Enabled := True;
    btnCancel.Enabled := False;
    btnSave.Enabled := False;
    btnCopy.Enabled := True;
    btnFind.Enabled := True;
    btnPrint.Enabled := True;
  end;

  procedure SetInactiveButtons;
  begin
    btnNew.Enabled := False;
    btnEdit.Enabled := False;
    btnDelete.Enabled := False;
    btnCancel.Enabled := False;
    btnSave.Enabled := False;
    btnCopy.Enabled := False;
    btnFind.Enabled := True;
    btnPrint.Enabled := False;
  end;

  procedure SetNoRecordButtons;
  begin
    btnNew.Enabled := True;
    btnEdit.Enabled := False;
    btnDelete.Enabled := False;
    btnCancel.Enabled := False;
    btnSave.Enabled := False;
    btnCopy.Enabled := False;
    btnFind.Enabled := True;
    btnPrint.Enabled := False;
  end;

  procedure SetUserModuleButtonAuth;
  var
    iAuth: string;
  begin
    iAuth := getUserModuleRight(FormId, DMEasyDBConnection.EasyCurrLoginUserID);
    if iAuth[1] = '1' then
      btnNew.Enabled := True
    else
      btnNew.Enabled := False;   
    if iAuth[2] = '1' then
      btnEdit.Enabled := True
    else
      btnEdit.Enabled := False;
    if iAuth[3] = '1' then
      btnDelete.Enabled := True
    else
      btnDelete.Enabled := False;
    if iAuth[4] = '1' then
      btnCopy.Enabled := True
    else
      btnCopy.Enabled := False;
    if iAuth[5] = '1' then
      btnFind.Enabled := True
    else
      btnFind.Enabled := False;
    if iAuth[6] = '1' then
      btnPrint.Enabled := True
    else
      btnPrint.Enabled := False;
  end;
begin
  case FEasyDataState of
    dsInsert, dsEdit:
      begin
        SetEditButtons;
      end;
    dsBrowse:
      begin
        SetBrowseButtons;
      end;
    dsInactive:
      begin
        SetInactiveButtons;
      end;
  end;
  SetUserModuleButtonAuth;
end;

procedure TfrmEasyPlateDBForm.SetBtnStatus_NoRecord;
begin
  if MainClientDataSet.RecordCount = 0 then
  begin
    btnNew.Enabled := True;
    btnEdit.Enabled := False;
    btnDelete.Enabled := False;
    btnSave.Enabled := False;
    btnCopy.Enabled := False;
    btnFind.Enabled := False;
  end;
end;

function TfrmEasyPlateDBForm.SetDeleteMark(
  AClientDataSet: TClientDataSet): Boolean;
begin

end;

procedure TfrmEasyPlateDBForm.SetEasyDataState(const Value: TDataSetState);
begin

end;

procedure TfrmEasyPlateDBForm.SetEasyMainClientDataSet(
  const Value: TClientDataSet);
begin
  FMainClientDataSet := Value;
end;

procedure TfrmEasyPlateDBForm.SetNotNullFieldColor;
begin

end;

procedure TfrmEasyPlateDBForm.SetSQL(AValue: string);
begin

end;

procedure TfrmEasyPlateDBForm.btnExitClick(Sender: TObject);
begin
  inherited;
//
  Close;
end;

procedure TfrmEasyPlateDBForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmEasyPlateDBForm.FormCreate(Sender: TObject);
begin
  inherited;
  FISSaveSuccessMsg := True;
  FISDeleteSuccessMsg := True;
  FISBtnNotVisibleHotKey:=False;
  FISCanHotKey:=True;
  //KeyPreview
  IsKeyPreView := True;
  MainClientDataSet := cdsMain;
end;

procedure TfrmEasyPlateDBForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  function GetState(Value : TEasyToolBarButton): Boolean;
  begin
    Result :=  Value.Enabled ;
    if not FISBtnNotVisibleHotKey then
      Result:=(Result and Value.Visible);
  end;
begin
  inherited;
  if FISCanHotKey then
  case Key of
    112: if GetState(btnNew)  then btnNewClick(Sender);
    113: if GetState(btnEdit) then btnEditClick(Sender);
    114: if GetState(btnDelete) then btnDeleteClick(Sender);
    115: if GetState(btnSave) then DoSave(Sender);
    116: if GetState(btnCancel) then btnCancelClick(Sender);
    117: if GetState(btnCopy) then btnCopyClick(Sender);
    118: if GetState(btnFind) then btnFindClick(Sender);
    119: if GetState(btnPrint) then btnPrintClick(Sender);
    120: if GetState(btnExit) then btnExitClick(Sender);
  end;
end;

procedure TfrmEasyPlateDBForm.btnNewClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmEasyPlateDBForm.btnEditClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmEasyPlateDBForm.btnDeleteClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmEasyPlateDBForm.btnCancelClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmEasyPlateDBForm.btnCopyClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmEasyPlateDBForm.btnSaveClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmEasyPlateDBForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmEasyPlateDBForm.btnFindClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmEasyPlateDBForm.btnPrintClick(Sender: TObject);
begin
  inherited;
//
end;

function TfrmEasyPlateDBForm.GetMainClientDataSet: TClientDataSet;
begin
  Result := FMainClientDataSet;
end;

procedure TfrmEasyPlateDBForm.SetClientDataSet(
  const Value: TClientDataSet);
begin
  FMainClientDataSet := Value;
end;

function TfrmEasyPlateDBForm.GetMainSQL: string;
begin
  Result := FMainSQL;
end;

procedure TfrmEasyPlateDBForm.SetMainSQL(const Value: string);
begin
  FMainSQL := Value;
end;

function TfrmEasyPlateDBForm.GetNotNullFieldColor: TColor;
begin
  Result := FNotNullFieldColor;
end;

procedure TfrmEasyPlateDBForm.SetNullFieldColor(const Value: TColor);
begin
  FNotNullFieldColor := Value;
end;

function TfrmEasyPlateDBForm.GetMainDeleteMark: string;
begin
  Result := FDeleteMark;
end;

procedure TfrmEasyPlateDBForm.SetMainDeleteMark(const Value: string);
begin
  FDeleteMark := Value;
end;

procedure TfrmEasyPlateDBForm.cdsMainReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError;
  UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  inherited;
  __ReconcileError(DataSet, E, UpdateKind, Action);
end;

procedure TfrmEasyPlateDBForm.__ReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError;
  UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  HandleReconcileError(DataSet, UpdateKind, E);
end;

end.
