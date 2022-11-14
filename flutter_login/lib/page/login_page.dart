import 'package:flutter/material.dart';
import 'package:flutter_login/component/custom_form.dart';
import 'package:flutter_login/component/logo.dart';
import 'package:flutter_login/size.dart';

const double small_gap = 5.0;
const double medium_gap = 10.0;
const double large_gap = 20.0;
const double xlarge_gap = 100.0;

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: xlarge_gap), // 자식 크기에 맞춰서 크기 지정됨
            Logo("Login"), // 로고 이미지 생성
            SizedBox(height: large_gap), // 1. 추가
            CustomForm(), // 2. 추가
          ],
        ),
      ),
    );
  }
}
