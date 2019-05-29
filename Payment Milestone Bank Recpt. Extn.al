pageextension 50055 "Payment Milestone Bank Recpt" extends "Cash Receipt Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Posting Type"; "Posting Type") { }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}