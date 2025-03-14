import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/home_screen/home_screen.dart';
import 'package:naengboo_front_jw/screen/recipe_search/recipe_search.dart';
import 'package:naengboo_front_jw/screen/liked_recipe/liked_recipe.dart';
import 'package:naengboo_front_jw/screen/info_screen/info_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecipeSearch()),
          );
        }
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LikedRecipe()),
          );
        }
        if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InfoScreen()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "레시피 검색"),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "찜한 레시피"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "내정보"),
      ],
    );
  }
}
