import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/home_screen/home_screen.dart';
import 'package:naengboo_front_jw/screen/home_screen/home_screen_nonlogin.dart';
import 'package:naengboo_front_jw/screen/home_screen/widgets/bottom_nav_bar.dart';

class LikedRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //메인 상단부의 '로고', '냉장고를 부탁해'
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row( // 여기 'Row'위젯에다가 로고랑, 우리 사이트명인 '냉장고를 부탁해' 넣었음. 근데 나중에 사이트명도 텍스트 말고 이미지로 같이 로고에 넣음 좋을것같음
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()), // HomeScreen은 홈 화면 위젯
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
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton( // 로그아웃 버튼
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen_NonLogin()), // 이동할 화면
              );
            },
            child: Text('로그아웃', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: Column( // '오늘의 레시피' Zone
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 130.0),
            child: Text('찜한 레시피가 없습니다.', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(), // 대부분의 화면에 이 바가 있어야 하므로 자주 써먹을 수 있게 따로 클래스화했음
    );
  }
}