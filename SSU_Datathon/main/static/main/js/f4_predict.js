document.addEventListener("DOMContentLoaded", async function () {

    const locationSelect = document.getElementById("locationSelect");
    const contentTab = document.querySelector(".content-tab");
    const bookNumInput = document.getElementById("bookNum");
    const bookYearInput = document.getElementById("bookYear");
    const predictButton = document.querySelector(".predict-button"); // 예측하기 버튼
    const detailsButton = document.querySelector(".details-button"); // 자세히 보기 버튼
    const icon = document.querySelector(".icon-box img");
    const noDataText = document.getElementById("noDataText");
    const chartCanvas = document.getElementById("myChart");
    const chartLegend = document.getElementById("custom-legend");
    const chartContainer = document.querySelector(".content-box");
    let chartInstance = null; // 차트 인스턴스 저장 변수

    // 드롭다운 기본값을 4층인문으로 설정
    locationSelect.value = "4층인문";

    // 시작 시 loadData 실행 (초기 데이터 로드)
    await loadData(locationSelect.value);

    // 드롭다운 값이 변경될 때 content-tab 업데이트 및 데이터 로드
    locationSelect.addEventListener("change", async function () {
        contentTab.textContent = locationSelect.value;
        await loadData(locationSelect.value);
    });

    // 도서 수량 입력 시 자동으로 천 단위 콤마 추가
    bookNumInput.addEventListener("input", function (event) {
        let value = event.target.value.replace(/,/g, ""); // 기존 콤마 제거
        if (!isNaN(value) && value !== "") {
            event.target.value = Number(value).toLocaleString(); // 숫자를 천 단위로 포맷
        } else {
            event.target.value = ""; // 숫자가 아닌 값이면 지움
        }
    });

    // 데이터 연도 입력 시 숫자가 아닌 값이면 자동 삭제
    bookYearInput.addEventListener("input", function (event) {
        let value = event.target.value.replace(/\D/g, ""); // 숫자가 아닌 문자 제거
        event.target.value = value;
    });

    // "자세히 보기" 버튼 초기 비활성화
    detailsButton.classList.add("disabled");

    // "예측하기" 버튼 클릭 시 "자세히 보기" 버튼 활성화 & 데이터 전송
    predictButton.addEventListener("click", async function () {
        const selectedLocation = locationSelect.value;
        const bookQuantity = bookNumInput.value.replace(/,/g, ""); // 콤마 제거한 숫자 값
        const bookYear = bookYearInput.value;

        if (!bookQuantity || !bookYear) {
            alert("도서 수량과 데이터 연도를 입력해주세요.");
            return;
        }

        const requestData = {
            location: selectedLocation,
            quantity: bookQuantity,
            year: bookYear
        };

        console.log(requestData);

        try {
            const response = await fetchWithLoading(PREDICT_BOOK, {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': getCookie("csrftoken"),
                },
                body: JSON.stringify(requestData)
            });

            const result = await response.json();

            if (result.data && result.data.length === 10) {
                drawHorizontalBarChart(result.data);
                detailsButton.classList.remove("disabled"); // "자세히 보기" 버튼 활성화
            } else {
                showNoData();
            }
        } catch (error) {
            showNoData();
        }
    });

    // **데이터 로드 함수**
    async function loadData(selectedLocation) {
        try {
            const response = await fetchWithLoading(LOAD_DATA, {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': getCookie("csrftoken"),
                },
                body: JSON.stringify({ location: selectedLocation })
            });

            const result = await response.json();
            parsedData = JSON.parse(result.data);
            console.log(parsedData);
            console.log(parsedData.length);

            if (parsedData && parsedData.length === 10) {
                drawHorizontalBarChart(parsedData);
            } else {
                showNoData();
            }
        } catch (error) {
            showNoData();
        }
    }

    // **데이터가 없을 경우 기본 화면 유지**
    function showNoData() {
        noDataText.style.display = "block"; // "데이터 없음" 표시
        chartCanvas.style.display = "none"; // 차트 숨기기
        chartLegend.classList.add("hide");     // 범례 숨기기
        icon.style.display = "block"; // 아이콘 표시
        if (chartInstance) chartInstance.destroy();
        chartContainer.querySelectorAll("table").forEach(el => el.remove());
    }

    // **가로 막대 그래프 생성 함수**
    function drawHorizontalBarChart(data) {
        clearChartOrTable(); // 기존 차트 초기화
    
        chartCanvas.style.display = "block"; // 차트 표시
        chartLegend.classList.remove("hide");     // 범례 숨기기
        icon.style.display = "none"; // 아이콘 숨기기
        noDataText.style.display = "none"; // "데이터 없음" 숨기기
    
        // 막대 색상 배열
        const backgroundColors = [
            "#19aa51", "#D61A30", "#999798", "#FF7F20", "#5A4637",
            "#1EB0FF", "#FFD525", "#8BD529", "#2C51B2", "#8121C2"
        ];
    
        // 레이블 배열
        const labels = [
            "총류", "철학", "종교", "사회과학", "자연과학",
            "기술과학", "예술", "언어", "문학", "역사"
        ];
    
        // 분류 코드와 매칭되는 레이블
        const labelMap = {
            '총류': '000',
            '철학': '100',
            '종교': '200',
            '사회과학': '300',
            '자연과학': '400',
            '기술과학': '500',
            '예술': '600',
            '언어': '700',
            '문학': '800',
            '역사': '900'
        };
    
        const ctx = chartCanvas.getContext("2d");
    
        chartInstance = new Chart(ctx, {
            type: "bar",
            data: {
                labels: labels,  // 레이블 설정
                datasets: [{
                    label: "대분류 데이터",
                    data: data,
                    backgroundColor: backgroundColors,  // 막대별 색상 적용
                    borderColor: backgroundColors, // 테두리 색상도 동일 적용
                    borderWidth: 1
                }]
            },
            options: {
                indexAxis: 'y', // 가로 방향 막대 그래프 설정
                responsive: true,
                maintainAspectRatio: false, // 비율 유지 비활성화 (화면 크기에 맞추기)
                scales: {
                    x: {
                        beginAtZero: true,
                        suggestedMax: Math.max(...data) * 1.25, // 최대값 확장 (1.2배)
                        grid: { display: false }, // 배경 격자 제거
                        ticks: { display: false } // x축 레이블 제거
                    },
                    y: {
                        grid: { display: false }, // 배경 격자 제거
                        ticks: { display: false } // y축 레이블 제거
                    }
                },
                plugins: {
                    legend: {
                        display: false // 기본 범례 제거 (우리는 HTML 범례 사용)
                    },
                    tooltip: {
                        enabled: true,
                        bodyFont: { size: 16 },
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.raw ? context.raw.toLocaleString() : '0';
                                const desc = labelMap[label] || '';  // 매핑된 분류명
                                return [` ${desc} ${label}`, `  ${value}권`];
                            }
                        }
                    }
                }
            }
        });
    
        // ✅ HTML 범례 업데이트
        updateCustomLegend();
    }
    
    // ✅ **HTML 범례 동적 생성 (CSS grid에 맞춰 자동 정렬)**
    function updateCustomLegend() {
        console.log(1)
        const labelMap = {
            '총류': '000',
            '철학': '100',
            '종교': '200',
            '사회과학': '300',
            '자연과학': '400',
            '기술과학': '500',
            '예술': '600',
            '언어': '700',
            '문학': '800',
            '역사': '900'
        };
        //const legendContainer = document.getElementById("custom-legend");
        chartLegend.innerHTML = ""; // 기존 범례 제거
        //chartLegend.style.display = "block";
    
        chartInstance.data.labels.forEach((label, index) => {
            const legendItem = document.createElement("div");
            legendItem.classList.add("legend-item");
    
            // ✅ 색상 아이콘 추가
            const colorBox = document.createElement("span");
            colorBox.classList.add("color-box");
            colorBox.style.backgroundColor = chartInstance.data.datasets[0].backgroundColor[index];
    
            // ✅ 범례 텍스트 추가
            const textNode = document.createTextNode(` ${labelMap[label]} ${label}`);
    
            // ✅ 범례 아이템 구성
            legendItem.appendChild(colorBox);
            legendItem.appendChild(textNode);
            chartLegend.appendChild(legendItem);
        });
    }

    // **차트/테이블 초기화 함수**
    function clearChartOrTable() {
        if (chartInstance) chartInstance.destroy();
        chartContainer.querySelectorAll("table").forEach(el => el.remove());
    }
});

// **CSRF 토큰 가져오기 함수**
function getCookie(name) {
    let cookieValue = null;
    if (document.cookie) {
        const cookies = document.cookie.split(";");
        cookies.forEach(cookie => {
            cookie = cookie.trim();
            if (cookie.startsWith(name + "=")) {
                cookieValue = decodeURIComponent(cookie.split("=")[1]);
            }
        });
    }
    return cookieValue;
}