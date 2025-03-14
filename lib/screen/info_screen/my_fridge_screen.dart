import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/info_screen/recipe_theme_screen.dart';
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar.dart';


class MyFridgeScreen extends StatefulWidget {
  const MyFridgeScreen({super.key});

  @override
  _MyFridgeScreenState createState() => _MyFridgeScreenState();
}

class _MyFridgeScreenState extends State<MyFridgeScreen> {
  final List<Map<String, dynamic>> _ingredients = [
    {'name': '닭', 'quantity': '2마리', 'selected': false},
    {'name': '달걀', 'quantity': 'n개', 'selected': false},
    {'name': '고추장', 'quantity': 'nCC', 'selected': false},
    {'name': '파', 'quantity': '1/2 대', 'selected': false},
    {'name': '양배추', 'quantity': '2개', 'selected': false},
    {'name': '사과', 'quantity': '', 'selected': false},
    {'name': '양파', 'quantity': '', 'selected': false},
    {'name': '밀가루', 'quantity': '', 'selected': false},
  ];

  void _addIngredient(String name, String quantity) {
    setState(() {
      _ingredients.add({'name': name, 'quantity': quantity, 'selected': false});
    });
    Navigator.pop(context); // 팝업 닫기
  }

  void _deleteIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _showAddIngredientDialog() {
    String newName = "";
    String newQuantity = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("재료 추가"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "재료 이름"),
                onChanged: (value) => newName = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "수량"),
                onChanged: (value) => newQuantity = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("취소"),
            ),
            TextButton(
              onPressed: () {
                if (newName.isNotEmpty) {
                  _addIngredient(newName, newQuantity);
                }
              },
              child: const Text("추가"),
            ),
          ],
        );
      },
    );
  }

  void _startCooking() {
    List<String> selectedItems = _ingredients
        .where((item) => item['selected'] == true)
        .map<String>((item) => item['name'] as String)
        .toList();

    if (selectedItems.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeThemeScreen(selectedIngredients: selectedItems),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("최소 한 개의 재료를 선택해주세요.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("my 냉장고", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _showAddIngredientDialog,
            child: const Text("재료추가", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _startCooking,
              child: const Text("선택한 재료로 요리하기"),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _ingredients.length,
                itemBuilder: (context, index) {
                  final ingredient = _ingredients[index];

                  return Card(
                    color: Colors.grey[300],
                    child: ListTile(
                      title: Text(ingredient['name'], style: const TextStyle(fontSize: 18)),
                      subtitle: Text(ingredient['quantity']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: ingredient['selected'],
                            onChanged: (value) {
                              setState(() {
                                ingredient['selected'] = value!;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteIngredient(index),
                          ),
                        ],
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