<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddCamp.aspx.cs" Inherits="OrphanageSite.Admin.AddCamp" %>
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
        <h2 class="card-header">Add New Camp</h2>
    <div class="card-body">
        <form>
            <div class="mb-3">
                <label for="CampName" class="form-label">Camp Name</label>
                <asp:TextBox ID="txtCampName" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="StreetAddress" class="form-label">Street Address</label>
                <asp:TextBox ID="txtStreetAddress" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="City" class="form-label">City</label>
                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="District" class="form-label">District</label>
                <asp:TextBox ID="txtDistrict" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="State" class="form-label">State</label>
                <asp:TextBox ID="txtState" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="Country" class="form-label">Country</label>
                <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="Description" class="form-label">Description</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" />
            </div>
            <div class="mb-3">
                <label for="ContactInfo" class="form-label">Contact Info</label>
                <asp:TextBox ID="txtContactInfo" runat="server" CssClass="form-control" />
            </div>
            <asp:Button ID="btnAddCamp" runat="server" Text="Add Camp" CssClass="form-control btn btn-primary" OnClick="btnAddCamp_Click" />
        </form>
        </div>
    </div>
        <hr />
    <div class="container card">
        <h2 class="card-header">List of Camps</h2>
        <div class="card-body">
        <asp:GridView ID="gvCamps" runat="server" CssClass="table table-striped" AutoGenerateColumns="False" OnRowCommand="gvCamps_RowCommand">
            <Columns>
                <asp:BoundField DataField="CampID" HeaderText="Camp ID" ReadOnly="True" />
                <asp:BoundField DataField="CampName" HeaderText="Camp Name" />
                <asp:BoundField DataField="StreetAddress" HeaderText="Street Address" />
                <asp:BoundField DataField="City" HeaderText="City" />
                <asp:BoundField DataField="District" HeaderText="District" />
                <asp:BoundField DataField="State" HeaderText="State" />
                <asp:BoundField DataField="Country" HeaderText="Country" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:BoundField DataField="ContactInfo" HeaderText="Contact Info" />
                <%--<asp:BoundField DataField="Status" HeaderText="Status" />--%>
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Button ID="btnToggleStatus" runat="server" Text='<%# Convert.ToBoolean(Eval("Status")) ? "Deactivate" : "Activate" %>' CommandName="ToggleStatus" CommandArgument='<%# Eval("CampID") %>' CssClass="btn btn-warning" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        </div>
    </div>
</asp:Content>
