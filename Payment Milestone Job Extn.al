pageextension 50054 "Payment Milestone Extend Job" extends "Job Card"
{
    layout
    {
        addafter("Project Manager")
        {
            field("Advance Amount"; "Advance Amount")
            {
                Editable = false;
            }
            field("Advance Received"; "Advance Received")
            {
                Editable = false;
            }
            field("Project Amount (Planned)"; "Project Amount (Planned)")
            {
                Editable = false;
            }
        }
    }
    actions
    {
        addlast("&Job")
        {
            action("Payment Milestone")
            {
                Image = Payment;
                Promoted = true;
                Caption = 'Payment Milestone';
                TRIGGER OnAction()
                var
                    PaymentMilestone: Record "Payment Milestone";
                BEGIN
                    PaymentMilestone.Reset();
                    PaymentMilestone.SetRange("Document Type", PaymentMilestone."Document Type"::Job);
                    PaymentMilestone.SetRange("Document No.", Rec."No.");
                    PAGE.RUNMODAL(50050, PaymentMilestone);
                END;
            }

        }
    }

    var
        myInt: Integer;

    trigger
OnAfterGetCurrRecord()
    var
        CustLedgerEntryRecL: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntryRecL.Reset();
        CustLedgerEntryRecL.SetRange("Customer No.", "Bill-to Customer No.");
        CustLedgerEntryRecL.SetRange("Job No.", "No.");
        CustLedgerEntryRecL.SetRange("Posting Type", CustLedgerEntryRecL."Posting Type"::Advance);
        if CustLedgerEntryRecL.FindSet() then begin
            CustLedgerEntryRecL.CalcFields(Amount);
            "Advance Amount" := CustLedgerEntryRecL.Amount;
        end;

    end;
}