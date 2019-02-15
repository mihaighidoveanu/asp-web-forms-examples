<%@ Page Title=""  MaintainScrollPositionOnPostback="true" Language="C#" MasterPageFile="~/Helpers/Navbar.master" AutoEventWireup="true" CodeFile="Bookmark.aspx.cs" Inherits="Bookmark" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderBody" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSourceBookmark" runat="server" ConnectionString="<%$ ConnectionStrings:MySqlMarkbook %>" 
        SelectCommand="SELECT Bookmarks.*, Users.UserName
        FROM Bookmarks
        INNER JOIN Users
        ON Bookmarks.AuthorId = Users.UserId
        WHERE (Bookmarks.Id = @bookmarkId)" 
        DeleteCommand="DELETE FROM [Bookmarks] WHERE [Id] = @Id" 
        UpdateCommand="UPDATE [Bookmarks]
        SET [Description] = @Description, [Title] = @Title, [Url] = @Url, [CreatedAt] = @CreatedAt, 
        [AuthorId] = @AuthorId, [Photo] = @Photo, [Views] = @Views, [Votes] = @Votes
        WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="bookmarkId" QueryStringField="ID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Url" Type="String" />
            <asp:Parameter Name="Photo" Type="String" />
            <asp:Parameter Name="Views" Type="Int32" />
            <asp:Parameter Name="Votes" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:FormView ID="FormViewBookmark" runat="server" DataSourceID="SqlDataSourceBookmark" DataKeyNames="Id" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal">
        <EditItemTemplate>
            <br />
            Description:
            <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' />
            <br />
            Title:
            <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
            <br />
            Url:
            <asp:TextBox ID="UrlTextBox" runat="server" Text='<%# Bind("Url") %>' />
            <br />            
            Photo:
            <asp:TextBox ID="PhotoTextBox" runat="server" Text='<%# Bind("Photo") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <EditRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
        <FooterStyle BackColor="White" ForeColor="#333333" />
        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
        <ItemTemplate>
            Description:
            <asp:Label ID="DescriptionLabel" runat="server" ReadOnly="true" Text='<%# Bind("Description") %>' />
            <br />

            Title:
            <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("Title") %>' />
            <br />

            Url:
            <asp:Label ID="UrlLabel" runat="server" Text='<%# Bind("Url") %>' />
            <br />
            
            CreatedAt:
            <asp:Label ID="CreatedAtLabel" runat="server" Text='<%# Bind("CreatedAt") %>' />
            <br />
            
            AuthorName:
            <asp:Label ID="AuthorIdLabel" runat="server" Text='<%# Bind("UserName") %>' />
            <br />

            <asp:Image ID="Image" runat="server" AlternateText='<%# Bind("Title") %>' 
                 ImageUrl='<%# Bind("Photo") %>' Width="100" Height="100"/>

           
            <br />
            Views:
            <asp:Label ID="ViewsLabel" runat="server" Text='<%# Bind("Views") %>' />
            <br />

        </ItemTemplate>
        
        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="White" ForeColor="#333333" />
        
    </asp:FormView>

    <asp:LoginView ID="LoginViewControls" runat="server">
        <RoleGroups>
            <asp:RoleGroup Roles="admins">
                <ContentTemplate>
                    <asp:Button ID="LinkButtonAdd" runat="server"  OnClick="LinkButtonAdd_Click" Text="Add new"  />
                    <asp:Button ID="ButtonEdit" runat="server" Text="Edit" OnClick="ButtonEdit_Click"/>
                    <asp:Button ID="ButtonDelete" runat="server" Text="Delete"  OnClick="ButtonDelete_Click"/>
                    <asp:Button ID="ButtonAddToCategory" runat="server" Text="Save to my profile" OnClick="ButtonAddToCategory_Click"/>
                </ContentTemplate>
            </asp:RoleGroup>
            <asp:RoleGroup Roles="members">
                <ContentTemplate>
                    <asp:Button ID="LinkButtonAdd" runat="server"  OnClick="LinkButtonAdd_Click" Text="Add new"  />
                    <asp:Button ID="ButtonAddToCategory" runat="server" Text="Save to my profile" OnClick="ButtonAddToCategory_Click" />
                </ContentTemplate>
            </asp:RoleGroup>
        </RoleGroups>
    </asp:LoginView>
    <br />

    <asp:Panel ID="PanelAddToCategory" runat="server">
        <p> Save this bookmark to the following category :</p>
        <asp:TextBox ID="TextBoxCategory" runat="server" Text="Default"/>
        <asp:RequiredFieldValidator ID="RequiredFieldValidatorCategory" runat="server"
            ErrorMessage="Category name should not be empty" ControlToValidate="TextBoxCategory" 
             ForeColor="Red" ValidationGroup="AddToCategory"/>
        <br />
        <asp:Button ID="ButtonSaveToProfile" runat="server" Text="Save bookmark" OnClick="ButtonSaveToProfile_Click" />
    </asp:Panel>
   

    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:MySqlMarkbook %>" 
        SelectCommand="SELECT Tags.Text FROM Tags 
        INNER JOIN TagsInBookmarks ON Tags.Id = TagsInBookmarks.TagId 
        WHERE (TagsInBookmarks.BookmarkId = @bookmarkId)">
        <SelectParameters>
            <asp:QueryStringParameter Name="bookmarkId" QueryStringField="ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceComments" runat="server" ConnectionString="<%$ ConnectionStrings:MySqlMarkbook %>"
        SelectCommand="SELECT [Comments].*, [Users].UserName
        FROM [Comments] 
        INNER JOIN [Users]
        ON [Users].UserId = [Comments].AuthorId
        WHERE ([BookmarkId] = @BookmarkId) 
        ORDER BY [CreatedAt] DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="BookmarkId" QueryStringField="ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceReplies" runat="server" ConnectionString="<%$ ConnectionStrings:MySqlMarkbook %>" 
        SelectCommand="SELECT [Replies].*, [Users].UserName
        FROM [Replies] 
        INNER JOIN [Users]
        ON [Users].UserId = [Replies].AuthorId
        WHERE ([BookmarkId] = @BookmarkId) 
        ORDER BY [CreatedAt] DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="BookmarkId" QueryStringField="ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <br />
    <br />
    <br />
    <asp:Button ID="ButtonTags" runat="server" Text="See Tags" OnClick="ButtonTags_Click"  />
    <asp:Button ID="ButtonComments" runat="server" Text="See Comments"  OnClick="ButtonComments_Click"/>
    <asp:Button ID="ButtonReplies" runat="server" Text="See Replies"  OnClick="ButtonReplies_Click"/>

    <br />
    <asp:ListView ID="ListViewTags" runat="server" DataSourceID="SqlDataSourceTags">
        <LayoutTemplate>
            <h1>Tags</h1>
            <ul id="itemPlaceholderContainer" runat="server" style="font-family: Verdana, Arial, Helvetica, sans-serif;">
                <li runat="server" id="itemPlaceholder" />
            </ul>
            <div style="text-align: center;background-color: #FFCC66;font-family: Verdana, Arial, Helvetica, sans-serif;color: #333333;">
                <asp:DataPager ID="DataPager1" runat="server">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
        <EmptyDataTemplate>
            No tags.
        </EmptyDataTemplate>
        <ItemSeparatorTemplate>
            <br />
        </ItemSeparatorTemplate>
        <ItemTemplate>
            <li style="background-color: #FFFBD6;color: #333333;">
                <asp:Label ID="LabelTag" runat="server" Text='<%#Eval("Text") %>'/>

                <br />
            </li>
        </ItemTemplate>
        <AlternatingItemTemplate>
            <li style="background-color: #FAFAD2;color: #284775;">
                <asp:Label ID="LabelTag" runat="server" Text='<%#Eval("Text") %>'/>
                <br />
            </li>
        </AlternatingItemTemplate>
        
    </asp:ListView>
    
    <asp:ListView ID="ListViewComments" runat="server" InsertItemPosition="FirstItem" DataSourceID="SqlDataSourceComments" DataKeyNames="Id">
        <LayoutTemplate>
            <h1>Comments</h1>
            <div id="itemPlaceholderContainer" runat="server" style="font-family: Verdana, Arial, Helvetica, sans-serif;">
                <span runat="server" id="itemPlaceholder" />
            </div>
            <div style="text-align: center;background-color: #FFCC66;font-family: Verdana, Arial, Helvetica, sans-serif;color: #333333;">
                <asp:DataPager ID="DataPager1" runat="server">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
        <AlternatingItemTemplate>
            <span style="background-color: #FAFAD2;color: #284775;">
            <br />
            <asp:Label ID="TextLabel" runat="server" Text='<%# Eval("Text") %>' />
            <br />
            <asp:Label ID="CreatedAtLabel" runat="server" Text='<%# Eval("CreatedAt") %>' />
            <br />
            <asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("UserName") %>' />
            <br />
            <br />
            </span>
        </AlternatingItemTemplate>
        <ItemTemplate>
            <span style="background-color: #FFFBD6;color: #333333;"">
            <br />
            <asp:Label ID="TextLabel" runat="server" Text='<%# Eval("Text") %>' />
            <br />
            <asp:Label ID="CreatedAtLabel" runat="server" Text='<%# Eval("CreatedAt") %>' />
            <br />
            <asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("UserName") %>' />
            <br />
            <br />
            </span>
        </ItemTemplate>
        <SelectedItemTemplate>
            <span style="background-color: #008A8C;font-weight: bold;color: #FFFFFF;">Id:
            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
            <br />
            Text:
            <asp:Label ID="TextLabel" runat="server" Text='<%# Eval("Text") %>' />
            <br />
            BookmarkId:
            <asp:Label ID="BookmarkIdLabel" runat="server" Text='<%# Eval("BookmarkId") %>' />
            <br />
            CreatedAt:
            <asp:Label ID="CreatedAtLabel" runat="server" Text='<%# Eval("CreatedAt") %>' />
            <br />
            AuthorId:
            <asp:Label ID="AuthorIdLabel" runat="server" Text='<%# Eval("AuthorId") %>' />
            <br />
            UserName:
            <asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("UserName") %>' />
            <br />
            <br />
            </span>
        </SelectedItemTemplate>
        <EditItemTemplate>
            <span style="background-color: #008A8C;color: #FFFFFF;">Id:
            <asp:Label ID="IdLabel1" runat="server" Text='<%# Eval("Id") %>' />
            <br />
            Text:
            <asp:TextBox ID="TextTextBox" runat="server" Text='<%# Bind("Text") %>' />
            <br />
            BookmarkId:
            <asp:TextBox ID="BookmarkIdTextBox" runat="server" Text='<%# Bind("BookmarkId") %>' />
            <br />
            CreatedAt:
            <asp:TextBox ID="CreatedAtTextBox" runat="server" Text='<%# Bind("CreatedAt") %>' />
            <br />
            AuthorId:
            <asp:TextBox ID="AuthorIdTextBox" runat="server" Text='<%# Bind("AuthorId") %>' />
            <br />
            UserName:
            <asp:TextBox ID="UserNameTextBox" runat="server" Text='<%# Bind("UserName") %>' />
            <br />
            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
            <br />
            <br />
            </span>
        </EditItemTemplate>
        <EmptyDataTemplate>
            No tags.
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <span style="">
             Text:
            <asp:TextBox ID="TextTextBox" runat="server" Text='<%# Bind("Text") %>' />
            <br />
            BookmarkId:
            <asp:TextBox ID="BookmarkIdTextBox" runat="server" Text='<%# Bind("BookmarkId") %>' />
            <br />
            CreatedAt:
            <asp:TextBox ID="CreatedAtTextBox" runat="server" Text='<%# Bind("CreatedAt") %>' />
            <br />
            AuthorId:
            <asp:TextBox ID="AuthorIdTextBox" runat="server" Text='<%# Bind("AuthorId") %>' />
            <br />
            UserName:
            <asp:TextBox ID="UserNameTextBox" runat="server" Text='<%# Bind("UserName") %>' />
            <br />
            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
            <br />
            <br />
            </span>
        </InsertItemTemplate>
        
    </asp:ListView>
    <asp:LoginView ID="LoginViewAddComment" runat="server">
        <LoggedInTemplate>
            <asp:Panel ID="AddComment" runat="server">
                <h1>Add comment</h1>
                <asp:TextBox ID="TextBoxComment" runat="server" Width="500" Height="100"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorCommment" runat="server"  ValidationGroup="AddComment"
                    ErrorMessage="Comment can not be empty" ControlToValidate="TextBoxComment" ForeColor="Red" />
                <br />
                <br />
                <asp:Button ID="ButtonAddComment" runat="server" Text="Add comment" ValidationGroup="AddComment"
                     OnClick="ButtonAddComment_Click"
                    />
            </asp:Panel>
            </LoggedInTemplate>
     </asp:LoginView>



    <asp:ListView ID="ListViewReplies" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceReplies">
        <ItemSeparatorTemplate>
            <br />
        </ItemSeparatorTemplate>
        <AlternatingItemTemplate>
            <li style="background-color: #FAFAD2;color: #284775;">
                

                <asp:HyperLink ID="UrlLink" runat="server" Target="_blank"
                    NavigateUrl='<%# Eval("Url") %>' Text='<%# Eval("Title") %>'/>
                
                <br />                
                
                <asp:Label ID="CreatedAtLabel" runat="server" Text='<%# Eval("CreatedAt") %>' />
                <br />
                
                <asp:Label ID="AuthorIdLabel" runat="server" Text='<%# Eval("UserName") %>' />
                <br />
                
            </li>
        </AlternatingItemTemplate>
        <ItemTemplate>
            <li style="background-color: #FFFBD6;color: #333333;">
                
                <asp:HyperLink ID="UrlLink" runat="server" Target="_blank"
                    NavigateUrl='<%# Eval("Url") %>' Text='<%# Eval("Title") %>'/>                
                <br />
                
                <asp:Label ID="CreatedAtLabel" runat="server" Text='<%# Eval("CreatedAt") %>' />
                <br />
                
                <asp:Label ID="AuthorIdLabel" runat="server" Text='<%# Eval("UserName") %>' />
                <br />
            </li>
        </ItemTemplate>
        <LayoutTemplate>
            <h1>Replies</h1>
            <ul id="itemPlaceholderContainer" runat="server" style="font-family: Verdana, Arial, Helvetica, sans-serif;">
                <li runat="server" id="itemPlaceholder" />
            </ul>
            <div style="text-align: center;background-color: #FFCC66;font-family: Verdana, Arial, Helvetica, sans-serif;color: #333333;">
                <asp:DataPager ID="DataPager1" runat="server">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <li style="background-color: #FFCC66;font-weight: bold;color: #000080;">Id:
                <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                <br />
                Url:
                <asp:Label ID="UrlLabel" runat="server" Text='<%# Eval("Url") %>' />
                <br />
                BookmarkId:
                <asp:Label ID="BookmarkIdLabel" runat="server" Text='<%# Eval("BookmarkId") %>' />
                <br />
                CreatedAt:
                <asp:Label ID="CreatedAtLabel" runat="server" Text='<%# Eval("CreatedAt") %>' />
                <br />
                AuthorId:
                <asp:Label ID="AuthorIdLabel" runat="server" Text='<%# Eval("AuthorId") %>' />
                <br />
            </li>
        </SelectedItemTemplate>
        <EmptyDataTemplate>
            No tags.
        </EmptyDataTemplate>
    </asp:ListView>
    
     <asp:LoginView ID="LoginViewAddReply" runat="server">
        <LoggedInTemplate>
            <br />
            <asp:Panel ID="AddReply" runat="server">
                <h1>Add reply</h1>
                
                <asp:Label ID="LabelReplyTitle" runat="server" AssociatedControlID="TextBoxReplyTitle" Text="Title:" />
                <asp:TextBox ID="TextBoxReplyTitle" runat="server"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="LabelReplyUrl" runat="server" AssociatedControlID="TextBoxReplyUrl" Text="Url:"></asp:Label>
                <asp:TextBox ID="TextBoxReplyUrl" runat="server" Width="300" Height="100"></asp:TextBox>
                <br />

                <asp:RequiredFieldValidator ID="RequiredFieldValidatorReply" runat="server"  ValidationGroup="AddReply"
                    ErrorMessage="Reply can not be empty" ControlToValidate="TextBoxReplyTitle" ForeColor="Red" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorReply" runat="server" 
                    ErrorMessage="The reply should be a valid url" ControlToValidate="TextBoxReplyUrl"
                     ValidationExpression ="^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$"
                    />
                <br />
                <asp:Button ID="ButtonAddReply" runat="server" Text="Add reply" ValidationGroup="AddReply"
                     OnClick="ButtonAddReply_Click"
                    />
            </asp:Panel>
        </LoggedInTemplate>
    </asp:LoginView>
</asp:Content>

