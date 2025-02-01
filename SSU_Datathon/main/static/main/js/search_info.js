document.addEventListener('DOMContentLoaded', () => {
    const csrfToken = getCookie('csrftoken');
    let debounceTimer;

    // 검색어 자동 추천
    async function fetchSuggestions(query) {
        if (query.length < 1) {
            clearSuggestions();
            return;
        }

        try {
            const response = await fetchWithLoading(SEARCH_AUTOCOMPLETE, {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': csrfToken
                },
                body: JSON.stringify({ query: query })
            });

            const data = await response.json();
            showSuggestions(data.suggestions);
        } catch (error) {
            console.error('Error fetch suggestions:', error);
        }
    }

    function showSuggestions(suggestions) {
        clearSuggestions(); // 기존 추천어 초기화

        const suggestionBox = document.createElement('ul');
        suggestionBox.id = 'suggestion-box';
        suggestionBox.style.position = 'absolute';
        suggestionBox.style.width = '100%';
        suggestionBox.style.border = '1px solid #ddd';
        suggestionBox.style.background = 'white';
        suggestionBox.style.zIndex = '10';
        suggestionBox.style.padding = '0';

        suggestions.forEach(suggestion => {
            const listItem = document.createElement('li');
            listItem.textContent = suggestion;
            listItem.style.padding = '10px';
            listItem.style.cursor = 'pointer';

            listItem.addEventListener('click', () => {
                searchInput.value = suggestion;
                clearSuggestions();
                searchBooks(suggestion); // 선택 시 바로 검색 실행
            });

            suggestionBox.appendChild(listItem);
        });

        searchInput.parentNode.appendChild(suggestionBox);
    }

    function clearSuggestions() {
        const existingBox = document.getElementById('suggestion-box');
        if (existingBox) {
            existingBox.remove();
        }
    }

    // 검색 결과 반환
    async function searchBooks(query) {
        try {
            const response = await fetchWithLoading(SEARCH_BOOK, {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': csrfToken
                },
                body: JSON.stringify({ query: query })
            });

            const data = await response.json();
            displayResults(data.results);
        } catch (error) {
            console.error('Error fetch results:', error);
        }
    }

    function displayResults(results) {
        const resultDiv = document.getElementById('myTable');
        resultDiv.innerHTML = ''; // 기존 결과 초기화

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

    // 이벤트 리스너 설정
    const searchInput = document.getElementById('book-search-input');
    const searchButton = document.querySelector('.search-button-rectangle:last-child');

    // 입력 시 디바운스 적용 (0.3초)
    searchInput.addEventListener('input', () => {
        clearTimeout(debounceTimer);
        const query = searchInput.value.trim();
        debounceTimer = setTimeout(() => fetchSuggestions(query), 300);
    });

    // 검색 버튼 클릭 시 검색 실행
    searchButton.addEventListener('click', () => {
        const query = searchInput.value.trim();
        searchBooks(query);
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
