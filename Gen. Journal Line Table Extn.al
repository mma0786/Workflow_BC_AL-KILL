tableextension 50052 "Gen. Jnl Line Table Extn." extends "Gen. Journal Line"
{
    fields
    {
        field(50050; "Posting Type"; Option)
        {
            OptionMembers = Advance,Running,Retention;
        }

    }
    var
        myInt: Integer;
}