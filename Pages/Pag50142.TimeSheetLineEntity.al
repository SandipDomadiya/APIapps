page 50142 TimeSheetLineEntity
{
    Caption='TimeSheetLine';
    PageType = ListPart;
    DelayedInsert = true;
    SourceTable = "Time Sheet Line";
    ODataKeyFields = Id;
  
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id;id)
                {
                    Editable = false;
                    Caption = 'Id';
                    ApplicationArea = All;
                }
                field(Type;type)
                {
                    ApplicationArea = "#Jobs";
                    ToolTip= 'Specifies the type of entity that will be type for this time sheet line, such as Resource,Job,Service,Absence,Assembly Order.';
                }
                field("Job No.";"Job No.")
                {
                    Visible = false;
                    Caption = '=Job No.';
                    ApplicationArea = "#Jobs";
                    ToolTip = 'Specifies the number for the job that is associated with the time sheet line.';
                }
                field(Description;description)
                {
                    Caption = 'Description';
                    ApplicationArea = "#Jobs";
                    ToolTip= 'Specifies a description of the time sheet line.';
                }
                field("Cause of Absence Code";"Cause of Absence Code")
                {
                    Visible = false;
                    Caption = 'Cause of Absence Code';
                    ApplicationArea = "#Jobs";
                    ToolTip= 'Specifies a list of standard absence codes, from which you may select one.';
                }
                field(Chargeable;Chargeable)
                {
                    Visible = false;
                    Caption = 'Chargeable';
                    ApplicationArea = "#Jobs";
                    ToolTip= 'Specifies if the usage that you are posting is chargeable.';
                }
                field("Work Type Code";"Work Type Code")
                {
                    Visible = false;
                    Caption = 'Work Type Code';
                    ApplicationArea = "#Jobs";
                    ToolTip= 'Specifies which work type the resource applies to. Prices are updated based on this entry.';
                }
                field("Service Order No.";"Service Order No.")
                {
                    Visible = false;
                    Caption = 'Service Order No.';
                    ApplicationArea = "#Jobs";
                    ToolTip= 'Specifies the service order number that is associated with the time sheet line.';
                }
                field("Assembly Order No.";"Assembly Order No.")
                {
                    Visible = false;
                    Caption = 'Assembly Order No.';
                    ApplicationArea = "#Assembly";
                    ToolTip= 'Specifies the assembly order number that is associated with the time sheet line.';
                }
                field(Field1;CellData[1])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[1];
                    DecimalPlaces = 0:2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD();
                        ValidateQuantity(1);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field2;CellData[2])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[2];
                    DecimalPlaces = 0:2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD();
                        ValidateQuantity(2);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field3;CellData[3])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[3];
                    DecimalPlaces = 0:2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD();
                        ValidateQuantity(3);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field4;CellData[4])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[4];
                    DecimalPlaces = 0:2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD();
                        ValidateQuantity(4);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field5;CellData[5])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[5];
                    DecimalPlaces = 0:2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD();
                        ValidateQuantity(5);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field6;CellData[6])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[6];
                    DecimalPlaces = 0:2;
                    Editable = AllowEdit;
                    Visible = false;
                    Width = 6;

                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD();
                        ValidateQuantity(6);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field7;CellData[7])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[7];
                    DecimalPlaces = 0:2;
                    Editable = AllowEdit;
                    Visible = false;
                    Width = 6;

                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD();
                        ValidateQuantity(7);
                        CellDataOnAfterValidate();
                    end;
                }
                field("Total Quantity";"Total Quantity")
                {
                    ApplicationArea = Jobs;
                    CaptionML = ENU='Total',
                                ENC='Total';
                    DrillDown = false;
                    ToolTipML = ENU='Specifies the total number of hours that have been entered on a time sheet.',
                                ENC='Specifies the total number of hours that have been entered on a time sheet.';
                    Visible = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU='Specifies information about the status of a time sheet line.',
                                ENC='Specifies information about the status of a time sheet line.';
                }
            }
        }
    }

    local procedure CellDataOnAfterValidate();
    begin
        // UpdateFactBoxes;
        CALCFIELDS("Total Quantity");
    end;
    local procedure ValidateQuantity(ColumnNo : Integer);
    begin
        IF (CellData[ColumnNo] <> 0) AND (Type = Type::" ") THEN
          ERROR(Text001_Txt);

        IF TimeSheetDetail.GET(
             "Time Sheet No.",
             "Line No.",
             ColumnRecords[ColumnNo]."Period Start")
        THEN BEGIN
          IF CellData[ColumnNo] <> TimeSheetDetail.Quantity THEN
            TestTimeSheetLineStatus();

          IF CellData[ColumnNo] = 0 THEN
            TimeSheetDetail.DELETE()
          ELSE BEGIN
            TimeSheetDetail.Quantity := CellData[ColumnNo];
            TimeSheetDetail.MODIFY(TRUE);
          END;
        END ELSE
          IF CellData[ColumnNo] <> 0 THEN BEGIN
            TestTimeSheetLineStatus();

            TimeSheetDetail.INIT();
            TimeSheetDetail.CopyFromTimeSheetLine(Rec);
            TimeSheetDetail.Date := ColumnRecords[ColumnNo]."Period Start";
            TimeSheetDetail.Quantity := CellData[ColumnNo];
            TimeSheetDetail.INSERT(TRUE);
          END;
    end;
    local procedure TestTimeSheetLineStatus();
    var
        TimeSheetLine : Record "Time Sheet Line";
    begin
        TimeSheetLine.GET("Time Sheet No.","Line No.");
        TimeSheetLine.TestStatus();
    end;
    var
        TimeSheetDetail : Record "Time Sheet Detail";
        ColumnRecords : array [32] of Record Date;
        CellData : array [32] of Decimal;
        ColumnCaption : array [32] of Text[1024];
        AllowEdit : Boolean;
        Text001_Txt : TextConst ENU ='The type of time sheet line cannot be empty.';
}