pageextension 50053 "Payment Milestone Extend SI" extends "Sales Invoice"
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
                    LineNo: Integer;
                BEGIN
                    SalesLine.Reset();
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.SetFilter("Job No.", '<>%1', '');
                    IF SalesLine.FindFirst() THEN BEGIN
                        PaymentMilestone2.Reset();
                        PaymentMilestone2.SetRange("Document Type", Rec."Document Type");
                        PaymentMilestone2.SetRange("Document No.", Rec."No.");
                        IF NOT PaymentMilestone2.FindFirst() THEN BEGIN
                            PaymentMilestone.Reset();
                            PaymentMilestone.SetRange("Document Type", PaymentMilestone."Document Type"::Job);
                            PaymentMilestone.SetRange("Document No.", SalesLine."Job No.");
                            IF PaymentMilestone.FindFirst() THEN BEGIN
                                REPEAT
                                    //SalesHeader.Reset();
                                    //SalesHeader.SetRange("Document Type", Rec."Document Type");
                                    //SalesHeader.SetRange("No.", SalesLine."Document No.");
                                    //IF SalesHeader.FindFirst THEN BEGIN
                                    //SalesHeader.CalcFields(Amount);
                                    PaymentMilestone3.Init();
                                    PaymentMilestone3.Copy(PaymentMilestone);
                                    PaymentMilestone3."Document Type" := Rec."Document Type";
                                    PaymentMilestone3."Document No." := Rec."No.";
                                    PaymentMilestone3.Insert(true);
                                    //END;
                                UNTIL PaymentMilestone.NEXT = 0;
                            END;
                        END;
                        Commit();
                    END;
                    Clear(PaymentMilestone);
                    PaymentMilestone.Reset();
                    PaymentMilestone.SetRange("Document Type", Rec."Document Type");
                    PaymentMilestone.SetRange("Document No.", Rec."No.");
                    PAGE.RUNMODAL(50050, PaymentMilestone);
                END;
            }

        }
    }

    var
        Job: Record Job;
        PaymentMilestone2: Record "Payment Milestone";
        SalesLine: Record "Sales Line";
        PaymentMilestone3: Record "Payment Milestone";
        SalesHeader: Record "Sales Header";
}