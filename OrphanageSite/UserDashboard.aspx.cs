using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace OrphanageSite
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        private readonly string connStr = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\hp\\source\\repos\\OrphanageSite\\OrphanageSite\\DataBase\\OrphanageSiteDB.mdf;Integrated Security=True;Connect Timeout=30";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load adoption and contribution statistics
                LoadAdoptionStatistics();
                LoadContributionStatistics();
                LoadChildren();
                BtnSubmitDonation.Click += new EventHandler(BtnSubmitDonation_Click);
                BtnSubmitAdoption.Click += new EventHandler(BtnSubmitAdoption_Click);
            }
        }

        private void LoadChildren()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT ChildID, FirstName + ' ' + LastName AS FullName FROM Children", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ddlChildID.DataSource = reader;
                ddlChildID.DataTextField = "FullName";
                ddlChildID.DataValueField = "ChildID";
                ddlChildID.DataBind();
                ddlChildID.Items.Insert(0, new ListItem("-- Select a Child --", "0"));
            }
        }


        protected void BtnSubmitDonation_Click(object sender, EventArgs e)
        {
            try
            {
                // Check if the user is logged in
                bool isUserLoggedIn = (Session["LoggedInUser"] != null);

                // Retrieve values from the form fields
                string firstName = txtFirstName.Value;
                string lastName = txtLastName.Value;
                string email = txtEmail.Value;
                string phoneNumber = txtPhoneNumber.Value;
                decimal amount = Convert.ToDecimal(txtAmount.Value);
                string contributionType = ddlContributionType.Value;
                bool isRegisteredMember = isUserLoggedIn; // Set based on session state

                // Call the SaveDonation method with the retrieved values
                SaveDonation(firstName, lastName, email, phoneNumber, amount, contributionType, isRegisteredMember);

                // Display a success message
                messageContainer.InnerText = "Donation submitted successfully!";
                messageContainer.Style["background-color"] = "#dff0d8";
                messageContainer.Style["color"] = "#3c763d";
                messageContainer.Style["border"] = "1px solid #d6e9c6";
                messageContainer.Style["display"] = "block";
            }
            catch (Exception ex)
            {
                // Display an error message
                messageContainer.InnerText = "Error submitting donation: " + ex.Message;
                messageContainer.Style["background-color"] = "#f2dede";
                messageContainer.Style["color"] = "#a94442";
                messageContainer.Style["border"] = "1px solid #ebccd1";
                messageContainer.Style["display"] = "block";
            }
        }

        protected void BtnSubmitAdoption_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate selected child ID
                if (ddlChildID.SelectedValue == "0")
                {
                    messageContainer.InnerText = "Please select a child to adopt.";
                    messageContainer.Style["background-color"] = "#f2dede";
                    messageContainer.Style["color"] = "#a94442";
                    messageContainer.Style["border"] = "1px solid #ebccd1";
                    messageContainer.Style["display"] = "block";
                    return;
                }

                // Validate user session
                if (Session["UserID"] == null || string.IsNullOrEmpty(Session["UserID"].ToString()))
                {
                    messageContainer.InnerText = "You must be logged in to submit an adoption request.";
                    messageContainer.Style["background-color"] = "#f2dede";
                    messageContainer.Style["color"] = "#a94442";
                    messageContainer.Style["border"] = "1px solid #ebccd1";
                    messageContainer.Style["display"] = "block";
                    return;
                }

                // Parse child ID and user ID
                if (!int.TryParse(ddlChildID.SelectedValue, out int childId) || !int.TryParse(Session["UserID"].ToString(), out int userId))
                {
                    messageContainer.InnerText = "Invalid child ID or user ID.";
                    messageContainer.Style["background-color"] = "#f2dede";
                    messageContainer.Style["color"] = "#a94442";
                    messageContainer.Style["border"] = "1px solid #ebccd1";
                    messageContainer.Style["display"] = "block";
                    return;
                }

                // Retrieve logged-in user's first name and last name from the database using the UserID
                string firstName;
                string lastName;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT FirstName, LastName FROM Users WHERE UserID = @UserID", conn);
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        firstName = reader["FirstName"].ToString();
                        lastName = reader["LastName"].ToString();
                    }
                    else
                    {
                        messageContainer.InnerText = "User details not found.";
                        messageContainer.Style["background-color"] = "#f2dede";
                        messageContainer.Style["color"] = "#a94442";
                        messageContainer.Style["border"] = "1px solid #ebccd1";
                        messageContainer.Style["display"] = "block";
                        return;
                    }
                }

                // Prepare adoption data
                DateTime adoptionDate = DateTime.Now;

                // Insert adoption record into the database
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand(@"INSERT INTO Adoptions (ChildID, UserID, AdoptionDate, UserFirstName, UserLastName) 
                              VALUES (@ChildID, @UserID, @AdoptionDate, @UserFirstName, @UserLastName)", conn);
                    cmd.Parameters.AddWithValue("@ChildID", childId);
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@AdoptionDate", adoptionDate);
                    cmd.Parameters.AddWithValue("@UserFirstName", firstName);
                    cmd.Parameters.AddWithValue("@UserLastName", lastName);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    messageContainer.InnerText = "Your adoption request has been submitted successfully!";
                    messageContainer.Style["background-color"] = "#dff0d8";
                    messageContainer.Style["color"] = "#3c763d";
                    messageContainer.Style["border"] = "1px solid #d6e9c6";
                    messageContainer.Style["display"] = "block";
                }
            }
            catch (SqlException ex)
            {
                messageContainer.InnerText = "An error occurred while submitting the adoption request: " + ex.Message;
                messageContainer.Style["background-color"] = "#f2dede";
                messageContainer.Style["color"] = "#a94442";
                messageContainer.Style["border"] = "1px solid #ebccd1";
                messageContainer.Style["display"] = "block";
            }
            catch (Exception ex)
            {
                messageContainer.InnerText = "An unexpected error occurred: " + ex.Message;
                messageContainer.Style["background-color"] = "#f2dede";
                messageContainer.Style["color"] = "#a94442";
                messageContainer.Style["border"] = "1px solid #ebccd1";
                messageContainer.Style["display"] = "block";
            }
        }




        private void LoadAdoptionStatistics()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OrphanageSiteDBConnectionStringUser"].ConnectionString;
            string query = "SELECT COUNT(*) FROM Adoptions";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                int adoptionCount = (int)command.ExecuteScalar();
                if (adoptionCount > 0)
                {
                    lblAdoptionCount.Text = adoptionCount.ToString();
                }
                else
                {
                    lblAdoptionCount.Text = "0";
                }
            }
        }

        private void LoadContributionStatistics()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OrphanageSiteDBConnectionStringUser"].ConnectionString;
            string query = "SELECT SUM(Amount) FROM Contributions";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                object totalAmount = command.ExecuteScalar();
                if (totalAmount != DBNull.Value)
                {
                    lblTotalContributions.Text = $"₹{Convert.ToDecimal(totalAmount):0.00}";
                }
            }
        }

        public void SaveDonation(string firstName, string lastName, string email, string phoneNumber, decimal amount, string contributionType, bool isRegisteredMember)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OrphanageSiteDBConnectionStringUser"].ConnectionString;
            string query = @"INSERT INTO Contributions (ContributorFirstName, ContributorLastName, ContributorEmail, ContributorPhoneNumber, Amount, ContributionType, IsRegisteredMember) 
                             VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @Amount, @ContributionType, @IsRegisteredMember)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@FirstName", firstName);
                command.Parameters.AddWithValue("@LastName", lastName);
                command.Parameters.AddWithValue("@Email", email);
                command.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                command.Parameters.AddWithValue("@Amount", amount);
                command.Parameters.AddWithValue("@ContributionType", contributionType);
                command.Parameters.AddWithValue("@IsRegisteredMember", isRegisteredMember);

                connection.Open();
                command.ExecuteNonQuery();
            }
        }

    }
}
