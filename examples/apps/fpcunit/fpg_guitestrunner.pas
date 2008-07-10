unit fpg_GuiTestRunner;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes,
  // fpGUI toolkit
  gfxbase, fpgfx, gui_edit, gfx_widget, gui_form, gui_label, gui_button,
  gui_listbox, gui_memo, gui_combobox, gui_basegrid, gui_grid, 
  gui_dialogs, gui_checkbox, gui_tree, gui_trackbar, gui_progressbar,
  gui_radiobutton, gui_tab, gui_menu, gui_panel, gui_popupcalendar,
  gui_gauge, gui_splitter, gfx_imagelist,
  // FPCUnit support
  fpcunit, testregistry, testdecorator;

type

  TGUITestRunnerForm = class(TfpgForm, ITestListener)
  private
    failureCounter: Integer;
    errorCounter: Integer;
    testsCounter: Integer;
    skipsCounter: Integer;
    testSuite: TTest;
    temptest: TTest;
    barColor: TfpgColor;
    FImagelist: TfpgImageList;
    img0: TfpgImage;
    img1: TfpgImage;
    img2: TfpgImage;
    img3: TfpgImage;
    img4: TfpgImage;
    // ITestListener
    procedure AddFailure(ATest: TTest; AFailure: TTestFailure);
    procedure AddError(ATest: TTest; AError: TTestFailure);
    procedure StartTest(ATest: TTest);
    procedure EndTest(ATest: TTest);
    procedure StartTestSuite(ATestSuite: TTestSuite);
    procedure EndTestSuite(ATestSuite: TTestSuite);
    //
    procedure RunTest(ATest: TTest);
    procedure MemoLog(LogEntry: string);
    procedure BuildTree(ARootNode: TfpgTreeNode; ASuite: TTestSuite);
    procedure FormCreate(Sender: TObject);
    procedure btnQuitClicked(Sender: TObject);
    procedure btnClearClicked(Sender: TObject);
    procedure btnRunClicked(Sender: TObject);
    procedure FindByData(ANode: TfpgTreeNode; var AFound: boolean);
    function  FindNode(ATest: TTest): TfpgTreeNode;
    procedure ResetNodeColors(ANode: TfpgTreeNode; var AFound: boolean);
    procedure PopulateImageList;
  public
    {@VFD_HEAD_BEGIN: GUITestRunnerForm}
    bvlTree: TfpgBevel;
    bvlButtons: TfpgBevel;
    bvlResults: TfpgBevel;
    splitter: TfpgSplitter;
    pbName1: TfpgProgressBar;
    btnRun: TfpgButton;
    lblName2: TfpgLabel;
    lblRuns: TfpgLabel;
    lblName4: TfpgLabel;
    lblErrors: TfpgLabel;
    lblName6: TfpgLabel;
    lblFailures: TfpgLabel;
    tvTests: TfpgTreeView;
    memName1: TfpgMemo;
    btnClear: TfpgButton;
    btnQuit: TfpgButton;
    {@VFD_HEAD_END: GUITestRunnerForm}
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   AfterCreate; override;
  end;

{@VFD_NEWFORM_DECL}

implementation

uses
  gfx_imgfmt_bmp;

{@VFD_NEWFORM_IMPL}

{$I treeimages.inc}

procedure TGUITestRunnerForm.AddFailure(ATest: TTest; AFailure: TTestFailure);
var
  FailureNode, node: TfpgTreeNode;
begin
  MemoLog('failed - ' + ATest.TestName);
  FailureNode := FindNode(ATest);
  if not Assigned(FailureNode) then
    memolog('  Failed to find node');
  if Assigned(FailureNode) then
  begin
    node := FailureNode.AppendText('Message: ' + AFailure.ExceptionMessage);
//    node.ImageIndex := 4;
//    node.SelectedIndex := 4;
    node.TextColor := clFuchsia;
    node := FailureNode.AppendText('Exception: ' + AFailure.ExceptionClassName);
//    node.ImageIndex := 4;
//    node.SelectedIndex := 4;
    node.TextColor := clFuchsia;
//    PaintNodeFailure(FailureNode);
  end;
  Inc(failureCounter);
  if errorCounter = 0 then
    barColor := clFuchsia; // Error color takes preference

  tvTests.Invalidate;
end;

procedure TGUITestRunnerForm.AddError(ATest: TTest; AError: TTestFailure);
var
  ErrorNode, node: TfpgTreeNode;
begin
  MemoLog('error - ' + ATest.TestName);
  ErrorNode := FindNode(ATest);
  if Assigned(ErrorNode) then
  begin
    node := ErrorNode.AppendText('Exception message: ' + AError.ExceptionMessage);
    node.TextColor := clRed;
//    node.ImageIndex := 4;
//    node.SelectedIndex := 4;
    node := ErrorNode.AppendText('Exception class: ' + AError.ExceptionClassName);
    node.TextColor := clRed;
//    node.ImageIndex := 4;
//    node.SelectedIndex := 4;
    if (AError.SourceUnitName <> '') and
      (AError.FailedMethodName <> '')
    then
    begin
      node := ErrorNode.AppendText('Unit name: ' + AError.SourceUnitName);
      node.TextColor := clRed;
//      node.ImageIndex := 11;
//      node.SelectedIndex := 11;
      node := ErrorNode.AppendText('Method name: ' + AError.FailedMethodName);
      node.TextColor := clRed;
//      node.ImageIndex := 11;
//      node.SelectedIndex := 11;
      node := ErrorNode.AppendText('Line number: ' + IntToStr(AError.LineNumber));
      node.TextColor := clRed;
//      node.ImageIndex := 11;
//      node.SelectedIndex := 11;
    end;
//    PaintNodeError(ErrorNode);
  end;
  Inc(errorCounter);
  barColor := clRed;

  tvTests.Invalidate;
end;

procedure TGUITestRunnerForm.StartTest(ATest: TTest);
var
  Node: TfpgTreeNode;
begin
//  MemoLog('StartTest');

  Node := FindNode(ATest);
  if Assigned(Node) then
  begin
    Node.Clear;
//    Node.TextColor := clBlue;
    tvTests.Invalidate;
    fpgApplication.ProcessMessages;
  end;

end;

procedure TGUITestRunnerForm.EndTest(ATest: TTest);
begin

end;

procedure TGUITestRunnerForm.StartTestSuite(ATestSuite: TTestSuite);
begin

end;

procedure TGUITestRunnerForm.EndTestSuite(ATestSuite: TTestSuite);
begin

end;

procedure TGUITestRunnerForm.RunTest(ATest: TTest);
var
  lTestResult: TTestResult;
  FStopCrono: TDateTime;
  FStartCrono: TDateTime;
begin
  // Reset counters
  failureCounter  := 0;
  errorCounter    := 0;
  testsCounter    := 0;
  skipsCounter    := 0;

  lTestResult := TTestResult.Create;
  try
    lTestResult.AddListener(self);
    MemoLog('Running ' + tvTests.Selection.Text);
    FStartCrono := Now;
    ATest.Run(lTestResult);
    FStopCrono  := Now;

    MemoLog('Number of executed tests: '
      + IntToStr(lTestResult.RunTests)
      + '  Time elapsed: '
      + FormatDateTime('hh:nn:ss.zzz', FStopCrono - FStartCrono));

  finally
    lTestResult.Free;
  end;
end;

procedure TGUITestRunnerForm.MemoLog(LogEntry: string);
begin
  memName1.Lines.Add(TimeToStr(Now) + ' - ' + LogEntry);
end;

procedure TGUITestRunnerForm.BuildTree(ARootNode: TfpgTreeNode; ASuite: TTestSuite);
var
  node: TfpgTreeNode;
  i: integer;
begin
//  ARootNode.StateIndex := Ord(tsChecked);

  for i := 0 to ASuite.Tests.Count-1 do
  begin
    node := ARootNode.AppendText(ASuite.Test[i].TestName);
    node.Data := ASuite.Test[i];
    node.ImageIndex := 0;
    if ASuite.Test[i] is TTestSuite then
      BuildTree(node, TTestSuite(ASuite.Test[i]))
    else
      if TObject(ASuite.Test[i]).InheritsFrom(TTestDecorator) then
        BuildTree(node, TTestSuite(TTestDecorator(ASuite.Test[i]).Test));

//    node.SelectedIndex := 12;
//    node.StateIndex := ord(tsChecked);
  end;
//  rootNode.Expand(False);
//  ResetNodeColors;

end;

procedure TGUITestRunnerForm.FormCreate(Sender: TObject);
var
  n: TfpgTreeNode;
begin
  n := tvTests.RootNode.AppendText('All Tests');
  BuildTree(n, GetTestRegistry);
  n.Data := GetTestRegistry;
//  n.Text := 'All Tests (count=' + IntToStr(GetTestRegistry.CountTestCases) + ')';
end;

procedure TGUITestRunnerForm.btnQuitClicked(Sender: TObject);
begin
  Close;
end;

procedure TGUITestRunnerForm.btnClearClicked(Sender: TObject);
begin
  memName1.Lines.Clear;
  tvTests.RootNode.FindSubNode(@ResetNodeColors);
  tvTests.Invalidate;
  fpgApplication.ProcessMessages;
end;

procedure TGUITestRunnerForm.btnRunClicked(Sender: TObject);
begin
  if tvTests.Selection = nil then
  begin
    TfpgMessageDialog.Critical('No selection', 'Please select a test case first.');
    Exit; //==>
  end;
  
  if (tvTests.Selection.Data <> nil) then
  begin
    testSuite := TTest(tvTests.Selection.Data);
//    tvTests.Selection.Collapse;
    RunTest(testSuite);
  end;
end;

procedure TGUITestRunnerForm.FindByData(ANode: TfpgTreeNode; var AFound: boolean);
begin
  AFound := TTest(ANode.Data) = temptest;
//  if AFound then
//    MemoLog('Found Node ' + ANode.Text);
end;

function TGUITestRunnerForm.FindNode(ATest: TTest): TfpgTreeNode;
var
  h: TfpgTreeNode;
begin
  result := nil;
  
  // short circut test
  if (tvTests.Selection.Next <> nil) and (tvTests.Selection.Next.Data <> nil) and (TTest(tvTests.Selection.Next.Data) = ATest) then
  begin
    result := tvTests.Selection.Next;
    Exit; //==>
  end;
  
  // recursive search
  try
    temptest := ATest;
    result := tvTests.RootNode.FindSubNode(@FindByData);
  finally
    temptest := nil;
  end;
end;

procedure TGUITestRunnerForm.ResetNodeColors(ANode: TfpgTreeNode; var AFound: boolean);
begin
  ANode.TextColor := clUnset;
end;

procedure TGUITestRunnerForm.PopulateImageList;
begin
  img0 := CreateImage_BMP(@fpcunit_circle_grey, sizeof(fpcunit_circle_grey) );
  FImagelist.AddImage(img0, 0);

  img1 := CreateImage_BMP(@fpcunit_circle_green, sizeof(fpcunit_circle_green) );
  FImagelist.AddImage(img1, 1);

  img2 := CreateImage_BMP(@fpcunit_circle_red, sizeof(fpcunit_circle_red) );
  FImagelist.AddImage(img2, 2);

  img3 := CreateImage_BMP(@fpcunit_information, sizeof(fpcunit_information) );
  FImagelist.AddImage(img3, 3);

  img4 := CreateImage_BMP(@fpcunit_bug, sizeof(fpcunit_bug) );
  FImagelist.AddImage(img4, 4);
end;

constructor TGUITestRunnerForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnCreate := @FormCreate;

  // create and populate the imagelist
  FImagelist := TfpgImageList.Create;
  PopulateImageList;
end;

destructor TGUITestRunnerForm.Destroy;
begin
  tvTests.ImageList := nil;
  FImagelist.Free;
  inherited Destroy;
end;

procedure TGUITestRunnerForm.AfterCreate;
begin
  {@VFD_BODY_BEGIN: GUITestRunnerForm}
  Name := 'GUITestRunnerForm';
  SetPosition(305, 196, 530, 547);
  WindowTitle := 'GUI Test Runner';

  bvlTree := TfpgBevel.Create(self);
  with bvlTree do
  begin
    Name := 'bvlTree';
    SetPosition(4, 8, 512, 364);
    Shape := bsSpacer;
    MinHeight := 200;
    Align := alClient;
  end;

  bvlButtons := TfpgBevel.Create(self);
  with bvlButtons do
  begin
    Name := 'bvlButtons';
    SetPosition(4, 505, 516, 40);
    Shape := bsTopLine;
    Align := alBottom;
  end;

  bvlResults := TfpgBevel.Create(self);
  with bvlResults do
  begin
    Name := 'bvlResults';
    SetPosition(4, 392, 516, 103);
    Shape := bsSpacer;
    Align := alBottom;
    MinHeight := 45;
  end;

  splitter := TfpgSplitter.Create(self);
  with splitter do
  begin
    Name := 'splitter';
    SetPosition(2, 376, 521, 8);
    Align := alBottom;
  end;

  pbName1 := TfpgProgressBar.Create(bvlTree);
  with pbName1 do
  begin
    Name := 'pbName1';
    SetPosition(8, 40, 496, 22);
    Anchors := [anLeft,anRight,anTop];
  end;

  btnRun := TfpgButton.Create(bvlTree);
  with btnRun do
  begin
    Name := 'btnRun';
    SetPosition(424, 8, 80, 24);
    Anchors := [anRight,anTop];
    Text := 'Run';
    FontDesc := '#Label1';
    ImageName := '';
    TabOrder := 2;
    OnClick := @btnRunClicked;
  end;

  lblName2 := TfpgLabel.Create(bvlTree);
  with lblName2 do
  begin
    Name := 'lblName2';
    SetPosition(8, 72, 40, 16);
    FontDesc := '#Label2';
    Text := 'Runs:';
  end;

  lblRuns := TfpgLabel.Create(bvlTree);
  with lblRuns do
  begin
    Name := 'lblRuns';
    SetPosition(48, 72, 55, 16);
    FontDesc := '#Label1';
    Text := '---';
  end;

  lblName4 := TfpgLabel.Create(bvlTree);
  with lblName4 do
  begin
    Name := 'lblName4';
    SetPosition(120, 72, 44, 16);
    FontDesc := '#Label2';
    Text := 'Errors:';
  end;

  lblErrors := TfpgLabel.Create(bvlTree);
  with lblErrors do
  begin
    Name := 'lblErrors';
    SetPosition(166, 72, 55, 16);
    FontDesc := '#Label1';
    Text := '---';
  end;

  lblName6 := TfpgLabel.Create(bvlTree);
  with lblName6 do
  begin
    Name := 'lblName6';
    SetPosition(232, 72, 60, 16);
    FontDesc := '#Label2';
    Text := 'Failures:';
  end;

  lblFailures := TfpgLabel.Create(bvlTree);
  with lblFailures do
  begin
    Name := 'lblFailures';
    SetPosition(292, 72, 55, 16);
    FontDesc := '#Label1';
    Text := '---';
  end;

  tvTests := TfpgTreeView.Create(bvlTree);
  with tvTests do
  begin
    Name := 'tvTests';
    SetPosition(8, 96, 496, 265);
    Anchors := [anLeft,anRight,anTop,anBottom];
    FontDesc := '#Label1';
    TabOrder := 3;
//    ImageList := FImagelist;
//    ShowImages := True;
  end;

  memName1 := TfpgMemo.Create(bvlResults);
  with memName1 do
  begin
    Name := 'memName1';
    SetPosition(8, 2, 500, 94);
    Anchors := [anLeft,anRight,anTop,anBottom];
    FontDesc := '#Edit1';
    TabOrder := 4;
  end;

  btnClear := TfpgButton.Create(bvlButtons);
  with btnClear do
  begin
    Name := 'btnClear';
    SetPosition(8, 8, 80, 24);
    Text := 'Clear';
    FontDesc := '#Label1';
    ImageName := '';
    TabOrder := 5;
    OnClick := @btnClearClicked;
  end;

  btnQuit := TfpgButton.Create(bvlButtons);
  with btnQuit do
  begin
    Name := 'btnQuit';
    SetPosition(428, 8, 80, 24);
    Anchors := [anRight,anTop];
    Text := 'Quit';
    FontDesc := '#Label1';
    ImageName := '';
    TabOrder := 6;
    OnClick := @btnQuitClicked;
  end;

  {@VFD_BODY_END: GUITestRunnerForm}
  
end;


end.