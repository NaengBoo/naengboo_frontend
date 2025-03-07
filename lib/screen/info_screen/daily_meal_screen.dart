import 'package:flutter/material.dart';
import 'dart:math';
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar.dart';

class DailyMealScreen extends StatefulWidget {
  final List<String> selectedRecipes;

  const DailyMealScreen({super.key, required this.selectedRecipes});

  @override
  _DailyMealScreenState createState() => _DailyMealScreenState();
}

class _DailyMealScreenState extends State<DailyMealScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedMealType = "아침";
  Map<DateTime, Map<String, List<Map<String, dynamic>>>> mealPlan = {};

  final Map<String, String> recipeImages = {
    "고구마 구운 것": "https://source.unsplash.com/400x300/?sweet_potato",
    "포트닭": "https://source.unsplash.com/400x300/?chicken",
    "치킨 샐러드": "https://source.unsplash.com/400x300/?salad",
    "버거": "https://source.unsplash.com/400x300/?burger",
  };

  final Map<String, int> recipeCalories = {
    "고구마 구운 것": 315,
    "포트닭": 190,
    "치킨 샐러드": 220,
    "버거": 550,
  };

  void _addRecipes() {
    setState(() {
      mealPlan.putIfAbsent(selectedDate, () => {"아침": [], "점심": [], "저녁": []});
      widget.selectedRecipes.forEach((recipe) {
        mealPlan[selectedDate]![selectedMealType]!.add({
          'name': recipe,
          'image': recipeImages[recipe] ?? "https://via.placeholder.com/400",
          'calories': recipeCalories[recipe] ?? Random().nextInt(500),
        });
      });
    });
  }

  void _removeRecipe(DateTime date, String mealType, Map<String, dynamic> recipe) {
    setState(() {
      mealPlan[date]?[mealType]?.remove(recipe);
      if (mealPlan[date]![mealType]!.isEmpty) {
        mealPlan[date]!.remove(mealType);
      }
      if (mealPlan[date]!.isEmpty) {
        mealPlan.remove(date);
      }
    });
  }

  int _calculateDailyCalories() {
    if (mealPlan.containsKey(selectedDate)) {
      return mealPlan[selectedDate]!.values
          .expand((meal) => meal)
          .fold(0, (sum, item) => sum + ((item is Map<String, dynamic> && item.containsKey('calories')) ? (item['calories'] as int) : 0));
    }
    return 0; // mealPlan[selectedDate]가 존재하지 않으면 0 반환
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Meal Logging", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("선택된 날짜: ${selectedDate.toLocal()}".split(' ')[0],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                ),
              ],
            ),
            DropdownButton<String>(
              value: selectedMealType,
              onChanged: (value) {
                setState(() {
                  selectedMealType = value!;
                });
              },
              items: ["아침", "점심", "저녁"]
                  .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
                  .toList(),
            ),
            ElevatedButton(
              onPressed: _addRecipes,
              child: const Text("레시피 추가"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: mealPlan[selectedDate]?.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.key, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: entry.value.map((recipe) {
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    recipe['image'],
                                    width: 150,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(recipe['name'],
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      Text("${recipe['calories']} kcal", style: const TextStyle(fontSize: 14)),
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _removeRecipe(selectedDate, entry.key, recipe),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }).toList() ??
                    [],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Daily Calories: ${_calculateDailyCalories()} kcal",
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(), // 분리한 위젯 사용
    );
  }
}
