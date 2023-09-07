using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace bootstrap
{
    public partial class TodoList : System.Web.UI.Page
    {
        string strDbCon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        
        protected void updateRepeater(string command)
        {
            if (Session["username"] != null)
            {
                SqlConnection con = new SqlConnection(strDbCon);
                con.Open();
                SqlCommand cmd = new SqlCommand(command, con);
                cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
                SqlDataAdapter adapter = new SqlDataAdapter();
                DataSet ds = new DataSet();
                adapter.SelectCommand = cmd;
                adapter.SelectCommand.Connection = con;
                adapter.Fill(ds);
                Repeater1.DataSource = ds;
                Repeater1.DataBind();
                con.Close();
            }
        }

        protected string getFilterCommand(string value)
        {
            switch (value) 
            {
                case "All":
                    return "select todo, isCheck from list where username=@username";
                case "Complete":
                    return "select todo, isCheck from list where username=@username and isCheck='true'";
                case "Active":
                    return "select todo, isCheck from list where username=@username and isCheck='false'";
                default: 
                    break;
            }
            return string.Empty;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                updateRepeater("select todo, isCheck from list where username=@username");
            }
            else
            {
                string eventTarget = Page.Request.Params["__EVENTTARGET"]; // check which controller cause postback
                if (eventTarget.Contains("DropDownList1"))
                {
                    SqlConnection con = new SqlConnection(strDbCon);
                    con.Open();
                    SqlCommand cmd = new SqlCommand(getFilterCommand(DropDownList1.SelectedValue), con);
                    cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
                    SqlDataAdapter adapter = new SqlDataAdapter();
                    DataSet ds = new DataSet();
                    adapter.SelectCommand = cmd;
                    adapter.SelectCommand.Connection = con;
                    adapter.Fill(ds);
                    Repeater1.DataSource = ds;
                    Repeater1.DataBind();
                    con.Close();
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                SqlConnection con = new SqlConnection(strDbCon);
                SqlCommand cmd = new SqlCommand("insert into list (username, todo, isCheck) values (@username, @todo, 'false')", con);
                con.Open();
                cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
                cmd.Parameters.AddWithValue("@todo", txtTodo.Text);
                cmd.ExecuteNonQuery();
                con.Close();
                updateRepeater("select todo, isCheck from list where username=@username");
            }
        }

        protected void btnDel_Command(object sender, CommandEventArgs e)
        {
            string todo = e.CommandArgument.ToString();
            SqlConnection con = new SqlConnection(strDbCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("delete from list where todo=@todo and username=@username", con);
            cmd.Parameters.AddWithValue("@todo", todo);
            cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
            cmd.ExecuteNonQuery();
            con.Close();
            updateRepeater("select todo, isCheck from list where username=@username");
        }

        protected void btnEdit_Command(object sender, CommandEventArgs e)
        {
            Session["oldTodo"] = e.CommandArgument.ToString();
            txtEditTodo.Text = e.CommandArgument.ToString();
            string script = "$('#editmodal').modal('show');";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(strDbCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("update list set todo=@todo where (username=@username and todo=@oldTodo)", con);
            cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
            cmd.Parameters.AddWithValue("@oldTodo", Session["oldTodo"].ToString());
            cmd.Parameters.AddWithValue("@todo", txtEditTodo.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            updateRepeater("select todo, isCheck from list where username=@username");
        }

        protected void status_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            string todoItem = chk.Attributes["CommandName"];
            if (chk.Checked == false)
            {
                SqlConnection con = new SqlConnection(strDbCon);
                con.Open();
                SqlCommand cmd = new SqlCommand("update list set isCheck=@isCheck where (username=@username and todo=@todo)", con);
                cmd.Parameters.AddWithValue("@isCheck", "false");
                cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
                cmd.Parameters.AddWithValue("@todo", todoItem);
                cmd.ExecuteNonQuery();
                con.Close();
                if (DropDownList1.SelectedValue != "All")
                {
                    updateRepeater(getFilterCommand(DropDownList1.SelectedValue));
                }
            }
            else
            {
                SqlConnection con = new SqlConnection(strDbCon);
                con.Open();
                SqlCommand cmd = new SqlCommand("update list set isCheck=@isCheck where (username=@username and todo=@todo)", con);
                cmd.Parameters.AddWithValue("@isCheck", "true");
                cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
                cmd.Parameters.AddWithValue("@todo", todoItem);
                cmd.ExecuteNonQuery();
                con.Close();
                if (DropDownList1.SelectedValue != "All")
                {
                    updateRepeater(getFilterCommand(DropDownList1.SelectedValue));
                }
            }
        }
    }
}