<%@ Page Title="" Language="C#" MasterPageFile="~/Helpers/Navbar.master" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderBody" Runat="Server">
    <asp:Panel ID="SearchAdvanced" runat="server">
        <asp:TextBox ID="SearchInputAdvanced" runat="server" AutoCompleteType="Disabled" ValidationGroup="SearchAdvanced"  />
        <asp:Button ID="SearchButtonAdvanced" runat="server" Text="Search" ValidationGroup="SearchAdvanced" OnClick="SearchOptions_SelectedIndexChanged"/>
    </asp:Panel>
    <br />
    <asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:MySqlMarkbook %>" ></asp:SqlDataSource>
    <asp:GridView ID="GridViewSearch" runat="server" AllowPaging="True" PageSize="4"
        AllowSorting="True" DataSourceID="SqlDataSourceSearch" 
         AutoGenerateColumns="false"
        EmptyDataText="Your search returned no results. Please try other keywords." >
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="Id" 
                DataNavigateUrlFormatString="Bookmark.aspx?ID={0}"
                DataTextField="Title"
                HeaderText="Title"
                SortExpression="Title"/>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:BoundField DataField="CreatedAt" HeaderText="CreatedAt" SortExpression="CreatedAt" />
            <asp:ImageField  HeaderText="Photo" DataImageUrlField="Photo" 
                ControlStyle-Height="100" ControlStyle-Width="100"
                 DataAlternateTextField="Title"
                 DataAlternateTextFormatString="{0}">
            </asp:ImageField>
            <asp:HyperLinkField DataNavigateUrlFields="AuthorId" 
                DataNavigateUrlFormatString="~/PagesMember/Markpage.aspx?ID={0}"
                DataTextField="UserName"
                HeaderText="Author"
                SortExpression="UserName"/>
        </Columns>
    </asp:GridView>
    <p>Your search will be conducted by :</p>
    <asp:CheckBoxList ID="SearchOptions" runat="server" 
        RepeatDirection="Horizontal"  OnSelectedIndexChanged="SearchOptions_SelectedIndexChanged"
         AutoPostBack="true">
        <asp:ListItem Selected="True" Text="By title" Value="[Bookmarks].Title"></asp:ListItem>
        <asp:ListItem Selected="False" Text="By tags" Value="[Tags].Text"></asp:ListItem>
        <asp:ListItem Selected="False" Text="By description" Value="[Bookmarks].Description"></asp:ListItem>
    </asp:CheckBoxList>
    <asp:Label ID="LabelError" runat="server"></asp:Label>
</asp:Content>

