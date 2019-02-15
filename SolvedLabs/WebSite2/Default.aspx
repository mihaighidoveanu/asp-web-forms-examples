<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="StudentForm" runat="server">
        <div>           
            <!--Search button -->
            <asp:Panel ID="Search" runat="server">
                <asp:TextBox ID="SearchInput" runat="server"></asp:TextBox>
                <asp:Button ID="SearchButton" runat="server"
                    ValidationGroup="Group" Text="Search" OnClick="SearchClick"/>
            </asp:Panel>
            <br />
            <br />

            <!-- Name Labels -->
            <asp:Panel ID="NamesText" runat="server">
                <asp:Label ID="LastNameLabel" runat="server" Text="Last Name "></asp:Label>
                <asp:Label ID="FirstNameLabel" runat="server" Text="First Name" ></asp:Label>
            </asp:Panel>

            <asp:Panel ID="NamesInput" runat="server">

                <asp:TextBox ID="LastNameInput" runat="server" AutoCompleteType="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="LastNameValidator" runat="server" 
                    ErrorMessage="Last Name is required" ControlToValidate ="LastNameInput" 
                    ForeColor="Red" Display="Dynamic">
                </asp:RequiredFieldValidator>      
                
                <!-- First Name -->
                <asp:TextBox ID="FirstNameInput" runat="server" AutoCompleteType="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="FirstNameValidator" runat="server" 
                    ErrorMessage="First Name is required" ControlToValidate="FirstNameInput"
                    ForeColor="Red">
                </asp:RequiredFieldValidator>   
            </asp:Panel>
            <br />
            <br />            
                        
                        
            <br />
            <br />

            <!-- Email --> 
            <asp:Label ID="EmailLabel" runat="server" Text="Your email ... ?"></asp:Label>
            <br />
            <asp:TextBox ID="EmailInput" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="EmailValidator" runat="server" 
                ErrorMessage="Email is required" ControlToValidate="EmailInput"
                ForeColor="Red">
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="EmailOkValidator" runat="server" 
                ErrorMessage="Email isn't in the right format" ControlToValidate="EmailInput"
                ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
            </asp:RegularExpressionValidator>
            <br />
            <br />

            <!-- Password Input -->
            <asp:Label ID="PasswordInfoLabel" runat="server" Text="Secret words to let you in:"></asp:Label>
            <br />
            <!-- Password -->
            <asp:Label ID="PasswordLabel" runat="server">Password : </asp:Label>
            <asp:TextBox ID="PasswordInput" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="PasswordValidator" runat="server" 
                ErrorMessage="Password is required" ControlToValidate="EmailInput"
                ForeColor="Red">
            </asp:RequiredFieldValidator> 
            <br />

            <!-- Password Confirm -->
            <asp:Label ID="PasswordConfirmLabel" runat="server" Text="Confirm Password:"></asp:Label>
            <asp:TextBox ID="PasswordConfirmInput" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="PasswordConfirmValidator" runat="server" 
                ErrorMessage="Password is required" ControlToValidate="EmailInput"
                ForeColor="Red">
            </asp:RequiredFieldValidator> 
            <br />

            <!-- Check that passwords match -->
            <asp:CompareValidator runat="server" ID="PasswordMatchValidator"
                ErrorMessage ="Passwords do not match" ControlToCompare="PasswordInput" 
                ControlToValidate="PasswordConfirmInput" ForeColor="Red">
            </asp:CompareValidator> 
            <br />
            <br />
            
            <!-- Study  -->
            <asp:Label ID="StudyInfoLabel" runat="server" Text="Where do you study ?"></asp:Label>
            <br />
            
            <!-- University -->
            <asp:Label ID="UniversityLabel" runat="server">University :</asp:Label>
            <asp:DropDownList ID="UniversityInput" runat="server">
                <asp:ListItem>---</asp:ListItem>
                <asp:ListItem>Unibuc</asp:ListItem>
                <asp:ListItem>Politehnica</asp:ListItem>
            </asp:DropDownList>                       
            <asp:CompareValidator ID="UniversityValidator" runat="server"
                ControlToValidate ="UniversityInput" ValueToCompare="---" Operator="NotEqual" 
                ErrorMessage="Please choose an option." ForeColor="Red">
            </asp:CompareValidator>
            <br />
            
            <!-- Study year -->
            <asp:Label ID="StudyYearLabel" runat="server">Study Year :</asp:Label>
            <asp:DropDownList ID="StudyYearInput" runat="server">
                <asp:ListItem>----</asp:ListItem>
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
            </asp:DropDownList>
            <asp:CompareValidator ID="StudyYearValidator" runat="server"
                ControlToValidate ="UniversityInput" ValueToCompare="---" Operator="NotEqual"
                ErrorMessage ="Please choose an option." ForeColor="Red">
            </asp:CompareValidator>
            <br />
            <br />

            <!-- Personal Info -->
            <asp:Label ID="PersonalInfoLabel" runat="server" Text="Stalkerly creepy questions : "></asp:Label>
            <br />

            <!-- Age -->
            <asp:Label ID="AgeInfoLabel" runat="server">Your age :</asp:Label>
            <asp:TextBox ID="AgeInput" runat="server"></asp:TextBox>  
            <asp:RequiredFieldValidator ID="AgeValidator" runat="server" 
                ErrorMessage="Email is required" ForeColor="Red" 
                ControlToValidate="AgeInput">
            </asp:RequiredFieldValidator> 
            <asp:RangeValidator ID="AgeOkValidator" runat="server" ErrorMessage="Age should be between 0 and 120"
                MinimumValue="0" MaximumValue="120" Type="Integer" 
                ControlToValidate="AgeInput" ForeColor="Red">
            </asp:RangeValidator>
            <asp:CustomValidator ID="AgeBelievable" runat="server" 
                ControlToValidate="AgeInput" OnServerValidate="AgeBelievable_ServerValidate" >
            </asp:CustomValidator>
            <br />

            <!-- Sex -->
            <asp:Label ID="SexInfoLabel" runat="server" Text="Sex :"></asp:Label>
            <asp:RadioButtonList ID="SexInput" runat="server">
                <asp:ListItem>Male</asp:ListItem>
                <asp:ListItem>Female</asp:ListItem>
                <asp:ListItem>Other</asp:ListItem>
            </asp:RadioButtonList>
            <asp:RequiredFieldValidator ID="RadioButtonValidator" runat="server" 
                ErrorMessage="Sex is required" ControlToValidate="AgeInput"
                ForeColor="Red">
            </asp:RequiredFieldValidator> 
            <br />
            <br />
            
            <!-- Data nasterii -->
            <asp:Label ID="BirthdayLabel" runat="server" Text="Birthday Date :"></asp:Label>
            <asp:TextBox ID ="BirthdayInput" runat="server"></asp:TextBox>
            <asp:CompareValidator ID="BirthdayValidator" runat="server"
                ControlToValidate="BirthdayInput" Type="Date" Operator="DataTypeCheck"
                ErrorMessage="Entered date is not a valid date" ForeColor="Red">
            </asp:CompareValidator>
            <br />
            <br />

            <!-- If Employed -->
            <asp:Label ID="EmployedInfoLabel" runat="server" Text="Check this box if you're currently employed."></asp:Label>
            <asp:CheckBox AutoPostBack="true" ID="EmployedInput" runat="server" OnCheckedChanged="IfEmployed"/>
            <br />
            <br />
            
            <!-- Firma -->
            <asp:Panel runat="server" ID="Firma" Visible="false">
                <asp:Label ID="FirmaLabel" runat="server" Text="Firma : " ></asp:Label>
                <asp:TextBox ID="FirmaInput" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="FirmaValidator" runat="server"
                    ErrorMessage="RequiredFieldValidator" ControlToValidate="FirmaInput"
                    ForeColor="Red">
                </asp:RequiredFieldValidator>
            </asp:Panel>

            <!-- Salariu -->
            <asp:Panel runat="server" ID="Salariu" Visible="false">
                <asp:Label ID="SalariuLabel" runat="server" Text="Salariu :"></asp:Label>
                <asp:TextBox ID="SalariuInput" runat="server" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="SalariuValidator" runat="server" 
                    ErrorMessage="RequiredFieldValidator" ControlToValidate="SalariuInput"
                    ForeColor="Red">
                </asp:RequiredFieldValidator>
            </asp:Panel>


            <!-- Submit button -->
            <asp:Button ID="StudentInfoButton" runat="server" OnClick="StudentInfoClick" Text="Submit info"/>


        </div>
        
        <asp:Panel ID="Output" runat="server" Visible="false">
            <asp:Label ID="NameOutput" runat="server" Text="Label" ></asp:Label>
            <br />
            <asp:Label ID="EmailOutput" runat="server" Text="Label" ></asp:Label>
            <br />
            <asp:Label ID="PasswordOutput" runat="server" Text="Label" ></asp:Label>
            <br />
            <asp:Label ID="UniversityOutput" runat="server" Text="Label" ></asp:Label>
            <br />
            <asp:Label ID="StudyYearOutput" runat="server" Text="Label" ></asp:Label>
            <br />
            <asp:Label ID="PersonalOutput" runat="server" Text="Label" ></asp:Label>
            <br />
            <asp:Label ID="EmployedOutput" runat="server" Text="Label" ></asp:Label>
         </asp:Panel>    
        
        
    </form>
</body>
</html>
