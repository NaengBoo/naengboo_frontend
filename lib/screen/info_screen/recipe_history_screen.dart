import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar.dart';


class RecipeHistoryScreen extends StatelessWidget {
  const RecipeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("추천받은 레시피 기록"),
      ),
      body: const Center(
        child: Text("추천받은 레시피 기록 화면"),
      ),
      bottomNavigationBar: const BottomNavBar(), // 분리한 위젯 사용
    );
  }
}