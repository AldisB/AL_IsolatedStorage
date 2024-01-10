permissionset 50100 "ABI All"
{
    Access = Internal;
    Assignable = true;
    Caption = 'All permissions', Locked = true;
    Permissions = codeunit "Isolated Storage Mgt. ABI" = X,
        page "Vendor Website Settings ABI" = X;
}