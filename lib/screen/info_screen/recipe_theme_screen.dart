import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/info_screen/recipe_list_screen.dart'; // 레시피 리스트 화면
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar.dart';


class RecipeThemeScreen extends StatelessWidget {
  final List<String> selectedIngredients;

  const RecipeThemeScreen({super.key, required this.selectedIngredients});

  @override
  Widget build(BuildContext context) {
    List<String> themes = [
      "저칼로리", "채식", "고단백", "저탄고지", "금방 만들 수 있는", "고칼로리"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("식단 테마", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "식단 테마",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    textStyle: const TextStyle(fontSize: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeListScreen(
                          theme: "전체 레시피",
                          selectedIngredients: selectedIngredients,
                        ),
                      ),
                    );
                  },
                  child: const Text("전체 레시피"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero, // GridView 여백 제거하여 꽉 차게
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.8, // 박스 크기 조정
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: themes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeListScreen(
                            theme: themes[index],
                            selectedIngredients: selectedIngredients,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        themes[index],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(), // 분리한 위젯 사용
    );
  }
}