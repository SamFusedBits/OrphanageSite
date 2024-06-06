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
    public partial class AddChildren : System.Web.UI.Page
    {
        private string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\smsha\\Desktop\\Sharique\\MCA\\Sem2\\Web Technology\\Project\\OrphanageSite\\OrphanageSite\\DataBase\\OrphanageSiteDB.mdf;Integrated Security=True;Connect Timeout=30";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindChildrenGrid();
            }
            if (!IsPostBack && Session["AdminUsername"] != null)
            {
                Response.Redirect("~/AdminLogin.aspx", false);
            }
        }
        protected void btnAddChild_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            DateTime dateOfBirth = DateTime.Parse(txtDateOfBirth.Text.Trim());
            string gender = ddlGender.SelectedValue;
            DateTime dateOfJoining = DateTime.Parse(txtDateOfJoining.Text.Trim());

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Children (FirstName, LastName, DateOfBirth, Gender, DateOfJoining) VALUES (@FirstName, @LastName, @DateOfBirth, @Gender, @DateOfJoining)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FirstName", firstName);
                cmd.Parameters.AddWithValue("@LastName", lastName);
                cmd.Parameters.AddWithValue("@DateOfBirth", dateOfBirth);
                cmd.Parameters.AddWithValue("@Gender", gender);
                cmd.Parameters.AddWithValue("@DateOfJoining", dateOfJoining);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            // Clear the form
            txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtDateOfBirth.Text = string.Empty;
            ddlGender.SelectedIndex = 0;
            txtDateOfJoining.Text = string.Empty;

            // Refresh the grid
            BindChildrenGrid();
        }

        private void BindChildrenGrid()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ChildID, FirstName, LastName, DateOfBirth, Gender, DateOfJoining, IsAdopted FROM Children";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvChildren.DataSource = dt;
                gvChildren.DataBind();
            }
        }
    }
}