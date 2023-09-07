using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace bootstrap
{
    public partial class LoginPage : System.Web.UI.Page
    {
        string strDbCon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtPass.Text = "";
            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Session["username"] = txtUser.Text;
                if (txtUser.Text == "admin")
                {
                    Response.Redirect("MemberListPage.aspx");
                }
                else
                {
                    Response.Redirect("TodoList.aspx");
                }
            }
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            try
            {
                SqlConnection con = new SqlConnection(strDbCon);
                SqlCommand cmd = new SqlCommand("Select * from member where username=@username", con);

                cmd.Parameters.AddWithValue("@username", txtUser.Text);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds, "member");
                if (ds.Tables["member"].Rows.Count == 0)
                {
                    args.IsValid = false;
                }
                else
                {
                    args.IsValid = true;
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}