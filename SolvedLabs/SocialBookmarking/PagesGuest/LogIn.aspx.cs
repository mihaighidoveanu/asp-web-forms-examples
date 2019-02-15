using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PagesGuest_LogIn : System.Web.UI.Page
{
    private Guid GetLoggedInUserId()
    {
        //get application connection String
        String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlMarkbook"].ConnectionString;
        SqlConnection conn = new SqlConnection(connectionString);

        String selectStatement =
            "SELECT Users.UserId " +
            "FROM Users " +
            "WHERE Users.UserName = @userName ;";

        try
        {
            conn.Open();

            SqlCommand command = new SqlCommand(selectStatement, conn);
            command.Parameters.AddWithValue("userName", LoginInput.UserName);

            SqlDataReader reader = command.ExecuteReader();

            if (reader.HasRows)
            {
                if (reader.Read())
                {
                    return reader.GetGuid(0);
                }
            }
        }
        catch (SqlException e)
        {
            Response.Write("Error : " + e.Message);
        }
        catch (Exception e)
        {
            Response.Write(e.Message);
        }
        finally
        {
            conn.Close();
        }
        return Guid.Empty;

    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void LoginInput_LoggedIn(object sender, EventArgs e)
    {
        // we will store the current user id in the Session
        Guid userId = GetLoggedInUserId();

        if (userId != Guid.Empty)
        {
            Session["currentUserId"] = userId;
        }
    }
}