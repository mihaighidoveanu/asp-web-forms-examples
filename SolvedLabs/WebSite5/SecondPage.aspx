<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="SecondPage.aspx.cs" Inherits="SecondPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h1>Where do users live ?</h1>
    <asp:FormView runat="server" ID="UserAdresses" AllowPaging="True" DataSourceID="UserAdressesDb">
        <EditItemTemplate>
            adress_name:
            <asp:TextBox ID="adress_nameTextBox" runat="server" Text='<%# Bind("adress_name") %>' />
            <br />
            name:
            <asp:TextBox ID="nameTextBox" runat="server" Text='<%# Bind("name") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <InsertItemTemplate>
            adress_name:
            <asp:TextBox ID="adress_nameTextBox" runat="server" Text='<%# Bind("adress_name") %>' />
            <br />
            name:
            <asp:TextBox ID="nameTextBox" runat="server" Text='<%# Bind("name") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </InsertItemTemplate>
        <ItemTemplate>
            adress_name:
            <asp:Label ID="adress_nameLabel" runat="server" Text='<%# Bind("adress_name") %>' />
            <br />
            name:
            <asp:Label ID="nameLabel" runat="server" Text='<%# Bind("name") %>' />
            <br />

        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="UserAdressesDb" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Adress.adress_name, [User].name FROM Adress INNER JOIN AdressToUsers ON Adress.id = AdressToUsers.adress_id INNER JOIN [User] ON AdressToUsers.user_id = [User].id"></asp:SqlDataSource>

    <h1>Address and User link</h1>
    <asp:FormView ID="UserAdressesLink" runat="server" AllowPaging="True" DataKeyNames="adress_id,user_id" DataSourceID="UserAdressesLinkDb">
        <EditItemTemplate>
            adress_id:
            <asp:Label ID="adress_idLabel1" runat="server" Text='<%# Eval("adress_id") %>' />
            <br />
            user_id:
            <asp:Label ID="user_idLabel1" runat="server" Text='<%# Eval("user_id") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <InsertItemTemplate>
            adress_id:
            <asp:TextBox ID="adress_idTextBox" runat="server" Text='<%# Bind("adress_id") %>' />
            <br />
            user_id:
            <asp:TextBox ID="user_idTextBox" runat="server" Text='<%# Bind("user_id") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </InsertItemTemplate>
        <ItemTemplate>
            adress_id:
            <asp:Label ID="adress_idLabel" runat="server" Text='<%# Eval("adress_id") %>' />
            <br />
            user_id:
            <asp:Label ID="user_idLabel" runat="server" Text='<%# Eval("user_id") %>' />
            <br />
            <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
        </ItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="UserAdressesLinkDb" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [AdressToUsers] WHERE [adress_id] = @original_adress_id AND [user_id] = @original_user_id" InsertCommand="INSERT INTO [AdressToUsers] ([adress_id], [user_id]) VALUES (@adress_id, @user_id)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [AdressToUsers]">
        <DeleteParameters>
            <asp:Parameter Name="original_adress_id" Type="Int32" />
            <asp:Parameter Name="original_user_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="adress_id" Type="Int32" />
            <asp:Parameter Name="user_id" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

    <h1>User adresses using repeater</h1>
    <asp:Repeater  runat="server" ID="Users" DataSourceID="UserAdressesDb">
        <HeaderTemplate>
             <table border="1">
          </HeaderTemplate>

          <ItemTemplate>
             <tr>
                <td> <%# Eval("adress_name") %> </td>
                <td> <%# Eval("name") %></td>
             </tr>
          </ItemTemplate>

          <FooterTemplate>
             </table>
          </FooterTemplate>

    </asp:Repeater>
</asp:Content>

