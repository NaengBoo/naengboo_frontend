import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/home_screen/home_screen_nonlogin.dart';
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:naengboo_front_jw/screen/info_screen/my_fridge_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String recipeImageUrl = "";
  String recipeName = "치킨 샐러드";

  @override
  void initState() {
    super.initState();
    fetchRecipeImage(recipeName);
  }

  Future<void> fetchRecipeImage(String query) async {
    final String accessKey = "YOUR_UNSPLASH_ACCESS_KEY";
    final String url = "https://api.unsplash.com/search/photos?query=$query&client_id=$accessKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          setState(() {
            recipeImageUrl = data['results'][0]['urls']['regular'];
          });
        } else {
          setState(() {
            recipeImageUrl = "";
          });
        }
      } else {
        throw Exception("Failed to load image");
      }
    } catch (e) {
      print("Error fetching image: $e");
      setState(() {
        recipeImageUrl = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Image.asset('asset/img/logo.png', width: 30, height: 30),
            const SizedBox(width: 10),
            const Text(
              "냉장고를 부탁해",
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen_NonLogin()),
                );
              },
              child: const Text("로그아웃", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("오늘의 레시피", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'asset/img/recipe.png',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Noodle", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(height: 100), // 아래 버튼 공간 확보용
              ],
            ),
          ),
          // 🔽 65% 위치에 고정 버튼
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0,
            left: 40,
            right: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyFridgeScreen()),
                );
              },
              child: const Text(
                '레시피 추천받기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
