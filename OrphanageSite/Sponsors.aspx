<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Sponsors.aspx.cs" Inherits="OrphanageSite.Sponsors" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f0f0;
        }
        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 500px; 
            padding: 20px;
            text-align: center;
        }
        .card img {
            width: 100%;
            border-radius: 10px 10px 0 0;
        }
        .card h1 {
            color: #4caf50;
            font-size: 30px;
            margin: 20px 0 10px;
        }
        .card p {
            color: black;
            font-size: 18px;
            margin: 0 0 20px;
        }
        .card form {
            display: flex;
            flex-direction: column;
        }
        .card form input, .card form select {
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .card form .btn-success {
            background-color: #4caf50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .card form .btn-success:hover {
            background-color: #45a049;
        }
        .message-success {
            background-color: #e0ffe0;
            color: #4caf50;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        .message-failure {
            background-color: #ffe0e0;
            color: #f44336;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        .contributors-section {
            margin-top: 20px;
            text-align: center;
        }
        .contributors-section h2 {
            color: #4caf50;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .contributors-section p {
            color: black;
            font-size: 18px;
            margin: 5px 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="card">
            <asp:Label ID="MessageLabel" runat="server" CssClass="message-success"></asp:Label>
            <img src="Assets/images/child.jpg" alt="Children">
            <h1>Orphanage Donation Form</h1>
            <p>Just a small help could help a soul</p>
            <form runat="server">
                <asp:TextBox ID="FirstName" runat="server" placeholder="First Name" CssClass="form-control" required="required"></asp:TextBox>
                <asp:TextBox ID="LastName" runat="server" placeholder="Last Name" CssClass="form-control" required="required"></asp:TextBox>
                <asp:TextBox ID="Email" runat="server" placeholder="Email" CssClass="form-control" TextMode="Email" required="required"></asp:TextBox>
                <asp:TextBox ID="Phone" runat="server" placeholder="Phone" CssClass="form-control" TextMode="Phone" required="required"></asp:TextBox>
                <asp:TextBox ID="Amount" runat="server" placeholder="Amount" CssClass="form-control" TextMode="Number" required="required"></asp:TextBox>
                <asp:DropDownList ID="DonateType" runat="server" CssClass="form-control" required="required">
                    <asp:ListItem Text="Donate Type" Value="" Disabled="true" Selected="true"></asp:ListItem>
                    <asp:ListItem Text="Goods" Value="goods"></asp:ListItem>
                    <asp:ListItem Text="Money" Value="money"></asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="Submit" runat="server" Text="Donate" CssClass="btn btn-success" OnClick="Submit_Click" />
            </form>
        </div>
    </div>
    <div class="contributors-section">
        <h2>People who donated</h2>
        <asp:Repeater ID="ContributorsList" runat="server">
            <ItemTemplate>
                <p><%# Container.DataItem %></p>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
