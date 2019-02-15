using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddBookmark : System.Web.UI.Page
{
    private int AddNewBookmark(String title,String description, String url, DateTime createdAt, Guid authorId, String photo,
        bool profile = false, String categoryTitle = "")
    {
        //get application connection String
        String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlMarkbook"].ConnectionString;
        SqlConnection conn = new SqlConnection(connectionString);

        SqlParameter returnParameter = new SqlParameter("retVal", SqlDbType.Int);
        returnParameter.Direction = ParameterDirection.ReturnValue;

        try
        {
            //open sql connection
            conn.Open();

            SqlCommand command = new SqlCommand("ProcedureAddBookmark", conn);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            command.Parameters.AddWithValue("title", title);
            command.Parameters.AddWithValue("description", description);
            command.Parameters.AddWithValue("url", url);
            command.Parameters.AddWithValue("createdAt", createdAt);
            command.Parameters.AddWithValue("authorId", authorId);
            command.Parameters.AddWithValue("thumbnail", photo);
            command.Parameters.AddWithValue("profile", profile);
            command.Parameters.AddWithValue("categoryTitle", categoryTitle);
            command.Parameters.Add(returnParameter);
            

            //if command succeded, it will return the new bookmarkID (which will be not null)
            if (command.ExecuteNonQuery() >= 1)
            {
                LabelErrorStatus.Text = "You succesfully added the bookmark .";
                LabelErrorStatus.ForeColor = System.Drawing.Color.Green;                
            }
            else
            {
                LabelErrorStatus.Text = "Your bookmark is already added. ";
                LabelErrorStatus.ForeColor = System.Drawing.Color.Red;
            }
        }
        catch (SqlException exp)
        {
            Response.Write("Error : " + exp.Message);
            LabelErrorStatus.Text = "There was an error adding the bookmark.Please try again later. " ;
            LabelErrorStatus.ForeColor = System.Drawing.Color.Red;
        }
        catch (Exception exp)
        {
            Response.Write(exp.Message);
            LabelErrorStatus.Text = "There was an error adding the bookmark.Please try again later. ";
            LabelErrorStatus.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {
            conn.Close();
        }
        return (int)returnParameter.Value;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void AddToProfile_CheckedChanged(object sender, EventArgs e)
    {
        if(AddToProfile.Checked)
        {
            PanelCategory.Visible = true;
        }
        else
        {
            PanelCategory.Visible = false;
        }
    }

    private void AddTagsToButton(String[] tags,int bookmarkId)
    {
        bool statusOk = true;
        foreach(String tag in tags)
        {
            //get application connection String
            String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlMarkbook"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            try
            {
                //open sql connection
                conn.Open();

                SqlCommand command = new SqlCommand("AddTagToBookmark", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.AddWithValue("tagText", tag);
                command.Parameters.AddWithValue("bookmarkId", bookmarkId);

                //if command succeded
                if (command.ExecuteNonQuery() < 1)
                {
                    statusOk = false;
                }

            }
            catch (SqlException exp)
            {
                Response.Write("Error : " + exp.Message);
                LabelErrorStatus.Text += "Your tags were already added. ";
                LabelErrorStatus.ForeColor = System.Drawing.Color.Red;

            }
            catch (Exception exp)
            {
                Response.Write(exp.Message);
                LabelErrorStatus.Text += "Your tags were already added. ";
                LabelErrorStatus.ForeColor = System.Drawing.Color.Red;

            }
            finally
            {
                conn.Close();
            }
        }
        if(!statusOk)
        {
            LabelErrorStatus.Text += "Your tags were already added";
        }
    }
    protected void ButtonAdd_Click(object sender, EventArgs e)
    {
        String thumbnailPath = "";
        //save the thumbnail photo
        if(Thumbnail.HasFile)
        {
            thumbnailPath = Server.MapPath("~/Images/Uploads/") + Thumbnail.FileName;
            Thumbnail.SaveAs(thumbnailPath);            
        }
        else
        {
            thumbnailPath = "~/Images/thumbnail.jpg";
        }

        //prepare the params for the sql transaction

        String title = TitleInput.Text;
        String description = Description.Text;
        String url = Url.Text;
        DateTime createdAt = DateTime.Now;
        Guid authorId = (Guid)Session["currentUserId"];
        bool profile = AddToProfile.Checked;
        String categoryTitle = Category.Text;        

        //make the sql insert for the bookmark
        int bookmarkId = AddNewBookmark(title, description, url, createdAt, authorId, thumbnailPath, profile, categoryTitle);
        Response.Write(bookmarkId);
        String[] tags = Tags.Text.Split(new char[] { ',' });

        //add the bookmark tags
        AddTagsToButton(tags, bookmarkId);
    }
}