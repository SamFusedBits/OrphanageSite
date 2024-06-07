using System;
using System.Configuration;
using System.Data.SqlClient;

namespace OrphanageSite
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OrphanageSiteDBConnectionStringUser"].ConnectionString;
            if (connectionString == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Database connection string not found. Please contact the administrator.');", true);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string selectQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email AND Password = @Password";
                    using (SqlCommand cmd = new SqlCommand(selectQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            Session["UserID"] = result.ToString();
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Login successful!'); window.location.href='UserDashboard.aspx';", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Login failed! Please check your email and password and try again.'); window.location.href='Login.aspx';", true);
                        }
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred: " + ex.Message + "'); window.location.href='Login.aspx';", true);
                }
            }
        }
    }
}
