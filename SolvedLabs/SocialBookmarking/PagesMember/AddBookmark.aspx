<%@ Page Title="" Language="C#" MasterPageFile="~/Helpers/Navbar.master" AutoEventWireup="true" CodeFile="AddBookmark.aspx.cs" Inherits="AddBookmark" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderBody" Runat="Server">
    <asp:Literal ID="Instructions" runat="server" Text="Enter following details to add a new bookmark." />
    <br />
    <asp:Label ID="LabelTitle" runat="server" Text="Title*" AssociatedControlID="TitleInput"></asp:Label>
    <asp:TextBox ID="TitleInput" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidatorTitle" runat="server" 
        ErrorMessage="A bookmark has to have a title" ForeColor="Red" 
        ControlToValidate="TitleInput" ValidationGroup="AddBookmark"/>
    <br />
    <asp:Label ID="LabelDescription" runat="server" Text="Description" AssociatedControlID="Description"></asp:Label>
    <asp:TextBox ID="Description" runat="server"></asp:TextBox>
    <br />
    <asp:Label ID="LabelUrl" runat="server" Text="Url*" AssociatedControlID="Url"></asp:Label>
    <asp:TextBox ID="Url" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidatorUrl" runat="server" 
        ErrorMessage="A bookmark has to have an url" ForeColor="Red" 
        ControlToValidate="Url" ValidationGroup="AddBookmark"/>
    <asp:RegularExpressionValidator id="RegularExpressionValidatorUrl" runat="server"
        ErrorMessage="It has to be a valid url." ForeColor="Red"
        ValidationExpression ="^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$"
        ControlToValidate="Url"  ValidationGroup="AddBookmark"/>
    <br />
    <asp:Label ID="LabelThumbnail" runat="server" Text="Photo" AssociatedControlID="Thumbnail"></asp:Label>
    <asp:FileUpload ID="Thumbnail" runat="server"   />
    <asp:RegularExpressionValidator id="RegularExpressionValidatorThumbnail" runat="server"
        ErrorMessage="Only photo file types are allowed : jpg,jpeg,png,gif,bmp,tiff." ForeColor="Red"
        ValidationExpression ="([^\s]+(\.(?i)(jpg|jpeg|png|gif|bmp|tiff))$)"
        ControlToValidate="Thumbnail"  ValidationGroup="AddBookmark"/>
    <br />

    <asp:Label ID="LabelAddToProfile" runat="server" Text="Check this if you want to save the bookmark to your profile." 
        AssociatedControlID="AddToProfile" />
    <asp:CheckBox ID="AddToProfile" runat="server" OnCheckedChanged="AddToProfile_CheckedChanged"
          AutoPostBack="true"/>
    <br />
    <asp:Label ID="LabelTags" runat="server" Text="Enter bookmark tags, separated by a comma"></asp:Label>
    <asp:TextBox ID="Tags" runat="server"></asp:TextBox>

    <br />
    <asp:Panel ID="PanelCategory" runat="server" Visible="false">
        <asp:Label ID="LabelCategory" runat="server" Text="Choose the category the bookmark will be shown in your profile"></asp:Label>
        <asp:TextBox ID="Category" runat="server" Text="Default"></asp:TextBox>
    </asp:Panel>
    <br />

    <asp:Button ID="ButtonAdd" runat="server" Text="Add the bookmark !" 
        OnClick="ButtonAdd_Click"  ValidationGroup="AddBookmark"/>

    <asp:Label ID="LabelErrorStatus" runat="server"></asp:Label>
</asp:Content>

