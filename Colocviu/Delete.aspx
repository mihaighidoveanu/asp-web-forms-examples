<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Delete.aspx.cs" Inherits="Delete" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Stergere sportiv </h1>

     <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
         ConnectionString="<%$ ConnectionStrings:colocviuConnectionString %>" 
         SelectCommand="SELECT [IDSportiv], [nume] FROM [Sportiv]"></asp:SqlDataSource>
    <asp:DropDownList ID="DropDownListDelete" runat="server"  DataTextField="nume"
        DataTextFormatString="{0}" DataValueField="IDSportiv"
        DataSourceID="SqlDataSource1" />
    <asp:Button ID="ButtonDelete" runat="server" Text="Delete" OnClick="ButtonDelete_Click" />

</asp:Content>

