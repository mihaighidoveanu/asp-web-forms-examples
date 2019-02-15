<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Hello World</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Literal ID="PageLiteral" runat="server"></asp:Literal>
        <br />
        <asp:TextBox ID="NumberTextBox" runat="server" AutoCompleteType="Disabled"></asp:TextBox>
        <br />
        <asp:Button ID="SendNumberButton" runat="server" OnClick="SendNumberClick" Text="Send a number!" />
        <br />
        <asp:Literal ID="NumberStatus" runat="server" Visible="false"></asp:Literal>
        <asp:Button ID="PlayAgainButton" runat="server" OnClick="PlayAgainClick" Text="Play again !" Visible="false" />
        <br />
    </div>
    </form>
</body>
</html>
