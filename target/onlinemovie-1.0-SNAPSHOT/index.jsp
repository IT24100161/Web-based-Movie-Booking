<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to Movie World</title>

    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Roboto&display=swap" rel="stylesheet">

    <style>
        html, body {
            height: 100%;
            margin: 0;
            font-family: 'Roboto', sans-serif;
        }

        body {
            /* ✅ Background image using your new Insider link */
            background-image: url('https://i.insider.com/5a256d413dbef48d0e8b9b4f?width=1200&format=jpeg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;

            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            text-align: center;
            color: white;
            text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.7);
        }

        .title {
            font-family: 'Playfair Display', serif;
            font-size: 60px;
            font-weight: bold;
        }

        .subtitle {
            font-size: 22px;
            margin-top: 15px;
            margin-bottom: 30px;
        }

        .btn-custom {
            font-size: 18px;
            padding: 12px 30px;
            border-radius: 30px;
            background-color: #ff6f61;
            color: white;
            border: none;
            text-decoration: none;
            transition: 0.3s;
        }

        .btn-custom:hover {
            background-color: #e65b4e;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="title">🎬 Welcome to Movie World 🎥</div>
<div class="subtitle">
    Explore the magic of cinema. Discover, manage, and enjoy movies like never before!
</div>
<a href="movieDisplay.jsp" class="btn btn-custom">Continue</a>

</body>
</html>
