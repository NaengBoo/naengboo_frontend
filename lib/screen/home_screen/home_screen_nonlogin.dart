import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar_nonlogin.dart';
import 'package:naengboo_front_jw/screen/login_and_register/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen_NonLogin extends StatefulWidget {
  const HomeScreen_NonLogin({super.key});

  @override
  _HomeScreen_NonLoginState createState() => _HomeScreen_NonLoginState();
}

class _HomeScreen_NonLoginState extends State<HomeScreen_NonLogin> {
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
                  MaterialPageRoute(builder: (context) => LoginScreen()), // 이동할 화면
                );
              },
              child: const Text("로그인/회원가입", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("오늘의 레시피", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: recipeImageUrl.isNotEmpty
                  ? Image.network(
                recipeImageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              )
                  : Container(
                width: double.infinity,
                height: 180,
                color: Colors.grey[300], // 🔹 이미지가 없을 때 빈 박스 표시
                child: const Center(child: Text("이미지를 찾을 수 없습니다.")),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Section title", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Section", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavBarNonlogin(), // 분리한 위젯 사용
    );
  }
}
