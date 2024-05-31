using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace OrphanageSite
{
    public partial class Sponsors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MessageLabel.Visible = false;
                LoadContributors();
            }
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            string firstName = FirstName.Text;
            string lastName = LastName.Text;
            string email = Email.Text;
            string phone = Phone.Text;
            decimal amount = Convert.ToDecimal(Amount.Text);
            string donateType = DonateType.SelectedValue;
            string connectionString = WebConfigurationManager.ConnectionStrings["OrphanageSiteDBConnectionString2"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO Contributions (ContributorFirstName, ContributorLastName, ContributorEmail, ContributorPhoneNumber, Amount, ContributionType) VALUES (@FirstName, @LastName, @Email, @Phone, @Amount, @DonateType)";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@FirstName", firstName);
                    command.Parameters.AddWithValue("@LastName", lastName);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Phone", phone);
                    command.Parameters.AddWithValue("@Amount", amount);
                    command.Parameters.AddWithValue("@DonateType", donateType);

                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();

                    MessageLabel.Text = "Donated to the Orphanage Successfully";
                    MessageLabel.CssClass = "message-success";
                }
            }
            catch (Exception ex)
            {
                MessageLabel.Text = "Donation not Successful";
                MessageLabel.CssClass = "message-failure";
            }
            finally
            {
                MessageLabel.Style["display"] = "block";
                MessageLabel.Visible = true;
            }
        }

        private void LoadContributors()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["OrphanageSiteDBConnectionString2"].ConnectionString;
            List<string> contributors = new List<string>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT ContributorFirstName, ContributorLastName FROM Contributions";
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    string firstName = reader["ContributorFirstName"].ToString();
                    string lastName = reader["ContributorLastName"].ToString();
                    contributors.Add($"{firstName} {lastName}");
                }
                connection.Close();
            }

            ContributorsList.DataSource = contributors;
            ContributorsList.DataBind();
        }
    }
}
