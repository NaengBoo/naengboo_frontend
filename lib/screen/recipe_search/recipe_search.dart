import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/home_screen/home_screen_nonlogin.dart';
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar.dart';
import 'package:naengboo_front_jw/screen/home_screen/home_screen.dart';
import 'package:naengboo_front_jw/models/recipe_dummy_data.dart';

class RecipeSearch extends StatefulWidget {
  @override
  State<RecipeSearch> createState() => _RecipeSearchState();
}

class _RecipeSearchState extends State<RecipeSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Image.asset(
                'asset/img/logo.png',
                height: 60,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '냉장고를 부탁해',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen_NonLogin()),
              );
            },
            child: Text('로그아웃', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: dummyRecipes.length,
        itemBuilder: (context, index) {
          final recipe = dummyRecipes[index];
          return ListTile(
            title: Text(recipe.name),
            subtitle: Text('재료: ${recipe.ingredients.join(', ')}'),
            trailing: IconButton(
              icon: Icon(
                recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: recipe.isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  recipe.isFavorite = !recipe.isFavorite;
                });
              },
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
                      child: const Text('닫기'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      bottomNavigationBar: BottomNavBar(),
    );
  }
}
