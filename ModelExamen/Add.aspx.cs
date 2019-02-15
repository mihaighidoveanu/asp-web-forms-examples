using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Add : System.Web.UI.Page
{
    private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["model_examenConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ButtonAdd_Click(object sender, EventArgs e)
    {
        
        SqlConnection conn = new SqlConnection(connectionString);

        try
        {
            conn.Open();

            String insert =
               @"Insert into Angajat
                values(@nume,@prenume,@data_nas,@data_ang);";

            SqlCommand comm = new SqlCommand(insert, conn);

            comm.Parameters.AddWithValue("nume", TextBoxNume.Text);
            comm.Parameters.AddWithValue("prenume", TextBoxPrenume.Text);
            comm.Parameters.AddWithValue("data_nas", Calendar1.SelectedDate);
            comm.Parameters.AddWithValue("data_ang", Calendar2.SelectedDate);

            if(comm.ExecuteNonQuery() == 1)
            {
                Response.Write("succes!!!");
            }
            else
            {
                Response.Write("Nu chiar succes !");
            }

        }
        catch(Exception eX)
        {
            Response.Write(eX.Message);
        }
        finally
        {
            conn.Close();
        }

    }
}