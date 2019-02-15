<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Cauta.aspx.cs" Inherits="Cauta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource runat="server" ID="SearchUserDb" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [User]">
    </asp:SqlDataSource>
    
    <h2>With Grid View</h2>
    
    <asp:GridView runat="server" ID="UsersGrid" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SearchUserDb">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
            <asp:BoundField DataField="cnp" HeaderText="cnp" SortExpression="cnp" />
        </Columns>
        <EmptyDataTemplate>No records found</EmptyDataTemplate>
    </asp:GridView>

    <h2>With Repeater</h2>

    <asp:Repeater ID="UsersRepeater" runat="server" DataSourceId="SearchUserDb">
        <HeaderTemplate>
             <table border="1">
                 <thead>
                     <tr>
                         <td>Id</td>
                         <td>Name</td>
                         <td>Cnp</td>
                     </tr>
                 </thead>
        </HeaderTemplate>
        <ItemTemplate>
            <tbody>
                <tr>
                    <td><%#Eval("id") %></td>
                    <td><%#Eval("name") %></td>
                    <td><%#Eval("cnp") %></td>
                </tr>
            </tbody>
        </ItemTemplate>
        <FooterTemplate>
            </table>
            <asp:Label runat="server" Visible="<%# UsersRepeater.Items.Count == 0%>" Text="No Items found"></asp:Label>
        </FooterTemplate>
    </asp:Repeater>

</asp:Content>

