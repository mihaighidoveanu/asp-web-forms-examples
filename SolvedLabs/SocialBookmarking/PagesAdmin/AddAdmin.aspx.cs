using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AddAdmin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //set ups to be made only at initial page load
        if(!Page.IsPostBack)
        {
            // make the error label hidded
            ErrorLabel.Visible = false;
        }
    }

    protected void ButtonAdminSubmit_Click(object sender, EventArgs e)
    {
        //the statement for updating a role id
        String updateTemplate =
            "UPDATE UsersInRoles " +
            "SET UsersInRoles.RoleId = (SELECT TOP(1) Roles.RoleId " +
                          "FROM Roles " +
                          "WHERE Roles.RoleName = @roleName) " +
            "WHERE UsersInRoles.UserId IN ";
                  
        //get application connection String
        String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlMarkbook"].ConnectionString;
        SqlConnection conn = new SqlConnection(connectionString);

        try
        {
            //open sql connection
            conn.Open();

            List<String> members = new List<String>();
            List<String> admins = new List<String>();

            foreach (RepeaterItem item in RepeaterAdmin.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    String currentRole = (item.FindControl("RoleNameData") as TextBox).Text;

                    //get the newRole based on the checkbox status
                    String newRole  = (item.FindControl("AdminStatus") as CheckBox).Checked ? "admins" : "members" ;

                    String userId = (item.FindControl("UserIdData") as TextBox).Text;
                    
                    //if the role is not to be changed, do nothing
                    if(newRole != currentRole)
                    {
                        // add the user id to member or admins, according to the new role to be given
                        if (newRole == "admins")
                        {
                            admins.Add(userId);
                        }
                        else if (newRole == "members")
                        {
                            members.Add(userId);
                        }   
                    }
                }
            }
            
            // prepare the statement parameters
            String membersIds = "('" + String.Join("' , '", members.ToArray()) + "') ";
            String adminIds = "('" + String.Join("' , '", admins.ToArray()) + "') ";

            //update the admins
            //check if there are any changes to make
            if (admins.Count != 0)
            {
                // create a new string, based on the template
                String updateStatement = updateTemplate;

                //add the user ids to modify
                updateStatement += adminIds;

                SqlCommand updateCommand = new SqlCommand(updateStatement, conn);
                updateCommand.Parameters.AddWithValue("roleName", "admins");

                //set the error message according to our success
                if (updateCommand.ExecuteNonQuery() >= 1)
                {
                    ErrorLabel.Text = "User roles were succesfully changed";
                    ErrorLabel.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    ErrorLabel.Text = "There was an error updating the roles. Please try again later.";
                    ErrorLabel.ForeColor = System.Drawing.Color.Red;
                }
                ErrorLabel.Visible = true;


            }

            //update the members
            //check if there are any changes to make
            if (members.Count != 0)
            {
                // create a new string, based on the template
                String updateStatement = updateTemplate;

                //add the user ids to modify
                updateStatement += membersIds;

                SqlCommand updateCommand = new SqlCommand(updateStatement, conn);
                updateCommand.Parameters.AddWithValue("roleName", "members");

                //set the error message according to our success
                if (updateCommand.ExecuteNonQuery() >= 1)
                {
                    ErrorLabel.Text = "User roles were succesfully changed";
                    ErrorLabel.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    ErrorLabel.Text = "There was an error updating the roles. Please try again later.";
                    ErrorLabel.ForeColor = System.Drawing.Color.Red;
                }
                ErrorLabel.Visible = true;
            }
        }
        catch(NullReferenceException)
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

    protected void RepeaterAdmin_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        //execute this logic for Item Templates and Alternating Item Templates
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            TextBox roleName = e.Item.FindControl("RoleNameData") as TextBox;
            if (roleName == null)
                return;
            CheckBox adminStatus = e.Item.FindControl("AdminStatus") as CheckBox;
            if (adminStatus == null)
                return;
            if (roleName.Text == "admins")
            {
                adminStatus.Checked = true;
            }
            else
            {
                adminStatus.Checked = false;                
            }
        }
    }
}