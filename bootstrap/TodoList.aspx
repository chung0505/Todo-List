<%@ Page Title="" Language="C#" MasterPageFile="~/NestedMasterPage1.master" AutoEventWireup="true" CodeBehind="TodoList.aspx.cs" Inherits="bootstrap.TodoList" %>
<asp:Content ID="Content3" ContentPlaceHolderID="bodyContent" runat="server">
    <style>
        #list1 .form-control {
          border-color: transparent;
        }
        #list1 .form-control:focus {
          border-color: transparent;
          box-shadow: none;
        }
        #list1 .select-input.form-control[readonly]:not([disabled]) {
          background-color: #fbfbfb;
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(2n+1) {
            background-color: #ddd;
        }
    </style>
    <div class="modal fade" id="editmodal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Edit Todo</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <asp:TextBox ID="txtEditTodo" CssClass="form-control" runat="server" />
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            <asp:Button ID="btnEdit" Text="Edit" CssClass="btn btn-primary" runat="server" OnClick="btnEdit_Click"/>
          </div>
        </div>
      </div>
    </div>
    <section class="vh-100 mt-4">
      <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
          <div class="col">
            <div class="card" id="list1" style="border-radius: .75rem; background-color: #eff1f2;">
              <div class="card-body py-4 px-4 px-md-5">

                <p class="h1 text-center mt-3 mb-4 pb-3 text-primary">
                  <u>My Todo-s</u>
                </p>

                <div class="pb-2">
                  <div class="card">
                    <div class="card-body">
                      <div class="d-flex flex-row align-items-center">
                        <asp:TextBox ID="txtTodo" placeholder="Add new..." runat="server" CssClass="form-control form-control-lg"></asp:TextBox>
                        <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
                      </div>
                    </div>
                  </div>
                </div>

                <hr class="my-4">

                <div class="d-flex justify-content-end align-items-center mb-4 pt-2 pb-3">
                  <p class="mb-0 mr-2 me-2 text-muted">Filter</p>
                  <asp:DropDownList ID="DropDownList1" autoPostBack="true" runat="server">
                      <asp:Listitem value="All">All</asp:Listitem>
                      <asp:Listitem value="Complete">Complete</asp:Listitem>
                      <asp:Listitem value="Active">Active</asp:Listitem>
                  </asp:DropDownList>
                </div>

                <div class="row">
                    <div class="col-12">
                        <table>
                            <asp:Repeater ID="Repeater1" runat="server">
                                <HeaderTemplate>
                                    <tr>
                                        <th></th>
                                        <th>Todo</th>
                                        <th>Action</th>
                                    </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr class="separator">
                                        <td>
                                            <asp:CheckBox ID="CheckBox1" CommandName='<%# Eval("todo")%>' Checked='<%# Eval("isCheck").ToString() == "true" %>' OnCheckedChanged="status_CheckedChanged" autoPostBack="true" runat="server" />
                                        </td>
                                        <td> <%# Eval("todo")%></td>
                                        <td>
                                            <asp:Button CommandName="edit" ID="btnEdit" CommandArgument='<%# Eval("todo")%>' onCommand="btnEdit_Command" Text="Edit" CssClass="btn btn-primary" runat="server" />
                                            <asp:Button CommandName="delete" ID="btnDel" CommandArgument='<%# Eval("todo")%>' onCommand="btnDel_Command" Text="Delete" CssClass="btn btn-danger" runat="server" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
</asp:Content>