<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="OrphanageSite.Admin.AdminDashboard" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <style>
        body {
            height: 100vh !important;
            width: 100vw;
        }
        .main{
            width: 100%;
            height: 100%;
            display: flow;
            margin: 0 auto;
            align-items: center;
            justify-content: center;
        }
        .cards1{
            min-width: 100% !important;
            margin: 20px auto;
            justify-content: center;
        }
        .card{
            text-align: center;
            justify-self: center;
        }
        .num-card{
            width: 30% !important;
        }
        .card-body{
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .cards2{
            min-width: 100% !important;
            margin: 20px auto;
            justify-content: center;
        }
        .graph-card{
            text-align: center;
            justify-self: center;
            min-height: 550px;
        }
        hr{
            border: 1px solid;
        }
        .ver{
            width: 0;
            padding: 0;
            height: 100%;
        }
    </style>
    <div class="conatainer main">
        <div class="container row cards1">
            <div class="card col-4 m-2 num-card">
                <div class="card-header">Registered Users</div>
                <div class="card-body">
                    <h1 class="card-title"><asp:Label ID="lblRegisteredUsers" runat="server" Text="0"></asp:Label></h1>
                </div>
            </div>
            <div class="card col-4 m-2 num-card">
                <div class="card-header">Children</div>
                <div class="card-body">
                    <h1 class="card-title"><asp:Label ID="lblChildren" runat="server" Text="0"></asp:Label></h1>
                </div>
            </div>
            <div class="card col-4 m-2 num-card">
                <div class="card-header">Camps</div>
                <div class="card-body row">
                    <div class="col">
                        <h1 class="card-title"><asp:Label ID="lblActiveCamps" runat="server" Text="0"></asp:Label></h1>
                        <p class="card-text">Active</p>
                    </div>
                    <hr class="ver" />
                    <div class="col">
                        <h1 class="card-title"><asp:Label ID="lblInactiveCamps" runat="server" Text="0"></asp:Label></h1>
                        <p class="card-text">Inactive</p>
                    </div>
                </div>
            </div>
        </div>


        <div class="container row cards2">
            <div class="card col-8 m-2 graph-card">
                <div class="card-header">Donation Graph</div>
                <div class="card-body">
                    <div class="card-title">
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OrphanageSiteDBConnectionStringUser %>" SelectCommand="SELECT MONTH(ContributionDate) AS Month, SUM(Amount) AS TotalDonation FROM Contributions WHERE (YEAR(ContributionDate) = YEAR(GETDATE())) GROUP BY MONTH(ContributionDate)"></asp:SqlDataSource>
                        <br />
                        <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" Palette="SeaGreen" CssClass="bar-graph" Height="450px" Width="600px">
                            <series>
                                <asp:Series Name="Series1" XValueMember="Month" YValueMembers="TotalDonation">
                                </asp:Series>
                            </series>
                            <chartareas>
                                <asp:ChartArea Name="ChartArea1">
                                </asp:ChartArea>
                            </chartareas>
                        </asp:Chart>
                    </div>
                </div>
            </div>
            <div class="card col-3 m-2 graph-card">
                <div class="card-header">Total Donation</div>
                <div class="card-body row">
                    <div class="row">
                        <h1 class="card-title"><asp:Label ID="lblMonthlyDonation" runat="server" Text="0"></asp:Label></h1>
                        <p class="card-text">Monthly</p>
                    </div>
                    <hr />
                    <div class="row">
                        <h1 class="card-title"><asp:Label ID="lblAnnualDonation" runat="server" Text="0"></asp:Label></h1>
                        <p class="card-text">Annual</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>