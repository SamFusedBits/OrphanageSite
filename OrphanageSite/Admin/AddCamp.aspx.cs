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
    public partial class AddCamp : System.Web.UI.Page
    {
        private string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\smsha\\Desktop\\Sharique\\MCA\\Sem2\\Web Technology\\Project\\OrphanageSite\\OrphanageSite\\DataBase\\OrphanageSiteDB.mdf;Integrated Security=True;Connect Timeout=30";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCampsGrid();
            }
            if (!IsPostBack && Session["AdminUsername"] != null)
            {
                Response.Redirect("~/AdminLogin.aspx", false);
            }
        }

        protected void btnAddCamp_Click(object sender, EventArgs e)
        {
            string campName = txtCampName.Text.Trim();
            string streetAddress = txtStreetAddress.Text.Trim();
            string city = txtCity.Text.Trim();
            string district = txtDistrict.Text.Trim();
            string state = txtState.Text.Trim();
            string country = txtCountry.Text.Trim();
            string description = txtDescription.Text.Trim();
            string contactInfo = txtContactInfo.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Camps (CampName, StreetAddress, City, District, State, Country, Description, ContactInfo) VALUES (@CampName, @StreetAddress, @City, @District, @State, @Country, @Description, @ContactInfo)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CampName", campName);
                cmd.Parameters.AddWithValue("@StreetAddress", streetAddress);
                cmd.Parameters.AddWithValue("@City", city);
                cmd.Parameters.AddWithValue("@District", district);
                cmd.Parameters.AddWithValue("@State", state);
                cmd.Parameters.AddWithValue("@Country", country);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@ContactInfo", contactInfo);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            // Clear the form
            txtCampName.Text = string.Empty;
            txtStreetAddress.Text = string.Empty;
            txtCity.Text = string.Empty;
            txtDistrict.Text = string.Empty;
            txtState.Text = string.Empty;
            txtCountry.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtContactInfo.Text = string.Empty;

            // Refresh the grid
            BindCampsGrid();
        }

        private void BindCampsGrid()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT CampID, CampName, StreetAddress, City, District, State, Country, Description, ContactInfo, Status FROM Camps";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvCamps.DataSource = dt;
                gvCamps.DataBind();
            }
        }

        protected void gvCamps_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleStatus")
            {
                int campID = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Camps SET Status = CASE WHEN Status = 1 THEN 0 ELSE 1 END WHERE CampID = @CampID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@CampID", campID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

                // Refresh the grid
                BindCampsGrid();
            }
        }
    }
}