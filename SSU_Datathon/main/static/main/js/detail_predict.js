document.addEventListener('DOMContentLoaded', async () => {
    /* ================================
        전역 상태 (페이지, 페이지크기)
    ================================ */
    let currentPage = 1;
    let pageSize = 25;   // 기본값
    let maxPages = 5; // 기본값 (임시 1)
    let order = 1;
    let headers = [];

    try {
        // 초기 pageSize=25에 대한 최대 페이지 수 로딩 
        maxPages = await load_max_page_len(pageSize);
    } catch (error) {
    }
    
    async function updateMaxPageAndReload() {
        try {
            maxPages = await load_max_page_len(pageSize);
            currentPage = 1;
            loadTableData();
        } catch (err) {
        }
    }

    /* ================================
        드롭다운 (페이지크기 선택) 관련
    ================================ */
    const dropdownContainer = document.getElementById("dropdownContainer");
    const dropdownMenu = document.getElementById("pageSizeDropdown");
    const currentPageSizeText = document.querySelector(".current-page-size");

    dropdownContainer.addEventListener("click", (event) => {
        event.stopPropagation();
        // 드롭다운 열기/닫기
        dropdownMenu.classList.toggle("hidden");

        // dropdown-item 클릭 시 값 변경
        const selectedItem = event.target.closest(".dropdown-item");
        if (selectedItem) {
            const newPageSize = selectedItem.dataset.value;
            currentPageSizeText.textContent = newPageSize;
            dropdownMenu.classList.add("hidden");
            
            pageSize = newPageSize;
            currentPage = 1;
            // 페이지크기 변경 시 다시 maxPages 로드 -> 테이블 로드
            updateMaxPageAndReload();
        }
    });

    document.addEventListener("click", (event) => {
        if (!dropdownContainer.contains(event.target)) {
            dropdownMenu.classList.add("hidden");
        }
    });

    /* ================================
        드롭다운 (정렬 선택) 관련
    ================================ */
    const orderdropdownContainer = document.getElementById("orderdropdownContainer");
    const orderdropdownMenu = document.getElementById("orderDropdown");
    const currentorder = document.querySelector(".current-order");

    currentorder.textContent = (LOCATIONDATA === "보존서고" || LOCATIONDATA === "전체") ? "내림차순" : "오름차순";

    orderdropdownContainer.addEventListener("click", (event) => {
        event.stopPropagation();
        // 드롭다운 열기/닫기
        orderdropdownMenu.classList.toggle("hidden");

        // dropdown-item 클릭 시 값 변경
        const selectedItem = event.target.closest(".dropdown-item");
        if (selectedItem) {
            const neworder = selectedItem.dataset.value;
            currentorder.textContent = neworder;
            orderdropdownMenu.classList.add("hidden");
            
            if (neworder === "오름차순") {
                order = (LOCATIONDATA === "보존서고" || LOCATIONDATA === "전체") ? 0 : 1;  // 보존서고면 내림차순, 아니면 오름차순
            } else if (neworder === "내림차순") {
                order = (LOCATIONDATA === "보존서고" || LOCATIONDATA === "전체") ? 1 : 0;  // 보존서고면 오름차순, 아니면 내림차순
            }
            currentPage = 1;
            // 페이지크기 변경 시 다시 maxPages 로드 -> 테이블 로드
            updateMaxPageAndReload();
        }
    });

    document.addEventListener("click", (event) => {
        if (!orderdropdownContainer.contains(event.target)) {
            orderdropdownMenu.classList.add("hidden");
        }
    });

    /* ================================
        페이지네이션 관련
    ================================ */
    const paginationContainer = document.getElementById("paginationContainer");

    // 화살표 아이콘 만드는 헬퍼
    function createArrowImg({ rotate=0, repeat=1 }) {
        // repeat=1 (단일), 2(두 개)
        const wrapper = document.createElement("div");
        wrapper.style.display = "flex";
        wrapper.style.alignItems = "center";
        wrapper.style.gap = "-5vw";
        for (let i = 0; i < repeat; i++) {
            const img = document.createElement("img");
            img.src = ARROW;
            img.classList.add("arrow-icon");
            if (rotate !== 0) {
                img.style.transform = `rotate(${rotate}deg)`;
            }
            // i>0일 때만 음수 마진
            if (i > 0) {
                img.style.marginLeft = "-0.6vw"; 
            }
            wrapper.appendChild(img);
        }
        return wrapper;
    }

    function createPageButton(content, onClick) {
        const btn = document.createElement("div");
        btn.classList.add("page-btn");
        btn.addEventListener("click", onClick);
        // content가 HTMLElement(SVG wrapper)인지, 숫자인지 체크
        if (typeof content === "number") {
            btn.textContent = content;
        } else {
            // 화살표 wrapper
            btn.appendChild(content);
        }
        return btn;
    }

    function renderPagination() {
        paginationContainer.innerHTML = "";

        // << 5페이지씩 이동
        const dblPrev = createArrowImg({ rotate: 180, repeat: 2 });
        const dblPrevBtn = createPageButton(dblPrev, () => {
            currentPage = Math.max(1, currentPage - 5);
            loadTableData();
        });
        paginationContainer.appendChild(dblPrevBtn);

        // < 1페이지씩
        const prevIco = createArrowImg({ rotate: 180, repeat: 1 });
        const prevBtn = createPageButton(prevIco, () => {
            currentPage = Math.max(1, currentPage - 1);
            loadTableData();
        });
        paginationContainer.appendChild(prevBtn);

        // 중앙 5개
        const visibleCount = 5;  // 한 번에 표시할 페이지 수
        let startPage = currentPage - 2;
        let endPage = currentPage + 2;

        // 왼쪽 경계 처리
        if (startPage < 1) {
            // startPage가 1보다 작다면 그만큼 오른쪽으로 밀어서 보정
            endPage += (1 - startPage);
            startPage = 1;
        }
        // 오른쪽 경계 처리
        if (endPage > maxPages) {
            // endPage가 maxPages보다 크다면 그만큼 왼쪽으로 밀어서 보정
            startPage -= (endPage - maxPages);
            endPage = maxPages;
            // 보정 후 startPage가 다시 1 이하로 내려갈 수도 있으니 재검사
            if (startPage < 1) startPage = 1;
        }

        // 이제 startPage ~ endPage 범위로 페이지 버튼 생성
        for (let p = startPage; p <= endPage; p++) {
            const pageBtn = createPageButton(p, () => {
                currentPage = p;
                loadTableData();
            });
            if (p === currentPage) pageBtn.classList.add("active");
            paginationContainer.appendChild(pageBtn);
        }

        // > 1페이지씩
        const nextIco = createArrowImg({ rotate: 0, repeat: 1 });
        const nextBtn = createPageButton(nextIco, () => {
            currentPage = Math.min(maxPages, currentPage+1);
            loadTableData();
        });
        paginationContainer.appendChild(nextBtn);

        // >> 5페이지씩
        const dblNext = createArrowImg({ rotate: 0, repeat: 2 });
        const dblNextBtn = createPageButton(dblNext, () => {
            currentPage = Math.min(maxPages, currentPage+5);
            loadTableData();
        });
        paginationContainer.appendChild(dblNextBtn);
    }

    // ========= 테이블 렌더링 =========
    const bookTable = document.getElementById("bookTable");
    const tableHead = bookTable.querySelector("thead");
    const tableBody = bookTable.querySelector("tbody");
    const noDataWrapper = document.getElementById("noDataWrapper");
    const iconBox = document.getElementById("iconBox");
    const noDataText = document.getElementById("noDataText");
    
    // 초기에 아이콘 + 메시지 표시
    iconBox.style.display = "block";
    noDataText.style.display = "block";
    // ========== 1) 테이블 헤더 (동적) ==========
    function createTableHeader() {
        /* 예시: 열 이름 (문자열 배열) */
        if (LOCATIONDATA !== "전체") {
            headers = ["ID","등록일자","수서방법","분류코드","ISBN","서명","저자","출판사","출판연도","예측 결과"];
        } else {
            headers = ["ID","등록일자","수서방법","분류코드","ISBN","서명","저자","출판사","출판연도","소장위치","예측 결과"];
        }
        
        // 한 줄(헤더 행) 생성
        const tr = document.createElement("tr");
        headers.forEach((headerText, colIndex) => {
            const th = document.createElement("th");
            th.textContent = headerText;

            // width 설정 (optional) -> 예: 120px
            th.style.width = "3vw";

            // (3) 열 크기 조절 핸들
            const resizer = document.createElement("div");
            resizer.classList.add("column-resizer");
            // 드래그 이벤트
            resizer.addEventListener("mousedown", onMouseDownResizer(th));
            th.appendChild(resizer);

            tr.appendChild(th);
        });
        tableHead.appendChild(tr);
    }

    function onMouseDownResizer(thElement) {
        return function (mouseDownEvent) {
            mouseDownEvent.preventDefault();
            const startX = mouseDownEvent.pageX;
            const startWidth = thElement.offsetWidth;

            function onMouseMove(moveEvent) {
                const delta = moveEvent.pageX - startX;
                const newWidth = startWidth + delta;
                thElement.style.width = newWidth + "px";
            }
            function onMouseUp() {
                document.removeEventListener("mousemove", onMouseMove);
                document.removeEventListener("mouseup", onMouseUp);
            }
            document.addEventListener("mousemove", onMouseMove);
            document.addEventListener("mouseup", onMouseUp);
        }
    }

    function renderTable(results) {
        if (!results || results.length === 0) {
            noDataWrapper.style.display = "block";
            tableBody.innerHTML = "";
            return;
        } else {
            noDataWrapper.style.display = "none";
        }
        tableBody.innerHTML = "";

        // 예: row => ['SS_000001', 1982, 7, ... '수정'은 버튼]
        results.forEach((row) => {
            const tr = document.createElement("tr");

            // row.length-1 까지 실제 데이터, 마지막 열에 수정 버튼
            for (let i=0; i<row.length; i++) {
                const td = document.createElement("td");
                td.textContent = row[i];
                tr.appendChild(td);
            }

            tableBody.appendChild(tr);
        });
    }

    /* ================================
        테이블 데이터 로드
    ================================ */
    async function loadTableData() {
        try {
            const res = await fetchWithLoading(LOADBOOKDATA, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-CSRFToken": getCookie("csrftoken")
                },
                body: JSON.stringify({ page: currentPage, pageSize: pageSize, order: order })
            });
            const json = await res.json();
            const results = json.data || [];
            renderTable(results);
            renderPagination();
        } catch (err) {
        }
    }

    async function load_max_page_len(pageSize) {
        try {
            const response = await fetchWithLoading(LOADMAXPAGELEN, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-CSRFToken": getCookie("csrftoken"),
                },
                body: JSON.stringify({ pageSize: pageSize, bookLen: LENBOOK}),
            });
            const data = await response.json();
            // data.data 에 최대 페이지 수가 있다고 가정
            return data.data; 
        } catch (error) {
            return 1; // 오류 시 1
        }
    }

    // 초기 데이터 로드
    // (B) 테이블 헤더 생성 (열 크기조절 핸들)
    createTableHeader();
    await updateMaxPageAndReload();
    
    /* ================================
         모달 / 버튼 공통 요소
    ================================ */
  
    // (내보내기) 버튼 + 모달
    const downloadBtn = document.getElementById('downloadBtn');
    const downloadModal = document.getElementById('downloadModal');
    const downloadModalClose = document.getElementById('downloadModalClose');
  
    /* ================================
         내보내기 (download)
    ================================ */
    downloadBtn.addEventListener('click', () => {
      downloadModal.classList.add('show');
    });
    downloadModalClose.addEventListener('click', () => {
      downloadModal.classList.remove('show');
    });
  
    async function downloadBookData() {
      try {
          const response = await fetchWithLoading(DOWNLOADBOOK, {
              method: "POST",
              headers: {
                  'Content-Type': 'application/json',
                  'X-CSRFToken': getCookie("csrftoken"),
              },
              body: JSON.stringify({ location: LOCATIONDATA })
          });
          const rawdata = await response.json();
          const data = rawdata.data;
          return data;
      }
      catch (error) {
          return []; // 오류 발생 시 빈 배열 반환
      }
    }

    const saveBtnInDownload = downloadModal.querySelector('.save-btn');
    // 확인 버튼 클릭 -> CSV 내보내기
    saveBtnInDownload.addEventListener('click', async function () {
      try {
          const data = await downloadBookData(); // 데이터를 변수에 저장

          downloadModal.classList.remove('show');
          if (data.length > 0) {
            // 엑셀 파일로 제작
            // const headers = Object.keys(data[0]); // 첫 번째 객체의 키를 가져옴 (열 제목)
            // const rows = data.map((row) => headers.map((key) => row[key])); // 행 데이터 생성
            // rows.unshift(headers);
            // const worksheet = XLSX.utils.aoa_to_sheet(rows);
            // const workbook = XLSX.utils.book_new();
            // XLSX.utils.book_append_sheet(workbook, worksheet, "Sheet1");
            // XLSX.writeFile(workbook, "exported_data.xlsx");

            const headers = Object.keys(data[0]); // 첫 번째 객체의 키를 가져옴 (열 제목)
            const csvRows = [
              headers.join(","), // 첫 번째 행에 열 제목 추가
              ...data.map((row) =>
                  headers.map((key) => `"${String(row[key]).replace(/"/g, '""')}"`).join(",")
              ),
            ];
            const csvContent = csvRows.join("\n");
            const bom = '\uFEFF'; // BOM 문자
            const blob = new Blob([bom + csvContent], { type: "text/csv;charset=utf-8;" });
            const url = URL.createObjectURL(blob);
            const a = document.createElement("a");
            a.style.display = "none";
            a.href = url;
            const date = getFormattedDate(); // 오늘 날짜 가져오기
            const fileName = `숭실대학교 도서관 ${LOCATIONDATA} 서가관리 예측 결과 ${date}.csv`; // 파일 이름에 날짜 추가
            a.download = fileName; // 파일 이름
            document.body.appendChild(a);
            a.click();
            URL.revokeObjectURL(url); // URL 해제
          }
          else {
              alert('CSV 내보내기에 실패했습니다.');
          }
      }
      catch (error) {
      }
    });
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

function getFormattedDate() {
    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, "0"); // 월은 0부터 시작하므로 +1
    const day = String(now.getDate()).padStart(2, "0");
    return `${year}-${month}-${day}`; // YYYY-MM-DD 형식
}
