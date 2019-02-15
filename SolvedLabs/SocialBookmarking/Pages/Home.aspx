<%@ Page Title="" Language="C#" MasterPageFile="~/Helpers/Navbar.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderBody" Runat="Server">
    <h1> Most popular</h1>
    <asp:SqlDataSource ID="SqlDataSourcePopular" runat="server" ConnectionString="<%$ ConnectionStrings:MySqlMarkbook %>" 
        SelectCommand="SELECT Bookmarks.*, Users.UserName 
        FROM Bookmarks 
        INNER JOIN Users 
        ON Bookmarks.AuthorId = Users.UserId
        ORDER BY Bookmarks.Views DESC, Bookmarks.Title"></asp:SqlDataSource>
    <asp:GridView ID="GridViewPopular" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="Id" DataSourceID="SqlDataSourcePopular" AllowPaging="True" PageSize="4">
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

    <h1>Most recent</h1>
    <asp:SqlDataSource ID="SqlDataSourceRecent" runat="server" ConnectionString="<%$ ConnectionStrings:MySqlMarkbook %>" 
        SelectCommand="SELECT Bookmarks.*, Users.UserName 
        FROM Bookmarks 
        INNER JOIN Users 
        ON Bookmarks.AuthorId = Users.UserId
        ORDER BY Bookmarks.CreatedAt DESC, Bookmarks.Title"></asp:SqlDataSource>    
    <asp:GridView ID="GridViewRecent" runat="server" AllowPaging="True"  PageSize="4"
        AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceRecent">
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
            <asp:BoundField DataField="UserName" HeaderText="Author" SortExpression="UserName" />
        </Columns>
    </asp:GridView>
    
</asp:Content>

