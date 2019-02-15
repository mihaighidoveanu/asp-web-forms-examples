using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class Adauga : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void addMovie_Click(object sender, EventArgs e)
    {
        bool success = false;

        XmlDocument doc = new XmlDocument();
        doc.Load(Server.MapPath("~") + "/Movies.xml");
        XmlElement movie = doc.CreateElement("movie");
        movie.SetAttribute("genre", TBgenre.Text);
        movie.SetAttribute("year", TByear.Text);
        movie.SetAttribute("duration", TBduration.Text);

        //set element id to the next available one
        XmlElement root = doc.DocumentElement;
        string ID = "1";
        XmlNode lastMovie = root.LastChild;
        if (lastMovie != null)
        {
            int maxID = int.Parse(lastMovie.Attributes["ID"].Value);
            ID = (maxID + 1).ToString();
        }
        movie.SetAttribute("ID", ID);

        XmlElement title = doc.CreateElement("title");
        title.InnerText = TBtitle.Text;
        movie.AppendChild(title);

        XmlElement director = doc.CreateElement("director");
        director.InnerText = TBdirector.Text;
        movie.AppendChild(director);

        if (!TBactor1.Text.Trim().Equals(""))
        {
            XmlElement actor1 = doc.CreateElement("actor");
            actor1.InnerText = TBactor1.Text;
            movie.AppendChild(actor1);
            success = true;
        }
        if (!TBactor2.Text.Trim().Equals(""))
        {
            XmlElement actor2 = doc.CreateElement("actor");
            actor2.InnerText = TBactor2.Text;
            movie.AppendChild(actor2);
            success = true;
        }
        if (!TBactor3.Text.Trim().Equals(""))
        {
            XmlElement actor3 = doc.CreateElement("actor");
            actor3.InnerText = TBactor3.Text;
            movie.AppendChild(actor3);
            success = true;
        }
       
        
        if (TBimage.HasFile && success)
        {
            if(TBimage.PostedFile.ContentType.ToLower().EndsWith("jpeg"))
            {
                TBimage.SaveAs(Server.MapPath("~") + "/Images/" + ID + ".jpeg");
                root.AppendChild(movie);
            }
            else
            {
                success = false;
                Response.Write("Imaginea trebuie sa fie in format jpg");
            }
        }
        else
        {
            Response.Write("Filmul trebuie sa aiba cel putin un actor");
        }

        status.Visible = true;
        if (success)
            status.Text = "Succes";
        else
            status.Text = "Failure";

        doc.Save(Server.MapPath("~") + "/Movies.xml");
    }
}