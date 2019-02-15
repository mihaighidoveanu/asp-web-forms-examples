<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="ThirdPage.aspx.cs" Inherits="ThirdPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:HyperLink id="LinkAddPhone" NavigateUrl="~/Add.aspx" Text="Add new phone client's phone number" runat="server" /> 
    <br />
    <br />
    <asp:GridView ID="PhoneNumbers" runat="server" AutoGenerateColumns="False" DataSourceID="PhoneNumbersDb">
        <Columns>
            <asp:BoundField DataField="name" HeaderText="Client name" SortExpression="name" />
            <asp:BoundField DataField="number" HeaderText="Phone number" SortExpression="number" />
            <asp:HyperLinkField DataNavigateUrlFields="Id" 
                DataNavigateUrlFormatString="~/Edit.aspx?id={0}"
                HeaderText="Edit Number" Text="Edit"/>
            <asp:HyperLinkField DataNavigateUrlFields="Id"
                DataNavigateUrlFormatString="~/Delete.aspx?id={0}"
                HeaderText="Delete Number" Text="Delete"/>
        </Columns>       
    </asp:GridView>
    <asp:SqlDataSource ID="PhoneNumbersDb" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [PhoneNumbers].Id, [User].name, PhoneNumbers.number FROM PhoneNumbers INNER JOIN [User] ON PhoneNumbers.user_id = [User].id"></asp:SqlDataSource>
</asp:Content>

