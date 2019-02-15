<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="HomePage.aspx.cs" Inherits="HomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:SqlDataSource ID="userDb" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [User]"></asp:SqlDataSource>
    
        <h1>Users </h1>
        <asp:GridView ID="userGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="userDb">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                <asp:BoundField DataField="cnp" HeaderText="cnp" SortExpression="cnp" />
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="adressDb" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Adress] WHERE [id] = @id" InsertCommand="INSERT INTO [Adress] ([adress_name]) VALUES (@adress_name)" SelectCommand="SELECT * FROM [Adress]" UpdateCommand="UPDATE [Adress] SET [adress_name] = @adress_name WHERE [id] = @id">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="adress_name" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="adress_name" Type="String" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <h1>Adresses</h1>
        <asp:GridView runat="server" ID="userGridEditable" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="adressDb">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="adress_name" HeaderText="adress_name" SortExpression="adress_name" />
            </Columns>
        </asp:GridView>

</asp:Content>

