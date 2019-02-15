<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Delete.aspx.cs" Inherits="Delete" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2> Sunteți sigur că vreți să ștergeți înregistrarea ? </h2>
    <asp:TextBox ID="ClientNameText" runat="server" ReadOnly="true"/>
    <asp:TextBox ID="ClientPhoneText" runat="server" ReadOnly="true"/>

    <asp:Button runat="server" ID="SubmitDelete" OnClick="SubmitDelete_Click" Text="Delete" />
    <asp:LinkButton runat="server" ID="ToThirdPage"  Text="Cancel" PostBackUrl="~/ThirdPage.aspx"/>
</asp:Content>

