using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Cauta : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var searchedUser = "%";

            if (! String.IsNullOrEmpty(Request.Params["q"]) )
            {
                searchedUser = Request.Params["q"];
            }

        // set default value for q parameter
            
        SearchUserDb.SelectCommand = "Select * from [User] where name LIKE @nume";
        SearchUserDb.SelectParameters.Add("nume", "%" + searchedUser + "%");
        SearchUserDb.DataBind();
        
    }
}