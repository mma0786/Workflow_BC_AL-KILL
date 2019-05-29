tableextension 50053 "Cust. Ledger Entry Table Extn." extends "Cust. Ledger Entry"
{
    fields
    {
        field(50050; "Posting Type"; Option)
        {
            OptionMembers = Advance,Running,Retention;
        }
        field(50051; "Job No."; Code[20])
        {
            TableRelation = Job;
        }
    }
    var
        myInt: Integer;
}