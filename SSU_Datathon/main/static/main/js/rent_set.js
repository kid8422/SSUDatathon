document.addEventListener('DOMContentLoaded', async () => {
    /* ================================
        전역 상태 (페이지, 페이지크기)
    ================================ */
    let currentPage = 1;
    let pageSize = 25;   // 기본값
    let maxPages = 5; // 기본값 (임시 1)
    let order = 1;

    try {
        // 초기 pageSize=25에 대한 최대 페이지 수 로딩
        maxPages = await load_max_page_len(pageSize);
        console.log("최대 페이지 수:", maxPages);
    } catch (error) {
        console.error("최대 페이지 수 로드 오류:", error);
    }
    
    async function updateMaxPageAndReload() {
        try {
            maxPages = await load_max_page_len(pageSize);
            currentPage = 1;
            loadTableData();
        } catch (err) {
            console.error("update max page error:", err);
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
        드롭다운 (페이지크기 선택) 관련
    ================================ */
    const orderdropdownContainer = document.getElementById("orderdropdownContainer");
    const orderdropdownMenu = document.getElementById("orderDropdown");
    const currentorder = document.querySelector(".current-order");

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
            
            if (neworder == '최신 순') {
                order = 1;
            }
            else if (neworder == '오래된 순') {
                order = 0;
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
        const startPage = Math.max(1, currentPage-2);
        let endPage = Math.min(maxPages, startPage+4);
        while ((endPage-startPage) <4 && startPage>1) {
            endPage++;
            if(endPage>maxPages) break;
        }
        for(let p=startPage; p<=endPage; p++){
            const pageBtn = createPageButton(p, ()=> {
                currentPage = p;
                loadTableData();
            });
            if(p===currentPage) pageBtn.classList.add("active");
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
        const headers = ["대출일시", "ID", "서명", "저자", "출판사", "분류코드", "소장위치"];
        
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
        console.log("Load data -> page:", currentPage, "pageSize:", pageSize);
        try {
            const res = await fetch(LOADRENTDATA, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-CSRFToken": getCookie("csrftoken")
                },
                body: JSON.stringify({ page: currentPage, pageSize, order })
            });
            const json = await res.json();
            const results = json.data || [];
            renderTable(results);
            renderPagination();
        } catch (err) {
            console.error("loadTableData error:", err);
        }
    }

    async function load_max_page_len(pageSize) {
        try {
            const response = await fetch(LOADMAXPAGELEN, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-CSRFToken": getCookie("csrftoken"),
                },
                body: JSON.stringify({ pageSize: pageSize }),
            });
            const data = await response.json();
            // data.data 에 최대 페이지 수가 있다고 가정
            console.log("load_max_page_len 응답:", data.data);
            return data.data; 
        } catch (error) {
            console.error("최대 페이지 수 요청 오류:", error);
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
  
    // (가져오기) 버튼 + 모달
    const importBtn = document.getElementById('uploadBtn');
    const importModal = document.getElementById('uploadModal');
    const importModalClose = document.getElementById('uploadModalClose');
  
    // (내보내기) 버튼 + 모달
    const downloadBtn = document.getElementById('downloadBtn');
    const downloadModal = document.getElementById('downloadModal');
    const downloadModalClose = document.getElementById('downloadModalClose');
  
    /* ================================
         가져오기 (Import) 관련
    ================================ */
    // 파일 입력 및 컬럼 선택 요소
    const fileInput = document.getElementById('fileInput');
    const fileText = document.querySelector('.upload-file-text');
    const fileLabel = document.querySelector('.upload-file-label');
    const allSelects = document.querySelectorAll('.column-select');

    // 파일 초기화 함수
    function resetFileUpload() {
      fileInput.value = "";  // 파일 선택 해제
      // 초기 표시 문구로 되돌림
      fileText.textContent = "파일 업로드 (*.csv, *.xls, *.xlsx)";
      fileLabel.style.background = "#FFFFFF"; // 초기 흰색 배경
      // 드롭다운도 초기화
      allSelects.forEach(select => {
        select.innerHTML = '<option value="">먼저 파일을 선택하세요</option>';
    });
    }
  
    // 가져오기 버튼: 모달 열기
    importBtn.addEventListener('click', () => {
      importModal.classList.add('show');
    });
  
    // 닫기(X) 버튼: 모달 닫고 파일 상태 초기화
    importModalClose.addEventListener('click', () => {
      importModal.classList.remove('show');
      resetFileUpload();
    });
  
    // 가져오기 모달 내 저장/취소 버튼
    const saveBtnInImport = importModal.querySelector('.save-btn');
    const cancelBtnInImport = importModal.querySelector('.cancel-btn');
  
    // 취소 버튼: 모달 닫고 파일 상태 초기화
    cancelBtnInImport.addEventListener('click', () => {
      importModal.classList.remove('show');
      resetFileUpload();
    });
    // saveBtnInImport 클릭 시 => 로직 추가 (ex: Ajax)
  
    // 파일이 선택(또는 변경)될 때
    fileInput.addEventListener('change', handleFile);
  
    /* ========== (1) 파일 읽고 SheetJS로 파싱 ========== */
    function handleFile(evt) {
      const file = evt.target.files[0];
      if (!file) return;
  
      // 확장자 검사(추가 안전장치)
      const allowed = ['csv', 'xls', 'xlsx'];
      const ext = file.name.split('.').pop().toLowerCase();
      if (!allowed.includes(ext)) {
        alert('허용되지 않는 파일 형식입니다.');
        fileInput.value = '';
        return;
      }
  
      // 라벨 배경색을 회색
      fileLabel.style.background = '#DDDDDD';
      fileText.textContent = file.name; // 선택한 파일명 표시
  
      // FileReader를 이용하여 파일 읽기 (ArrayBuffer)
      const reader = new FileReader();
      reader.onload = function(e) {
        const data = new Uint8Array(e.target.result);
  
        // SheetJS로 workbook 생성
        const workbook = XLSX.read(data, { type: 'array' });
  
        // 첫 번째 시트만 사용
        const firstSheetName = workbook.SheetNames[0];
        const worksheet = workbook.Sheets[firstSheetName];
  
        // sheet_to_json, header: 1 -> 2차원 배열 형태 ([ [행1], [행2], ... ])
        const rows = XLSX.utils.sheet_to_json(worksheet, { header: 1 });
  
        // rows[0] 는 첫 번째 행(배열). => 열 수
        if (rows.length > 0) {
          const firstRow = rows[0];
          const colCount = firstRow.length;
  
          // (2) 드롭다운 생성
          createColumnOptions(colCount);
        }
      };
  
      // reader가 arraybuffer로 읽어오도록 지정
      reader.readAsArrayBuffer(file);
    }
  
    /* ========== (2) 열 개수만큼 A, B, C... 생성해 <select>에 옵션 추가 ========== */
    function createColumnOptions(colCount) {
        // A, B, C, D... (26개 넘으면 COL27 등으로 처리)
        const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        // 모든 .column-select에 대해 반복
        allSelects.forEach(selectElem => {
            // 기존 옵션 초기화
            selectElem.innerHTML = '<option value="">컬럼 선택</option>';

            // 열 개수만큼 옵션 생성
            for (let i = 0; i < colCount; i++) {
            let colLetter;
            if (i < 26) {
                colLetter = alphabet[i];
            } else {
                colLetter = `COL${i + 1}`;
            }
            const option = document.createElement('option');
            option.value = colLetter;
            option.textContent = colLetter;
            selectElem.appendChild(option);
            }
        });
    }
  
    /* ================================
         내보내기 (download)
    ================================ */
    downloadBtn.addEventListener('click', () => {
      downloadModal.classList.add('show');
    });
    downloadModalClose.addEventListener('click', () => {
      downloadModal.classList.remove('show');
    });
  
    async function downloadrentData() {
      try {
          const response = await fetch(DOWNLOADRENT, {
              method: "POST",
              headers: {
                  'Content-Type': 'application/json',
                  'X-CSRFToken': getCookie("csrftoken"),
              }
          });
          const rawdata = await response.json();
          const data = rawdata.data;
          return data;
      }
      catch (error) {
          console.error(error);
          return []; // 오류 발생 시 빈 배열 반환
      }
    }

    const saveBtnInDownload = downloadModal.querySelector('.save-btn');
    // 확인 버튼 클릭 -> CSV 내보내기
    saveBtnInDownload.addEventListener('click', async function () {
      try {
          const data = await downloadrentData(); // 데이터를 변수에 저장
          console.log(data)

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
            const fileName = `숭실대학교 도서관 대출정보 ${date}.csv`; // 파일 이름에 날짜 추가
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
        console.error(error);
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
