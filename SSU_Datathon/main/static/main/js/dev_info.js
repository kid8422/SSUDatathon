document.addEventListener("DOMContentLoaded", function () {
    // UI 요소 선택
    const tabs = document.querySelectorAll(".content-tab");
    const chartContainer = document.querySelector(".content-box");
    const dev = document.getElementById("dev-info");
    const copy = document.getElementById("copy-info");
    let selectedTab = "개발자 정보"; // 기본 선택 탭

    // **탭 클릭 이벤트 - 이미지 변경 및 초기화**
    tabs.forEach(tab => {
        tab.addEventListener("click", function () {
            tabs.forEach(t => t.classList.remove("active"));
            this.classList.add("active");

            // 선택된 탭 설정
            selectedTab = this.innerText;


            // 탭 전환 시 저장된 데이터에 따라 차트 또는 표 표시
            if (selectedTab === "개발자 정보") {
                dev.style.display = "block";
                copy.style.display = "none";
            } else {
                dev.style.display = "none";
                copy.style.display = "block";
            }
        });
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