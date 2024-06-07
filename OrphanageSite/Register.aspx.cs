using System;
using System.Configuration;
using System.Data.SqlClient;

namespace OrphanageSite
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OrphanageSiteDBConnectionStringUser"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string checkEmailQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                    using (SqlCommand checkCmd = new SqlCommand(checkEmailQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Email", txtEmail.Text);

                        int emailCount = (int)checkCmd.ExecuteScalar();
                        if (emailCount > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Email is already registered! Please use a different email.'); window.location.href='Register.aspx';", true);
                        }
                        else
                        {
                            string insertQuery = "INSERT INTO Users (Email, Password, FirstName, LastName, PhoneNumber) VALUES (@Email, @Password, @FirstName, @LastName, @PhoneNumber)";
                            using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                            {
                                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                                cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                                cmd.Parameters.AddWithValue("@LastName", txtLastName.Text);
                                cmd.Parameters.AddWithValue("@PhoneNumber", txtPhoneNumber.Text);

                                int rowsAffected = cmd.ExecuteNonQuery();
                                if (rowsAffected > 0)
                                {
                                    string firstName = txtFirstName.Text;
                                    string lastName = txtLastName.Text;
                                    string successMessage = $"Registration successful! Welcome, {firstName} {lastName}.";
                                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{successMessage}'); window.location.href='Login.aspx';", true);
                                }
                                else
                                {
                                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Registration failed! Please try again.'); window.location.href='Register.aspx';", true);
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('An error occurred: {ex.Message}'); window.location.href='Register.aspx';", true);
                }
            }
        }
    }
}
