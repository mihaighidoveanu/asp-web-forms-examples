<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:colocviuConnectionString %>" 
        SelectCommand="SELECT [IDSportiv], [Nume], [Prenume] FROM [Sportiv]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server"
        ConnectionString="<%$ ConnectionStrings:colocviuConnectionString %>" 
        SelectCommand="SELECT [IDProba], [Denumire], [Data] FROM [Angajat]"></asp:SqlDataSource>

    <asp:DropDownList ID="DropDownListSportiv" runat="server" 
        DataTextField="nume,prenume" DataTextFormatString="{0} {1}" DataValueField="Id"
        DataSourceID="SqlDataSource1" OnSelectedIndexChanged="DropDownListSportiv_SelectedIndexChanged"></asp:DropDownList>
    
    <h3> Editare sportiv </h3>
        <br />
        <br />

         <table>
         <tr>
            <td>Nume: &nbsp;</td>
            <td><asp:TextBox ID="Nume" runat="server"></asp:TextBox></td>
            <td>
                <asp:RequiredFieldValidator ValidationGroup="Create" ID="RequiredFieldValidator1" runat="server" ControlToValidate="Nume" ErrorMessage="Numele este obligatoriu"></asp:RequiredFieldValidator>
            </td>
         </tr>

        <tr>
            <td>Prenume &nbsp;</td>
            <td><asp:TextBox ID="Prenume" runat="server"></asp:TextBox></td>
            <td>
                <asp:RequiredFieldValidator ValidationGroup="Create" ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="Prenume" ErrorMessage="Prenumele este obligatoriu"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Tara &nbsp;</td>
            <td><asp:TextBox ID="Tara" runat="server"></asp:TextBox></td>
            <td>
                <asp:RequiredFieldValidator ValidationGroup="Create" ID="RequiredFieldValidator5" runat="server"
                    ControlToValidate="Tara" ErrorMessage="Tara este obligatorie"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Data Nasterii: &nbsp;</td>
            <td><asp:TextBox ID="DataNasterii" runat="server"></asp:TextBox></td>
            <td>
                <asp:RequiredFieldValidator ValidationGroup="Create" ID="RequiredFieldValidator3" runat="server" ControlToValidate="DataNasterii" ErrorMessage="Data nasterii este obligatorie"></asp:RequiredFieldValidator>
                <asp:CompareValidator ValidationGroup="Create" ID="CompareValidator2" runat="server" ControlToValidate="DataNasterii" ErrorMessage="Tip Data !" Operator="DataTypeCheck" Type="Date"></asp:CompareValidator>
            </td>
        </tr>

        <tr>
            <td>Proba la care participa: &nbsp;</td>
            <td><asp:DropDownList ID="DropDownListProba" runat="server" 
        DataTextField="nume,prenume" DataTextFormatString="{0} {1}" DataValueField="Id"
        DataSourceID="SqlDataSource1" OnSelectedIndexChanged="DropDownListProba_SelectedIndexChanged"></asp:DropDownList></td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="Proba" 
                    ErrorMessage="Denumirea probei este obligatorie" ValidationGroup="Create"></asp:RequiredFieldValidator>
                
            </td>
        </tr>
    </table>

    <asp:Button ID="ButtonEdit" runat="server" Text="eDIT" OnClick="ButtonEdit_Click" />
</asp:Content>

