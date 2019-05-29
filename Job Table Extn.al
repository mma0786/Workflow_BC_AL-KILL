tableextension 50051 "Job Table Extn." extends Job
{
    fields
    {
        field(50050; "Project Amount (Planned)"; Decimal)
        {
            Caption = 'Project Amount (Planned)';
            FieldClass = FlowField;
            CalcFormula = sum ("Job Planning Line"."Line Amount" where
            ("Job No." = field ("No."), "Contract Line" = const (true)));
            Editable = false;
        }

        field(50051; "Advance Received"; Boolean)
        {
            Editable = false;
        }

        field(50052; "Advance Amount"; Decimal)
        {
            //FieldClass = FlowField;
            //CalcFormula = SUM ("Cust. Ledger Entry".Amount WHERE ("Job No." = field ("No."), "Posting Type" = const (Advance)));
        }

    }

    var
        myInt: Integer;
}