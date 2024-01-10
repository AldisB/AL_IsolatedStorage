codeunit 50100 "Isolated Storage Mgt. ABI"
{
    trigger OnRun()
    begin
    end;

    internal procedure SetPassword(KeyName: Text)
    var
        ConfirmManagement: Codeunit "Confirm Management";
        PasswordDialogManagement: Codeunit "Password Dialog Management";
        DefaultValue: Boolean;
        [NonDebuggable]
        PasswordValue: Text;
        PasswordExistsLbl: Label 'Password already stored! Replace with new value?';
    begin
        DefaultValue := true;
        if HasKey(KeyName) then
            if not ConfirmManagement.GetResponseOrDefault(PasswordExistsLbl, DefaultValue) then
                exit;

        PasswordValue := PasswordDialogManagement.OpenPasswordDialog();
        if PasswordValue = '' then
            exit;

        SetKey(KeyName, PasswordValue);
    end;

    [NonDebuggable]
    internal procedure HasKey(KeyName: Text): Boolean
    begin
        if not IsolatedStorage.Contains(KeyName) then
            exit(false);

        exit(true);
    end;

    [NonDebuggable]
    internal procedure SetKey(KeyName: Text; KeyValue: Text)
    begin
        if EncryptionEnabled() then
            IsolatedStorage.SetEncrypted(KeyName, KeyValue, DataScope::Company)
        else
            IsolatedStorage.Set(KeyName, KeyValue, DataScope::Company);
    end;

    [NonDebuggable]
    internal procedure ShowKey(KeyName: Text)
    var
        Passowrd: Text;
        PasswordNotStoredLbl: Label 'Possword could not be retreaved!';
    begin
        if IsolatedStorage.Get(KeyName, Passowrd) then
            Message(Passowrd)
        else
            Message(PasswordNotStoredLbl)
    end;
}
