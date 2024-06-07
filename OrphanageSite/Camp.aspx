<%@ Page Title="List of Camps" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Camp.aspx.cs" Inherits="OrphanageSite.Camp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>List of Camps</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        body {
            background-color: white;
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin: 35px auto;
            width: 90%; /* Increased width */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        .card-header {
            background-color: #55a458;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 1.5em;
            display: block; /* Ensure it is a block element */
        }
        .card-body {
            padding: 30px;
            overflow-x: auto; /* Ensure horizontal scrolling if content overflows */
        }
        hr {
            width: 50%;
            margin: auto;
        }
        .myGridStyle {
            width: 100%;
            border-collapse: collapse;
        }
        .myGridStyle th {
            background-color: #55a458;
            color: white;
            padding: 15px;
            text-align: left;
            border: 1px solid #ddd;
        }
        .myGridStyle td {
            padding: 15px;
            border: 1px solid #ddd;
        }
        .myGridStyle tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .myGridStyle tr:nth-child(odd) {
            background-color: white;
        }
        .myGridStyle tr:hover {
            background-color: #e1ffe1;
        }
        .centered-green-text {
            text-align: center;
            color: #55a458; /* Green color */
            display: block; /* Ensure it is a block element */
        }
    </style>
    <div class="container card">
        <h2 class="card-header centered-white-text">List of Camps</h2>
        <div class="card-body">
            <form id="form1" runat="server">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="myGridStyle">
                    <Columns>
                        <asp:BoundField DataField="CampName" HeaderText="CampName" SortExpression="CampName" />
                        <asp:BoundField DataField="StreetAddress" HeaderText="StreetAddress" SortExpression="StreetAddress" />
                        <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                        <asp:BoundField DataField="District" HeaderText="District" SortExpression="District" />
                        <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
                        <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" />
                        <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                        <asp:BoundField DataField="ContactInfo" HeaderText="ContactInfo" SortExpression="ContactInfo" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OrphanageSiteDBConnectionStringUser %>" ProviderName="<%$ ConnectionStrings:OrphanageSiteDBConnectionStringUser.ProviderName %>" SelectCommand="SELECT [CampName], [StreetAddress], [City], [District], [State], [Country], [Description], [ContactInfo] FROM [Camps]"></asp:SqlDataSource>
            </form>
        </div>
    </div>
</asp:Content>