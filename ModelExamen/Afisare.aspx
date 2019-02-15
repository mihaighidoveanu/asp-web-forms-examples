<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Afisare.aspx.cs" Inherits="Afisare" MasterPageFile="~/MasterPage.master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
    
    <asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:model_examenConnectionString %>" SelectCommand="SELECT Angajat.nume, Angajat.prenume, Salarii.salariu FROM Angajat INNER JOIN Salarii ON Angajat.Id = Salarii.Id WHERE (Salarii.salariu &gt;= @salariu)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox1" Name="salariu" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <p>Salariu minim :</p>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="nume" HeaderText="nume" SortExpression="nume" />
                    <asp:BoundField DataField="prenume" HeaderText="prenume" SortExpression="prenume" />
                    <asp:BoundField DataField="salariu" HeaderText="salariu" SortExpression="salariu" />
                </Columns>
            </asp:GridView>

           
        </asp:Content>    
