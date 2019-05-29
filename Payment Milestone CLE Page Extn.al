pageextension 50056 "Payment Milestone CLE extn." extends "Customer Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Posting Type"; "Posting Type") { }
            field("Job No."; "Job No.") { }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}