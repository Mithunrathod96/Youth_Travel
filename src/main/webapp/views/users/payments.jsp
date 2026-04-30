<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payments | Youth Travel</title>
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
        .card-white { background: rgba(0,0,0,0.3); backdrop-filter: blur(15px); padding: 40px; border-radius: 20px; border: 1px solid rgba(255,255,255,0.1); box-shadow: 0 8px 32px 0 rgba(0,0,0,0.3); }
        .table { color: #fff; margin-bottom: 0; }
        .table th { color: #fff; font-size: 13px; font-weight: 800; text-transform: uppercase; border: none; text-shadow: 0 2px 4px rgba(0,0,0,0.8); letter-spacing: 1px; padding-bottom: 20px; }
        .table td { border-color: rgba(255,255,255,0.1); vertical-align: middle; padding: 18px 10px; font-weight: 500; text-shadow: 0 1px 3px rgba(0,0,0,0.5); }
        .status-badge { padding: 6px 14px; border-radius: 20px; font-size: 11px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.5px; border: 1px solid rgba(255,255,255,0.1); }
        .status-success { background: rgba(46, 125, 50, 0.2); color: #81c784; }
        .status-pending { background: rgba(239, 108, 0, 0.2); color: #ffb74d; }
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
            <jsp:param name="activePage" value="payments" />
        </jsp:include>
        <main class="main-content">
            <div class="mb-4">
                <div>
                    <h2 style="font-weight: 800; margin: 0; color: #fff; text-shadow: 0 4px 15px rgba(0,0,0,0.8); font-size: 32px;">Payment History</h2>
                    <p style="color: #fff; margin: 0; font-weight: 600; text-shadow: 0 2px 8px rgba(0,0,0,0.8);">Manage your transaction records</p>
                </div>
            </div>
            <div class="card-white">
                <c:choose>
                    <c:when test="${not empty payments}">
                        <div class="table-responsive">
                            <table class="table">
                                <thead><tr><th>Package</th><th>Amount</th><th>Status</th><th>Date</th></tr></thead>
                                <tbody>
                                    <c:forEach var="payment" items="${payments}">
                                        <tr>
                                            <td style="font-weight: 700;">${payment.booking.trip.title}</td>
                                            <td style="font-weight: 800; color: #ff4d4d; font-size: 16px;">₹${payment.amount}</td>
                                            <td><span class="status-badge status-${payment.status.toLowerCase()}">${payment.status}</span></td>
                                            <td>${payment.paymentDate}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center" style="padding: 60px;">
                            <i class="fa fa-credit-card" style="font-size: 60px; color: rgba(255,255,255,0.2); margin-bottom: 20px; display: block; text-shadow: 0 0 20px rgba(0,0,0,0.5);"></i>
                            <p style="color: #fff; font-weight: 700; font-size: 18px; text-shadow: 0 2px 5px rgba(0,0,0,0.8);">No payment records found.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
</body>
</html>
