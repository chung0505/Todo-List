<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignUpPage.aspx.cs" Inherits="bootstrap.SignUpPage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="container py-5 h-100">
        <div class="row justify-content-center align-items-center h-100">
            <div class="col-12 col-lg-9 col-xl-7">
                <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                    <div class="card-body p-4 p-md-5">
                        <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">Registration Form</h3>
                        <div class="mb-4">
                            <div class="form-outline">
                                <label class="w-25 mr-2">Username <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtUser" runat="server"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="ValidUser" runat="server" ControlToValidate="txtUser" Display="Dynamic" ErrorMessage="Must Input Username" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <div class="mb-4">
                            <div class="form-outline">
                                <label class="w-25 mr-2">Password <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtPass" TextMode="Password" runat="server"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="ValidPass" runat="server" ControlToValidate="txtPass" Display="Dynamic" ErrorMessage="Must Input Password" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <div class="mb-4">
                            <div class="form-outline mb-4">
                                <label class="w-25 mr-2">Confirm <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtPassCheck" TextMode="Password" runat="server"></asp:TextBox>
                            </div>
                            <asp:CompareValidator ID="ValidComp1" runat="server" ControlToCompare="txtPass" ControlToValidate="txtPassCheck" Display="Dynamic" ErrorMessage="Input Two Different Password" ForeColor="Red"></asp:CompareValidator>
                            <asp:CompareValidator ID="ValidComp2" runat="server" ControlToCompare="txtPassCheck" ControlToValidate="txtPass" Display="Dynamic" ForeColor="Black"></asp:CompareValidator>
                        </div>
                        <div class="mb-4">
                            <div class="form-outline"> 
                                <label class="w-25 mr-2">Email <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Must Input Email" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="ValidEmail" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Wrong Type Of Email Address" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        </div>
                        <div class="mb-4">
                            <div class="form-outline">
                                <label class="w-25 mr-2">Phone <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPhone" Display="Dynamic" ErrorMessage="Must Input Phone Number" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Wrong Type of Phone Number" ControlToValidate="txtPhone" ForeColor="Red" ValidationExpression="09[0-9]{8}"></asp:RegularExpressionValidator>
                        </div>
                        <div class="mb-4">
                            <div class="form-outline d-flex flex-row align-items-center">
                                <label class="w-25 mr-2">Gender <span class="text-danger">*</span></label>
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" style="display:inline">
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                    <asp:ListItem>Other</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="RadioButtonList1" ErrorMessage="Please select something" ForeColor="Red"/>
                        </div>
                        <div class="mb-4">
                            <div class="form-outline">
                                <label class="w-25 mr-2">City <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="city" DataValueField="city" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:demoConnectionString %>" ProviderName="<%$ ConnectionStrings:demoConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT [city] FROM [citydata]"></asp:SqlDataSource>
                            </div>
                            <asp:RequiredFieldValidator ID="ValidCity" runat="server" ControlToValidate="DropDownList1" ErrorMessage="Please select something" ForeColor="Red"/>
                        </div>
                        <div class="mb-4">
                            <div class="form-outline">
                                <label class="w-25 mr-2">District <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="district" DataValueField="district">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:demoConnectionString %>" SelectCommand="SELECT [district] FROM [citydata] WHERE ([city] = @city)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList1" Name="city" PropertyName="SelectedValue" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DropDownList1" ErrorMessage="Please select something" ForeColor="Red"/>
                        </div>
                        <div class="form-outline mb-4 d-flex flex-row align-items-center">
                            <label class="w-25 mr-2">Address</label>
                            <asp:TextBox ID="txtAddr" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </div>
                        <div class="mb-4">
                            <asp:Button ID="btnSignUp" Text="Sign Up" CssClass="btn btn-block btn-primary" runat="server" onClick="btnSignUp_Click" />
                        </div>
                        <div>
                            <p>Already have a account? <a href="LoginPage.aspx">Login</a></p>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
