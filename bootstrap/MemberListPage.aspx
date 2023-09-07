<%@ Page Title="" Language="C#" MasterPageFile="~/NestedMasterPage1.master" AutoEventWireup="true" CodeBehind="MemberListPage.aspx.cs" Inherits="bootstrap.Default" %>
<asp:Content ID="Content4" ContentPlaceHolderID="bodyContent" runat="server">
    <style>
        .styledButton {
            background-color: white;
            color: blue;
            text-decoration: underline;
            border: none;
        }
    </style>

    <div class="modal fade" id="deletemodal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Confirm Delete</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            Are you sure you want to delete this data?
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            <asp:Button ID="btnDelete" Text="Delete" CssClass="btn btn-primary" runat="server" OnClick="btnDelete_Click"/>
          </div>
        </div>
      </div>
    </div>

    <div class="container">
        <div class="modal fade" id ="mymodal" role="dialog">
            <div class=" modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Edit Information</h4>
                        <asp:Label ID="lbloutput" runat="server"></asp:Label>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-2">
                            <label>Username</label>
                            <asp:TextBox ID="txtUser" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="ValidUser" runat="server" ControlToValidate="txtUser" Display="Dynamic" ErrorMessage="Must Input Username" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <div class="mb-2">
                            <label>Password</label>
                            <asp:TextBox ID="txtPass" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="ValidPass" runat="server" ControlToValidate="txtPass" Display="Dynamic" ErrorMessage="Must Input Password" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <div class="mb-2">
                            <label>Email</label>
                            <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Must Input Password" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="ValidEmail" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Wrong Type Of Email Address" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        </div>
                        <div class="mb-2">
                            <label>Phone</label>
                            <asp:TextBox ID="txtPhone" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPhone" Display="Dynamic" ErrorMessage="Must Input Password" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Wrong Type of Phone Number" ControlToValidate="txtPhone" ForeColor="Red" ValidationExpression="09[0-9]{8}"></asp:RegularExpressionValidator>
                        </div>
                        <div class="mb-2">
                            <label>Gender</label>
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                                <asp:ListItem Value="Male">Male</asp:ListItem>
                                <asp:ListItem Value="Female">Female</asp:ListItem>
                                <asp:ListItem Value="Other">Other</asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="RadioButtonList1" ErrorMessage="Please select something" ForeColor="Red"/>
                        </div>
                        <div class="mb-2">
                            <label>City</label>
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="city" DataValueField="city" AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:demoConnectionString %>" ProviderName="<%$ ConnectionStrings:demoConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT [city] FROM [citydata]"></asp:SqlDataSource>
                            <asp:RequiredFieldValidator ID="ValidCity" runat="server" ControlToValidate="DropDownList1" InitialValue="0" ErrorMessage="Please select something" ForeColor="Red"/>
                        </div>
                        <div class="mb-2">
                            <label>District</label>
                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="district" DataValueField="district">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:demoConnectionString %>" SelectCommand="SELECT [district] FROM [citydata] WHERE ([city] = @city)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList1" Name="city" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                        <div class="mb-2">
                            <label>Address</label>
                            <asp:TextBox ID="txtAddr" TextMode="MultiLine" CssClass="form-control" runat="server" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        <asp:Button ID="btnSave" CssClass="btn btn-primary" onClick="btnSave_Click" Text="Save" runat="server" />
                    </div>
                </div>
            </div>
       </div>
    </div>
    <section class="vh-100 mt-4">
        <div class="container py-5 h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            Member Info
                        </div>
                        <div class="card-content">
                            <div class="card-body">
                                <asp:GridView CssClass="mb-2" ID="GridView1" AutoGenerateColumns="False" runat="server" OnRowCommand="GridView1_RowCommand">
                                <%--<asp:GridView CssClass="mb-4" ID="GridView1" runat="server" AutoGenerateColumns="False"  allowpaging="true" onpageindexchanging="GridView1_PageIndexChanging" pagesize="2" IDataKeyNames="username" OnRowCommand="GridView1_RowCommand">--%>
                                    <%--<PagerSettings Mode="NumericFirstLast" firstpagetext="First" lastpagetext="Last" pagebuttoncount="2" />--%>
                                    <Columns>
                                        <asp:BoundField DataField="username" HeaderText="Username" ReadOnly="True" SortExpression="username" />
                                        <asp:BoundField DataField="pass" HeaderText="Password" SortExpression="pass" />
                                        <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
                                        <asp:BoundField DataField="phone" HeaderText="Phone" SortExpression="phone" />
                                        <asp:BoundField DataField="gender" HeaderText="Gender" SortExpression="gender" />
                                        <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" />
                                        <asp:BoundField DataField="district" HeaderText="District" SortExpression="district" />
                                        <asp:BoundField DataField="addr" HeaderText="Address" SortExpression="addr" />
                                        <asp:ButtonField ButtonType="Button" CommandName="btn_edit"  Text="Edit" />
                                        <asp:ButtonField ButtonType="Button" CommandName="btn_delete"  Text="Delete" />
                                    </Columns>
                                </asp:GridView>
                                <div id="buttonList" runat="server">
                                </div>
                            </div>
                        </div>
                    </div>
                    <asp:Button ID="btnSignout" runat="server" CssClass="mt-2 btn btn-primary" OnClick="btnSignout_Click" Text="Sign Out" />
                </div>
            </div>
        </div>
    </section>
</asp:Content>
