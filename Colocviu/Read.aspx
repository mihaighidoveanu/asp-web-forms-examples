<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Read.aspx.cs" Inherits="Read" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:colocviuConnectionString %>" 
        SelectCommand="SELECT Sportiv.Nume, Sportiv.Prenume, Sportiv.Tara, Sportiv.DataNasterii, Proba.Denumire AS Proba
        FROM Sportiv INNER JOIN Proba ON Sportiv.IDProba = Proba.IDProba"></asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="Nume" HeaderText="Nume" SortExpression="Nume" />
            <asp:BoundField DataField="Prenume" HeaderText="Prenume" SortExpression="Prenume" />
            <asp:BoundField DataField="Tara" HeaderText="Tara" SortExpression="Tara" />
            <asp:BoundField DataField="DataNasterii" HeaderText="DataNasterii" SortExpression="DataNasterii" />
            <asp:BoundField DataField="Proba" HeaderText="Proba" SortExpression="Proba" />
        </Columns>

    </asp:GridView>
</asp:Content>

