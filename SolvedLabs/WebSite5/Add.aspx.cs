//#define DEBUG

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Add : System.Web.UI.Page
{
#if DEBUG
    static int i = 0 ;
#endif
    protected void Page_Load(object sender, EventArgs e)
    {
#if DEBUG
        Response.Write(i++);
#endif
        InputListClientName.DataSourceID = "SqlDataSource1";
        InputListClientName.DataTextField = "name";
        InputListClientName.DataValueField = "Id";
        InputListClientName.DataBind();

        if(! Page.IsPostBack)
        {
            InputListClientName.Items.Insert(0,"--");
            InputListClientName.SelectedIndex = 0;
        }

    }

    protected void Phone_ServerValidate(object source, ServerValidateEventArgs args)
    {
        // if the phoneNumber can be cast to an int, then it has only digits
        if(Int32.TryParse(args.Value, out int phoneNumber))
        {
            //if the phone has only digits in a number of exactly 10, the number is valid
            args.IsValid = (args.Value.Length == 10);
        }
        else
        {
            args.IsValid = false;
        }
        
    }

    protected void SubmitNewPhoneNumber_Click(object sender, EventArgs e)
    {
        String user_id = InputListClientName.Text;
        String number = TextInputNumber.Text;
       
        String insertStatement = "INSERT INTO PhoneNumbers (number, user_id)" +
            "VALUES(@number, @user_id);";

        SqlConnection conn = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Database.mdf;Integrated Security=True");

        try
        {
            //open sql connection 
            conn.Open();

            //create sql command
            SqlCommand command = new SqlCommand(insertStatement, conn);
            command.Parameters.AddWithValue("number", number);
            command.Parameters.AddWithValue("user_id", user_id);

            if (command.ExecuteNonQuery() == 1)
                Response.Write("Ati adaugat cu succes un numar nou de telefon pentru " + InputListClientName.SelectedItem.Text);
            else
                Response.Write("Nu s-a putut adauga un numar de telefon pentru " + InputListClientName.SelectedItem.Text);
        }
        catch (SqlException  exp)
        {
            Response.Write("Eroare : " + exp.Message);
        }
        catch(Exception exp)
        {
            Response.Write(exp.Message);
        }
        finally
        {
            conn.Close();
        }



    }
}