using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.ComponentModel;
using System.Xml.Linq;
using System.Drawing;

namespace bootstrap
{

    public partial class Default : System.Web.UI.Page
    {
        string strDbCon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        static int num = 0;
        protected void CreateButtons()
        {
            if (Session["username"] != null)
            {
                SqlConnection con = new SqlConnection(strDbCon);
                SqlCommand cmd = new SqlCommand("Select * from member", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds, "member");
                int row = ds.Tables["member"].Rows.Count % 2 == 0 ? ds.Tables["member"].Rows.Count : ds.Tables["member"].Rows.Count + 1;
                for (int i = 1; i <= row / 2; i++) 
                { 
                    Button button = new Button();
                    button.ID = "btnPage" + i;
                    button.Text = i.ToString();
                    button.Click += btnPage_Click; // Attach a click event handler
                    button.CssClass = "styledButton";
                    buttonList.Controls.Add(button);
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(strDbCon);
            SqlCommand cmd;
            if (!IsPostBack)
            {
                if (Session["username"] != null)
                {
                    con.Open();
                    if (Session["username"].ToString() == "admin")
                    {
                        cmd = new SqlCommand("Select * from member order by username offset 0 rows fetch next 2 rows only", con);
                        CreateButtons();
                    }
                    else
                    {
                        cmd = new SqlCommand("Select * from member where username=@username", con);
                        cmd.Parameters.AddWithValue("@username", Session["username"]);
                    }
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    adapter.Fill(ds);
                    GridView1.DataSource = ds;
                    GridView1.DataBind();
                    con.Close();
                }
            }
            
            if (IsPostBack) {
                string eventTarget = Page.Request.Params["__EVENTTARGET"]; // check which controller cause postback
                if (eventTarget.Contains("DropDownList1"))
                {
                    string script = "$('#mymodal').modal('show');";
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
                }
                if (Session["username"].ToString() == "admin")
                {
                    CreateButtons();
                    cmd = new SqlCommand("Select * from member order by username offset " + num.ToString() + " rows fetch next 2 rows only", con);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    adapter.Fill(ds);
                    GridView1.DataSource = ds;
                    GridView1.DataBind();
                    con.Close();
                }                
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "btn_edit")
            {
                int i = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = GridView1.Rows[i];
                Session["edituser"] = selectedRow.Cells[0].Text;
                txtUser.Text = selectedRow.Cells[0].Text;
                txtPass.Text = selectedRow.Cells[1].Text;
                txtEmail.Text = selectedRow.Cells[2].Text;
                txtPhone.Text = selectedRow.Cells[3].Text;
                RadioButtonList1.SelectedValue = selectedRow.Cells[4].Text;
                DropDownList1.SelectedValue = selectedRow.Cells[5].Text;
                DropDownList2.SelectedItem.Value = selectedRow.Cells[6].Text;
                txtAddr.Text = selectedRow.Cells[7].Text;
                string script = "$('#mymodal').modal('show');";
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
            }
            else if (e.CommandName == "btn_delete")
            {
                int i = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = GridView1.Rows[i];
                Session["currentUsername"] = selectedRow.Cells[0].Text;
                string script = "$('#deletemodal').modal('show');";
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SqlConnection con = new SqlConnection(strDbCon);
                con.Open();
                SqlCommand cmd = new SqlCommand("Update member set username=@username, pass=@pass, email=@email, phone=@phone, gender=@gender, city=@city, addr=@addr, district=@district WHERE username=@user", con);
                cmd.Parameters.AddWithValue("@username", txtUser.Text);
                cmd.Parameters.AddWithValue("@pass", txtPass.Text);
                cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@phone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@gender", RadioButtonList1.SelectedValue);
                cmd.Parameters.AddWithValue("@city", DropDownList1.SelectedValue);
                cmd.Parameters.AddWithValue("@district", DropDownList2.SelectedValue);
                cmd.Parameters.AddWithValue("@addr", txtAddr.Text);
                cmd.Parameters.AddWithValue("@user", Session["edituser"].ToString());
                cmd.ExecuteNonQuery();
                con.Close();
                if (Session["username"] != null)
                {
                    if (Session["username"].ToString() == "admin")
                    {
                        cmd = new SqlCommand("Select * from member order by username offset " + (num).ToString() + "rows fetch next 2 rows only", con);
                    }
                    else
                    {
                        cmd = new SqlCommand("Select * from member where username=@username", con);
                        cmd.Parameters.AddWithValue("@username", Session["username"]);
                    }
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    adapter.Fill(ds);
                    GridView1.DataSource = ds;
                    GridView1.DataBind();
                    con.Close();
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            // CreateButtons();
            SqlConnection con = new SqlConnection(strDbCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("DELETE FROM member where username=@username", con);
            cmd.Parameters.AddWithValue("@username", Session["currentUsername"].ToString());
            cmd.ExecuteNonQuery();
            if (Session["username"].ToString() == "admin")
            {
                cmd = new SqlCommand("Select * from member order by username offset " + num.ToString() + " rows fetch next 2 rows only", con);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                adapter.Fill(ds);
                GridView1.DataSource = ds;
                GridView1.DataBind();
                con.Close();

            }
            else {
                con.Close();
                Response.Redirect("LoginPage.aspx");
            }
        }

        protected void btnSignout_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginPage.aspx");
        }

        protected void btnPage_Click(object sender, EventArgs e)
        {
            Button click = sender as Button;
            if (click != null)
            {
                int n = Convert.ToInt32(click.Text);
                num = 2 * n - 2;
                SqlConnection con = new SqlConnection(strDbCon);
                SqlCommand cmd;
                con.Open();
                cmd = new SqlCommand("Select * from member order by username offset " + (num).ToString() + "rows fetch next 2 rows only", con);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                adapter.Fill(ds);
                GridView1.DataSource = ds;
                GridView1.DataBind();
                con.Close();
            }
        }
    }
}