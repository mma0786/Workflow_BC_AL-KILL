codeunit 50051 "Sales-Post Extn."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', true, true)]
    procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header";
                                        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                                        SalesShptHdrNo: Code[20];
                                        RetRcpHdrNo: Code[20];
                                        SalesInvHdrNo: Code[20];
                                        SalesCrMemoHdrNo: Code[20])
    var
        SalesHeader2: Record "Sales Header";
        PaymentMilestone2: Record "Payment Milestone";
        PaymentMilestone3: Record "Payment Milestone";
    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN BEGIN
            PaymentMilestone2.Reset();
            PaymentMilestone2.SetRange("Document Type", PaymentMilestone2."Document Type"::Invoice);
            PaymentMilestone2.SetRange("Document No.", SalesHeader."No.");
            PaymentMilestone2.SetRange("Posting Type", PaymentMilestone2."Posting Type"::Advance);
            IF PaymentMilestone2.FindFirst() THEN BEGIN
                PaymentMilestone2.CalcSums(Amount);
                IF PaymentMilestone2.Amount > 0 THEN BEGIN
                    CreateSalesJournal(PaymentMilestone2, PaymentMilestone2.Amount, SalesHeader);
                END;
            END;
        END;
    end;

    procedure CreateSalesJournal(var PaymentMilestone: Record "Payment Milestone";
                                     PaymentMilestoneAmount: Decimal;
                                     SalesHeader: Record "Sales Header");
    var
        SalesJournalLine: Record "Gen. Journal Line";
        SalesJournalLine2: Record "Gen. Journal Line";
        Cust: Record Customer;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        SalesJournalLine2.Reset();
        SalesJournalLine2.SetRange("Journal Template Name", 'SALES');
        SalesJournalLine2.SetRange("Journal Batch Name", 'DEFAULT');
        SalesJournalLine2.SetRange("Document No.", PaymentMilestone."Document No.");
        SalesJournalLine2.DeleteAll();

        Cust.Get(SalesHeader."Sell-to Customer No.");

        SalesJournalLine2.Reset();
        SalesJournalLine2.SetRange("Journal Template Name", 'SALES');
        SalesJournalLine2.SetRange("Journal Batch Name", 'DEFAULT');
        IF SalesJournalLine2.FindLast() THEN;
        SalesJournalLine.Init;
        SalesJournalLine.Validate("Journal Template Name", 'SALES');
        SalesJournalLine.Validate("Journal Batch Name", 'DEFAULT');
        SalesJournalLine.Validate("Line No.", SalesJournalLine2."Line No." + 10000);
        SalesJournalLine.Insert(TRUE);
        SalesJournalLine.validate("Posting Date", SalesHeader."Posting Date");
        SalesJournalLine.Validate("Document No.", SalesHeader."No.");
        SalesJournalLine.Validate("Posting Type", SalesJournalLine."Posting Type"::Advance);
        SalesJournalLine.Validate("Account Type", SalesJournalLine."Account Type"::"G/L Account");
        Cust.TestField("Advance A/c");
        SalesJournalLine.Validate("Account No.", Cust."Advance A/c");
        SalesJournalLine.Description := 'Advance';
        SalesJournalLine.Validate(Amount, PaymentMilestoneAmount);
        SalesJournalLine.Validate("Bal. Account Type", SalesJournalLine."Bal. Account Type"::Customer);
        SalesJournalLine.Validate("Bal. Account No.", Cust."No.");
        SalesJournalLine.Validate("Job No.", SalesHeader."No.");
        SalesJournalLine.Modify();
        //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Line", SalesJournalLine);
        GenJnlPostLine.RunWithCheck(SalesJournalLine);
    end;

}