import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final String? prefixText;
  final TextEditingController? controller;
  final VoidCallback? onTap; // 추가됨

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixText,
    this.controller,
    this.onTap, // 추가됨
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 5),
        GestureDetector( // 클릭 감지 추가
          onTap: onTap,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              prefixText: prefixText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: suffixIcon,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            ),
            readOnly: onTap != null, // onTap이 있으면 키보드 입력 방지
          ),
        ),
      ],
    );
  }
}
