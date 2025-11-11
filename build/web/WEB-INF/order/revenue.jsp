<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        border-bottom: 2px solid #FFA500; /* Đổi sang cam */
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
        border-color: #FFA500; /* Đổi sang cam */
        outline: none;
        box-shadow: 0 0 5px rgba(255, 165, 0, 0.3); /* Đổi sang cam */
    }

    /* Style for the button */
    .revenue-info button {
        width: 100%;
        padding: 12px;
        background-color: #FFA500; /* Đổi sang cam */
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
        background-color: #E69500; /* Đổi sang cam đậm */
    }

    /* Add some spacing for the chart column */
    .chart-container {
        padding: 20px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    
    .chart-container h2 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
        font-size: 20px;
    }
    
    .revenue-display {
        background-color: #FFA500; /* Đổi sang cam */
        color: white;
        padding: 15px;
        border-radius: 8px;
        margin-top: 15px;
        text-align: center;
        font-size: 18px;
        font-weight: bold;
    }
    
    .revenue-display .amount {
        font-size: 24px;
        margin-top: 8px;
    }
</style>

<form action="<c:url value="/order/revenue.do" />">
    <div class="row">
        <div class="col-md-4">
            <div class="revenue-info">
                <h1>Revenue Information</h1>

                <p>Select Date:</p>
                <input type="date" name="selectedDate" value="${param.selectedDate}" required/><br/>
                
                <button type="submit">Check Revenue</button>
                
                <c:if test="${not empty dailyRevenue}">
                    <div class="revenue-display">
                        <div>Total Revenue</div>
                        <div class="amount">
                            <fmt:formatNumber value="${dailyRevenue}" type="currency" currencySymbol="$" maxFractionDigits="0"/>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
        <div class="col-md-8 chart-container">
            <h2>Revenue Chart (Last 7 Days)</h2>
            <canvas id="weeklyRevenueChart" style="max-height: 400px;"></canvas>
        </div>
    </div> 
</form>

<script>
    const ctx = document.getElementById('weeklyRevenueChart').getContext('2d');
    let weeklyRevenue = ${weeklyRevenueJson != null ? weeklyRevenueJson : '[]'};
    let weeklyLabels = ${weeklyLabelsJson != null ? weeklyLabelsJson : '[]'};
    
    console.log('weeklyRevenue:', weeklyRevenue);
    console.log('weeklyLabels:', weeklyLabels);
    
    // Filter out days with 0 revenue
    let filteredRevenue = [];
    let filteredLabels = [];
    
    for (let i = 0; i < weeklyRevenue.length; i++) {
        if (weeklyRevenue[i] > 0) {
            filteredRevenue.push(weeklyRevenue[i]);
            filteredLabels.push(weeklyLabels[i]);
        }
    }
    
    // If no data, show empty chart
    if (filteredRevenue.length === 0) {
        filteredRevenue = [0];
        filteredLabels = ['No Data'];
    }
    
    // Convert to thousands (K)
    // If value is already in thousands (< 10000), use as is
    // If value is in VND (>= 10000), divide by 1000
    const revenueInThousands = filteredRevenue.map(val => {
        if (val >= 10000) {
            // Value is in VND, convert to thousands
            return (val / 1000).toFixed(2);
        } else {
            // Value is already in thousands or dollars
            return parseFloat(val).toFixed(2);
        }
    });
    
    console.log('Filtered Revenue:', filteredRevenue);
    console.log('Filtered Labels:', filteredLabels);
    console.log('revenueInThousands:', revenueInThousands);

    const chart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: filteredLabels,
            datasets: [{
                label: 'Revenue (Thousand $)',
                data: revenueInThousands,
                backgroundColor: 'rgba(255, 165, 0, 0.7)', /* Đổi sang cam */
                borderColor: 'rgba(255, 165, 0, 1)', /* Đổi sang cam */
                borderWidth: 2,
                borderRadius: 5,
                barThickness: 60
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            scales: {
                y: {
                    beginAtZero: true,
                    max: 7000,
                    ticks: {
                        stepSize: 500,
                        callback: function(value) {
                            return value + 'K';
                        }
                    },
                    title: {
                        display: true,
                        text: 'Revenue (Thousand $)',
                        font: {
                            size: 14,
                            weight: 'bold'
                        }
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: 'Date',
                        font: {
                            size: 14,
                            weight: 'bold'
                        }
                    }
                }
            },
            plugins: {
                legend: {
                    display: true,
                    position: 'top'
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return 'Revenue: $' + context.parsed.y + 'K';
                        }
                    }
                }
                /* Đã xóa đoạn 'datalabels' bị lỗi/conflict ở đây */
            }
        },
        plugins: [{
            afterDatasetsDraw: function(chart) {
                const ctx = chart.ctx;
                chart.data.datasets.forEach(function(dataset, i) {
                    const meta = chart.getDatasetMeta(i);
                    if (!meta.hidden) {
                        meta.data.forEach(function(element, index) {
                            ctx.fillStyle = '#333';
                            const fontSize = 12;
                            const fontStyle = 'bold';
                            const fontFamily = 'Arial';
                            ctx.font = fontStyle + ' ' + fontSize + 'px ' + fontFamily;
                            
                            const dataString = '$' + dataset.data[index] + 'K';
                            ctx.textAlign = 'center';
                            ctx.textBaseline = 'bottom';
                            
                            const padding = 5;
                            const position = element.tooltipPosition();
                            ctx.fillText(dataString, position.x, position.y - padding);
                        });
                    }
                });
            }
        }]
    });
</script>