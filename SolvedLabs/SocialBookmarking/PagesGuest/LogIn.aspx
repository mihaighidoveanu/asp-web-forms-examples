﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Helpers/Navbar.master" AutoEventWireup="true" CodeFile="LogIn.aspx.cs" Inherits="PagesGuest_LogIn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderBody" Runat="Server">
    <asp:Login ID="LoginInput" runat="server" MembershipProvider="DefaultMembershipProvider"
        OnLoggedIn="LoginInput_LoggedIn" />
</asp:Content>

