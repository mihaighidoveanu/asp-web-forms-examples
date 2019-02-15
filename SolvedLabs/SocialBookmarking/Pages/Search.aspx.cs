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

    private void bindSearchData(String query,String parameterName, String parameter)
    {
        bool paramOk = checkParameter(parameter);

        if(paramOk)
        {
            SqlDataSourceSearch.SelectCommand = query;
            SqlDataSourceSearch.SelectParameters.Clear();
            SqlDataSourceSearch.SelectParameters.Add(parameterName, "%" + parameter + "%");
            //SqlDataSourceSearch.DataBind();
        }
        else
        {
            SqlDataSourceSearch.SelectCommand = @"SELECT [Bookmarks].*, [Users].UserName
                FROM Bookmarks
                INNER JOIN[Users] ON[Users].UserId = [Bookmarks].AuthorId
                WHERE 1 = 0";

            LabelError.Text = "Your search query is invalid Try another one.";
            LabelError.ForeColor = System.Drawing.Color.Red;
        }
    
    }

    

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!this.IsPostBack)
        {
            String query = 
                @"SELECT [Bookmarks].*, [Users].UserName
                FROM Bookmarks
                INNER JOIN [Users] ON [Users].UserId = [Bookmarks].AuthorId
                WHERE Bookmarks.Title LIKE @question;";

            String question = Request.QueryString["question"];

            bindSearchData(query, "question", question);

            SearchInputAdvanced.Text = question;
        }       
        else
        {
            LabelError.Text = "";
        }
    }

    protected void SearchOptions_SelectedIndexChanged(object sender, EventArgs e)
    {
        String query =
            @"SELECT DISTINCT [Bookmarks].*, [Users].UserName
             FROM [Bookmarks] 
             INNER JOIN [Users] ON [Bookmarks].AuthorId = [Users].UserId
             LEFT OUTER JOIN [TagsInBookmarks] ON [TagsInBookmarks].BookmarkId = [Bookmarks].Id 
             LEFT OUTER JOIN [Tags] ON [TagsInBookmarks].TagId = [Tags].Id 
             WHERE ";

        //loop through checkBoxList to select selected items
        foreach (ListItem option in SearchOptions.Items)
        {
            if (option.Selected)
            {
                query += " " + option.Value + " LIKE @question OR ";
            }
        }
        // add a dummy ending comparation for the remaining last 'OR'
        query += " 1 = 0 ";

        bindSearchData(query, "question", SearchInputAdvanced.Text);
    }
}