using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;

public partial class Pages_SignUp : System.Web.UI.Page
{
    private void CreateUserProfile()
    {
        
        //get application connection String
        String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlMarkbook"].ConnectionString;
        SqlConnection conn = new SqlConnection(connectionString);

        try
        {
            //open sql connection
            conn.Open();

            //the statement for inserting a profile for the created user
            String insertStatement =
                "INSERT INTO Markpages(UserId) " +
                "(SELECT Users.UserId " +
                    "FROM Users " +
                    "WHERE Users.UserName = @userName) ";

            SqlCommand insert = new SqlCommand(insertStatement, conn);
            
            String userName = CreateUserWizard.UserName;

            insert.Parameters.AddWithValue("userName", userName);

            Label errorLabelCompleted = CompleteWizardStep.FindControl("ErrorLabelCompleted") as Label;
            if (insert.ExecuteNonQuery() == 1)
            {
                errorLabelCompleted.Text = "Your account was succesfully created.";
                errorLabelCompleted.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                errorLabelCompleted.Text = "There was an error creating your account. Please try again later.";
                errorLabelCompleted.ForeColor = System.Drawing.Color.Red;
            }
            errorLabelCompleted.Visible = true;
        }
        catch (NullReferenceException)
        {
            return;
        }
        catch (SqlException exp)
        {
            Response.Write("Error : " + exp.Message);
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

    protected void Page_Load(object sender, EventArgs e)
    {
        if(this.IsPostBack)
        {
            this.Validate();            
        }
       
    }

    protected void ContinueButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Pages/Home.aspx");

    }

    protected void CreateUserWizard_CreatedUser(object sender, EventArgs e)
    {
        //add the signed up user to the default role, 'members'      
        Roles.AddUserToRole(CreateUserWizard.UserName, "members");

        //create a Markpage(profile page) for the created user
        CreateUserProfile();
    }

    // validation to ensure an email is only used once
    //ANTI SPAM
    protected void CustomValidatorEmail_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //get application connection String
        String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlMarkbook"].ConnectionString;
        SqlConnection conn = new SqlConnection(connectionString);

        try
        {
            conn.Open();

            String selectStatement =
                "SELECT Memberships.Email " +
                "FROM Memberships " +
                "WHERE Memberships.Email = @email";

            String emailToCheck = args.Value;

            SqlCommand command = new SqlCommand(selectStatement, conn);

            command.Parameters.AddWithValue("email", emailToCheck);

            using (SqlDataReader data = command.ExecuteReader())
            {
                if(data.HasRows)
                {
                    args.IsValid = false;
                }
                else
                {
                    args.IsValid = true;
                }
            }


        }
        catch(SqlException exp)
        {
            Response.Write("Error " + exp.Message);
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