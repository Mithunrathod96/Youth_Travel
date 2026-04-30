<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root { --primary-blue: #e63946; --text-muted: #7e8c9a; --transition: all 0.3s ease; }
        body { font-family: 'Dosis', sans-serif; background-color: #0b0f18; color: rgba(255, 255, 255, 0.92); margin: 0; padding: 0; }
        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: 240px; padding: 100px 30px 40px; }
        .header { position: fixed; top: 0; left: 0; right: 0; height: 70px; background: rgba(0,0,0,0.4); backdrop-filter: blur(10px); display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .booking-table { width: 100%; border-collapse: separate; border-spacing: 0 12px; }
        .booking-table th { color: #fff; font-weight: 800; text-transform: uppercase; font-size: 13px; padding: 15px 20px; border: none; text-shadow: 0 2px 4px rgba(0,0,0,0.8); letter-spacing: 1px; }
        .booking-table td { background: rgba(0,0,0,0.4); backdrop-filter: blur(10px); padding: 20px; border: 1px solid rgba(255,255,255,0.05); vertical-align: middle; color: #fff; text-shadow: 0 1px 3px rgba(0,0,0,0.5); }
        .booking-table td:first-child { border-radius: 15px 0 0 15px; border-right: none; }
        .booking-table td:last-child { border-radius: 0 15px 15px 0; border-left: none; }
        .status-badge { padding: 6px 14px; border-radius: 20px; font-size: 11px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.5px; border: 1px solid rgba(255,255,255,0.1); }
        .status-pending { background: rgba(245, 124, 0, 0.2); color: #ffb74d; }
        .status-confirmed { background: rgba(46, 125, 50, 0.2); color: #81c784; }
        .status-completed { background: rgba(139, 92, 246, 0.2); color: #a78bfa; }
    </style>
</head>
<body class="premium-theme">
    <!-- Sunlight Rays -->
    <div class="sun-rays-container">
        <div class="ray ray-1"></div>
        <div class="ray ray-2"></div>
        <div class="ray ray-3"></div>
        <div class="ray ray-4"></div>
    </div>
    <header class="header">
        <div class="header-logo"><a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" style="height: 35px;"></a></div>
        <div style="display: flex; align-items: center; gap: 20px;">
            <div style="display: flex; align-items: center; gap: 15px;">
                <span style="font-weight: 700;">Hi, ${user.name}</span>
                <c:set var="defaultAvatar" value="https://ui-avatars.com/api/?name=${user.name}&background=f04c26&color=fff" />
                <img src="${not empty user.profilePhoto ? user.profilePhoto : defaultAvatar}" style="width: 32px; height: 32px; border-radius: 50%; object-fit: cover;">
            </div>
        </div>
    </header>
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="bookings" />
        </jsp:include>
        <main class="main-content">
            <div class="container-fluid">
                <div class="mb-4">
                    <h2 style="font-weight: 800; margin: 0; color: #fff; text-shadow: 0 4px 15px rgba(0,0,0,0.8); font-size: 32px;">My Bookings</h2>
                    <p style="color: #fff; margin: 0; font-weight: 600; text-shadow: 0 2px 8px rgba(0,0,0,0.8);">View and manage your travel adventures</p>
                </div>
                <div class="card-white">
                    <c:choose>
                        <c:when test="${not empty bookings}">
                            <table class="booking-table">
                                <thead>
                                    <tr>
                                        <th>Package Name</th>
                                        <th>Travel Date</th>
                                        <th>Amount Paid</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="booking" items="${bookings}">
                                        <tr>
                                            <td style="font-weight: 700; font-size: 16px;">${booking.trip.title}</td>
                                            <td style="font-weight: 600;">${booking.selectedDate}</td>
                                            <td style="font-weight: 800; color: #ff4d4d; font-size: 18px;">₹${booking.totalPrice}</td>
                                            <td><span class="status-badge ${booking.status == 'Confirmed' ? 'status-confirmed' : booking.status == 'Completed' ? 'status-completed' : 'status-pending'}">${booking.status}</span></td>
                                            <td style="display: flex; gap: 10px;">
                                                <a href="<c:url value='/user/booking/${booking.id}/chat'/>" class="btn btn-sm" style="border-radius: 8px; background: var(--primary-blue); color: #fff; border: none;">
                                                    <i class="fa fa-comments"></i> Chat
                                                </a>
                                                <c:if test="${booking.status == 'Completed' && !booking.reviewed}">
                                                    <a href="<c:url value='/user/booking/${booking.id}/review'/>" class="btn btn-sm" style="border-radius: 8px; background: #f59e0b; color: #fff; border: none;">
                                                        <i class="fa fa-star"></i> Review
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div style="text-align: center; padding: 40px;">
                                <i class="fa fa-calendar-times-o" style="font-size: 50px; color: rgba(255,255,255,0.1); margin-bottom: 20px;"></i>
                                <h3 style="font-weight: 700;">No Bookings Found</h3>
                                <p style="color: var(--text-muted);">You haven't booked any trips yet. Start exploring now!</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
