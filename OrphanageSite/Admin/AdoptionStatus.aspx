<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdoptionStatus.aspx.cs" Inherits="OrphanageSite.Admin.AdoptionStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .container{
            margin: 35px auto;
        }
        .card-body{
            padding: 20px;
        }
        hr{
            width: 50%;
            margin: auto;
        }
        .pending {
            color: red;
            font-weight: bold;
        }
        .approved {
            color: green;
            font-weight: bold;
        }
        .declined {
            color: grey;
            font-weight: bold;
        }
    </style>
    <div class="container mt-5 card">
            <h2 class="card-header">Adoption Status</h2>
            <div class="card-body">
                <asp:GridView ID="GridViewAdoptions" runat="server" AutoGenerateColumns="False" CssClass="table table-striped">
                    <Columns>
                        <asp:BoundField DataField="AdoptionID" HeaderText="Adoption ID" />
                        <asp:BoundField DataField="ChildID" HeaderText="Child ID" />
                        <asp:BoundField DataField="ChildFirstName" HeaderText="Child First Name" />
                        <asp:BoundField DataField="ChildLastName" HeaderText="Child Last Name" />
                        <asp:BoundField DataField="UserID" HeaderText="User ID" />
                        <asp:BoundField DataField="UserFirstName" HeaderText="User First Name" />
                        <asp:BoundField DataField="UserLastName" HeaderText="User Last Name" />
                        <asp:BoundField DataField="AdoptionDate" HeaderText="Adoption Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") == DBNull.Value ? "Pending" : (bool)Eval("Status") ? "Approved" : "Declined" %>' 
                                           CssClass='<%# Eval("Status") == DBNull.Value ? "pending" : (bool)Eval("Status") ? "approved" : "declined" %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnApprove" runat="server" Text="Approve" CommandArgument='<%# Eval("AdoptionID") %>' OnClick="btnApprove_Click" CssClass="btn btn-success" />
                                <asp:Button ID="btnDecline" runat="server" Text="Decline" CommandArgument='<%# Eval("AdoptionID") %>' OnClick="btnDecline_Click" CssClass="btn btn-danger" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
</asp:Content>
