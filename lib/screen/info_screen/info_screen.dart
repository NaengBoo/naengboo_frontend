import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/info_screen/daily_meal_screen.dart'; // daily meal logging 화면
import 'package:naengboo_front_jw/screen/info_screen/my_fridge_screen.dart'; // my 냉장고 화면
import 'package:naengboo_front_jw/screen/info_screen/recipe_history_screen.dart'; // 추천받은 레시피 기록 화면
import 'package:naengboo_front_jw/screen/info_screen/settings_screen.dart'; // 환경설정 화면
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내정보", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    context,
                    Icons.fastfood,
                    "daily meal logging",
                    DailyMealScreen( selectedRecipes: [],), // 이동할 화면
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _infoCard(
                    context,
                    Icons.kitchen,
                    "my 냉장고",
                    MyFridgeScreen(), // 이동할 화면
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    context,
                    Icons.history,
                    "추천받은 레시피 기록",
                    RecipeHistoryScreen(), // 이동할 화면
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _infoCard(
                    context,
                    Icons.settings,
                    "환경설정",
                    const SettingsScreen(), // 이동할 화면
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(), // 분리한 위젯 사용
    );
  }

  Widget _infoCard(BuildContext context, IconData icon, String text, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 8),
            Text(text, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}