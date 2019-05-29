pageextension 50051 "Payment Milestone Extend SQ" extends "Sales Quote"
{
    actions
    {
        addlast(Create)
        {
            action("Payment Milestone")
            {
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = "#Basic", "#Suite";
                PromotedIsBig = true;
                PromotedOnly = true;
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