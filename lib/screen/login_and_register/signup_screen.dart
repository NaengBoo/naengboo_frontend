import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/login_and_register/widgets/custom_text_field.dart';
import 'package:naengboo_front_jw/screen/login_and_register/login_screen.dart';
import 'package:naengboo_front_jw/screen/login_and_register/forgot_password_screen.dart';
import 'package:naengboo_front_jw/screen/home_screen/home_screen_nonlogin.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            // 앱 로고
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen_NonLogin()), // HomeScreen은 홈 화면 위젯
                );
              },
              child: Image.asset(
                'asset/img/logo.png',
                height: 60,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "회원가입",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // 이메일 입력 필드
            const CustomTextField(
              label: "Email Address",
              hintText: "Enter your email",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 15),

            // 전화번호 입력 필드
            const CustomTextField(
              label: "Phone Number",
              hintText: "Enter your phonenumber",
              keyboardType: TextInputType.phone,
              prefixText: "+82 ",
            ),
            const SizedBox(height: 15),

            // 비밀번호 입력 필드
            CustomTextField(
              label: "Password",
              hintText: "Please Enter Your Password",
              obscureText: obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

            // "Remember Me" & "Forgot Password"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),
                    const Text("Remember Me"),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()), // 이동할 화면
                    );
                  },
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 회원가입 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),

            // 로그인 링크
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()), // 이동할 화면
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
