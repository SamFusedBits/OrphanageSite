using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OrphanageSite.Admin
{
    public partial class ListSponsors : System.Web.UI.Page
    {
        private string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\hp\\source\\repos\\OrphanageSite\\OrphanageSite\\DataBase\\OrphanageSiteDB.mdf;Integrated Security=True;Connect Timeout=30";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindContributionsGrid();
            }
            if (!IsPostBack && Session["AdminUsername"] != null)
            {
                Response.Redirect("~/AdminLogin.aspx", false);
            }
        }

        //protected void ddlContributionType_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlContributionType.SelectedValue == "Money")
        //    {
        //        amountField.Visible = true;
        //    }
        //    else
        //    {
        //        amountField.Visible = false;
        //    }
        //}

        //protected void btnAddContribution_Click(object sender, EventArgs e)
        //{
        //    string firstName = txtContributorFirstName.Text.Trim();
        //    string lastName = txtContributorLastName.Text.Trim();
        //    string email = txtContributorEmail.Text.Trim();
        //    string phoneNumber = txtContributorPhoneNumber.Text.Trim();
        //    string contributionType = ddlContributionType.SelectedValue;
        //    decimal amount = contributionType == "Money" ? Convert.ToDecimal(txtAmount.Text.Trim()) : 0;
        //    bool isAnonymous = !IsRegisteredUser(email);

        //    using (SqlConnection conn = new SqlConnection(connectionString))
        //    {
        //        string query = "INSERT INTO Contributions (ContributorFirstName, ContributorLastName, ContributorEmail, ContributorPhoneNumber, ContributionType, Amount, IsAnonymous) VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @ContributionType, @Amount, @IsAnonymous)";
        //        SqlCommand cmd = new SqlCommand(query, conn);
        //        cmd.Parameters.AddWithValue("@FirstName", firstName);
        //        cmd.Parameters.AddWithValue("@LastName", lastName);
        //        cmd.Parameters.AddWithValue("@Email", email);
        //        cmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
        //        cmd.Parameters.AddWithValue("@ContributionType", contributionType);
        //        cmd.Parameters.AddWithValue("@Amount", amount);
        //        cmd.Parameters.AddWithValue("@IsAnonymous", isAnonymous);

        //        conn.Open();
        //        cmd.ExecuteNonQuery();
        //        conn.Close();
        //    }

        //    // Clear the form
        //    txtContributorFirstName.Text = string.Empty;
        //    txtContributorLastName.Text = string.Empty;
        //    txtContributorEmail.Text = string.Empty;
        //    txtContributorPhoneNumber.Text = string.Empty;
        //    ddlContributionType.SelectedIndex = 0;
        //    txtAmount.Text = string.Empty;
        //    amountField.Visible = false;

        //    // Refresh the grid
        //    BindContributionsGrid();
        //}

        private bool IsRegisteredUser(string email)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                conn.Close();

                return count > 0;
            }
        }

        private void BindContributionsGrid()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ContributionID, ContributorFirstName, ContributorLastName, ContributorEmail, ContributorPhoneNumber, ContributionType, Amount, ContributionDate, IsRegisteredMember, SponsorshipReceived FROM Contributions";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvContributions.DataSource = dt;
                gvContributions.DataBind();
            }
        }

        protected void gvContributions_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleSponsorship")
            {
                int contributionID = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Contributions SET SponsorshipReceived = CASE WHEN SponsorshipReceived = 1 THEN 0 ELSE 1 END WHERE ContributionID = @ContributionID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ContributionID", contributionID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

                // Refresh the grid
                BindContributionsGrid();
            }
        }
    }
}