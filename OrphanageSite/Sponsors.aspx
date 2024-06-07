<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Sponsors.aspx.cs" Inherits="OrphanageSite.Sponsors" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 100px); /* Adjust based on header and footer height */
            background-color: #f0f0f0;
            padding: 20px;
            box-sizing: border-box;
        }
        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px; 
            padding: 20px;
            text-align: center;
            box-sizing: border-box;
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
                <asp:TextBox ID="FirstName" runat="server" placeholder="First Name" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" ControlToValidate="FirstName" ErrorMessage="First Name is required" CssClass="message-failure" Display="Dynamic"></asp:RequiredFieldValidator>
                
                <asp:TextBox ID="LastName" runat="server" placeholder="Last Name" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="LastNameRequired" runat="server" ControlToValidate="LastName" ErrorMessage="Last Name is required" CssClass="message-failure" Display="Dynamic"></asp:RequiredFieldValidator>
                
                <asp:TextBox ID="Email" runat="server" placeholder="Email" CssClass="form-control" TextMode="Email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" ErrorMessage="Email is required" CssClass="message-failure" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="EmailValidator" runat="server" ControlToValidate="Email" ErrorMessage="Invalid email format" CssClass="message-failure" Display="Dynamic" ValidationExpression="^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$"></asp:RegularExpressionValidator>
                
                <asp:TextBox ID="Phone" runat="server" placeholder="Phone" CssClass="form-control" TextMode="Phone"></asp:TextBox>
                <asp:RequiredFieldValidator ID="PhoneRequired" runat="server" ControlToValidate="Phone" ErrorMessage="Phone is required" CssClass="message-failure" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="PhoneValidator" runat="server" ControlToValidate="Phone" ErrorMessage="Invalid phone number" CssClass="message-failure" Display="Dynamic" ValidationExpression="^\d{10}$"></asp:RegularExpressionValidator>
                
                <asp:TextBox ID="Amount" runat="server" placeholder="Amount" CssClass="form-control" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="AmountRequired" runat="server" ControlToValidate="Amount" ErrorMessage="Amount is required" CssClass="message-failure" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="AmountRangeValidator" runat="server" ControlToValidate="Amount" ErrorMessage="Amount must be between 1 and 10000" CssClass="message-failure" Display="Dynamic" MinimumValue="1" MaximumValue="10000" Type="Double"></asp:RangeValidator>
                
                <asp:DropDownList ID="DonateType" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Donate Type" Value="" Disabled="true" Selected="true"></asp:ListItem>
                    <asp:ListItem Text="Goods" Value="goods"></asp:ListItem>
                    <asp:ListItem Text="Money" Value="money"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="DonateTypeRequired" runat="server" ControlToValidate="DonateType" InitialValue="" ErrorMessage="Please select a donate type" CssClass="message-failure" Display="Dynamic"></asp:RequiredFieldValidator>
                
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
