using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Delete : System.Web.UI.Page
{
    private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["model_examenConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ButtonDelete_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(connectionString);

        try
        {
            conn.Open();

            String insert =
               @"DELETE from Departament
                where id_angajat = @id;

                Delete from Angajat
                where Id = @id;                
                ";

            SqlCommand comm = new SqlCommand(insert, conn);

            comm.Parameters.AddWithValue("id", DropDownListDelete.SelectedValue);

            if (comm.ExecuteNonQuery() >= 1)
            {
                Response.Write("succes!!!");
                DropDownListDelete.DataBind();
            }
            else
            {
                Response.Write("Nu chiar succes !");
            }

        }
        catch (Exception eX)
        {
            Response.Write(eX.Message);
        }
        finally
        {
            conn.Close();
        }
    }
}