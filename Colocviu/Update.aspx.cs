using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Update : System.Web.UI.Page
{
    private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["colocviuConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void DropDownListSportiv_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(connectionString);

        try
        {
            conn.Open();

            String select =
               @"SELECT Sportiv.*, Proba.*
                from Sportiv 
                inner join Proba on Proba.IDProba = Sportiv.IDProba
                where IDSportiv = @id;";

            SqlCommand comm = new SqlCommand(select, conn);

            comm.Parameters.AddWithValue("id", DropDownListSportiv.SelectedValue);

            SqlDataReader reader = comm.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())

                {
                    Nume.Text = reader["nume"] as String;
                    Prenume.Text = reader["prenume"] as String;
                    Tara.Text = reader["tara"] as String;
                    DataNasterii.Text = reader["data_nasterii"] as String;

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

    //protected void DropDownListProba_SelectedIndexChanged(object sender, EventArgs e)
    //{
        
    //}

    protected void ButtonEdit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(connectionString);
        try
        {
            conn.Open();

            String update =
               @" DECLARE @id_proba int;
                
                select @id_proba = IDProba
                from Proba
                where Denumire = @nume_proba;

                if @id_proba is not null
                begin
                    UPDATE Sportiv
                    SET Nume = @nume, Prenume = @prenume, Tara = @tara, DataNasterii = @data_nas, IDProba = @id_proba
                    where IDSportiv = @id_sportiv; 
                end;
                ";

            SqlCommand comm = new SqlCommand(update, conn);

            comm.Parameters.AddWithValue("nume", Nume.Text);
            comm.Parameters.AddWithValue("prenume", Prenume.Text);
            comm.Parameters.AddWithValue("tara", Tara.Text);
            comm.Parameters.AddWithValue("data_nas", DataNasterii.Text);
            comm.Parameters.AddWithValue("nume_proba", Proba.Text);
            comm.Parameters.AddWithValue("id_sportiv", DropDownListSportiv.SelectedValue);

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