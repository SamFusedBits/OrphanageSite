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
    public partial class AdoptionStatus : System.Web.UI.Page
    {
        private readonly string connStr = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\hp\\source\\repos\\OrphanageSite\\OrphanageSite\\DataBase\\OrphanageSiteDB.mdf;Integrated Security=True;Connect Timeout=30";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
            if (!IsPostBack && Session["AdminUsername"] != null)
            {
                Response.Redirect("~/AdminLogin.aspx", false);
            }
        }

        private void BindGrid()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter(@"SELECT A.*, U.FirstName AS UserFirstName, U.LastName AS UserLastName,
                                                C.FirstName AS ChildFirstName, C.LastName AS ChildLastName
                                         FROM Adoptions A
                                         INNER JOIN Users U ON A.UserID = U.UserID
                                         INNER JOIN Children C ON A.ChildID = C.ChildID", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridViewAdoptions.DataSource = dt;
                GridViewAdoptions.DataBind();
            }
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int adoptionId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();
                try
                {
                    // Approve the selected adoption
                    SqlCommand cmdApprove = new SqlCommand("UPDATE Adoptions SET Status = 1 WHERE AdoptionID = @AdoptionID", conn, transaction);
                    cmdApprove.Parameters.AddWithValue("@AdoptionID", adoptionId);
                    cmdApprove.ExecuteNonQuery();

                    // Find the ChildID of the approved adoption
                    SqlCommand cmdChildId = new SqlCommand("SELECT ChildID FROM Adoptions WHERE AdoptionID = @AdoptionID", conn, transaction);
                    cmdChildId.Parameters.AddWithValue("@AdoptionID", adoptionId);
                    int childId = (int)cmdChildId.ExecuteScalar();

                    // Decline all other adoptions for the same ChildID
                    SqlCommand cmdDeclineOthers = new SqlCommand("UPDATE Adoptions SET Status = 0 WHERE ChildID = @ChildID AND AdoptionID != @AdoptionID", conn, transaction);
                    cmdDeclineOthers.Parameters.AddWithValue("@ChildID", childId);
                    cmdDeclineOthers.Parameters.AddWithValue("@AdoptionID", adoptionId);
                    cmdDeclineOthers.ExecuteNonQuery();

                    // Commit the transaction
                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    // Rollback the transaction in case of an error
                    transaction.Rollback();
                    // Show error message
                    ScriptManager.RegisterStartupScript(this, GetType(), "errorAlert", $"alert('An error occurred: {ex.Message}');", true);
                }
            }
            BindGrid();
        }

        protected void btnDecline_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int adoptionId = Convert.ToInt32(btn.CommandArgument);

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("UPDATE Adoptions SET Status = 0 WHERE AdoptionID = @AdoptionID", conn);
                    cmd.Parameters.AddWithValue("@AdoptionID", adoptionId);
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                // Show error message
                ScriptManager.RegisterStartupScript(this, GetType(), "errorAlert", $"alert('An error occurred: {ex.Message}');", true);
            }
            BindGrid();
        }
    }
}