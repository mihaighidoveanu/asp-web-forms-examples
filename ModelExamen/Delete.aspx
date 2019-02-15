<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Delete.aspx.cs" Inherits="Delete" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:model_examenConnectionString %>" SelectCommand="SELECT [Id], [nume] FROM [Angajat]"></asp:SqlDataSource>
    <asp:DropDownList ID="DropDownListDelete" runat="server"  DataTextField="nume" DataTextFormatString="{0}" DataValueField="Id"
        DataSourceID="SqlDataSource1" />
    <asp:Button ID="ButtonDelete" runat="server" Text="dELETE" OnClick="ButtonDelete_Click" />

</asp:Content>

