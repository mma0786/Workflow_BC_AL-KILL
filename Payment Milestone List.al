page 50050 "Payment Milestone List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payment Milestone";
    AutoSplitKey = true;
    DelayedInsert = true;
    layout
    {
        area(Content)
        {
            group(Groupname)
            {
                repeater("Payment Milestone")
                {
                    field("Document Type"; "Document Type")
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field("Document No."; "Document No.")
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field("Document Date"; "Document Date")
                    {
                        Editable = false;
                    }
                    field("Posting Type"; "Posting Type") { }
                    field("Milestone %"; "Milestone %") { }
                    field("Milestone Description"; "Milestone Description") { }
                    field("Payment Terms"; "Payment Terms") { }
                    field("Total Value"; "Total Value") { }
                    field(Amount; Amount)
                    {
                        Editable = false;
                    }
                    field("Due Date"; "Due Date") { }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}