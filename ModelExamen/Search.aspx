<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search"  MasterPageFile="~/MasterPage.master"%>

<asp:Content runat="server" ContentPlaceHolderID="head">

</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
            <asp:TextBox ID="TextBoxSearch" runat="server"></asp:TextBox>
            <asp:Button ID="ButtonSearch" runat="server" Text="sEARCH" OnClick="ButtonSearch_Click" />

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:model_examenConnectionString %>" 
                SelectCommand="SELECT [nume], [prenume], [data_nasterii], [data_angajare]
                FROM [Angajat] WHERE (([nume] LIKE '%' + @nume + '%') OR ([prenume] LIKE '%' + @prenume + '%'))">
                <SelectParameters>
                    <asp:QueryStringParameter Name="nume" QueryStringField="q" Type="String" />
                    <asp:QueryStringParameter Name="prenume" QueryStringField="q" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="nume" HeaderText="nume" SortExpression="nume" />
                    <asp:BoundField DataField="prenume" HeaderText="prenume" SortExpression="prenume" />
                    <asp:BoundField DataField="data_nasterii" HeaderText="data_nasterii" SortExpression="data_nasterii" />
                    <asp:BoundField DataField="data_angajare" HeaderText="data_angajare" SortExpression="data_angajare" />
                </Columns>
            </asp:GridView>
</asp:Content>