<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Customer Reviews | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root { --primary-blue: #f04c26; --transition: all 0.3s ease; }
        body.yt-dark { background: transparent; color: #fff; font-family: 'Dosis', sans-serif; }

        .review-card {
            background: rgba(0,0,0,0.4);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 24px;
            padding: 35px;
            margin-bottom: 25px;
            transition: var(--transition);
            box-shadow: 0 8px 32px 0 rgba(0,0,0,0.3);
        }

        .review-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.05);
        }

        .stars { color: #f59e0b; font-size: 18px; margin-bottom: 10px; }
        
        .reviewer-info {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        .reviewer-info img {
            width: 50px; height: 50px; border-radius: 50%; object-fit: cover;
        }

        .trip-tag {
            background: rgba(240, 76, 38, 0.1);
            color: #f04c26;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            display: inline-block;
            margin-bottom: 15px;
        }
    </style>
</head>

<body class="yt-dark premium-theme">
    <div class="sun-rays-container">
        <div class="ray ray-1"></div>
        <div class="ray ray-2"></div>
        <div class="ray ray-3"></div>
        <div class="ray ray-4"></div>
    </div>
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="reviews" />
    </jsp:include>

    <!-- Main Content -->
    <div class="main-content">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px;">
            <div>
                <h2 style="font-weight: 800; margin: 0; font-size: 38px; color: #fff; text-shadow: 0 4px 15px rgba(0,0,0,0.8);">Customer Reviews</h2>
                <p style="color: #fff; margin-top: 5px; font-weight: 600; text-shadow: 0 2px 8px rgba(0,0,0,0.8);">See what your travelers are saying about your trips.</p>
            </div>
            <div style="text-align: right;">
                <div style="font-size: 42px; font-weight: 800; color: #f59e0b; text-shadow: 0 2px 15px rgba(245, 158, 11, 0.3);">
                    <i class="fa fa-star"></i> 4.8
                </div>
                <div style="color: #fff; font-size: 14px; font-weight: 700; text-shadow: 0 2px 5px rgba(0,0,0,0.5);">Average Rating</div>
            </div>
        </div>

        <div class="row">
            <c:forEach var="review" items="${reviews}">
                <div class="col-md-6 mb-4">
                    <div class="review-card">
                        <div class="trip-tag"><i class="fa fa-map-marker"></i> ${review.trip.title}</div>
                        <div class="reviewer-info">
                            <img src="https://ui-avatars.com/api/?name=${review.user.name}&background=random">
                            <div>
                                <div style="font-weight: 800; font-size: 20px; color: #fff; text-shadow: 0 2px 5px rgba(0,0,0,0.5);">${review.user.name}</div>
                                <div style="color: #fff; font-size: 13px; font-weight: 600; text-shadow: 0 1px 3px rgba(0,0,0,0.5);">${review.createdAt.toLocalDate()}</div>
                            </div>
                        </div>
                        <div class="stars">
                            <c:forEach begin="1" end="${review.rating}">
                                <i class="fa fa-star"></i>
                            </c:forEach>
                            <c:forEach begin="1" end="${5 - review.rating}">
                                <i class="fa fa-star-o" style="color: rgba(255,255,255,0.2);"></i>
                            </c:forEach>
                        </div>
                        <p style="color: #fff; line-height: 1.6; font-size: 16px; font-weight: 500; text-shadow: 0 1px 3px rgba(0,0,0,0.5); font-style: italic;">
                            "${review.reviewText}"
                        </p>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty reviews}">
                <div class="col-12 text-center" style="padding: 80px 20px;">
                    <i class="fa fa-star-half-o" style="font-size: 60px; color: rgba(255,255,255,0.1); margin-bottom: 20px;"></i>
                    <h3 style="font-weight: 700; color: #fff;">No Reviews Yet</h3>
                    <p style="color: rgba(255,255,255,0.4);">Once travelers complete their trips and leave feedback, it will appear here.</p>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>