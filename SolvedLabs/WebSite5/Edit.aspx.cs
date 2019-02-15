//#define DEBUG

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Edit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (!String.IsNullOrEmpty(Request.Params["id"]))
            {
                String phone_id = Request.Params["id"];
                if(! SelectPhoneNumber(phone_id))
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

    private void UpdatePhoneNumber(String number, String phone_id)
    {
        String updateStatement = "UPDATE PhoneNumbers " +
                "SET number = @number " +
                "WHERE id = @phone_id";

        SqlConnection conn = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Database.mdf;Integrated Security=True");

        try
        {
            //open sql connection 
            conn.Open();

            //create sql command
            SqlCommand command = new SqlCommand(updateStatement, conn);
            command.Parameters.AddWithValue("number", number);
            command.Parameters.AddWithValue("phone_id", phone_id);

            if (command.ExecuteNonQuery() == 1)
                Response.Write("Numarul  de telefon a fost actualizat pentru " + TextClientName.Text);
            else
                Response.Write("Numarul  de telefon nu s-a putut actualiza pentru " + TextClientName.Text);
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
                        TextClientName.Text = data["user_name"].ToString();
                        TextInputNumber.Text = data["number"].ToString();
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


    protected void SubmitEditPhoneNumber_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
            return;

        String phone_id = (String)Session["phone_id"];

        // if exists a phone number with the required phone id
        if(SelectPhoneNumber(phone_id,false))
        {
            UpdatePhoneNumber(TextInputNumber.Text, phone_id);
        }
        else
        {
            Response.Write("Nu  exista niciun telefon cu id-ul " + phone_id + ".");
        }
    }
   
    protected void ValidatorPhone_ServerValidate(object source, ServerValidateEventArgs args)
    {
        // if the phoneNumber can be cast to an int, then it has only digits
        if (Int32.TryParse(args.Value, out int phoneNumber))
        {
            //if the phone has only digits in a number of exactly 10, the number is valid
            args.IsValid = (args.Value.Length == 10);
        }
        else
        {
            args.IsValid = false;
        }
    }
}