using System;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void StudentInfoClick(object sender, EventArgs e)
    {
        NameOutput.Text = "Name : " + FirstNameInput.Text + " " + LastNameInput.Text;
        EmailOutput.Text = "Email : " + EmailInput.Text;
        PasswordOutput.Text = "Password : " + PasswordInput.Text;
        UniversityOutput.Text = "University : " + UniversityInput.Text + ", Year " + StudyYearInput.Text;
        PersonalOutput.Text = "Gender : " + SexInput.Text + ", Age " + AgeInput.Text + ", Born on " + BirthdayInput.Text;
        if (EmployedInput.Checked == true)
            EmployedOutput.Text = "Employed";
        else
            EmployedOutput.Text = "Unemployed";

        Output.Visible = true;

    }

    protected void AgeBelievable_ServerValidate(object source, ServerValidateEventArgs args)
    {
        int inputAge = 0;
        if (Int32.TryParse(AgeInput.Text, out inputAge))
        {
            var now = DateTime.Now;
            var birthdate = DateTime.Parse(BirthdayInput.Text);

            //get the difference time span
            int age = now.Year - birthdate.Year;

            if (birthdate > now.AddYears(-age))
                --age;

            if (age == inputAge)
                args.IsValid = true;
            else
                args.IsValid = false;

            CustomValidator cv = (CustomValidator)source;
            cv.ErrorMessage = "Based on your birthdate, age should be " + age;
            cv.ForeColor = System.Drawing.Color.Red;
        }

    }

    protected void IfEmployed(object source, EventArgs e)
    {
        if(EmployedInput.Checked)
        {    
            Salariu.Visible = true;
            Firma.Visible = true;
        }
        else
        {
            Salariu.Visible = false;
            Firma.Visible = false;
        }
    }


    protected void SearchClick(object sender, EventArgs e)
    {
        Search.GroupingText = SearchInput.Text;
    }
}