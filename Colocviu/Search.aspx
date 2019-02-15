<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     
   <h1>Cautare sportivi</h1>
    <asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" 
        ConnectionString="<%$ ConnectionStrings:colocviuConnectionString %>" ></asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSourceSearch"></asp:GridView>
    <p>Veti cauta sportivi dupa :</p>
    <p>Nume : </p>
    <asp:TextBox ID="Nume" runat="server"></asp:TextBox>
    <br />
    <p>Tara :</p>
    <br />
    <asp:TextBox ID="Tara" runat="server"></asp:TextBox>
    <p>Proba : </p>
    <br />
    <asp:TextBox ID="Proba" runat="server"></asp:TextBox>
    <br />
    <asp:Button ID="SearchButtonAdvanced" runat="server" Text="Search" 
            ValidationGroup="SearchAdvanced" OnClick="SearchButtonAdvanced_Click"/>

    <asp:Label ID="LabelError" runat="server"></asp:Label>
</asp:Content>

