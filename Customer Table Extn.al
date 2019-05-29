tableextension 50054 "Customer Table Extn." extends Customer
{
    fields
    {
        field(50050; "Retention A/c"; code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50051; "Advance A/c"; code[20])
        {
            TableRelation = "G/L Account";
        }
    }

    var
        myInt: Integer;
}