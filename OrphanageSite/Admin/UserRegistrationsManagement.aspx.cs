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
    public partial class UserRegistrations : System.Web.UI.Page
    {
        private string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\smsha\Desktop\Sharique\MCA\Sem2\Web Technology\Project\OrphanageSite\OrphanageSite\DataBase\OrphanageSiteDB.mdf"";Integrated Security=True;Connect Timeout=30";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUsersGrid();
            }
        }

        private void BindUsersGrid()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT UserID, Email, FirstName, LastName, PhoneNumber, RegistrationDate, Status FROM Users";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ChangeStatus")
            {
                int userID = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Users SET Status = CASE WHEN Status = 1 THEN 0 ELSE 1 END WHERE UserID = @UserID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

                BindUsersGrid();
            }
        }

        protected void btnExecuteQuery_Click(object sender, EventArgs e)
        {
            string query = txtSqlQuery.Text.Trim();

            if (!string.IsNullOrEmpty(query))
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();

                    try
                    {
                        da.Fill(dt);
                        gvQueryResults.DataSource = dt;
                        gvQueryResults.DataBind();
                    }
                    catch (Exception ex)
                    {
                        // Create a DataTable to hold the error message
                        DataTable errorTable = new DataTable();
                        errorTable.Columns.Add("Error", typeof(string));
                        DataRow errorRow = errorTable.NewRow();
                        errorRow["Error"] = ex.Message;
                        errorTable.Rows.Add(errorRow);

                        // Bind the error message to the GridView
                        gvQueryResults.DataSource = errorTable;
                        gvQueryResults.DataBind();
                    }
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            gvQueryResults.DataSource = null;
            gvQueryResults.DataBind();
            txtSqlQuery.Text = string.Empty;
        }
    }
}