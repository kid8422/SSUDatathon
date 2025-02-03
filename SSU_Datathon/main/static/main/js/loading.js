window.fetchWithLoading = async function (url, options = {}) {
    let startTime = performance.now();
    let loadingOverlay = document.getElementById("loadingOverlay");

    if (!loadingOverlay) {
        loadingOverlay = document.createElement("div");
        loadingOverlay.id = "loadingOverlay";
        loadingOverlay.innerHTML = `
            <div class="loading-spinner"></div>
            <div class="loading-text">로딩 중...</div>
        `;
        document.body.appendChild(loadingOverlay);
    }
    loadingOverlay.style.display = "flex";

    try {
        const response = await fetch(url, options);
        return response; // ✅ Response 객체 그대로 반환
    } catch (error) {
        alert("네트워크 오류가 발생했습니다. 다시 시도하세요.");
        throw error;
    } finally {
        loadingOverlay.style.display = "none";
    }
};


window.getCookie = function (name) {
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
};
