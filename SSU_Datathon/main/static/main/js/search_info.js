document.addEventListener('DOMContentLoaded', () => {
    const csrfToken = getCookie('csrftoken');
    const suggestionBox = document.getElementById('suggestion-box');
    const suggestionList = document.getElementById('suggestion-list');
    const searchInput = document.getElementById('book-search-input');
    const searchButton = document.getElementById('on-search-button'); // 검색 버튼
    let debounceTimer;
    let isSearching = false; // 검색 실행 여부를 확인하는 플래그
    let isTableInitialized = false; // 테이블 헤더가 이미 생성되었는지 확인

    // 검색어 자동 추천
    async function fetchSuggestions(query) {
        if (isSearching || query.length < 1) {
            clearSuggestions();
            return;
        }

        try {
            const response = await fetch(SEARCH_AUTOCOMPLETE, {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': csrfToken
                },
                body: JSON.stringify({ title: query, jaum: HangulUtils.getChoseong(query), bulli: HangulUtils.disassemble(query) })
            });

            const data = await response.json();
            showSuggestions(data.suggestions);
        } catch (error) {
            console.error('Error fetching suggestions:', error);
        }
    }

    function showSuggestions(suggestions) {
        clearSuggestions();

        if (suggestions.length === 0 || isSearching) {
            suggestionBox.style.display = "none";
            return;
        }

        suggestions.slice(0, 5).forEach(suggestion => {
            const listItem = document.createElement('li');

            // 아이콘 추가
            const icon = document.createElement('img');
            icon.src = SEARCHICON;
            icon.alt = "검색 아이콘";
            icon.classList.add('suggestion-icon');

            // 텍스트 추가
            const textSpan = document.createElement('span');
            textSpan.textContent = suggestion;
            textSpan.classList.add('suggestion-text');

            // 리스트 아이템에 아이콘과 텍스트 추가
            listItem.appendChild(icon);
            listItem.appendChild(textSpan);

            // 추천 검색어 클릭 시 검색 실행
            listItem.addEventListener('click', () => {
                searchInput.value = suggestion;
                executeSearch();
            });

            suggestionList.appendChild(listItem);
        });

        suggestionBox.style.display = "block";
    }

    function clearSuggestions() {
        suggestionList.innerHTML = '';
        suggestionBox.style.display = "none";
    }

    // 검색 실행 후 연관 검색어 요청 차단 + 입력 필드 포커스 해제
    function executeSearch() {
        const query = searchInput.value.trim();
        if (!query) return;

        isSearching = true; // 검색 중 상태 설정
        clearSuggestions(); // 연관 검색어 숨김
        searchInput.blur(); // 입력 필드 포커스 해제

        searchBooks(query).then(() => {
            setTimeout(() => {
                isSearching = false; // 검색 완료 후 다시 연관 검색어 활성화
            }, 500); // 일정 시간 후 검색 허용
        });
    }

    // 검색 결과 반환
    async function searchBooks(query) {
        if (!query.trim()) return; // 빈 검색어 방지
    
        try {
            // 📌 1. SEARCH_BOOK 요청 -> bookLen 반환
            const response = await fetchWithLoading(SEARCH_BOOK, {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': getCookie("csrftoken")
                },
                body: JSON.stringify({ title: query, jaum: HangulUtils.getChoseong(query), bulli: HangulUtils.disassemble(query) })
            });
    
            const data = await response.json();
            console.log("SEARCH_BOOK 결과:", data);
    
            // 실패 시 기본 메시지 표시
            if (!data.success) {
                noDataWrapper.style.display = "block";
                iconBox.style.display = "block"; // 아이콘이 표시되도록 설정
                noDataText.style.display = "block"; // "도서정보를 찾을 수 없습니다" 텍스트 표시
                tableBody.innerHTML = "";
                return;
            }
    
            // 📌 2. bookLen을 기준으로 페이지네이션 설정
            const bookLen = data.bookLen || 0;
            maxPages = Math.ceil(bookLen / 25); // 25권씩 페이지 나눔
            currentPage = 1; // 검색 후 첫 페이지로 이동
    
            // 📌 3. 검색된 데이터를 기반으로 테이블 로드
            await loadTableData();
            renderPagination();
    
        } catch (error) {
            console.error("searchBooks 오류:", error);
            noDataWrapper.style.display = "block";
            iconBox.style.display = "block"; // 아이콘이 표시되도록 설정
            noDataText.style.display = "block"; // "도서정보를 찾을 수 없습니다" 텍스트 표시
            tableBody.innerHTML = "";
        }
    }

    async function loadTableData() {
        console.log("Load data -> page:", currentPage, "pageSize:", 25);
    
        try {
            const res = await fetchWithLoading(LOADBOOK, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-CSRFToken": getCookie("csrftoken")
                },
                body: JSON.stringify({ page: currentPage, pageSize: 25 }) // 한 페이지 25개
            });
    
            const json = await res.json();
            const results = json.data || [];
            console.log("LOADBOOK 결과:", results);

            if (results.length === 0) {
                showNoDataMessage();
                return;
            }
    
            // 검색된 도서 데이터 렌더링
            createTableHeader(); // 📌 **테이블 헤더를 한 번만 생성**
            renderTable(results);
            renderPagination();
            showTable(); // 📌 **검색 결과가 있으면 테이블 표시**
    
        } catch (err) {
            console.error("loadTableData 오류:", err);
            showNoDataMessage();
        }
    }

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
    
        if (maxPages <= 1) return; // 한 페이지 이하라면 페이지네이션 불필요
    
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
    
        // 중앙 5개 페이지 버튼
        const visibleCount = 5;
        let startPage = currentPage - 2;
        let endPage = currentPage + 2;
    
        if (startPage < 1) {
            endPage += (1 - startPage);
            startPage = 1;
        }
        if (endPage > maxPages) {
            startPage -= (endPage - maxPages);
            endPage = maxPages;
            if (startPage < 1) startPage = 1;
        }
    
        for (let p = startPage; p <= endPage; p++) {
            const pageBtn = createPageButton(p, () => {
                currentPage = p;
                loadTableData();
            });
            if (p === currentPage) pageBtn.classList.add("active");
            paginationContainer.appendChild(pageBtn);
        }
    
        // > 1페이지씩 이동
        const nextIco = createArrowImg({ rotate: 0, repeat: 1 });
        const nextBtn = createPageButton(nextIco, () => {
            currentPage = Math.min(maxPages, currentPage + 1);
            loadTableData();
        });
        paginationContainer.appendChild(nextBtn);
    
        // >> 5페이지씩 이동
        const dblNext = createArrowImg({ rotate: 0, repeat: 2 });
        const dblNextBtn = createPageButton(dblNext, () => {
            currentPage = Math.min(maxPages, currentPage + 5);
            loadTableData();
        });
        paginationContainer.appendChild(dblNextBtn);
    }

    function displayResults(results) {
        const resultDiv = document.getElementById('myTable');
        resultDiv.innerHTML = '';

        if (results.length > 0) {
            results.forEach(result => {
                const item = document.createElement('div');
                item.innerHTML = `<strong>${result.title}</strong> by ${result.author}`;
                item.style.padding = '10px';
                item.style.borderBottom = '1px solid #ddd';
                resultDiv.appendChild(item);
            });
        } else {
            resultDiv.innerHTML = '<p style="text-align: center; color: grey;">검색 결과가 없습니다.</p>';
        }
    }

    // ========= 테이블 렌더링 =========
    const bookTable = document.getElementById("bookTable");
    const tableHead = bookTable.querySelector("thead");
    const tableBody = bookTable.querySelector("tbody");
    const noDataWrapper = document.getElementById("noDataWrapper");
    const iconBox = document.getElementById("iconBox");
    const noDataText = document.getElementById("noDataText");
    
    // 초기에 아이콘 + 메시지 표시
    noDataWrapper.style.display = "block";
    iconBox.style.display = "block"; // 아이콘이 표시되도록 설정
    noDataText.style.display = "block"; // "도서정보를 찾을 수 없습니다" 텍스트 표시
    tableBody.innerHTML = "";
    // ========== 1) 테이블 헤더 (동적) ==========
    function createTableHeader() {
        if (isTableInitialized) return; // 이미 생성된 경우 중복 생성 방지
        isTableInitialized = true;
        /* 예시: 열 이름 (문자열 배열) */
        const headers = ["ID","등록일자","수서방법","분류코드","ISBN","서명","저자","출판사","출판연도","소장 위치"];
        
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
        bookTable.style.display = "none"; // 테이블을 처음에는 숨김 처리
    }

    // 🔹 **검색 결과가 없을 때 메시지를 표시**
    function showNoDataMessage() {
        noDataWrapper.style.display = "block"; // 메시지를 표시
        iconBox.style.display = "block"; // 아이콘 표시
        noDataText.style.display = "block"; // "도서정보를 찾을 수 없습니다" 텍스트 표시
        bookTable.style.display = "none"; // 테이블 숨김
        tableBody.innerHTML = ""; // 테이블 초기화
    }

    // 🔹 **검색 결과가 있을 때 테이블을 표시**
    function showTable() {
        noDataWrapper.style.display = "none"; // "도서정보를 찾을 수 없습니다" 메시지 숨김
        iconBox.style.display = "none"; // 아이콘 숨김
        noDataText.style.display = "none"; // 텍스트 숨김
        bookTable.style.display = "table"; // 테이블 표시
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
            createTableHeader();
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

    // **검색 버튼 클릭 시 검색 실행**
    searchButton.addEventListener('click', executeSearch);

    // **엔터 키 입력 시 검색 실행**
    searchInput.addEventListener('keypress', (event) => {
        if (event.key === "Enter") {
            event.preventDefault();
            executeSearch();
        }
    });

    // 입력 시 디바운스 적용 (0.3초)
    searchInput.addEventListener('input', () => {
        clearTimeout(debounceTimer);
        const query = searchInput.value.trim();

        // 검색 실행 중이면 연관 검색어 요청 방지
        if (!isSearching) {
            debounceTimer = setTimeout(() => fetchSuggestions(query), 300);
        }
    });
});
