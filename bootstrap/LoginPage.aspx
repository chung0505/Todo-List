<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="bootstrap.LoginPage" %>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                    <div class="card-body p-5 text-center">
                        <div class="mb-md-5 mt-md-4 pb-5">
                            <h2 class="fw-bold mb-5 text-uppercase">Login</h2>
                            <div class="form-outline mb-4">
                                <asp:TextBox ID="txtUser" CssClass="form-control" placeholder="Username" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ValidUser" runat="server" ControlToValidate="txtUser" Display="Dynamic" ErrorMessage="Please Input Username" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-outline mb-4">
                                <asp:TextBox ID="txtPass" CssClass="form-control" placeholder="Password" TextMode="Password" runat="server"></asp:TextBox>
                                <asp:CustomValidator ID="CustomValidator1" runat="server" Display="Dynamic" ErrorMessage="Invalid User" ForeColor="Red" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                            </div>

                            <!-- Submit button -->
                            <asp:Button ID="btnSignIn" Text="Sign In" CssClass="btn btn-block btn-primary mb-5" runat="server" OnClick="btnSignIn_Click"/>

                            <!-- Register buttons -->
                            <div class="text-center">
                                <p>Not a member? <a href="SignUpPage.aspx">Register</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
