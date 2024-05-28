<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="UserRegistrationsManagement.aspx.cs" Inherits="OrphanageSite.Admin.UserRegistrations" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .container{
            margin: 35px auto;
            width: 70%;
        }
        .card-body{
            padding: 30px;
        }
        hr{
            width: 50%;
            margin: auto;
        }
    </style>
    <div class="container card">
        <h2 class="card-header">User Registrations</h2>
        <div class="card-body">
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" OnRowCommand="gvUsers_RowCommand" CssClass="table table-striped">
                <Columns>
                    <asp:BoundField DataField="UserID" HeaderText="UserID" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                    <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                    <asp:BoundField DataField="PhoneNumber" HeaderText="Phone Number" />
                    <asp:BoundField DataField="RegistrationDate" HeaderText="Registration Date" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnChangeStatus" runat="server" Text="Change Status" CommandName="ChangeStatus" CommandArgument='<%# Eval("UserID") %>' CssClass="btn btn-warning" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
    <hr />
    <div class ="container card">
        <h2 class="card-header">Execute Custom SQL Query</h2>
        <div class="card-body">
            <div class="mb-3">
                <asp:TextBox ID="txtSqlQuery" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" />
            </div>
            <div class="mb-3">
                <asp:Button ID="btnExecuteQuery" runat="server" Text="Execute Query" OnClick="btnExecuteQuery_Click" CssClass="form-control btn btn-success" />
            </div>

            <asp:GridView ID="gvQueryResults" runat="server" AutoGenerateColumns="True" CssClass="table table-striped" />
            <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" CssClass="form-control btn btn-danger mt-2 ml-2" />
        </div>
    </div>
</asp:Content>
