table 50050 "Payment Milestone"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = Quote,Order,Invoice,Job;
        }
        field(2; "Document No."; Code[20]) { }
        field(3; "Line No."; Integer) { }
        field(4; "Document Date"; Date) { }
        field(5; "Posting Type"; Option)
        {
            OptionMembers = Advance,Running,Retention;
        }
        field(6; "Milestone %"; Decimal)
        {
            trigger OnValidate()
            begin
                Amount := Round(("Total Value" * "Milestone %") / 100, 0.01, '=');
            end;
        }
        field(7; "Milestone Description"; Text[100]) { }
        field(8; "Payment Terms"; Code[20])
        {
            TableRelation = "Payment Terms";
            trigger OnValidate()
            begin
                IF ("Payment Terms" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                    PaymentTerms.Get("Payment Terms");
                    "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
                END;
            end;
        }

        field(9; "Total Value"; Decimal) { }
        field(10; Amount; Decimal)
        {
            Editable = false;
        }
        field(11; "Due Date"; Date) { }

    }

    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(PostingType; "Document Type", "Document No.", "Posting Type")
        {
            SumIndexFields = Amount;
        }
    }

    var
        SalesHeader: Record "Sales Header";
        PaymentTerms: Record "Payment Terms";
        Job: Record Job;

    trigger OnInsert()
    begin
        IF NOT ("Document Type" = "Document Type"::Job) THEN BEGIN
            SalesHeader.Reset();
            SalesHeader.SetRange("Document Type", Rec."Document Type");
            SalesHeader.SetRange("No.", Rec."Document No.");
            IF SalesHeader.FindFirst THEN BEGIN
                "Document Date" := SalesHeader."Document Date";
                SalesHeader.CalcFields(Amount);
                "Total Value" := SalesHeader.Amount;
            END;
        END
        ELSE BEGIN
            Job.Reset();
            Job.SetRange("No.", Rec."Document No.");
            IF Job.FindFirst() THEN BEGIN
                "Document Date" := Job."Starting Date";
                Job.CalcFields("Project Amount (Planned)");
                "Total Value" := Job."Project Amount (Planned)";
            END;
        END;
        Amount := Round(("Total Value" * "Milestone %") / 100, 0.01, '=');
        IF ("Payment Terms" <> '') AND ("Document Date" <> 0D) THEN BEGIN
            PaymentTerms.Get("Payment Terms");
            "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
        END;
    end;

    trigger OnModify()
    begin
        Amount := Round(("Total Value" * "Milestone %") / 100, 0.01, '=');
        IF ("Payment Terms" <> '') AND ("Document Date" <> 0D) THEN BEGIN
            PaymentTerms.Get("Payment Terms");
            "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
        END;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}