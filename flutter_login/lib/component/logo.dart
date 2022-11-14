import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SVG 렌더링 패키지(파일 아님 : 공식 지원)

class Logo extends StatelessWidget {
  final String title;

  const Logo(this.title); // 로고에 들어갈 문자 설정

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          // svg 이미지 추가 및 크기 설정
          "assets/logo.svg",
          height: 70,
          width: 70,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold), // 문자 설정
        ),
      ],
    );
  }
}
