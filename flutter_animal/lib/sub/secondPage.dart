import 'package:flutter/material.dart';
import '../animalItem.dart';

// ignore: must_be_immutable
class SecondApp extends StatefulWidget {
  // 두번째 페이지는 stateful 위젯
  List<Animal> list;
  SecondApp({Key? key, required this.list}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SecondApp();
}

class _SecondApp extends State<SecondApp> {
  int _radioValue = 0;
  final nameController = TextEditingController(); // 텍스트 입력 반환
  bool flyExist = false;
  // ignore: prefer_typing_uninitialized_variables
  var _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('먼저 하단 텍스트 입력창에 동물의 이름을 입력합시다 :'),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text, // 텍스트 필드
                maxLines: 1,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Radio(
                        value: 0,
                        groupValue: _radioValue,
                        onChanged: _radioChange),
                    const Text('양서류'),
                    Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: _radioChange),
                    const Text('포충류'),
                    Radio(
                        value: 2,
                        groupValue: _radioValue,
                        onChanged: _radioChange),
                    const Text('포유류'),
                  ]),
              // ignore: sort_child_properties_last
              Row(children: <Widget>[
                const Text('날수 있나요?'),
                Checkbox(
                    value: flyExist,
                    onChanged: (bool? check) {
                      setState(() {
                        flyExist = check!;
                      });
                    })
              ], mainAxisAlignment: MainAxisAlignment.spaceAround),

              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal, // 가로 동물 리스트뷰
                  children: <Widget>[
                    GestureDetector(
                      // 제스터 이벤트 등록
                      child: Image.asset('repo/images/cow.png', width: 80),
                      onTap: () {
                        _imagePath = 'repo/images/cow.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('repo/images/pig.png', width: 80),
                      onTap: () {
                        _imagePath = 'repo/images/pig.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('repo/images/bee.png', width: 80),
                      onTap: () {
                        _imagePath = 'repo/images/bee.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('repo/images/cat.png', width: 80),
                      onTap: () {
                        _imagePath = 'repo/images/cat.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('repo/images/fox.png', width: 80),
                      onTap: () {
                        _imagePath = 'repo/images/fox.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('repo/images/monkey.png', width: 80),
                      onTap: () {
                        _imagePath = 'repo/images/monkey.png';
                      },
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                  child: const Text('동물 추가하기'),
                  onPressed: () {
                    var animal = Animal(
                        // 동물 클래스 초기화
                        animalName: nameController.value.text,
                        kind: getKind(_radioValue),
                        imagePath: _imagePath,
                        flyExist: flyExist);
                    AlertDialog dialog = AlertDialog(
                      title: const Text('동물 추가하기'),
                      content: Text(
                        '이 동물은 ${animal.animalName} 입니다 또 동물의 종류는 ${animal.kind}입니다.\n 이 동물을 추가하시겠습니까?',
                        style: const TextStyle(fontSize: 30.0),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            widget.list.add(animal); // 리스트에 새로운 동물 정보를 넣음
                            Navigator.of(context).pop();
                          },
                          child: const Text('예'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('아니요'),
                        ),
                      ],
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog);
                  })
            ],
          ),
        ),
      ),
    );
  }

  _radioChange(int? value) {
    setState(() {
      // 화면 다시 그리기
      _radioValue = value!;
    });
  }

  getKind(int radioValue) {
    switch (radioValue) {
      case 0:
        return "양서류";
      case 1:
        return "파충류";
      case 2:
        return "포유류";
    }
  }
}
