pageextension 50052 "Payment Milestone Extend SO" extends "Sales Order"
{
    actions
    {
        addlast("P&osting")
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
                    PaymentMilestone.SetRange("Document Type", Rec."Document Type");
                    PaymentMilestone.SetRange("Document No.", Rec."No.");
                    PAGE.RUNMODAL(50050, PaymentMilestone);
                END;
            }

        }
    }

    var
        myInt: Integer;
}