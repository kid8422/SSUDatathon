document.addEventListener('DOMContentLoaded', function () {
    const sidebar = document.getElementById('sidebar'); // 사이드바
    const toggleBtn = document.getElementById('sidebarToggleBtn'); // 화살표 버튼
    const menuIcons = document.querySelectorAll('.menu-icon'); // 모든 아이콘 선택

    // 사이드바 열기 함수
    function openSidebar() {
        if (sidebar.classList.contains('close')) { // 닫혀 있는 경우에만 실행
            sidebar.classList.remove('close'); // 닫힘 제거
            sidebar.classList.add('open'); // 열림 추가
        }
    }

    // 화살표 버튼 클릭 시 토글
    toggleBtn.addEventListener('click', function () {
        sidebar.classList.toggle('close'); // 닫기/열기 토글
        sidebar.classList.toggle('open');
    });

    // 메뉴 아이콘 클릭 시 사이드바 열기
    menuIcons.forEach(icon => {
        icon.addEventListener('click', openSidebar); // 클릭 시 열림
    });

    // 디버깅 로그 추가
    //console.log('Sidebar initialized:', sidebar);
    //console.log('Toggle button initialized:', toggleBtn);
    //console.log('Menu icons initialized:', menuIcons);
});
