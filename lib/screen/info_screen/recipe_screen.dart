import 'package:flutter/material.dart';

class RecipeScreen extends StatelessWidget {
  final String recipeTitle;

  const RecipeScreen({super.key, required this.recipeTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("레시피 - $recipeTitle")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: const [
                  Text("없는재료 목록", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 8),
                  Text("두부\n다진마늘\n고춧가루", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text("없는재료 사러가기"),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("✅ 만드는 순서", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("\u{1F4CC} 1) 육수 만들기 (멸치 & 다시마 육수)"),
                  Text("\u{1F4CC} 2) 국물 붓기"),
                  Text("\u{1F4CC} 3) 최소 5분 동안 끓이기"),
                  Text("\u{1F4CC} 4) 간 맞추기"),
                  Text("\u{1F4CC} 5) 마지막으로 완성하기!"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: const Text("출처에 대한 링크 보여주기", style: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text("애니메이션으로 보기"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "레시피 검색"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "찜한 레시피"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "내정보"),
        ],
      ),
    );
  }
}