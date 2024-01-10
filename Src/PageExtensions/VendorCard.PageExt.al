pageextension 50100 "Vendor Card ABI" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field(HasWebshopPassword; HasWebshopPassword)
            {
                ApplicationArea = All;
                Caption = 'Has Webshop Password';
                ToolTip = 'Specifies if Vendor have web shop password stored.';
                Editable = false;

                trigger OnAssistEdit()
                begin
                    IsolatedStorageMgt.SetPassword('Vendor' + Rec."No.");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if IsolatedStorageMgt.HasKey('Vendor' + Rec."No.") then
            HasWebshopPassword := 'available'
        else
            HasWebshopPassword := 'assign';
    end;

    var
        IsolatedStorageMgt: Codeunit "Isolated Storage Mgt. ABI";
        HasWebshopPassword: Text;

}