// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../animalItem.dart'; // 동물 클래스 연동

class FirstApp extends StatelessWidget {
  final List<Animal> list; // Animal List 선언
  const FirstApp({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
            // 리스트 뷰 .빌더 방식으로 정의
            itemBuilder: (context, position) {
              return GestureDetector(
                // 이벤트 리스너 묶음
                child: Card(
                  // 카드 위젯과 함께 사용
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        // 이미지 추가
                        list[position].imagePath!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain, // 원본 비율 채우기
                      ),
                      Text(list[position].animalName!),
                    ],
                  ),
                ),
                onTap: () {
                  // 한번 터치
                  AlertDialog dialog = AlertDialog(
                    content: Text(
                      '이 동물은 ${list[position].kind} 입니다',
                      style: const TextStyle(fontSize: 30.0),
                    ),
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                },
                onLongPress: () {
                  // 길게 누르면
                  AlertDialog dialog = AlertDialog(
                    content: Text(
                      '현재 ${list[position].kind} 을 삭제합니다',
                      style: const TextStyle(fontSize: 30.0),
                    ),
                    actions: <Widget>[
                      // 다이얼로그 액션, 예/아니오
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'CANCEL'),
                        child: const Text('CANCEL'),
                      ),
                    ],
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                  list.removeAt(position);
                },
              );
            },
            itemCount: list.length), // 개수 만큼만 스크롤 제한
      ),
    );
  }
}
