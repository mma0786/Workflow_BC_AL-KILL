codeunit 50050 "Job Create-Invoice Extension"
{
    //Delete Payment Milestone Entries on deletion of sales invoice.
    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeDeleteEvent', '', true, true)]
    procedure OnBeforeDeleteSalesInvoice(VAR Rec: Record "Sales Header"; RunTrigger: Boolean)
    var
        PaymentMilestone: Record "Payment Milestone";
    begin
        PaymentMilestone.Reset();
        IF Rec."Document Type" = Rec."Document Type"::Invoice THEN
            PaymentMilestone.SetRange("Document Type", PaymentMilestone."Document Type"::Invoice)
        else
            if Rec."Document Type" = Rec."Document Type"::Order then
                PaymentMilestone.SetRange("Document Type", PaymentMilestone."Document Type"::Order)
            else
                if Rec."Document Type" = Rec."Document Type"::Quote then
                    PaymentMilestone.SetRange("Document Type", PaymentMilestone."Document Type"::Quote);

        PaymentMilestone.SetRange("Document No.", Rec."No.");
        PaymentMilestone.DeleteAll();
    end;
    //Delete Payment Milestone Entries on deletion of sales invoice.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnAfterOnRun', '', true, true)]
    local procedure OnAfterOnRunSalesQuoteToOrder(var SalesHeader: Record "Sales Header";
                                                  var SalesOrderHeader: Record "Sales Header")
    begin
        PaymentMilestone2.Reset();
        PaymentMilestone2.SetRange("Document Type", PaymentMilestone2."Document Type"::Quote);
        PaymentMilestone2.SetRange("Document No.", SalesHeader."No.");
        IF PaymentMilestone2.FindFirst() THEN BEGIN
            REPEAT
                PaymentMilestone3.Init();
                PaymentMilestone3.Copy(PaymentMilestone2);
                PaymentMilestone3."Document Type" := PaymentMilestone3."Document Type"::Order;
                PaymentMilestone3."Document No." := SalesOrderHeader."No.";
                PaymentMilestone3.Insert(true);
            UNTIL PaymentMilestone2.NEXT = 0;
        END;
    END;

    var
        PaymentMilestone2: Record "Payment Milestone";
        PaymentMilestone3: Record "Payment Milestone";
        SalesHeader2: Record "Sales Header";
}

