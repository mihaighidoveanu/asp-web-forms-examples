<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HyperLink runat="server" ID="linkToAdd" Text="Adauga un film nou !"  Target="_new" NavigateUrl="~/Adauga.aspx" />
            <asp:XmlDataSource ID="xmlData" runat="server" DataFile="~/movies.xml" XPath="moviestore/movie"></asp:XmlDataSource>
            <asp:Repeater runat="server" ID="movieData" DataSourceID="xmlData">
                <ItemTemplate>
                    <br />
                    Title : <%#XPath("title")%>
                    <br />
                    Image : <%#XPath("@imagine")%>
                    <br />
                    Genre : <%#XPath("@genre")%>
                    <br />
                    Duration : <%#XPath("@duration")%>
                    <br />
                    Director : <%#XPath("director")%>
                    <br />
                    Actors :
                    <asp:Repeater ID="actorsData" runat="server" DataSource='<%# XPathSelect("actor") %>'>
                        <ItemTemplate>
                            <%# XPath(".") %> ;
                        </ItemTemplate>
                    </asp:Repeater>
                    <br />
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
