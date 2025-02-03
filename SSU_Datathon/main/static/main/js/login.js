function getCookie(name) {
  let cookieValue = null;
  if (document.cookie && document.cookie !== '') {
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
      const cookie = cookies[i].trim();
      if (cookie.substring(0, name.length + 1) === (name + '=')) {
        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
        break;
      }
    }
  }
  return cookieValue;
}
const csrftoken = getCookie('csrftoken');

// 로그인 요청 예시
fetch('/login/', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-CSRFToken': csrftoken
  },
  body: JSON.stringify({
    username: 'myusername',
    password: 'mypassword'
  })
})
.then(response => response.json())
.then(data => {
  // ...
})
.catch(error => console.error(error));

// 파이차트 그리기
document.addEventListener("DOMContentLoaded", function() {
  // Canvas element
  const ctx = document.getElementById("myChart").getContext("2d");

  // 데이터 및 레이블
  const labels = [
    "총류","철학","종교","사회과학","자연과학",
    "기술과학","예술","언어","문학","역사"
  ];
  const dataValues = BOOK_COUNT_RESULT;
  const backgroundColors = [
    "#19aa51","#D61A30","#999798","#FF7F20","#5A4637",
    "#1EB0FF","#FFD525","#8BD529","#2C51B2","#8121C2"
  ];

  // 차트 생성
  new Chart(ctx, {
    type: 'pie', // 'pie' or 'doughnut'
    data: {
      labels: labels,
      datasets: [{
        label: '도서 권수',
        data: dataValues,
        backgroundColor: backgroundColors
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
          callbacks: {
            label: function(context) {
              const label = context.label || '';     // ex) "000", "100", ...
              const value = context.parsed ? context.parsed.toLocaleString() : '0';  // ex) 30, 40, ...
              
              // 000~900 레이블에 해당하는 한글 분류명 매핑
              const labelMap = {
                '총류': '000',
                '철학': '100',
                '종교': '200',
                '사회과학': '300',
                '자연과학': '400',
                '기술과학': '500',
                '예술': '600',
                '언어': '700',
                '문학': '800',
                '역사': '900',
              };
              
              const desc = labelMap[label] || '';  // 매핑된 분류명
    
              // Chart.js에서는 "문자열 배열"을 반환하면
              // 여러 줄로 툴팁이 표시됩니다.
              // 예: ["000 총류", "30권"] → 두 줄
              return [
                ` ${desc} ${label}`,  // "000 총류"
                `  ${value}권`         // "30권"
              ];
            }
          }
        }
      }
    }
  });
});