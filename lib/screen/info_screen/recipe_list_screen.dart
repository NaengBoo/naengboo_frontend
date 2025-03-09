import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/info_screen/daily_meal_screen.dart';
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar.dart';
import 'package:naengboo_front_jw/screen/info_screen/recipe_screen.dart';

class RecipeListScreen extends StatefulWidget {
  final String theme;
  final List<String> selectedIngredients;

  const RecipeListScreen({super.key, required this.theme, required this.selectedIngredients});

  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<String> selectedRecipes = []; // 선택된 레시피
  bool showAvailableOnly = false; // "있는 재료들로만 추천" 체크박스 상태
  String searchQuery = ""; // 검색어

  Map<String, List<Map<String, dynamic>>> recipes = {
    "저칼로리": [
      {"title": "닭가슴살 샐러드", "image": "https://source.unsplash.com/100x100/?chicken,salad", "favorite": false},
      {"title": "오트밀", "image": "https://source.unsplash.com/100x100/?oatmeal", "favorite": false}
    ],
    "채식": [
      {"title": "채소 볶음", "image": "https://source.unsplash.com/100x100/?vegetables", "favorite": false},
      {"title": "두부 샐러드", "image": "https://source.unsplash.com/100x100/?tofu", "favorite": false}
    ],
    "고단백": [
      {"title": "스테이크", "image": "https://source.unsplash.com/100x100/?steak", "favorite": false},
      {"title": "닭가슴살 스크램블", "image": "https://source.unsplash.com/100x100/?scramble,eggs", "favorite": false}
    ],
    "전체 레시피": [
      {"title": "닭가슴살 샐러드", "image": "https://source.unsplash.com/100x100/?chicken,salad", "favorite": false},
      {"title": "오트밀", "image": "https://source.unsplash.com/100x100/?oatmeal", "favorite": false},
      {"title": "채소 볶음", "image": "https://source.unsplash.com/100x100/?vegetables", "favorite": false},
      {"title": "두부 샐러드", "image": "https://source.unsplash.com/100x100/?tofu", "favorite": false},
      {"title": "스테이크", "image": "https://source.unsplash.com/100x100/?steak", "favorite": false},
      {"title": "닭가슴살 스크램블", "image": "https://source.unsplash.com/100x100/?scramble,eggs", "favorite": false}
    ],
  };

  void toggleFavorite(int index) {
    setState(() {
      recipes[widget.theme]![index]["favorite"] = !recipes[widget.theme]![index]["favorite"];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredRecipes = recipes[widget.theme] ?? [];

    // 검색어 필터 적용
    if (searchQuery.isNotEmpty) {
      filteredRecipes = filteredRecipes.where((recipe) {
        return recipe["title"].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    //"있는 재료들로만 추천" 필터 적용
    if (showAvailableOnly) {
      filteredRecipes = filteredRecipes.where((recipe) {
        return widget.selectedIngredients.any((ingredient) => recipe["title"].contains(ingredient));
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.theme} 레시피", style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: selectedRecipes.isNotEmpty
                ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DailyMealScreen(selectedRecipes: selectedRecipes),
                ),
              );
            }
                : null,
            child: Text(
              "추가하기",
              style: TextStyle(color: selectedRecipes.isNotEmpty ? Colors.blue : Colors.grey),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //  검색창 추가
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 10),

            //  "있는 재료들로만 추천" 체크박스
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("있는 재료들로만 추천"),
                Checkbox(
                  value: showAvailableOnly,
                  onChanged: (value) {
                    setState(() {
                      showAvailableOnly = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            //  레시피 리스트
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  var recipe = filteredRecipes[index];
                  bool isSelected = selectedRecipes.contains(recipe["title"]);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeScreen(recipeTitle: recipe["title"]),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: recipe["image"].isNotEmpty
                            ? Image.network(recipe["image"], width: 80, height: 80, fit: BoxFit.cover)
                            : Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        ),
                        title: Text(recipe["title"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text("사용 가능 재료: ${widget.selectedIngredients.join(', ')}"),
                        trailing: Wrap(
                          spacing: 8,
                          children: [
                            //  찜하기 버튼
                            IconButton(
                              icon: Icon(
                                recipe["favorite"] ? Icons.star : Icons.star_border,
                                color: recipe["favorite"] ? Colors.yellow : Colors.grey,
                              ),
                              onPressed: () => toggleFavorite(index),
                            ),
                            //  레시피 추가 버튼
                            IconButton(
                              icon: Icon(
                                isSelected ? Icons.check_circle : Icons.add_circle_outline,
                                color: isSelected ? Colors.green : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedRecipes.remove(recipe["title"]);
                                  } else {
                                    selectedRecipes.add(recipe["title"]);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
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
