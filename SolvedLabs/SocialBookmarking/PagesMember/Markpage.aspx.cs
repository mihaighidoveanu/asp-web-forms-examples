using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Markpage : System.Web.UI.Page
{
    private bool checkUrlParameter(String parameterToCheck)
    {

        bool parameterOk = true;

        if (!String.IsNullOrEmpty(Request.Params[parameterToCheck]))
        {
            //check if query parameter is valid
            //it doesn't permit injections
            if (!System.Text.RegularExpressions.Regex.IsMatch(Request.QueryString[parameterToCheck], @"^[a-zA-Z'.\s]{1,40}$"))
            {
                parameterOk = false;

            }
        }
        else
        {
            parameterOk = false;
        }

        return parameterOk;
    }

    private void debug_sqlCommand()
    {
        //get application connection String
        String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlMarkbook"].ConnectionString;
        SqlConnection conn = new SqlConnection(connectionString);

        try
        {
            conn.Open();

            Guid currentUserId = (Guid)Session["currentUserId"];
            SqlCommand command = new SqlCommand("SelectBookmarksInProfiles", conn);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            command.Parameters.AddWithValue("currentUserId", currentUserId);
            command.Parameters.AddWithValue("markPageId", 0);

            SqlDataReader sqlData = command.ExecuteReader();

            if(sqlData.HasRows)
            {
                //Response.Write("rezultat");
                if (sqlData.Read())
                {
                  //  Response.Write("Avem coloane");
                }
            }
        }
        catch(Exception e)
        {
            Response.Write(e.Message);
        }
        finally
        {
            conn.Close();
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        bool IdOk = checkUrlParameter("ID");

        //Session["currentUserId"] = "1067e200-fe8f-4df0-8d88-2d302ab92a85";
        debug_sqlCommand();

        SqlDataSourceBookmarks.SelectCommand = "SelectBookmarksInProfiles";
        SqlDataSourceBookmarks.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;

        // user wants to sees their own profile, so we use the currentUserId parameter to filter the results
        if(! IdOk)
        {
            String currentUserId = Session["currentUserId"] as String;
            SqlDataSourceBookmarks.SelectParameters.Clear();
            SqlParameter userId = new SqlParameter("currentUserId",System.Data.SqlDbType.UniqueIdentifier);
            SqlDataSourceBookmarks.SelectParameters.Add("currentUserId", currentUserId );
            SqlDataSourceBookmarks.SelectParameters.Add("markPageId", "0");
            
            GridViewBookmarks.DataBind();
           
        }
        //user wants to see the bookmark on other user's profile, so we use the markPageId parameter to filter the results
        else
        {
            SqlDataSourceBookmarks.SelectParameters.Clear();
            SqlDataSourceBookmarks.SelectParameters.Add("currentUserId", "0");
            SqlDataSourceBookmarks.SelectParameters.Add("markPageId", Request.QueryString["ID"]);

            GridViewBookmarks.DataBind();
        }
    }
}