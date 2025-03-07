import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("환경설정"),
      ),
      body: const Center(
        child: Text("환경설정 화면"),
      ),
      bottomNavigationBar: const BottomNavBar(), // 분리한 위젯 사용
    );
  }
}