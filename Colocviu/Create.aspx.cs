using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Create : System.Web.UI.Page
{
    private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["colocviuConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(connectionString);

        try
        {
            conn.Open();

            String insert =
               @"declare @id_proba int;

                select @id_proba = IDProba
                from Proba
                where Denumire = @nume_proba;
                
                if @id_proba is not null
				begin
                    Insert into Sportiv
                    values(@nume,@prenume,@tara,@data_nas,@id_proba);
                end;";


            SqlCommand comm = new SqlCommand(insert, conn);

            comm.Parameters.AddWithValue("nume", Nume.Text);
            comm.Parameters.AddWithValue("prenume", Prenume.Text);
            comm.Parameters.AddWithValue("tara", Tara.Text);
            comm.Parameters.AddWithValue("data_nas", DataNasterii.Text);
            comm.Parameters.AddWithValue("nume_proba", Proba.Text);

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
}