<%@ Page Title="" Language="C#" MasterPageFile="~/Helpers/Navbar.master" AutoEventWireup="true" CodeFile="Markpage.aspx.cs" Inherits="Markpage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderBody" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSourceBookmarks" runat="server" ConnectionString="<%$ ConnectionStrings:MySqlMarkbook %>" 
         />
    <asp:GridView ID="GridViewBookmarks" runat="server" AllowPaging="True"
        AutoGenerateColumns="False" DataSourceID="SqlDataSourceBookmarks" DataKeyNames="Id">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="Id" 
                DataNavigateUrlFormatString="~/Pages/Bookmark.aspx?ID={0}"
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
            <asp:HyperLinkField DataNavigateUrlFields="MarkPageId" 
                DataNavigateUrlFormatString="~/PagesMember/Markpage.aspx?ID={0}"
                DataTextField="UserName"
                HeaderText="Author"
                SortExpression="UserName"
                />            
        </Columns>
    </asp:GridView>
</asp:Content>
