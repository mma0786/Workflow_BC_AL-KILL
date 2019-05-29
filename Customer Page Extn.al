pageextension 50057 "Customer Page Extn." extends "Customer Card"
{
    layout
    {
        addafter("Disable Search by Name")
        {
            field("Retention A/c"; "Retention A/c") { }
            field("Advance A/c"; "Advance A/c") { }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}