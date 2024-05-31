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
                <h2>Adoption Preferences Form</h2>
                <h3>Personal Information</h3>
                <input type="text" placeholder="Full Name" id="txtFullName" runat="server" />
                <input type="email" placeholder="Email Address" id="txtEmailAdopt" runat="server" />
                <input type="tel" placeholder="Phone Number" id="txtPhoneAdopt" runat="server" />
                <input type="text" placeholder="City" id="txtCity" runat="server" />
                <input type="text" placeholder="State/Province" id="txtState" runat="server" />
                <input type="text" placeholder="Postal/ZIP Code" id="txtPostalCode" runat="server" />
                
                <h3>Child Preferences</h3>
                <label>Preferred Gender</label>
                <select id="ddlPreferredGender" runat="server">
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="No Preference">No Preference</option>
                </select>
                <label>Preferred Age Range</label>
                <select id="ddlAgeRange" runat="server">
                    <option value="0-2 years">0-2 years</option>
                    <option value="3-5 years">3-5 years</option>
                    <option value="6-8 years">6-8 years</option>
                    <option value="9-12 years">9-12 years</option>
                    <option value="13-18 years">13-18 years</option>
                    <option value="No Preference">No Preference</option>
                </select>
                <input type="number" placeholder="Number of Children to Adopt" id="txtNumberOfChildren" runat="server" />
                <label>Health Considerations</label>
                <select id="ddlHealthConsiderations" runat="server">
                    <option value="Healthy Child">Healthy Child</option>
                    <option value="Child with Special Needs">Child with Special Needs</option>
                    <option value="No Preference">No Preference</option>
                </select>
                
                <h3>Background and Lifestyle Information</h3>
                <input type="text" placeholder="Primary Language Spoken at Home" id="txtPrimaryLanguage" runat="server" />
                <label>Religion (if applicable, and whether you prefer a child of the same religion)</label>
                <select id="ddlReligion" runat="server">
                    <option value="Yes">Yes</option>
                    <option value="No">No</option>
                    <option value="No Preference">No Preference</option>
                </select>
                
                <h3>Parenting Style and Support</h3>
                <textarea placeholder="Parenting Style Description" id="txtParentingStyle" runat="server"></textarea>
                <label>Education Plans for the Child</label>
                <select id="ddlEducationPlans" runat="server">
                    <option value="Public School">Public School</option>
                    <option value="Private School">Private School</option>
                    <option value="Homeschooling">Homeschooling</option>
                    <option value="No Preference">No Preference</option>
                </select>
                
                <h3>Motivations and Additional Information</h3>
                <textarea placeholder="Reason for Adopting" id="txtReasonForAdopting" runat="server"></textarea>
                <textarea placeholder="Previous Adoption Experience (if any)" id="txtPreviousExperience" runat="server"></textarea>
                <textarea placeholder="How did you learn about our NGO?" id="txtLearnAboutNGO" runat="server"></textarea>
                <textarea placeholder="Any Other Relevant Information" id="txtOtherInformation" runat="server"></textarea>
                
                <asp:Button ID="BtnSubmitAdoption" runat="server" Text="Submit Adoption Preferences" CssClass="button" OnClick="BtnSubmitAdoption_Click" />
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

        function submitDonation() {
            // Retrieve form data
            var firstName = document.getElementById('txtFirstName').value;
            var lastName = document.getElementById('txtLastName').value;
            var email = document.getElementById('txtEmail').value;
            var phoneNumber = document.getElementById('txtPhoneNumber').value;
            var amount = document.getElementById('txtAmount').value;
            var contributionType = document.getElementById('ddlContributionType').value;
            var isRegisteredMember = document.getElementById('chkIsRegisteredMember').checked;

            // Create an HTML form element
            var form = document.createElement('form');
            form.setAttribute('method', 'post');
            form.setAttribute('action', 'SaveDonation');

            // Create hidden input fields to hold form data
            var firstNameInput = document.createElement('input');
            firstNameInput.setAttribute('type', 'hidden');
            firstNameInput.setAttribute('name', 'FirstName');
            firstNameInput.setAttribute('value', firstName);
            form.appendChild(firstNameInput);

            var lastNameInput = document.createElement('input');
            lastNameInput.setAttribute('type', 'hidden');
            lastNameInput.setAttribute('name', 'LastName');
            lastNameInput.setAttribute('value', lastName);
            form.appendChild(lastNameInput);

            // Repeat the process for other form fields...

            var emailInput = document.createElement('input');
            emailInput.setAttribute('type', 'hidden');
            emailInput.setAttribute('name', 'Email');
            emailInput.setAttribute('value', email);
            form.appendChild(emailInput);

            var phoneNumberInput = document.createElement('input');
            phoneNumberInput.setAttribute('type', 'hidden');
            phoneNumberInput.setAttribute('name', 'PhoneNumber');
            phoneNumberInput.setAttribute('value', phoneNumber);
            form.appendChild(phoneNumberInput);

            var amountInput = document.createElement('input');
            amountInput.setAttribute('type', 'hidden');
            amountInput.setAttribute('name', 'Amount');
            amountInput.setAttribute('value', amount);
            form.appendChild(amountInput);

            var contributionTypeInput = document.createElement('input');
            contributionTypeInput.setAttribute('type', 'hidden');
            contributionTypeInput.setAttribute('name', 'ContributionType');
            contributionTypeInput.setAttribute('value', contributionType);
            form.appendChild(contributionTypeInput);

            var isRegisteredMemberInput = document.createElement('input');
            isRegisteredMemberInput.setAttribute('type', 'hidden');
            isRegisteredMemberInput.setAttribute('name', 'IsRegisteredMember');
            isRegisteredMemberInput.setAttribute('value', isRegisteredMember);
            form.appendChild(isRegisteredMemberInput);

            // Append the form to the document body and submit it
            document.body.appendChild(form);
            form.submit();
        }
    </script>

</body>
</html>
