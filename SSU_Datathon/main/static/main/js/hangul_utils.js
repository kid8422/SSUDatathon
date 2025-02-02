import { disassemble, getChoseong } from 'https://cdn.jsdelivr.net/npm/es-hangul/+esm';

// 전역 객체(window)에 등록하여 다른 스크립트에서도 접근 가능하게 만듦
window.HangulUtils = {
    disassemble,
    getChoseong
};