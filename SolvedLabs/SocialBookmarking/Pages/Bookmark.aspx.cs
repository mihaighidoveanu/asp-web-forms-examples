using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Bookmark : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(! this.IsPostBack)
        {
            ListViewTags.Visible = true;
            ListViewComments.Visible = false;
            ListViewReplies.Visible = false;
            LoginViewAddComment.Visible = false;
            LoginViewAddReply.Visible = false;
            PanelAddToCategory.Visible = false;
        }
        
    }

    protected void ButtonTags_Click(object sender, EventArgs e)
    {
        ListViewTags.Visible = true;
        ListViewComments.Visible = false;
        ListViewReplies.Visible = false;
        LoginViewAddComment.Visible = false;
        LoginViewAddReply.Visible = false;
    }

    protected void ButtonComments_Click(object sender, EventArgs e)
    {
        ListViewTags.Visible = false;
        ListViewComments.Visible = true;
        ListViewReplies.Visible = false;
        LoginViewAddComment.Visible = true;
        LoginViewAddReply.Visible = false;
    }

    protected void ButtonReplies_Click(object sender, EventArgs e)
    {
        ListViewTags.Visible = false;
        ListViewComments.Visible = false;
        ListViewReplies.Visible = true;
        LoginViewAddReply.Visible = true;
        LoginViewAddComment.Visible = false;        
    }

    protected void LinkButtonAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/PagesMember/AddBookmark.aspx");
    }

    

    protected void ButtonAddToCategory_Click(object sender, EventArgs e)
    {
        if(PanelAddToCategory.Visible)
        {
            PanelAddToCategory.Visible = false;

        }
        else
        {
            PanelAddToCategory.Visible = true;
        }
    }

    protected void ButtonAddComment_Click(object sender, EventArgs e)
    {
        
    }

    protected void ButtonAddReply_Click(object sender, EventArgs e)
    {

    }

    protected void ButtonSaveToProfile_Click(object sender, EventArgs e)
    {

    }

    protected void ButtonEdit_Click(object sender, EventArgs e)
    {
        FormViewBookmark.ChangeMode(FormViewMode.Edit);
    }

    protected void ButtonDelete_Click(object sender, EventArgs e)
    {
        
    }
}