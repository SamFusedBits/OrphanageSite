<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="OrphanageSite.UserDashboard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>User Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .page-title {
            text-align: center;
            font-size: 36px;
            color: #333;
            margin: 20px 0;
            font-weight: bold;
            margin-bottom: 30px;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 70px;
            background-color: #d2f6d2;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .image-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 30px 0;
        }
        .image-button-container {
            width: 45%;
            text-align: center;
        }
        .image-button-container img {
            width: 100%;
            max-width: 415px;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }
        .image-button-container img:hover {
            transform: scale(1.05);
        }
        .button {
            display: inline-block;
            width: 90%;
            background-color: #13f610;
            color: white;
            padding: 15px 0;
            margin-top: 15px;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #0b850b;
        }
        .stats-container {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        .stats-container div {
            width: 45%;
            text-align: center;
        }
        .stats-container p {
            font-size: 18px;
            color: #333;
            margin: 10px 0 0 0;
        }
        .or-text {
            font-size: 24px;
            color: #333;
            margin: 0 20px;
            font-weight: bold;
        }
        .camp-list {
            margin-top: 30px;
        }
        .camp-item {
            background-color: #ffffff;
            padding: 20px;
            margin: 10px 0;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: left;
        }
        .camp-item h3 {
            margin: 0;
            color: #333;
        }
        .camp-item p {
            margin: 5px 0;
            color: #666;
        }
         .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black */
            z-index: 1000; /* Ensure it's above other content */
            display: none; /* Initially hidden */
        }

        /* CSS for the donation form */
        #donationForm {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            z-index: 1001; /* Ensure it's above the overlay */
            width: 90%;
            max-width: 800px;
        }
        /* CSS for the donation form fields */
        #donationForm input[type="text"],
        #donationForm input[type="email"],
        #donationForm input[type="tel"],
        #donationForm input[type="number"],
        #donationForm select {
            width: 100%; /* Set width to 100% */
            padding: 10px; /* Adjust padding */
            margin-bottom: 10px; /* Adjust margin */
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        #donationForm button {
            width: 100%; /* Set width to 100% */
            padding: 15px; /* Adjust padding */
            background-color: #13f610;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px; /* Adjust margin */
        }

        #donationForm button:hover {
            background-color: #0b850b;
        }
        /* CSS for the adoption preferences form */
        #adoptionPreferencesForm {
            display: none;
            position: fixed;
            max-height:80%;
            top: 50%;
            left: 50%;
            overflow-y: auto;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            z-index: 1001; /* Ensure it's above the overlay */
            width: 90%;
            max-width: 800px;
        }

        #adoptionPreferencesForm input[type="text"],
        #adoptionPreferencesForm input[type="email"],
        #adoptionPreferencesForm input[type="tel"],
        #adoptionPreferencesForm input[type="number"],
        #adoptionPreferencesForm select,
        #adoptionPreferencesForm textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        #adoptionPreferencesForm button {
            width: 100%;
            padding: 15px;
            background-color: #13f610;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        #adoptionPreferencesForm button:hover {
            background-color: #0b850b;
        }
    </style>
</head>
<body>
    <div class="page-title">User Dashboard: Change Lives Today</div>
    <form id="form1" runat="server">
        <div class="container">
            <div class="image-container">
                <div class="image-button-container">
                    <img src="Assets/images/donation.jpg" alt="Donate Image" />
                    <asp:Button ID="BtnDonate" runat="server" Text="Donate" CssClass="button" OnClientClick="toggleDonationForm(); return false;" />
                    <p><strong>Total Contributions: </strong><asp:Label ID="lblTotalContributions" runat="server" Text=""></asp:Label></p>
                </div>
                <div class="or-text">OR</div>
                <div class="image-button-container">
                    <img src="Assets/images/adopt.png" alt="Adopt Image" />
                    <asp:Button ID="BtnAdopt" runat="server" Text="Adopt" CssClass="button" OnClientClick="toggleAdoptionForm(); return false;" />
                    <p><strong>Total Adoptions: </strong><asp:Label ID="lblAdoptionCount" runat="server" Text=""></asp:Label></p>
                </div>
            </div>
            <div class="camp-list">
                <asp:Repeater ID="rptCamps" runat="server">
                    <ItemTemplate>
                        <div class="camp-item">
                            <h3><%# Eval("Name") %></h3>
                            <p><b>Location:</b> <%# Eval("Location") %></p>
                            <p><b>Upcoming Events:</b> <%# Eval("UpcomingEvents") %></p>
                            <p><b>Contact Information:</b> <%# Eval("ContactInfo") %></p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="overlay" id="overlay"></div>
            <div id="donationForm" style="display: none; width: 70%; max-width: 600px; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);">
                <h2>Donation Form</h2>
                <input type="text" placeholder="First Name" id="txtFirstName" runat="server" style="width: 100%; padding: 10px; margin-bottom: 10px;" />
                <input type="text" placeholder="Last Name" id="txtLastName" runat="server" style="width: 100%; padding: 10px; margin-bottom: 10px;" />
                <input type="email" placeholder="Email" id="txtEmail" runat="server" style="width: 100%; padding: 10px; margin-bottom: 10px;" />
                <input type="tel" placeholder="Phone Number" id="txtPhoneNumber" runat="server" style="width: 100%; padding: 10px; margin-bottom: 10px;" />
                <input type="number" placeholder="Amount" id="txtAmount" runat="server" style="width: 100%; padding: 10px; margin-bottom: 10px;" />
                <select id="ddlContributionType" runat="server" style="width: 100%; padding: 10px; margin-bottom: 10px;">
                    <option value="Monetary">Monetary</option>
                    <option value="In-Kind">In-Kind</option>
                </select>
                <input type="checkbox" id="chkIsRegisteredMember" /> Is Registered Member
                <br />
                <asp:Button ID="BtnSubmitDonation" runat="server" Text="Submit Donation" CssClass="button" OnClick="BtnSubmitDonation_Click" />
            </div>

            <!-- Adoption Preferences Form -->
            <div id="adoptionPreferencesForm">
                <h2>Adoption Request Form</h2>
                <asp:Label ID="lblMessage" runat="server" Visible="False"></asp:Label>
    
                <h3>Select Child to Adopt</h3>
                <asp:DropDownList ID="ddlChildID" runat="server" CssClass="form-control"></asp:DropDownList>
    
                <asp:Button ID="BtnSubmitAdoption" runat="server" Text="Submit Adoption Request" CssClass="button" OnClick="BtnSubmitAdoption_Click" />
               
            </div>
            </div>
    </form>
    <!-- HTML Markup -->
    <div id="messageContainer" runat="server" style="display: none; text-align: center; padding: 10px; border-radius: 5px; margin-top: 20px;"></div>
    <footer style="text-align: center; padding: 10px; font-weight:bold">
        © HopeHaven.
    </footer>

<!-- Script to toggle the visibility of the overlay, donation and adoption form -->
    <script>
        function toggleDonationForm() {
            var overlay = document.getElementById('overlay');
            var form = document.getElementById('donationForm');

            if (overlay.style.display === 'none') {
                overlay.style.display = 'block';
                form.style.display = 'block';
                return true; // Return true to allow default action
            } else {
                overlay.style.display = 'none';
                form.style.display = 'none';
                return false; // Return false to prevent default action
            }
        }

        // Function to disable the "Is Registered Member" checkbox if the user is logged in
        window.onload = function () {
            var isUserLoggedIn = '<%= Session["LoggedInUser"] != null %>'; // Check if user is logged in
            var checkbox = document.getElementById('chkIsRegisteredMember');

            if (isUserLoggedIn) {
                checkbox.disabled = true; // Disable checkbox if user is logged in
            }
        };

        function toggleAdoptionForm() {
            var overlay = document.getElementById('overlay');
            var form = document.getElementById('adoptionPreferencesForm');

            if (overlay.style.display === 'none') {
                overlay.style.display = 'block';
                form.style.display = 'block';
            } else {
                overlay.style.display = 'none';
                form.style.display = 'none';
            }
        }
    </script>

</body>
</html>
