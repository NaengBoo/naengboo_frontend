import 'package:flutter/material.dart';

void showErrorOverlay(BuildContext context, String message) {
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 100, // 화면 하단에 배치
      left: MediaQuery.of(context).size.width * 0.2, // 중앙 정렬
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    ),
  );

  // 오버레이 추가
  overlayState?.insert(overlayEntry);

  // 1초 후 자동 삭제
  Future.delayed(const Duration(seconds: 1), () {
    overlayEntry.remove();
  });
}
