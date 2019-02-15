using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Delete : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (!String.IsNullOrEmpty(Request.Params["id"]))
            {
                String phone_id = Request.Params["id"];
                if (!SelectPhoneNumber(phone_id))
                {
                    Response.Write("Nu  exista niciun telefon cu id-ul " + phone_id + ".");
                }
                Session["phone_id"] = phone_id;
            }
            else
            {
#if Debug
                Response.Write("id null");
#endif
            }

        }
        else
        {
#if Debug
                Response.Write("postback");
#endif
        }
    }

    private bool SelectPhoneNumber(String phone_id, bool show = true)
    {
        String selectStatement = "SELECT number, " +
            "[User].id as user_id, [User].name as user_name " +
            " FROM PhoneNumbers JOIN[User] " +
            " ON PhoneNumbers.user_id = [User].id " +
            " AND PhoneNumbers.Id = @phone_id";

        SqlConnection conn = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Database.mdf;Integrated Security=True");

        try
        {
            //open sql connection 
            conn.Open();

            //create sql command
            SqlCommand command = new SqlCommand(selectStatement, conn);
            command.Parameters.AddWithValue("phone_id", phone_id);

            using (SqlDataReader data = command.ExecuteReader())
            {
                if (show)
                {
                    while (data.Read())
                    {
                        ClientNameText.Text = data["user_name"].ToString();
                        ClientPhoneText.Text = data["number"].ToString();
                    }
                }
                return data.HasRows;
            }
        }
        catch (SqlException exp)
        {
            Response.Write("Eroare : " + exp.Message);
            Response.Write(exp.StackTrace);
        }
        catch (Exception exp)
        {
            Response.Write(exp.Message);
            Response.Write(exp.StackTrace);
        }
        finally
        {
            conn.Close();
        }

        return false;
    }

    private void DeletePhoneNumber(String phone_id)
    {
        String deleteStatement = "DELETE FROM PhoneNumbers " +
                "WHERE id = @phone_id";

        SqlConnection conn = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Database.mdf;Integrated Security=True");

        try
        {
            //open sql connection 
            conn.Open();

            //create sql command
            SqlCommand command = new SqlCommand(deleteStatement, conn);
            command.Parameters.AddWithValue("phone_id", phone_id);

            if (command.ExecuteNonQuery() == 1)
                Response.Write("S-a șters numărul de telefon " + ClientPhoneText.Text + " pentru " + ClientNameText.Text);
            else
                Response.Write("Nu s-a putut sterge " + ClientNameText.Text + " pentru " + ClientNameText.Text);
        }
        catch (SqlException exp)
        {
            Response.Write("Eroare : " + exp.Message);
        }
        catch (Exception exp)
        {
            Response.Write(exp.Message);
        }
        finally
        {
            conn.Close();
        }
    }

    protected void SubmitDelete_Click(object sender, EventArgs e)
    {
        String phone_id = (String)Session["phone_id"];

        //if a phone number with the specified id exists
        if(SelectPhoneNumber(phone_id,false))
        {
            DeletePhoneNumber(phone_id);
            ClientNameText.Text = "";
            ClientPhoneText.Text = "";
        }
        else
        {
            Response.Write("Nu  exista niciun telefon cu id-ul " + phone_id + ".");
        }
    }
}