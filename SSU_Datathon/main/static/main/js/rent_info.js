document.addEventListener("DOMContentLoaded", function () {
    // 이미지 경로 상수
    const L_ICON = BAR_ICON;   // 대분류 이미지

    // UI 요소 선택
    const icon = document.querySelector(".icon-box img");
    const optionsGrid = document.querySelector(".options-grid");
    const confirmButton = document.querySelector(".button.confirm");
    const resetButton = document.querySelector(".button.reset");
    const noDataText = document.getElementById("noDataText");
    const chartCanvas = document.getElementById("myChart");
    const chartContainer = document.querySelector(".content-box");
    const stabTabs = document.querySelectorAll(".select-tab"); // Stab 탭 선택
    let chartInstance = null; // 차트 인스턴스 저장 변수
    let selectedTab = "대분류"; // 기본 선택 탭
    let storedData = { large: [], middle: [] }; // 데이터를 저장할 변수
    let activeSelection = "연도선택"; // 현재 활성화된 선택 (연도선택 또는 분류선택)

    // **선택 상태를 저장할 변수 추가**
    let selectedYears = []; // 연도 선택 탭에서 선택된 연도들
    let selectedCategories = [
        "000 총류", "100 철학", "200 종교", "300 사회과학",
        "400 자연과학", "500 기술과학", "600 예술",
        "700 언어", "800 문학", "900 역사"
    ]; // 분류 선택 탭에서 선택된 분류들

    // 초기 활성 탭에 'active' 클래스 추가 및 초기 선택 상태 설정
    stabTabs.forEach(tab => {
        if (tab.classList.contains("active")) {
            activeSelection = tab.innerText;
        }
    });

    // ---------------------------------------------
    // [1] 이벤트 위임: optionsGrid에 change 이벤트 리스너 등록
    // ---------------------------------------------
    optionsGrid.addEventListener("change", function (e) {
        const target = e.target;

        // "전체 선택" 체크박스인지 확인
        if (target.matches("#optionAll")) {
            // 전체 선택 체크박스가 바뀌면, 나머지 체크박스 모두 선택/해제
            const isChecked = target.checked;
            handleSelectAll(isChecked);

            // 선택 상태 업데이트
            if (activeSelection === "연도선택") {
                selectedYears = isChecked ? getAllYears() : [];
            } else if (activeSelection === "분류선택") {
                selectedCategories = isChecked ? getAllCategories() : [];
            }
        }
        // 개별 체크박스인지 확인
        else if (target.matches(".checkbox")) {
            const label = target.nextElementSibling.innerText;

            if (activeSelection === "연도선택") {
                if (target.checked) {
                    if (!selectedYears.includes(label)) {
                        selectedYears.push(label);
                    }
                } else {
                    selectedYears = selectedYears.filter(year => year !== label);
                }
            } else if (activeSelection === "분류선택") {
                if (target.checked) {
                    if (!selectedCategories.includes(label)) {
                        selectedCategories.push(label);
                    }
                } else {
                    selectedCategories = selectedCategories.filter(category => category !== label);
                }
            }

            // 전체 선택 체크박스 상태 동기화
            syncSelectAllCheckbox();
        }
    });

    // ---------------------------------------------
    // [2] "전체 선택" 체크박스에 따라 나머지 체크박스 전부 토글
    // ---------------------------------------------
    function handleSelectAll(isChecked) {
        const allCheckboxes = optionsGrid.querySelectorAll(".checkbox:not(#optionAll)");
        allCheckboxes.forEach(cb => {
            cb.checked = isChecked;
        });
    }

    // ---------------------------------------------------------
    // [3] 개별 체크박스 변경 시 "전체 선택" 체크박스 상태 동기화
    // ---------------------------------------------------------
    function syncSelectAllCheckbox() {
        const allCheckboxes = optionsGrid.querySelectorAll(".checkbox:not(#optionAll)");
        const selectAll = optionsGrid.querySelector("#optionAll");

        if (!selectAll) return; // "전체 선택" 체크박스가 없으면 중단

        const allChecked = Array.from(allCheckboxes).every(cb => cb.checked);
        selectAll.checked = allChecked;
    }

    // ---------------------------------------------------------
    // [4] Stab 탭 관련 이벤트
    // ---------------------------------------------------------
    stabTabs.forEach(tab => {
        tab.addEventListener("click", function () {
            // 현재 활성 탭에서 선택 상태 저장 (이미 위의 change 이벤트에서 처리됨)
            // 필요한 경우 추가 로직을 여기에 작성할 수 있습니다.

            // 탭 전환
            stabTabs.forEach(t => t.classList.remove("active"));
            this.classList.add("active");
            activeSelection = this.innerText;

            // 연도 선택과 분류 선택에 따라 옵션 변경
            if (activeSelection === "연도선택") {
                loadYearOptions(); // 연도 옵션 로드
            } else if (activeSelection === "분류선택") {
                loadCategoryOptions(); // 분류 옵션 로드
            }

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

    // **연도 선택 옵션 로드**
    function loadYearOptions() {
        // .options-grid 내부를 완전히 새로 그림
        optionsGrid.innerHTML = `
            <div class="option full-width">
                <input type="checkbox" id="optionAll" class="checkbox">
                <div class="label">전체 선택</div>
            </div>
        `;

        for (let year = 2024; year >= 2004; year--) {
            const isChecked = selectedYears.includes(String(year));
            optionsGrid.innerHTML += `
                <div class="option">
                    <input type="checkbox" class="checkbox" id="option${year}" ${isChecked ? 'checked' : ''}>
                    <div class="label">${year}</div>
                </div>
            `;
        }

        // "전체 선택" 체크박스 상태 동기화
        syncSelectAllCheckbox();
    }

    // **분류 선택 옵션 로드**
    function loadCategoryOptions() {
        // .options-grid 내부를 완전히 새로 그림
        optionsGrid.innerHTML = `
            <div class="option full-width">
                <input type="checkbox" id="optionAll" class="checkbox">
                <div class="label">전체 선택</div>
            </div>
        `;

        const categories = [
            "000 총류", "100 철학", "200 종교", "300 사회과학",
            "400 자연과학", "500 기술과학", "600 예술",
            "700 언어", "800 문학", "900 역사"
        ];

        categories.forEach((category, index) => {
            const isChecked = selectedCategories.includes(category);
            optionsGrid.innerHTML += `
                <div class="option">
                    <input type="checkbox" class="checkbox" id="option${index * 100}" ${isChecked ? 'checked' : ''}>
                    <div class="label">${category}</div>
                </div>
            `;
        });

        // "전체 선택" 체크박스 상태 동기화
        syncSelectAllCheckbox();
    }

    // **도움 함수: 모든 연도 반환**
    function getAllYears() {
        const years = [];
        for (let year = 2024; year >= 2004; year--) {
            years.push(String(year));
        }
        return years;
    }

    // **도움 함수: 모든 분류 반환**
    function getAllCategories() {
        return [
            "000 총류", "100 철학", "200 종교", "300 사회과학",
            "400 자연과학", "500 기술과학", "600 예술",
            "700 언어", "800 문학", "900 역사"
        ];
    }

    // ---------------------------------------------
    // [5] 확인 버튼 클릭 시 데이터 로드 및 차트/표 생성
    // ---------------------------------------------
    confirmButton.addEventListener("click", async function () {
        // "연도선택"과 "분류선택" 모두의 선택 상태를 가져옴
        const checkedYears = selectedYears; // 연도 선택에서 선택된 연도들
        const checkedCategories = selectedCategories; // 분류 선택에서 선택된 분류들

        // 모든 선택을 합침
        const allCheckedOptions = {
            years: checkedYears,
            categories: checkedCategories
        };

        console.log(allCheckedOptions);

        // 연도 선택과 분류 선택 중 하나라도 비어있을 경우 처리
        const isYearsEmpty = checkedYears.length === 0;
        const isCategoriesEmpty = checkedCategories.length === 0;

        if (isYearsEmpty && isCategoriesEmpty) {
            showNoData();
            storedData = { large: [], middle: [] }; // 저장된 데이터 초기화
            return;
        }

        // 서버에 두 개의 선택 데이터를 모두 전송
        await loadData(allCheckedOptions);
    });

    // ---------------------------------------------
    // [6] 초기화 버튼 클릭 - 체크박스 및 화면 초기화
    // ---------------------------------------------
    resetButton.addEventListener("click", function () {
        // 현재 활성화된 선택에 따라 초기화
        if (activeSelection === "연도선택") {
            selectedYears = [];
            loadYearOptions();
        } else if (activeSelection === "분류선택") {
            selectedCategories = getAllCategories();
            loadCategoryOptions();
        }

        // 화면 초기화
        showNoData();
        storedData = { large: [], middle: [] };
    });

    // ---------------------------------------------
    // [7] 데이터 로드 및 저장 함수
    // ---------------------------------------------
    async function loadData(selectedData) {
        try {
            const response = await fetch(LOAD_DATA, {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': getCookie("csrftoken"),
                },
                body: JSON.stringify({ selectedData: selectedData })
            });

            const result = await response.json();

            // 데이터 저장
            storedData.large = result.large;
            storedData.middle = result.middle;

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
            // 에러 시에도 '데이터 없음'으로 처리
            showNoData();
        }
    }

    // ---------------------------------------------
    // [8] 데이터가 없을 경우의 처리
    // ---------------------------------------------
    function showNoData() {
        noDataText.style.display = "block"; 
        chartCanvas.style.display = "none"; 
        icon.style.display = "block"; 
        if (chartInstance) chartInstance.destroy();
        chartContainer.querySelectorAll("table").forEach(el => el.remove());
    }

    // ---------------------------------------------
    // [9] 차트 생성 함수 (대분류용)
    // ---------------------------------------------
    function drawBarChart(data) {
        clearChartOrTable();

        chartCanvas.style.display = "block";
        icon.style.display = "none";
        noDataText.style.display = "none";

        const parsedData = JSON.parse(data);
        const mapdata = parsedData.map(Number);

        const ctx = chartCanvas.getContext("2d");
        chartInstance = new Chart(ctx, {
            type: "bar",
            data: {
                labels: ["000", "100", "200", "300", "400", "500", "600", "700", "800", "900"],
                datasets: [
                    {
                        label: "대분류 데이터",
                        data: mapdata,
                        backgroundColor: "rgba(75, 192, 192, 0.2)",
                        borderColor: "rgba(75, 192, 192, 1)",
                        borderWidth: 1
                    }
                ]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        enabled: true,
                        titleFont: {
                            size: 0
                        },
                        bodyFont: {
                            size: 16
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                suggestedMax: Math.max(...mapdata) * 1.2,
                            }
                        },
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.parsed.y 
                                    ? context.parsed.y.toLocaleString() 
                                    : '0';
                                return [
                                    ` ${label}`,
                                    `  ${value}권`
                                ];
                            }
                        }
                    }
                }
            }
        });
    }

    // ---------------------------------------------
    // [10] 표 생성 함수 (중분류용)
    // ---------------------------------------------
    function drawTable(data) {
        clearChartOrTable();

        const tableContainer = document.getElementById("myTable");
        tableContainer.style.display = "block";
        chartCanvas.style.display = "none";
        icon.style.display = "none";
        noDataText.style.display = "none";

        const parsedData = JSON.parse(data);
        const mapdata = parsedData.map(Number);

        const table = document.createElement("table");
        table.classList.add("data-table");

        // 상단 헤더(가로 레이블)
        const headerRow = document.createElement("tr");
        headerRow.appendChild(document.createElement("th")); // 왼쪽 상단 공백
        for (let col = 0; col < 10; col++) {
            const headerCell = document.createElement("th");
            headerCell.textContent = `${col * 100}`.padStart(3, "0");
            headerCell.classList.add("header-cell");
            headerRow.appendChild(headerCell);
        }
        table.appendChild(headerRow);

        // 실제 데이터 행 생성
        for (let row = 0; row < 10; row++) {
            const tableRow = document.createElement("tr");

            // 왼쪽 세로 레이블 (row * 10)
            const rowHeader = document.createElement("th");
            rowHeader.textContent = `${row * 10}`.padStart(3, "0");
            rowHeader.classList.add("header-cell");
            tableRow.appendChild(rowHeader);

            for (let col = 0; col < 10; col++) {
                const cell = document.createElement("td");
                // (col * 10) + row 인덱스 위치의 값
                cell.textContent = mapdata[(col * 10) + row] || 0;
                cell.classList.add("table-cell");
                tableRow.appendChild(cell);
            }
            table.appendChild(tableRow);
        }

        // 기존 표 제거 후 새 표 추가
        tableContainer.innerHTML = "";
        tableContainer.appendChild(table);
    }

    // ---------------------------------------------
    // [11] 차트 / 표 초기화
    // ---------------------------------------------
    function clearChartOrTable() {
        if (chartInstance) chartInstance.destroy();
        chartContainer.querySelectorAll("table").forEach(el => el.remove());
    }

    // ---------------------------------------------
    // [초기 구동] 연도 선택 또는 분류 선택에 따라 기본 옵션 로드
    // ---------------------------------------------
    if (activeSelection === "연도선택") {
        loadYearOptions();
    } else if (activeSelection === "분류선택") {
        loadCategoryOptions();
    }
});

// CSRF 토큰 가져오기
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
