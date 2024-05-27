<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ListSponsors.aspx.cs" Inherits="OrphanageSite.Admin.ListSponsors" %>
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
    <%--<div class="container card">
        <h2 class="card-header">Add New Contribution</h2>
        <div class="card-body">
        <form>
            <div class="mb-3">
                <label for="ContributorFirstName" class="form-label">First Name</label>
                <asp:TextBox ID="txtContributorFirstName" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="ContributorLastName" class="form-label">Last Name</label>
                <asp:TextBox ID="txtContributorLastName" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="ContributorEmail" class="form-label">Email</label>
                <asp:TextBox ID="txtContributorEmail" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="ContributorPhoneNumber" class="form-label">Phone Number</label>
                <asp:TextBox ID="txtContributorPhoneNumber" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="ContributionType" class="form-label">Contribution Type</label>
                <asp:DropDownList ID="ddlContributionType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlContributionType_SelectedIndexChanged">
                    <asp:ListItem Text="Select Contribution Type" Value=""></asp:ListItem>
                    <asp:ListItem Text="Money" Value="Money"></asp:ListItem>
                    <asp:ListItem Text="Goods" Value="Goods"></asp:ListItem>
                    <asp:ListItem Text="Services" Value="Services"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="mb-3" id="amountField" runat="server" visible="false">
                <label for="Amount" class="form-label">Amount</label>
                <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" TextMode="Number" />
            </div>
            <asp:Button ID="btnAddContribution" runat="server" Text="Add Contribution" CssClass="btn btn-primary" OnClick="btnAddContribution_Click" />
        </form>
        </div>
    </div>
        <hr /> --%>
    <div class="container card">
        <h2 class="card-header">List of Contributions</h2>
        <div class="card-body">
        <asp:GridView ID="gvContributions" runat="server" CssClass="table table-striped" AutoGenerateColumns="False" OnRowCommand="gvContributions_RowCommand">
            <Columns>
                <asp:BoundField DataField="ContributionID" HeaderText="Contribution ID" ReadOnly="True" />
                <asp:BoundField DataField="ContributorFirstName" HeaderText="First Name" />
                <asp:BoundField DataField="ContributorLastName" HeaderText="Last Name" />
                <asp:BoundField DataField="ContributorEmail" HeaderText="Email" />
                <asp:BoundField DataField="ContributorPhoneNumber" HeaderText="Phone Number" />
                <asp:BoundField DataField="ContributionType" HeaderText="Contribution Type" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" />
                <asp:BoundField DataField="ContributionDate" HeaderText="Contribution Date" DataFormatString="{0:MM/dd/yyyy}" />
                <asp:BoundField DataField="IsRegisteredMember" HeaderText="Is Anonymous" />
                <asp:BoundField DataField="SponsorshipReceived" HeaderText="Sponsorship Received" />
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button ID="btnToggleSponsorship" runat="server" Text='<%# Convert.ToBoolean(Eval("SponsorshipReceived")) ? "Mark as Not Received" : "Mark as Received" %>' CommandName="ToggleSponsorship" CommandArgument='<%# Eval("ContributionID") %>' CssClass="form-control btn btn-warning" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        </div>
    </div>
</asp:Content>
