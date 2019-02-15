using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Search : System.Web.UI.Page
{
    private bool checkParameter(String parameter)
    {

        bool parameterOk = true;

        if (!String.IsNullOrEmpty(parameter))
        {
            //check if query parameter is valid
            //it doesn't permit injections
            if (!System.Text.RegularExpressions.Regex.IsMatch(parameter, @"^[a-zA-Z'.\s]{1,40}$"))
            {
                parameterOk = false;

            }
        }
        else
        {
            parameterOk = false;
        }

        return parameterOk;
    }

    private void bindSearchData(String query, String parameterName, String parameter)
    {
        bool paramOk = checkParameter(parameter);

        if (paramOk)
        {
            SqlDataSourceSearch.SelectCommand = query;
            SqlDataSourceSearch.SelectParameters.Clear();
            SqlDataSourceSearch.SelectParameters.Add(parameterName, "%" + parameter + "%");
            //SqlDataSourceSearch.DataBind();
        }
        else
        {
            SqlDataSourceSearch.SelectCommand = @"SELECT * FROM Sportiv
                WHERE 1 = 0";

            LabelError.Text = "Termenul dupa care ati cautat este invalid. Folositi un altul.";
            LabelError.ForeColor = System.Drawing.Color.Red;
        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void SearchButtonAdvanced_Click(object sender, EventArgs e)
    {
        String query =
            @"SELECT Nume, Prenume, DataNasterii, Denumire as Proba, Data as Data_Probei 
               FROM Sportiv inner join Proba on Sportiv.IDProba = Proba.IDProba 
               WHERE ";

        SqlDataSourceSearch.SelectParameters.Clear();

        bool something = false;
        if(Nume.Text != "")
        {
            something = true;
            query += "Nume LIKE @nume AND ";
            SqlDataSourceSearch.SelectParameters.Add("nume", Nume.Text);
        }
        if (Tara.Text != "")
        {
            something = true;
            query += "Tara LIKE @tara AND ";
            SqlDataSourceSearch.SelectParameters.Add("tara", Nume.Text);

        }
        if (Proba.Text != "")
        {
            something = true;
            query += "Proba LIKE @proba AND ";
            SqlDataSourceSearch.SelectParameters.Add("proba", Nume.Text);

        }

        if (something)
        {
            query += " 1 = 1";
        }
        else
        {
            query += " 0 = 0";
        }


        SqlDataSourceSearch.SelectCommand = query;
        SqlDataSourceSearch.DataBind();
    }
}