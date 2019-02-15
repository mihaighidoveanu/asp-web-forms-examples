<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Adauga.aspx.cs" Inherits="Adauga" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HyperLink runat="server" ID="linkToList" Text="Vezi lista de filme" NavigateUrl="~/Default.aspx" />
        <div>
            Titlu : <asp:TextBox runat="server" ID="TBtitle" AutoCompleteType="Disabled"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="TBtitle" ErrorMessage="Acest camp este obligatoriu" ForeColor="Red" />
            <br />
            Durata : <asp:TextBox runat="server" ID="TBduration" AutoCompleteType="Disabled"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="TBduration" ErrorMessage="Acest camp este obligatoriu" ForeColor="Red" />
            <br />
            Regizor : <asp:TextBox runat="server" ID="TBdirector" AutoCompleteType="Disabled"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="TBdirector" ErrorMessage="Acest camp este obligatoriu" ForeColor="Red" />
            <br />
            Gen : <asp:TextBox runat="server" ID="TBgenre" AutoCompleteType="Disabled"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="TBgenre" ErrorMessage="Acest camp este obligatoriu" ForeColor="Red" />
            <br />
            An : <asp:TextBox runat="server" ID="TByear" AutoCompleteType="Disabled"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="TByear" ErrorMessage="Acest camp este obligatoriu" ForeColor="Red" />
            <br />
            Actori :
            <br />
            &emsp;<asp:TextBox runat="server" ID="TBactor1" AutoCompleteType="Disabled"></asp:TextBox>
            <br />
            &emsp;<asp:TextBox runat="server" ID="TBactor2" AutoCompleteType="Disabled"></asp:TextBox>
            <br />
            &emsp;<asp:TextBox runat="server" ID="TBactor3" AutoCompleteType="Disabled"></asp:TextBox>
            <br />
            <asp:FileUpload runat="server" ID="TBimage" />
            <br />
            <asp:Button runat="server" ID="submit" Text="Submit" OnClick="addMovie_Click" />
            <br />
            <asp:Literal runat="server" ID="status" Visible="false"></asp:Literal>
            <br />
        </div>
    </form>
</body>
</html>
