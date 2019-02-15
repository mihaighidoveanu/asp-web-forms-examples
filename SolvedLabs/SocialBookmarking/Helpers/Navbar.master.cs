using System;
using System.Collections.Generic;
using System.Linq;
using System.Web; //HttpContext
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.IO;

public partial class Navbar : System.Web.UI.MasterPage
{

    private void debugShowMemberRoles()
    {
        var roles = Roles.GetRolesForUser(Context.User.Identity.Name);
        Response.Write("Roluri : ");
        foreach (String role in roles)
        {
            Response.Write(role.ToString() + " ");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            LoginNameLabel.Visible = true;
        }
        else
        {
            LoginNameLabel.Visible = false;
        }

        //hide the navbar search form on the search page
        // that page has an advanced search already
        string currentPageName = Path.GetFileNameWithoutExtension(Page.AppRelativeVirtualPath);
        if (currentPageName == "Search")
        {
            Search.Visible = false;
        }
            

        Response.Write(Session["currentUserId"]);

        //set link to user profile
       
        ////Menu menuAdmin = NavbarHeader.FindControl("MenuAdmin") as Menu;
        //menuAdmin.Items[0].NavigateUrl = "~/PagesMember/Markpage.aspx?ID=" + Session["currentUserId"];


    }

 

    protected void SearchButton_Click(object sender, EventArgs e)
    {
        String textSearched = SearchInput.Text;
        SearchInput.Text = "";
       
        Response.Redirect("~/Pages/Search.aspx?question=" + Uri.EscapeDataString(textSearched));
    }

    protected void LoginStatus_LoggingOut(object sender, LoginCancelEventArgs e)
    {
        Session["currentUserId"] = null;
    }
}
