import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/models/recipe_dummy_data.dart';
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar.dart';

class RecipeListScreen extends StatefulWidget {
  final String theme;
  final List<String> selectedIngredients;

  const RecipeListScreen({
    super.key,
    required this.theme,
    required this.selectedIngredients,
  });

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<String> selectedRecipes = [];
  bool showAvailableOnly = false;
  String searchQuery = "";

  List<RecipeDummyData> getFilteredByTheme() {
    switch (widget.theme) {
      case '저칼로리':
        return dummyRecipes.where((r) => r.isLowCalorie).toList();
      case '채식':
        return dummyRecipes.where((r) => r.isVegetarian).toList();
      case '고단백':
        return dummyRecipes.where((r) => r.isHighProtein).toList();
      case '저탄고지':
        return dummyRecipes.where((r) => r.isLowCarbHighFat).toList();
      case '금방 만들 수 있는':
        return dummyRecipes.where((r) => r.isQuickToMake).toList();
      case '고칼로리':
        return dummyRecipes.where((r) => r.isHighCalorie).toList();
      default:
        return dummyRecipes;
    }
  }

  void toggleFavorite(RecipeDummyData recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
    });
  }

  @override //여기가 우리 앱 핵심 알고리즘 (재료를 기반으로 어떤 메뉴를 추천할 것인지)
  Widget build(BuildContext context) {
    List<RecipeDummyData> filteredRecipes = getFilteredByTheme();  // 1차 필터링 : 음식 테마에 따른

    if (searchQuery.isNotEmpty) {
      filteredRecipes = filteredRecipes
          .where((r) => r.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList(); // 2차 필터링 : 검색어에 따른
    }

    if (showAvailableOnly) {
      filteredRecipes = filteredRecipes
          .where((r) =>
          widget.selectedIngredients.any((ingredient) => r.requiredIngredients.join(', ').contains(ingredient)))
          .toList(); // 3차 필터링 : 음식에 들어가는 재료가 하나라도 있다면 뜸
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.theme} 레시피'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("있는 재료들로만 추천"),
                Checkbox(
                  value: showAvailableOnly,
                  onChanged: (value) => setState(() => showAvailableOnly = value!),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];
                  final isSelected = selectedRecipes.contains(recipe.name);

                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: Text(recipe.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('재료: ${recipe.requiredIngredients.join(', ')}'),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          IconButton(
                            icon: Icon(
                              recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: recipe.isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () => toggleFavorite(recipe),
                          ),
                          IconButton(
                            icon: Icon(
                              isSelected ? Icons.check_circle : Icons.add_circle_outline,
                              color: isSelected ? Colors.green : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                isSelected
                                    ? selectedRecipes.remove(recipe.name)
                                    : selectedRecipes.add(recipe.name);
                              });
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(recipe.name),
                            content: Text(recipe.instructions),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("닫기"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
