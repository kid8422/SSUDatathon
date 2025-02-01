document.addEventListener("DOMContentLoaded", async function () {

    // UI 요소 선택
    const selectAllCheckbox = document.querySelector("#optionAll");
    const dataCheckboxes = document.querySelectorAll(".checkbox:not(#optionAll)");
    const confirmButton = document.querySelector(".button.confirm");
    const resetButton = document.querySelector(".button.reset");
    
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

        // 데이터가 하나라도 있는 경우
        if (checkedOptions.length !== 0) {
            console.log(checkedOptions);
            await dataPreprocessing(checkedOptions);
        }
    });

    // **초기화 버튼 클릭 - 모든 체크박스 해제 및 화면 초기화**
    resetButton.addEventListener("click", function () {
        selectAllCheckbox.checked = false;
        dataCheckboxes.forEach(checkbox => checkbox.checked = false);
    });

    async function dataPreprocessing(data) {
        try {
            const response = await fetchWithLoading(PREPROCESSING_DATA, {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': getCookie("csrftoken"),
                },
                body: JSON.stringify({ data: data })
            });

            const result = await response.json();

            if (result.success) {
                alert("데이터 전처리 성공");
                // 모달 닫기 or 추가 로직
                await loadData(data); // 데이터 로드
            } else {
                alert(result.message);
            }
        } catch (error) {
            alert(error);
            //alert("오류가 발생했습니다. 관리자에게 문의하세요.");
        }
    };

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

            Object.keys(result.data).forEach(key => {
                let element = document.getElementById(key); // id에 해당하는 요소 찾기
                if (element) {
                    element.textContent = result.data[key]; // 요소의 텍스트 업데이트
                }
            });
        } catch (error) {
            alert(error);
        }
    }
    await loadData(); // 데이터 로드
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