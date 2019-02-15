using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (! Page.IsPostBack)
        {
            PageLiteral.Text = "Page is not postback!";

            //generate random number
            Random rgen = new Random();
            Session["randomNumber"] = rgen.Next(1, 101);
        }


        PageLiteral.Text = "Try to guess the lucky number ! ";
    }

    protected void SendNumberClick(object sender, EventArgs e)
    {
        //get client number
        int clientNumber = 0;
        if(! Int32.TryParse(NumberTextBox.Text, out clientNumber) )
        {
            PageLiteral.Text = "You should enter a number here";
            return;
        }

        //check success of client    
        int randomNumber = (int)Session["randomNumber"];
        if ( clientNumber == randomNumber)
        { 
            PageLiteral.Text = "Succes";
            NumberStatus.Text = "You were lucky ! How about another one ?";
        }
        else
        {         
            PageLiteral.Text = "Fail, the number was " + Session["randomNumber"] + ".";
            if( clientNumber < randomNumber)
                NumberStatus.Text = "Too bad, your number was smaller";
            else
                NumberStatus.Text = "Too bad, your number was bigger";
        }


        PlayAgainButton.Visible = true;
        NumberStatus.Visible = true;
    }

    protected void PlayAgainClick(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }

}
