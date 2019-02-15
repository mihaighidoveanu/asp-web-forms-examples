<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Add.aspx.cs" Inherits="Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>Nume : </p>
    <asp:TextBox ID="TextBoxNume" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
        ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBoxNume"></asp:RequiredFieldValidator>
        
    <br />
    <p>Prenume :</p>
    <asp:TextBox ID="TextBoxPrenume" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
        ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBoxPrenume"></asp:RequiredFieldValidator>

    <p>Data nasterii : </p>
    <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
    <br />
    <p>Data angajarii:</p>

    <asp:Calendar ID="Calendar2" runat="server"></asp:Calendar>
    <br />

    <asp:Button ID="ButtonAdd" runat="server" OnClick="ButtonAdd_Click"  Text="Add"/>

</asp:Content>

