using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace OrphanageSite.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        private string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\smsha\\Desktop\\Sharique\\MCA\\Sem2\\Web Technology\\Project\\OrphanageSite\\OrphanageSite\\DataBase\\OrphanageSiteDB.mdf;Integrated Security=True;Connect Timeout=30";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Fetch data for tiles
                FetchRegisteredUsers();
                FetchChildren();
                FetchCamps();
                FetchDonations();
            }
        }

        private void FetchRegisteredUsers()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string comm = "SELECT COUNT(*) FROM Users";
                SqlCommand cmd = new SqlCommand(comm, conn);

                conn.Open();
                int registeredUsersCount = (int)cmd.ExecuteScalar();
                lblRegisteredUsers.Text = registeredUsersCount.ToString();
            }
        }

        private void FetchChildren()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string comm = "SELECT COUNT(*) FROM Children";
                SqlCommand cmd = new SqlCommand(comm, conn);

                conn.Open();
                int childrenCount = (int)cmd.ExecuteScalar();
                lblChildren.Text = childrenCount.ToString();
            }
        }

        private void FetchCamps()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string comm = "SELECT COUNT(*) FROM Camps WHERE Status = 1";
                SqlCommand cmd = new SqlCommand(comm, conn);

                conn.Open();
                int activeCampsCount = (int)cmd.ExecuteScalar();
                lblActiveCamps.Text = activeCampsCount.ToString();

                comm = "SELECT COUNT(*) FROM Camps WHERE Status = 0";
                cmd.CommandText = comm;
                int inactiveCampsCount = (int)cmd.ExecuteScalar();
                lblInactiveCamps.Text = inactiveCampsCount.ToString();
            }
        }

        private void FetchDonations()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Fetch monthly donations for the current month
                string comm = "SELECT SUM(Amount) FROM Contributions WHERE MONTH(ContributionDate) = MONTH(GETDATE()) AND YEAR(ContributionDate) = YEAR(GETDATE())";
                SqlCommand cmd = new SqlCommand(comm, conn);
                conn.Open();
                object monthlyTotal = cmd.ExecuteScalar();
                lblMonthlyDonation.Text = "₹" + (monthlyTotal == DBNull.Value ? "0" : ((decimal)monthlyTotal).ToString("F2"));

                // Fetch annual donations for the current year
                comm = "SELECT SUM(Amount) FROM Contributions WHERE YEAR(ContributionDate) = YEAR(GETDATE())";
                cmd.CommandText = comm;
                object annualTotal = cmd.ExecuteScalar();
                lblAnnualDonation.Text = "₹" + (annualTotal == DBNull.Value ? "0" : ((decimal)annualTotal).ToString("F2"));

                conn.Close();
            }
        }
    }
}
