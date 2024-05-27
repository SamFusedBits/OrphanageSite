<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddChildren.aspx.cs" Inherits="OrphanageSite.Admin.AddChildren" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        .container{
            margin: 35px auto;
            width: 70%;
        }
        hr{
            width: 50%;
            margin: auto;
        }
    </style>
    <div class="container">
        <h2>Add New Child</h2>
        <form>
            <div class="mb-3">
                <label for="FirstName" class="form-label">First Name</label>
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="LastName" class="form-label">Last Name</label>
                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="DateOfBirth" class="form-label">Date of Birth</label>
                <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="form-control" TextMode="Date" />
            </div>
            <div class="mb-3">
                <label for="Gender" class="form-label">Gender</label>
                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Select Gender" Value="" />
                    <asp:ListItem Text="Male" Value="Male" />
                    <asp:ListItem Text="Female" Value="Female" />
                    <asp:ListItem Text="Other" Value="Other" />
                </asp:DropDownList>
            </div>
            <div class="mb-3">
                <label for="DateOfJoining" class="form-label">Date of Joining</label>
                <asp:TextBox ID="txtDateOfJoining" runat="server" CssClass="form-control" TextMode="Date" />
            </div>
            <asp:Button ID="btnAddChild" runat="server" Text="Add Child" CssClass="btn btn-primary" OnClick="btnAddChild_Click" />
        </form>
     </div>
    <hr />
    <div class="container">
        <h2>List of Children</h2>
        <asp:GridView ID="gvChildren" runat="server" CssClass="table table-striped">
        </asp:GridView>
    </div>
</asp:Content>
