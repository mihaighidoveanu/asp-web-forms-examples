<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT [id], [name] FROM [User]">
    </asp:SqlDataSource>

    <asp:Panel ID="PanelInputName" runat="server">
        <asp:Label runat="server" Text="Client :"  AssociatedControlID="TextClientName"></asp:Label>
        <asp:TextBox runat="server" ID="TextClientName"  Enabled="false" />
          
    </asp:Panel>
    <asp:Panel ID="PanelInputNumber" runat="server">
        <asp:Label runat="server" Text="Client phone number :" AssociatedControlID="TextInputNumber"></asp:Label>
        <asp:TextBox ID="TextInputNumber" runat="server"
            AutoCompleteType="Disabled" Text="" ValidationGroup="Edit"></asp:TextBox>
        <asp:CustomValidator ID="ValidatorPhone" runat="server" ControlToValidate="TextInputNumber" 
             Type="String" ValidateEmptyText="true" OnServerValidate="ValidatorPhone_ServerValidate"
             ValidationGroup="Edit"
            ErrorMessage="Phone number should be a number with 10 digits. It is required." ForeColor="Red"/>
    </asp:Panel>

    <asp:Button ID="SubmitEditPhoneNumber" runat="server" Text="Submit" 
         UseSubmitBehavior="false"
        OnClick="SubmitEditPhoneNumber_Click" ValidationGroup="Edit"/>
</asp:Content>

