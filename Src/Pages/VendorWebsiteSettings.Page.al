page 50100 "Vendor Website Settings ABI"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Vendor;
    Caption = 'Vendor Website Settings';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name.';
                }
                field(HasWebshopPassword; HasWebshopPassword)
                {
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
    }

    actions
    {
        area(Processing)
        {
            action(ForgetPassword)
            {
                ApplicationArea = All;
                Caption = 'Forget Password';
                ToolTip = 'Delete the password for the selected Vendor.';
                Image = Delete;

                trigger OnAction();
                begin
                    IsolatedStorage.Delete('Vendor' + Rec."No.");
                end;
            }
            action(ShowPassword)
            {
                ApplicationArea = All;
                Caption = 'Show Password';
                ToolTip = 'Show the current password.';
                Image = ShowSelected;

                trigger OnAction();
                begin
                    IsolatedStorageMgt.ShowKey('Vendor' + Rec."No.");
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