<%@ Page Title="" Language="C#" MasterPageFile="~/Helpers/Navbar.master" AutoEventWireup="true" CodeFile="SignUp.aspx.cs" Inherits="Pages_SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderBody" Runat="Server">
    <asp:CreateUserWizard ID="CreateUserWizard" runat="server" 
        MembershipProvider="DefaultMembershipProvider" OnCreatedUser="CreateUserWizard_CreatedUser">
        <WizardSteps>
            <asp:CreateUserWizardStep ID="CreateUserWizardStep" runat="server" 
                Title="Sign up and start marking and exploring !" >
                <ContentTemplate>
                    <p>Sign up and start marking and exploring !</p>
                    <asp:Label ID="UserNameLabel" runat="server" 
                        AssociatedControlID="UserName">User Name:</asp:Label>
                    <br />
                    <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                        ControlToValidate="UserName" ErrorMessage="User Name is required." 
                        ToolTip="User Name is required." ValidationGroup="CreateUserWizard">*</asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="PasswordLabel" runat="server" 
                        AssociatedControlID="Password">Password:</asp:Label>
                    <br />
                    <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                        ControlToValidate="Password" ErrorMessage="Password is required." 
                        ToolTip="Password is required." ValidationGroup="CreateUserWizard">*</asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="ConfirmPasswordLabel" runat="server" 
                        AssociatedControlID="ConfirmPassword">Confirm Password:</asp:Label>
                    <br />
                    <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server"
                        ControlToValidate="ConfirmPassword" ErrorMessage="Confirm Password is required." 
                        ToolTip="Confirm Password is required." ValidationGroup="CreateUserWizard">*</asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" 
                        ControlToValidate="ConfirmPassword" Display="Dynamic" 
                        ErrorMessage="The Password and Confirmation Password must match." 
                        ValidationGroup="CreateUserWizard"></asp:CompareValidator>
                    <br />
                    <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label>
                    <br />
                    <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" 
                        ControlToValidate="Email" ErrorMessage="E-mail is required." 
                        ToolTip="E-mail is required." ValidationGroup="CreateUserWizard">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="EmailValidator" runat="server" 
                        ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" 
                        ControlToValidate="Email" ErrorMessage="Invalid Email Format" />
                    <asp:CustomValidator ID="CustomValidatorEmail" runat="server"
                        ErrorMessage="This email is already registered. Please choose another one" 
                        ControlToValidate="Email" OnServerValidate="CustomValidatorEmail_ServerValidate"
                        />
                    <br />                    
                    <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                    <br />
                    

                </ContentTemplate>
            </asp:CreateUserWizardStep>
            
            <asp:CompleteWizardStep ID="CompleteWizardStep" runat="server">
                <ContentTemplate>
                    <asp:Label ID="ErrorLabelCompleted" runat="server">Your account was succesfully created.</asp:Label>
                    <asp:Button ID="ContinueButton" runat="server" CausesValidation="False" 
                        CommandName="Continue" OnClick="ContinueButton_Click" 
                        Text="Continue" ValidationGroup="CreateUserWizard"/>
                </ContentTemplate>
            </asp:CompleteWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>
    <br />
</asp:Content>

