import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/home_screen/home_screen_nonlogin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String recipeImageUrl = ""; // 초기값을 빈 문자열로 설정
  String recipeName = "치킨 샐러드"; // 예제 레시피

  @override
  void initState() {
    super.initState();
    fetchRecipeImage(recipeName); // 화면이 처음 로드될 때 실행
  }

  // 🔹 Unsplash API를 사용하여 이미지 가져오는 함수
  Future<void> fetchRecipeImage(String query) async {
    final String accessKey = "YOUR_UNSPLASH_ACCESS_KEY"; //  Unsplash API 키 입력
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
            recipeImageUrl = ""; // 이미지가 없을 경우 빈 값 유지
          });
        }
      } else {
        throw Exception("Failed to load image");
      }
    } catch (e) {
      print("Error fetching image: $e");
      setState(() {
        recipeImageUrl = ""; // 오류 발생 시 기본값 유지
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
            Image.asset('asset/img/logo.png', width: 30, height: 30), // 로고 이미지
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
                  MaterialPageRoute(builder: (context) => HomeScreen_NonLogin()), // 이동할 화면
                );
              },
              child: const Text("로그아웃", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 150),
          Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("오늘의 레시피", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 여백 추가
            decoration: BoxDecoration(
              color: Colors.grey[300], // 연한 회색 배경
              borderRadius: BorderRadius.circular(20), // 둥근 모서리
            ),
            padding: EdgeInsets.all(8), // 이미지가 작아지도록 패딩 추가
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15), // 이미지도 둥글게
              child: Image.asset(
                'asset/img/recipe.png',
                width: double.infinity, // 부모 크기에 맞추되 패딩 때문에 작아짐
                height: 200, // 원하는 높이 설정
                fit: BoxFit.contain, // 배경이 보이도록 contain 사용
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
          Divider(),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(), // 분리한 위젯 사용
    );
  }
}