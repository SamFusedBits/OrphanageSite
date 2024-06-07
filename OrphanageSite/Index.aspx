<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="OrphanageSite.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hope Haven - A Haven for Children in Need</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }

        .hero {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 100px 20px;
            background-color: #ffffff;
        }

        .hero img {
            width: 700px;
            height: 300px;
            border-radius: 10px;
            object-fit: cover;
            margin-right: 20px;
            background-color:transparent;
        }

        .hero-content {
            text-align: center;
        }

        .hero h1 {
            font-size: 48px;
            color: #333;
        }

        .hero .explore-btn {
            padding: 15px 30px;
            font-size: 18px;
            border: none;
            background-color: #4CAF50;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }
        section {
            padding: 60px 20px;
            text-align: center;
        }

        .mission {
            background-color: #ffffff;
        }

        .mission h2 {
            font-size: 36px;
            color: #333;
        }

        .mission .stories {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .mission .stories div {
            background-color: #e0ffe0;
            padding: 20px;
            border-radius: 5px;
            width: 200px;
        }

        .commitments {
            background-color: #ffffff;
            display: flex;
            flex-direction: column;
            gap: 40px;
        }

        .commitment {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 20px;
        }

        .commitment:nth-child(odd) {
            flex-direction: row;
        }

        .commitment:nth-child(even) {
            flex-direction: row-reverse;
        }

        .commitment img {
            width: 600px;
            height: 350px;
            border-radius: 10px;
            object-fit: cover;
        }

        .commitment h3 {
            font-size: 24px;
            color: #333;
            margin: 0;
        }

        .commitment p {
            font-size: 16px;
            color: #666;
            margin: 0;
        }

        .stories h2 {
            font-size: 36px;
            color: #333;
        }

        .story-cards {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .card {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 5px;
            width: 250px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .card h3 {
            font-size: 20px;
            color: #333;
        }

        .card p {
            font-size: 16px;
            color: #666;
        }

        .card a {
            text-decoration: none;
            color: #4CAF50;
        }

        .join-us {
            background-color: #e0ffe0;
        }

        .join-us h2 {
            font-size: 36px;
            color: #333;
        }

        .join-us .join-btn {
            padding: 15px 30px;
            font-size: 18px;
            border: none;
            background-color: #4CAF50;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
        }

       .stories-of-hope {
            background-color: #ffffff;
            padding: 60px 20px;
            text-align: center;
        }

        .stories-of-hope h2 {
            font-size: 36px;
            color: #333;
        }

        .testimonials {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
        }

        .testimonial {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            width: 250px; /* Adjust the width as needed */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: left;
        }

        .testimonial .hearts {
            display: flex;
            justify-content: left;
            gap: 5px;
            margin-bottom: 10px;
        }

        .testimonial .hearts span {
            font-size: 24px;
            color: #ff0000;
        }

        .testimonial p {
            font-size: 16px;
            color: #666;
        }

        .testimonial .profile {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 15px;
        }

        .testimonial .profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .testimonial .profile div {
            display: flex;
            flex-direction: column;
        }

        .testimonial .profile span {
            font-size: 14px;
            color: #333;
        }

        .testimonial .profile .title {
            font-size: 12px;
            color: #999;
        }

        .connect {
            background-color: #ffffff;
            padding: 60px 20px;
            text-align: center;
        }

        .connect h2 {
            font-size: 36px;
            color: #333;
        }

        .social-icons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .social-icons a img {
            width: 40px;
            height: 40px;
        }
    </style>
<body>
<div class="hero">
    <img src="Assets/images/png-transparent-kids-playing.png" alt="Hero Image">
    <div class="hero-content">
        <h1>A haven for children in need</h1>
        <%--<button class="explore-btn">Explore more</button>--%>
    </div>
</div>
    <section class="mission">
        <h2>Bringing hope to young hearts</h2>
        <div class="stories">
            <div>
                <h3>Stories</h3>
                <p>Once there was a little orphan named Maya, who dreamed of a family to call her own. Despite the challenges she faced, Maya never lost hope. One day, her dream came true when a loving couple adopted her, giving her a forever home filled with love and laughter.y</p>
            </div>
            <div>
                <h3>Stories</h3>
                <p>When Raju was abandoned as a baby, he thought he would never experience love. However, his life changed when he was adopted by a caring family. With their love and support, Raju flourished and became a beacon of hope for other children in need, proving that love truly has the power to transform lives.</p>
            </div>
            <div>
                <h3>Stories</h3>
                <p>
                    Sarah grew up in an orphanage, where she discovered her passion for sports. Despite facing adversity, Sarah trained tirelessly and eventually represented her country in the Olympics. Her journey inspired countless others to believe in themselves and chase their dreams, no matter where they come from.
                </p>
            </div>
            <div>
                <h3>Stories</h3>
                <p>Samir had a difficult childhood, but he never gave up on his dreams. With determination and hard work, he overcame every obstacle in his path and went on to become a successful entrepreneur. Today, Samir uses his success to support orphanages, giving back to those who need a second chance, just like he once did.</p>
            </div>
        </div>
    </section>

    <section class="commitments">
        <div class="commitment">
            <img src="Assets/images/group.png" alt="Commitment 1 Image">
            <div>
                <h3>Compassionate and caring for every child</h3>
                <br />
                <p>We provide a safe haven by offering love, support, education, and hope.</p>
            </div>
        </div>
        <div class="commitment">
            <img src="Assets/images/group%20(1).png" alt="Commitment 2 Image">
            <div>
                <h3>Love is the answer</h3>
                <br />
                <p>Our belief in love drives us to create a nurturing environment for every child.</p>
            </div>
        </div>
        <div class="commitment">
            <img src="Assets/images/group%20(2).png" alt="Commitment 3 Image">
            <div>
                <h3>Brightening futures for all</h3>
                <br />
                <p>With love and support, we work to empower every child to achieve their potential.</p>
            </div>
        </div>
    </section>

    <section class="stories">
        <h2>Explore our stories</h2>
        <div class="story-cards">
            <div class="card">
                <h3>Inspiring resilience</h3>
                <p>Empowering kids to overcome obstacles and thrive.</p>
                <a href="#">Write</a>
            </div>
            <div class="card">
                <h3>Dreams come true</h3>
                <p>Nurturing dreams and turning them into reality.</p>
                <a href="#">Manage</a>
            </div>
            <div class="card">
                <h3>Balancing love and growth</h3>
                <p>Creating a home filled with love and personal growth.</p>
                <a href="#">Collaborate</a>
            </div>
        </div>
    </section>

    <section class="join-us">
        <h2>Join us in making a difference</h2>
        <button class="join-btn">Explore More</button>
    </section>

    <section class="stories-of-hope">
        <h2>Stories of Hope</h2>
        <div class="testimonials">
            <div class="testimonial">
                <div class="hearts">
                    <span>&#10084;</span>
                    <span>&#10084;</span>
                    <span>&#10084;</span>
                    <span>&#10084;</span>
                    <span>&#10084;</span>
                </div>
                <p>"This place is a sanctuary of love and hope. I'm grateful for the opportunity to be a part of this family."</p>
                <div class="profile">
                    <img src="Assets/images/circle-profile-pic_!.jpg" alt="Emily Johnson">
                    <div>
                        <span>Emily Johnson</span>
                        <span class="title">HopeHaven Foundation</span>
                    </div>
                </div>
            </div>
            <div class="testimonial">
                <div class="hearts">
                    <span>&#10084;</span>
                    <span>&#10084;</span>
                    <span>&#10084;</span>
                    <span>&#10084;</span>
                    <span>&#10084;</span>
                </div>
                <p>"A heartwarming experience filled with love and care. Truly a blessing to be here."</p>
                <div class="profile">
                    <img src="Assets/images/circle-profile-pic_3.jfif" alt="Michael Thompson">
                    <div>
                        <span>Michael Thompson</span>
                        <span class="title">Hopeful Foundation</span>
                    </div>
                </div>
            </div>
            <div class="testimonial">
                <div class="hearts">
                    <span>&#10084;</span>
                    <span>&#10084;</span>
                    <span>&#10084;</span>
                    <span>&#10084;</span>
                    <span>&#10084;</span>
                </div>
                <p>"Once you step into HopeHaven, you'll feel the warmth and love that defines us. A place like no other."</p>
                <div class="profile">
                    <img src="Assets/images/circle-profile-pic_2.jfif" alt="Sarah Adams">
                    <div>
                        <span>Sarah Adams</span>
                        <span class="title">Hopeful Foundation</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="connect">
        <h2>Connect with our community</h2>
        <div class="social-icons">
            <a href="#"><img src="Assets/images/icon1.png" alt="Icon 1"></a>
            <a href="#"><img src="Assets/images/icon2.png" alt="Icon 2"></a>
            <a href="#"><img src="Assets/images/icon3.png" alt="Icon 3"></a>
            <a href="#"><img src="Assets/images/icon4.png" alt="Icon 4"></a>
            <a href="#"><img src="Assets/images/icon5.png" alt="Icon 5"></a>
            <a href="#"><img src="Assets/images/icon6.png" alt="Icon 6"></a>
        </div>
    </section>
</body>
</asp:Content>
