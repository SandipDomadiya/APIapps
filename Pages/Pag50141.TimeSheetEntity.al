page 50141 "timesheetentity"
{
    DelayedInsert = true;
    EntityName = 'timesheet';
    EntitySetName = 'timesheets';
    ODataKeyFields = "Id";
    APIPublisher = 'TimeSheetEntity';
    APIGroup = 'TimeSheetEntity';
    PageType = "API";
    SourceTable = "Time Sheet Header";
    ApplicationArea = "#All";
    Caption = 'timesheetentity'; 
    UsageCategory = Tasks;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CurrTimeSheetNo; CurrTimeSheetNo)
                {
                    ApplicationArea = Jobs;
                    CaptionML = ENU = 'TimeSheetNo',
                                ENC = 'TimeSheetNo';
                    ToolTipML = ENU = 'Specifies the number of the time sheet.',
                                ENC = 'Specifies the number of the time sheet.';

                    trigger OnLookup(Text: Text): Boolean;
                    begin
                        CurrPage.SAVERECORD();
                        TimeSheetMgt.LookupOwnerTimeSheet(CurrTimeSheetNo,TimeSheetLine,TimeSheetHeader); 
                        UpdateControls();
                    end;

                    trigger OnValidate();
                    begin
                        TimeSheetHeader.RESET();
                        TimeSheetMgt.FilterTimeSheets(TimeSheetHeader, TimeSheetHeader.FIELDNO("Owner User ID"));
                        TimeSheetMgt.CheckTimeSheetNo(TimeSheetHeader, CurrTimeSheetNo);
                        CurrPage.SAVERECORD();
                        TimeSheetMgt.SetTimeSheetNo(CurrTimeSheetNo,TimeSheetLine);
                        UpdateControls();
                    end;
                }
                field(ResourceNo; "Resource No.")
                {
                    ApplicationArea = Jobs;
                    CaptionML = ENU = 'ResourceNo',
                                ENC = 'ResourceNo';
                    Editable = false;
                    ToolTipML = ENU = 'Specifies a number for the resource.',
                                ENC = 'Specifies a number for the resource.';
                }
                field(ApproverUserID; "Approver User ID")
                {
                    ApplicationArea = Jobs;
                    CaptionML = ENU = 'ApproverUserID',
                                ENC = 'ApproverUserID';
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the ID of the time sheet approver.',
                                ENC = 'Specifies the ID of the time sheet approver.';
                    Visible = false;
                }
                field(StartingDate; "Starting Date")
                {
                    ApplicationArea = Jobs;
                    CaptionML = ENU = 'StartingDate',
                                ENC = 'StartingDate';
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the date from which the report or batch job processes information.',
                                ENC = 'Specifies the date from which the report or batch job processes information.';
                }
                field(EndingDate; "Ending Date")
                {
                    ApplicationArea = Jobs;
                    CaptionML = ENU = 'EndingDate';
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the date to which the report or batch job processes information.',
                                ENC = 'Specifies the date to which the report or batch job processes information.';
                }
            }
        part(TimeSheetLineEntity; 50142)
        {
            ApplicationArea = All;
            CaptionML = Comment = '{Locked}',
                    ENU = 'TimeSheetLines',
                    ENC = 'TimeSheetLines';
            EntityName = 'timesheet';
            EntitySetName = 'timesheets';
            SubPageLink = "Id"=FIELD(Id);
        }
            
        }
    }
    
    actions
    {
        area(processing)
        {
            action(ActionName)
            {
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
    
    local procedure UpdateControls();
    begin
        SetColumns();
        CurrPage.UPDATE(FALSE);
    end;
    procedure SetColumns();
    var
        Calendar : Record Date;
    begin
        CLEAR(ColumnCaption);
        CLEAR(ColumnRecords);
        CLEAR(Calendar);
        CLEAR(NoOfColumns);

        TimeSheetHeader.GET(CurrTimeSheetNo);
        Calendar.SETRANGE("Period Type",Calendar."Period Type"::Date);
        Calendar.SETRANGE("Period Start",TimeSheetHeader."Starting Date",TimeSheetHeader."Ending Date");
        IF Calendar.FINDSET() THEN
          REPEAT
            NoOfColumns += 1;
            ColumnRecords[NoOfColumns]."Period Start" := Calendar."Period Start";
            ColumnCaption[NoOfColumns] := TimeSheetMgt.FormatDate(Calendar."Period Start",1);
          UNTIL Calendar.NEXT() = 0;
    end;
    
    var
        TimeSheetHeader : Record "Time Sheet Header";
        TimeSheetLine : Record "Time Sheet Line";
        ColumnRecords : array [32] of Record Date;
        TimeSheetMgt : Codeunit "Time Sheet Management";
        TimeSheetApprovalMgt : Codeunit "Time Sheet Approval Management";
        NoOfColumns : Integer;
        CellData : array [32] of Decimal;
        ColumnCaption : array [32] of Text[1024];
        CurrTimeSheetNo : Code[20];
        SetWanted : Option Previous,Next;
        Text001_Txt : TextConst ENU='The type of time sheet line cannot be empty.',ENC='The type of time sheet line cannot be empty.';
        Text003_Txt : TextConst ENU='Could not find job planning lines.',ENC='Could not find job planning lines.';
        Text004_Txt : TextConst ENU='There are no time sheet lines to copy.',ENC='There are no time sheet lines to copy.';
        Text009_Txt : TextConst ENU='Do you want to copy lines from the previous time sheet (%1)?',ENC='Do you want to copy lines from the previous time sheet (%1)?';
        Text010_Txt : TextConst ENU='Do you want to create lines from job planning (%1)?',ENC='Do you want to create lines from job planning (%1)?';
        AllowEdit : Boolean;
}