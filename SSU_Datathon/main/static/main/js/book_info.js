document.addEventListener("DOMContentLoaded", function () {
    // 이미지 경로 상수
    const L_ICON = LARGE_ICON;   // 대분류 이미지
    const M_ICON = MIDDLE_ICON; // 중분류 이미지

    // UI 요소 선택
    const tabs = document.querySelectorAll(".content-tab");
    const icon = document.querySelector(".icon-box img");
    const selectAllCheckbox = document.querySelector("#optionAll");
    const dataCheckboxes = document.querySelectorAll(".checkbox:not(#optionAll)");
    const confirmButton = document.querySelector(".button.confirm");
    const resetButton = document.querySelector(".button.reset");
    const noDataText = document.getElementById("noDataText");
    const chartCanvas = document.getElementById("myChart");
    const chartContainer = document.querySelector(".content-box");
    let chartInstance = null; // 차트 인스턴스 저장 변수
    let selectedTab = "대분류"; // 기본 선택 탭
    let storedData = { large: [], middle: [] }; // 데이터를 저장할 변수

    // **탭 클릭 이벤트 - 이미지 변경 및 초기화**
    tabs.forEach(tab => {
        tab.addEventListener("click", function () {
            tabs.forEach(t => t.classList.remove("active"));
            this.classList.add("active");

            // 선택된 탭 설정
            selectedTab = this.innerText;

            // 이미지 변경
            icon.src = selectedTab === "대분류" ? L_ICON : M_ICON;

            // 탭 전환 시 저장된 데이터에 따라 차트 또는 표 표시
            if (selectedTab === "대분류") {
                if (storedData.large.length > 0) {
                    drawBarChart(storedData.large);
                } else {
                    showNoData();
                }
            } else {
                if (storedData.middle.length > 0) {
                    drawTable(storedData.middle);
                } else {
                    showNoData();
                }
            }
        });
    });

    // **전체 선택 버튼 기능**
    selectAllCheckbox.addEventListener("change", function () {
        dataCheckboxes.forEach(checkbox => {
            checkbox.checked = selectAllCheckbox.checked;
        });
    });

    // **개별 체크박스 변경 시 전체 선택 동기화**
    dataCheckboxes.forEach(checkbox => {
        checkbox.addEventListener("change", function () {
            const allChecked = Array.from(dataCheckboxes).every(cb => cb.checked);
            selectAllCheckbox.checked = allChecked;
        });
    });

    // **확인 버튼 클릭 시 데이터 로드 및 차트/표 생성**
    confirmButton.addEventListener("click", async function () {
        const checkedOptions = Array.from(dataCheckboxes)
            .filter(option => option.checked)
            .map(option => option.nextElementSibling.innerText);

        // 데이터가 선택되지 않았을 경우 초기화 상태로 복귀
        if (checkedOptions.length === 0) {
            showNoData();
            storedData = { large: [], middle: [] }; // 저장된 데이터 초기화
            return;
        }

        await loadData(checkedOptions); // 데이터 로드
    });

    // **초기화 버튼 클릭 - 모든 체크박스 해제 및 화면 초기화**
    resetButton.addEventListener("click", function () {
        selectAllCheckbox.checked = false;
        dataCheckboxes.forEach(checkbox => checkbox.checked = false);
        showNoData(); // 초기화 시 기본 화면 복원
        storedData = { large: [], middle: [] }; // 저장된 데이터 초기화
    });

    // **데이터 로드 및 저장 함수**
    async function loadData(selectedData) {
        try {
            const response = await fetchWithLoading(LOAD_DATA, {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': getCookie("csrftoken"),
                },
                body: JSON.stringify({ selectedData: selectedData })
            });

            const result = await response.json();

            // 데이터 저장
            storedData.large = result.large
            storedData.middle = result.middle

            // 선택된 탭에 따라 렌더링
            if (selectedTab === "대분류") {
                if (storedData.large.length > 0) {
                    drawBarChart(storedData.large);
                } else {
                    showNoData();
                }
            } else {
                if (storedData.middle.length > 0) {
                    drawTable(storedData.middle);
                } else {
                    showNoData();
                }
            }
        } catch (error) {
            showNoData();
        }
    }

    // **데이터가 없을 경우 기본 화면 유지**
    function showNoData() {
        noDataText.style.display = "block"; // "데이터 없음" 표시
        chartCanvas.style.display = "none"; // 차트 숨기기
        icon.style.display = "block"; // 아이콘 표시
        if (chartInstance) chartInstance.destroy();
        chartContainer.querySelectorAll("table").forEach(el => el.remove());
    }

    // **차트 생성 함수**
    function drawBarChart(data) {
        clearChartOrTable(); // 초기화

        chartCanvas.style.display = "block"; // 차트 표시
        icon.style.display = "none"; // 아이콘 숨기기
        noDataText.style.display = "none"; // "데이터 없음" 숨기기

        parsedData = JSON.parse(data);

        const mapdata = parsedData.map(Number);

        const ctx = chartCanvas.getContext("2d");
        chartInstance = new Chart(ctx, {
            type: "bar",
            data: {
                labels:  ["000", "100", "200", "300", "400", "500", "600", "700", "800", "900"],
                datasets: [{
                    label: "대분류 데이터",
                    data: mapdata,
                    backgroundColor: "rgba(75, 192, 192, 0.2)",
                    borderColor: "rgba(75, 192, 192, 1)",
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false  // 필요시
                    },
                    tooltip: {
                        enabled: true,
                        titleFont: {
                        size: 0 // 툴팁의 타이틀 폰트 크기
                        },
                        bodyFont: {
                        size: 16 // 툴팁의 실제 본문 폰트 크기
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                suggestedMax: Math.max(...data) * 1.2, // 최대값 확장 (1.2배)
                            } 
                        },
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.parsed.y ? context.parsed.y.toLocaleString() : '0';
                                return [
                                    ` ${label}`,  // "000 총류"
                                    `  ${value}권`         // "30권"
                                ];
                            }
                        }
                    } 
                }
            }
        });
    }

    // **표 생성 함수**
    function drawTable(data) {
        clearChartOrTable(); // 기존 차트 및 표 초기화
    
        const tableContainer = document.getElementById("myTable");
        tableContainer.style.display = "block"; // 테이블 표시
        chartCanvas.style.display = "none"; // 차트 숨기기
        icon.style.display = "none"; // 아이콘 숨기기
        noDataText.style.display = "none"; // "데이터 없음" 숨기기
    
        // **데이터 처리**
        const parsedData = JSON.parse(data); // JSON 데이터 파싱
        const mapdata = parsedData.map(Number); // 문자열 → 숫자 변환
    
        // **표 생성**
        const table = document.createElement("table");
        table.classList.add("data-table"); // 표 스타일 클래스 추가
    
        // **가로 레이블 추가 (백의 자리: 000, 100, 200, ...)**
        const headerRow = document.createElement("tr");
        headerRow.appendChild(document.createElement("th")); // 왼쪽 상단 빈 칸 추가
        for (let col = 0; col < 10; col++) {
            const headerCell = document.createElement("th");
            headerCell.textContent = `${col * 100}`.padStart(3, "0"); // '000' 형식 유지
            headerCell.classList.add("header-cell"); // 스타일 추가
            headerRow.appendChild(headerCell);
        }
        table.appendChild(headerRow); // 헤더 행 추가
    
        // **데이터 삽입 (세로 레이블 포함)**
        let index = 0; // 데이터 인덱스
        for (let row = 0; row < 10; row++) {
            const tableRow = document.createElement("tr");
    
            // **세로 레이블 추가 (십의 자리: 000, 010, 020, ...)**
            const rowHeader = document.createElement("th");
            rowHeader.textContent = `${row * 10}`.padStart(3, "0"); // '000' 형식 유지
            rowHeader.classList.add("header-cell"); // 스타일 추가
            tableRow.appendChild(rowHeader); // 행 헤더 추가
    
            // **데이터 삽입**
            for (let col = 0; col < 10; col++) {
                const cell = document.createElement("td");
                // 가로/세로 데이터 위치 변경 (값만 바뀜, 레이블 유지)
                cell.textContent = mapdata[(col * 10) + row] || 0; // 값 삽입
                cell.classList.add("table-cell"); // 스타일 추가
                tableRow.appendChild(cell); // 행에 셀 추가
            }
            table.appendChild(tableRow); // 행 추가
        }
    
        // 기존 표 제거 후 새 표 추가
        tableContainer.innerHTML = ""; // 기존 테이블 초기화
        tableContainer.appendChild(table); // 새로운 표 추가
    }

    // **초기화 함수**
    function clearChartOrTable() {
        if (chartInstance) chartInstance.destroy();
        chartContainer.querySelectorAll("table").forEach(el => el.remove());
    }
});

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