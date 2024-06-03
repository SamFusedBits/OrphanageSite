<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OrphanageSite.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 35px auto;
            max-width: 80%;
        }
        .form-container {
            flex: 1;
            max-width: 50%;
            margin-right: 20px;
            background-color: #d7fbcf;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-container .card-body {
            padding: 30px;
            background-color: #ffffff;
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }
        .card-header {
            background-color: #d7fbcf;
            color: black;
            text-align: center;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }
        .btn-primary {
            background-color: #51a05b;
            border-color: #51a05b;
        }
        .btn-primary:hover {
            background-color: #42904e;
            border-color: #42904e;
        }
        label {
            color: #51a05b;
        }
        .image-container {
            flex: 1;
            max-width: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 15px;
        }
        .image-container img {
            max-width: 100%;
            border-radius: 15px;
        }
    </style>
    <div class="container">
        <div class="form-container card">
            <h2 class="card-header">User Registration Form</h2>
            <div class="card-body">
                <form id="form1" runat="server">
                    <div class="mb-3">
                        <label for="Email" class="form-label">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" required="required" />
                        <label for="Email" class="form-label">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Email is required!" ForeColor="Red" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                        </label>
                    </div>
                    <div class="mb-3">
                        <label for="Password" class="form-label">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" required="required" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required!" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <label for="FirstName" class="form-label">First Name</label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" required="required" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtFirstName" ErrorMessage="Firstname is required!" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <label for="LastName" class="form-label">Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" required="required" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtLastName" ErrorMessage="Lastname is required!" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <label for="PhoneNumber" class="form-label">Phone Number</label>
                        <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" required="required" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtPhoneNumber" ErrorMessage="Phone Number is required!" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="form-control btn btn-primary" OnClick="btnRegister_Click" />
                </form>
            </div>
        </div>
        <div class="image-container">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Assets/images/admin-image.png" CssClass="img-fluid" Height="350px" Width="350px" />
        </div>
    </div>
</asp:Content>
