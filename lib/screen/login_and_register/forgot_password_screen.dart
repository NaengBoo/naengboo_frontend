import 'package:flutter/material.dart';
import 'package:naengboo_front_jw/screen/login_and_register/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  void resetPassword() {
    String email = emailController.text.trim();
    if (email.isNotEmpty) {
      // 여기에 비밀번호 재설정 로직 추가 (예: Firebase Auth)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("A reset link has been sent to $email")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your email")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('비밀번호 찾기', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Please enter your email to reset the password",
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Text("Your Email", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            CustomTextField(
              label: "email",
              controller: emailController,
              hintText: "Enter your email",
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade200,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text("Reset Password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
