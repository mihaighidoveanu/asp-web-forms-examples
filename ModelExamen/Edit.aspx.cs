using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Edit : System.Web.UI.Page
{
    private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["model_examenConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ButtonEdit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(connectionString);

        try
        {
            conn.Open();

            String update =
               @"Update [Angajat]
                 SET nume = @nume,
                 prenume = @prenume,
                 data_nasterii = @data_nas,
                data_angajare = @data_ang
                where id = @id;
                 ";

            SqlCommand comm = new SqlCommand(update, conn);

            comm.Parameters.AddWithValue("nume", TextBoxNume.Text);
            comm.Parameters.AddWithValue("prenume", TextBoxPrenume.Text);
            comm.Parameters.AddWithValue("data_nas", Calendar1.SelectedDate);
            comm.Parameters.AddWithValue("data_ang", Calendar2.SelectedDate);

            if (comm.ExecuteNonQuery() == 1)
            {
                Response.Write("succes!!!");
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

    protected void DropDownListEdit_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(connectionString);

        try
        {
            conn.Open();

            String select =
               @"SELECT * from angajat where id = @id;";

            SqlCommand comm = new SqlCommand(select, conn);

            comm.Parameters.AddWithValue("id", DropDownListEdit.SelectedValue);

            SqlDataReader reader = comm.ExecuteReader();

            if(reader.HasRows)
            {
                while(reader.Read())

                {
                    TextBoxNume.Text = reader["nume"] as String;
                    TextBoxPrenume.Text = reader["prenume"] as String;
                    Calendar1.SelectedDate = (DateTime)reader["data_nasterii"];
                    Calendar2.SelectedDate = (DateTime)reader["data_angajare"];
                }

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