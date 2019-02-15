<%@ Page Title="" Language="C#" MasterPageFile="~/Helpers/Navbar.master" AutoEventWireup="true" CodeFile="AddAdmin.aspx.cs" Inherits="Admin_AddAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderBody" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSourceAdmins" runat="server" ConnectionString="<%$ ConnectionStrings:MySqlMarkbook %>" 
        SelectCommand="SELECT Users.UserId, Users.UserName, Users.LastActivityDate, Roles.RoleName 
        FROM Roles INNER JOIN UsersInRoles ON Roles.RoleId = UsersInRoles.RoleId 
        INNER JOIN Users ON UsersInRoles.UserId = Users.UserId ORDER BY Users.LastActivityDate ASC">
    </asp:SqlDataSource>
    <%--<asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSourceAdmins" >
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
            <asp:BoundField DataField="LastActivityDate" HeaderText="LastActivityDate" SortExpression="LastActivityDate" />
            <asp:BoundField DataField="RoleName" HeaderText="RoleName" SortExpression="RoleName" />
        </Columns>
    </asp:GridView>--%>
    <asp:Repeater ID="RepeaterAdmin" runat="server" DataSourceID="SqlDataSourceAdmins"
        OnItemDataBound="RepeaterAdmin_ItemDataBound">
        <HeaderTemplate>
            <asp:Label runat="server" >User name</asp:Label>
            <asp:Label runat="server" >Last activity</asp:Label>
            <asp:Label runat="server" >Admin status</asp:Label>
        </HeaderTemplate>
        <ItemTemplate>
            <br />
            <asp:TextBox ID="UserName" runat="server" ReadOnly="true" 
                Text ='<%# Eval("UserName") %>' />
            <asp:TextBox ID="LastActivityDate" runat="server" ReadOnly="true" 
                Text ='<%# Eval("LastActivityDate") %>'/>
            <asp:CheckBox ID="AdminStatus" runat="server" />

            <!-- Hidden auxiliary fields -->
            <asp:TextBox ID="RoleNameData" runat="server" ReadOnly="true" 
                Text ='<%# Eval("RoleName") %>' Visible="false"/>
            <asp:TextBox ID="UserIdData" runat="server" ReadOnly="true" 
                Text ='<%# Eval("UserId") %>' Visible="false"/>
            
        </ItemTemplate>
    </asp:Repeater>
    <br />
    <asp:Button ID="ButtonAdminSubmit" runat="server" Text="Submit changes" OnClick="ButtonAdminSubmit_Click"
        ValidationGroup="ManageAdmins" />
    <asp:Label ID="ErrorLabel" runat="server" ForeColor="Red"></asp:Label>
</asp:Content>

