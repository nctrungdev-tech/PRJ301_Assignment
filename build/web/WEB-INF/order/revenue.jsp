<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
    /* Style for the left column */
    .revenue-info {
        background-color: #f9f9f9;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        height: fit-content;
    }

    /* Style for the heading */
    .revenue-info h1 {
        font-size: 24px;
        color: #333;
        margin-bottom: 20px;
        border-bottom: 2px solid #744DA9;
        padding-bottom: 10px;
    }

    /* Style for paragraphs (labels) */
    .revenue-info p {
        font-size: 16px;
        color: #555;
        margin: 10px 0 5px;
        font-weight: 500;
    }

    /* Style for date inputs */
    .revenue-info input[type="date"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        color: #333;
        background-color: #fff;
        transition: border-color 0.3s ease;
    }

    /* Add hover/focus effect for inputs */
    .revenue-info input[type="date"]:hover,
    .revenue-info input[type="date"]:focus {
        border-color: #744DA9;
        outline: none;
        box-shadow: 0 0 5px rgba(255, 77, 79, 0.3);
    }

    /* Style for the button */
    .revenue-info button {
        width: 100%;
        padding: 12px;
        background-color: #744DA9;
        color: #fff;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    /* Hover effect for the button */
    .revenue-info button:hover {
        background-color: #e63946;
    }

    /* Add some spacing for the chart column */
    .chart-container {
        padding: 20px;
    }
</style>

<form action="<c:url value="/order/revenue.do" />">
    <div class="row">
        <div class="col-md-4">
            <div class="revenue-info">
                <h1>Thông Tin Doanh Thu</h1>

                <p>Tổng doanh thu ngày: ${dailyRevenue}</p>
                <input type="date" name="dailyRevenue" value="${param.dailyRevenue}"/><br/>

                <p>Tổng doanh thu tháng: ${monthlyRevenue}</p>
                <input type="date" name="monthlyRevenue" value="${param.monthlyRevenue}"/><br/>

                <p>Tổng doanh thu năm: ${yearlyRevenue}</p>
                <input type="date" name="yearlyRevenue" value="${param.yearlyRevenue}"/><br/>

                <p>Doanh thu 7 ngày kể từ ngày: </p>
                <input type="date" id="weeklyDate" name="weeklyRevenue" value="${param.weeklyRevenue}"/><br/>
                <button type="submit">Screen</button>
            </div>
        </div>
        <div class="col-md-8 chart-container">
            <canvas id="weeklyRevenueChart"></canvas>
        </div>
    </div> 
</form>

<script>
    const ctx = document.getElementById('weeklyRevenueChart').getContext('2d');
    let weeklyRevenue = ${weeklyRevenue != null ? weeklyRevenue : '[]'};
    if (weeklyRevenue.length === 0) {
        weeklyRevenue = [0, 0, 0, 0, 0, 0, 0]; // Fallback to zeros if no data
    }
    console.log('weeklyRevenue:', weeklyRevenue); // Debug
    const labels = ['Ngày chọn', '1 ngày trước', '2 ngày trước', '3 ngày trước', '4 ngày trước', '5 ngày trước', '6 ngày trước'];

    const chart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                    label: 'Doanh Thu',
                    data: weeklyRevenue,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>