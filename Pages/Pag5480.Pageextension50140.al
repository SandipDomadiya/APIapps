pageextension 50140 Pageextension50140 extends "Account Entity"
{
    layout
    {
        addafter(lastModifiedDateTime)
        {
            Field("Account Type"; "Account Type")
            {
                ApplicationArea = "#All";
            }
            Field("Net Change"; "Net Change")
            {
                ApplicationArea = "#All";
            }
            Field("Balance"; "Balance")
            {
                ApplicationArea = "#All";
            }

        }
    }
}