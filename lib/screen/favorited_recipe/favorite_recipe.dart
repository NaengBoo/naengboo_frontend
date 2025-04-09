import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/recipe_dummy_data.dart';
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar.dart';

class FavoriteRecipe extends StatefulWidget {
  const FavoriteRecipe({super.key});

  @override
  State<FavoriteRecipe> createState() => _FavoriteRecipeState();
}

class _FavoriteRecipeState extends State<FavoriteRecipe> {
  @override
  Widget build(BuildContext context) {
    // 화면을 갱신할 때마다 찜된 레시피 리스트를 다시 가져옴
    final favoriteRecipes = dummyRecipes.where((r) => r.isFavorited).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('찜한 레시피'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: favoriteRecipes.isEmpty
          ? const Center(
        child: Text('찜한 레시피가 없습니다.'),
      )
          : ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = favoriteRecipes[index];
          return ListTile(
            title: Text(recipe.name),
            subtitle: Text('재료: ${recipe.ingredients.join(', ')}'),
            trailing: IconButton(
              icon: Icon(
                recipe.isFavorited ? Icons.favorite : Icons.favorite_border,
                color: recipe.isFavorited ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  recipe.isFavorited = !recipe.isFavorited;
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
