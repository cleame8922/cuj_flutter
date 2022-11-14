import 'package:flutter/material.dart';
import 'package:flutter_login/page/home_page.dart';
import 'package:flutter_login/page/login_page.dart'; // 기본 로그인 화면

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 1. 테마설정
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            primary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // 테두리 모양과 크기 설정
            ),
            minimumSize: Size(400, 60), // 텍스트 버튼 최소 사이즈
          ),
        ),
      ),
      initialRoute: "/login", // 네비게이터(화면 이동 시작)
      routes: {
        "/login": (context) => LoginPage(), // 현재는 첫번쨰 화면 메인(로그인) 페이지만 작성
        "/home": (context) => HomePage(),
      },
    );
  }
}
