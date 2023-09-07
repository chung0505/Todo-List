using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace bootstrap
{
    public partial class SignUpPage : System.Web.UI.Page
    {
        string strDbCon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    SqlConnection con = new SqlConnection(strDbCon);
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    string sqlCmd = "insert into member(username, pass, email, phone, gender, city, addr, district) VALUES (@username, @pass, @email, @phone, @gender, @city, @addr, @district)";
                    SqlCommand cmd = new SqlCommand(sqlCmd, con);
                    cmd.Parameters.AddWithValue("@username", txtUser.Text.Trim());
                    cmd.Parameters.AddWithValue("@pass", txtPass.Text);
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@phone", txtPhone.Text);
                    cmd.Parameters.AddWithValue("@gender", RadioButtonList1.SelectedItem.Value);
                    cmd.Parameters.AddWithValue("@city", DropDownList1.SelectedItem.Value);
                    cmd.Parameters.AddWithValue("@addr", txtAddr.Text);
                    cmd.Parameters.AddWithValue("@district", DropDownList2.SelectedItem.Value);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Response.Redirect("LoginPage.aspx");
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
        }
    }
}