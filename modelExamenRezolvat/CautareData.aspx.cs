﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Cautare_dupa_data : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string query = "SELECT *"
                    + " FROM angajat";

            // Deschidem conexiunea la baza de date
            SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\Mihaaai\Documents\model_examen.mdf;Integrated Security=True;Connect Timeout=30");
            con.Open();
            // Incercam sa executam comanda
            try
            {
                // Se construieste comanda SQL (select-ul nostru)
                SqlCommand com = new SqlCommand(query, con);

                // Se executa comanda si se returneaza valorile intr-un reader
                SqlDataReader reader = com.ExecuteReader();
                GridView1.DataSource = reader; // Alocam readerul pentru citirea datelor
                GridView1.DataBind(); // Incarca datele din reader

            }
            catch (Exception ex)
            {
                MessagePlaceholder.Text = "Eroare din baza de date: " + ex.Message;
            }
            finally
            {
                con.Close();
            }
        }
    }

    protected void Search_Click(object sender, EventArgs e)
    {
        
        DateTime _DataAngajarii = DateTime.Parse(SearchParam.Text);

        string query = "SELECT * FROM angajat join " +
            "departament on angajat.id = departament.id_angajat " +
            "join salarii on angajat.id = salarii.id_angajat " +
            "WHERE angajat.data_nasterii = @search";

        // Deschidem conexiunea la baza de date
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\Mihaaai\Documents\model_examen.mdf;Integrated Security=True;Connect Timeout=30");
        con.Open();
        // Incercam sa executam comanda
        try
        {
            // Se construieste comanda SQL (select-ul nostru)
            SqlCommand com = new SqlCommand(query, con);
            com.Parameters.AddWithValue("search", _DataAngajarii);

            // Se executa comanda si se returneaza valorile intr-un reader
            SqlDataReader reader = com.ExecuteReader();
            GridView1.DataSource = reader; // Alocam readerul pentru citirea datelor
            GridView1.DataBind(); // Incarca datele din reader

        }
        catch (Exception ex)
        {
            MessagePlaceholder.Text = "Eroare din baza de date: " + ex.Message;
        }
        finally
        {
            con.Close();
        }

    }
}