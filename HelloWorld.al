// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!
pageextension 50101 "Customer Card Page" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Statistics)
        {
            action("Click me")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Message('Done');
                end;
            }
        }

    }

    var
        myInt: Integer;
}