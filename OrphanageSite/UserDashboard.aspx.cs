using System;
using System.Configuration;
using System.Data.SqlClient;

namespace OrphanageSite
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load adoption and contribution statistics
                LoadAdoptionStatistics();
                LoadContributionStatistics();
                BtnSubmitDonation.Click += new EventHandler(BtnSubmitDonation_Click);
                BtnSubmitAdoption.Click += new EventHandler(BtnSubmitAdoption_Click);
            }
        }

        protected void BtnSubmitDonation_Click(object sender, EventArgs e)
        {
            try
            {
                // Retrieve values from the form fields
                string firstName = txtFirstName.Value;
                string lastName = txtLastName.Value;
                string email = txtEmail.Value;
                string phoneNumber = txtPhoneNumber.Value;
                decimal amount = Convert.ToDecimal(txtAmount.Value);
                string contributionType = ddlContributionType.Value;
                bool isRegisteredMember = chkIsRegisteredMember.Checked;
                bool sponsorshipReceived = chkSponsorshipReceived.Checked;

                // Call the SaveDonation method with the retrieved values
                SaveDonation(firstName, lastName, email, phoneNumber, amount, contributionType, isRegisteredMember, sponsorshipReceived);

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
                // Retrieve values from the form fields
                string fullName = txtFullName.Value;
                string email = txtEmailAdopt.Value;
                string phoneNumber = txtPhoneAdopt.Value;
                string city = txtCity.Value;
                string state = txtState.Value;
                string postalCode = txtPostalCode.Value;
                string preferredGender = ddlPreferredGender.Value;
                string ageRange = ddlAgeRange.Value;
                int numberOfChildren = Convert.ToInt32(txtNumberOfChildren.Value);
                string healthConsiderations = ddlHealthConsiderations.Value;
                string primaryLanguage = txtPrimaryLanguage.Value;
                string religion = ddlReligion.Value;
                string parentingStyle = txtParentingStyle.Value;
                string educationPlans = ddlEducationPlans.Value;
                string reasonForAdopting = txtReasonForAdopting.Value;
                string previousExperience = txtPreviousExperience.Value;
                string learnAboutNGO = txtLearnAboutNGO.Value;
                string otherInformation = txtOtherInformation.Value;

                // Call the SaveAdoptionPreferences method with the retrieved values
                SaveAdoptionPreferences(fullName, email, phoneNumber, city, state, postalCode, preferredGender, ageRange, numberOfChildren, healthConsiderations, primaryLanguage, religion, parentingStyle, educationPlans, reasonForAdopting, previousExperience, learnAboutNGO, otherInformation);

                // Display a success message
                messageContainer.InnerText = "Your adoption preferences have been successfully submitted! Our team will reach out to you soon to discuss the next steps in the adoption process. Thank you for choosing to change a child's life through adoption!";
                messageContainer.Style["background-color"] = "#dff0d8";
                messageContainer.Style["color"] = "#3c763d";
                messageContainer.Style["border"] = "1px solid #d6e9c6";
                messageContainer.Style["display"] = "block";
            }
            catch (Exception ex)
            {
                // Display an error message
                messageContainer.InnerText = "Error submitting adoption preferences: " + ex.Message;
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

        public void SaveDonation(string firstName, string lastName, string email, string phoneNumber, decimal amount, string contributionType, bool isRegisteredMember, bool sponsorshipReceived)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OrphanageSiteDBConnectionStringUser"].ConnectionString;
            string query = @"INSERT INTO Contributions (ContributorFirstName, ContributorLastName, ContributorEmail, ContributorPhoneNumber, Amount, ContributionType, IsRegisteredMember, SponsorshipReceived) 
                             VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @Amount, @ContributionType, @IsRegisteredMember, @SponsorshipReceived)";

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
                command.Parameters.AddWithValue("@SponsorshipReceived", sponsorshipReceived);

                connection.Open();
                command.ExecuteNonQuery();
            }
        }

        public void SaveAdoptionPreferences(string fullName, string email, string phoneNumber, string city, string state, string postalCode, string preferredGender, string ageRange, int numberOfChildren, string healthConsiderations, string primaryLanguage, string religion, string parentingStyle, string educationPlans, string reasonForAdopting, string previousExperience, string learnAboutNGO, string otherInformation)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OrphanageSiteDBConnectionStringUser"].ConnectionString;
            string query = @"INSERT INTO AdoptionPreferences (FullName, Email, PhoneNumber, City, State, PostalCode, PreferredGender, AgeRange, NumberOfChildren, HealthConsiderations, PrimaryLanguage, Religion, ParentingStyle, EducationPlans, ReasonForAdopting, PreviousExperience, LearnAboutNGO, OtherInformation) 
                     VALUES (@FullName, @Email, @PhoneNumber, @City, @State, @PostalCode, @PreferredGender, @AgeRange, @NumberOfChildren, @HealthConsiderations, @PrimaryLanguage, @Religion, @ParentingStyle, @EducationPlans, @ReasonForAdopting, @PreviousExperience, @LearnAboutNGO, @OtherInformation)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@FullName", fullName);
                command.Parameters.AddWithValue("@Email", email);
                command.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                command.Parameters.AddWithValue("@City", city);
                command.Parameters.AddWithValue("@State", state);
                command.Parameters.AddWithValue("@PostalCode", postalCode);
                command.Parameters.AddWithValue("@PreferredGender", preferredGender);
                command.Parameters.AddWithValue("@AgeRange", ageRange);
                command.Parameters.AddWithValue("@NumberOfChildren", numberOfChildren);
                command.Parameters.AddWithValue("@HealthConsiderations", healthConsiderations);
                command.Parameters.AddWithValue("@PrimaryLanguage", primaryLanguage);
                command.Parameters.AddWithValue("@Religion", religion);
                command.Parameters.AddWithValue("@ParentingStyle", parentingStyle);
                command.Parameters.AddWithValue("@EducationPlans", educationPlans);
                command.Parameters.AddWithValue("@ReasonForAdopting", reasonForAdopting);
                command.Parameters.AddWithValue("@PreviousExperience", previousExperience);
                command.Parameters.AddWithValue("@LearnAboutNGO", learnAboutNGO);
                command.Parameters.AddWithValue("@OtherInformation", otherInformation);

                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }
}
