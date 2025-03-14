import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/login_and_register/login_screen.dart';
import 'package:naengboo_front_jw/screen/home_screen/home_screen_nonlogin.dart';
import 'package:naengboo_front_jw/screen/home_screen/widgets/error_message_popup.dart';

class BottomNavBarNonlogin extends StatelessWidget {
  const BottomNavBarNonlogin({super.key});

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
            MaterialPageRoute(builder: (context) => const HomeScreen_NonLogin()),
          );
        } else {
          showErrorOverlay(context, "로그인이 필요합니다.");
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          });
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