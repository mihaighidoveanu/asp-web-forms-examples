using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string sURL = Request.Url.ToString().ToLower();
            //if homepage loaded
            if (sURL.EndsWith("default.aspx"))
            {

                NavbarChild.Visible = false;
            }
            else if (sURL.Contains("/products/") ||
                          sURL.Contains("/services/"))
            {
                // this line makes the child links be visible even when the current page is a child link
                smdsChild.StartingNodeOffset = -1;
            }
        }
    }
}
