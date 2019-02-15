<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Add.aspx.cs" Inherits="Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" >
    <!-- Client Name SQL Data Source -->
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT [id], [name] FROM [User]">
        </asp:SqlDataSource>

    <asp:Panel ID="PanelInputName" runat="server">
        <asp:Label runat="server" Text="New client name :"  AssociatedControlID="InputListClientName"></asp:Label>
        <asp:DropDownList runat="server" ID="InputListClientName" />
           <asp:RequiredFieldValidator runat="server" ControlToValidate="InputListClientName" 
               InitialValue="--" ErrorMessage="Client name is required" ForeColor="Red" />
        
    </asp:Panel>
    <asp:Panel ID="PanelInputNumber" runat="server">
        <asp:Label runat="server" Text="New client phone number :" AssociatedControlID="TextInputNumber"></asp:Label>
        <asp:TextBox ID="TextInputNumber" runat="server"
            AutoCompleteType="Disabled"></asp:TextBox>
        <asp:CustomValidator ID="ValidatorPhone" runat="server" ControlToValidate="TextInputNumber" 
             Type="String" ValidateEmptyText="true" OnServerValidate="Phone_ServerValidate"
            ErrorMessage="Phone number should be a number with 10 digits. It is required." ForeColor="Red"/>
    </asp:Panel>

    <asp:Button ID="SubmitNewPhoneNumber" runat="server" Text="Submit" OnClick="SubmitNewPhoneNumber_Click"/>
</asp:Content>

