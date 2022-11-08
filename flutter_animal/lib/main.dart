import 'package:flutter/material.dart';
import 'animalItem.dart'; // 동물 정의
import 'sub/firstPage.dart'; // 첫 페이지
import 'sub/secondPage.dart'; // 두번째 페이지

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // 첫번째 화면 위젯S
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // 공룡 화면 영역

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  // ignore : library private types in public api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // 탭바 컨트롤러 vsync에 필요
  TabController? controller; // 탭바를 위한 탭 컨트롤러
  List<Animal> animalList = List.empty(growable: true); // 가변 리스트 활성화

  @override
  void initState() {
    // stateful의 초기화 메서드
    super.initState(); // 객체가 위젯 트리에 추가 될 때 호출됨
    controller = TabController(length: 2, vsync: this); // 컨트롤러 초기화, 2개 탭

    animalList.add(
        Animal(animalName: "벌", kind: "곤충", imagePath: "repo/images/bee.png"));
    animalList.add(Animal(
        animalName: "고양이", kind: "포유류", imagePath: "repo/images/cat.png"));
    animalList.add(Animal(
        animalName: "젖소", kind: "포유류", imagePath: "repo/images/cow.png"));
    animalList.add(Animal(
        animalName: "강아지", kind: "포유류", imagePath: "repo/images/dog.png"));
    animalList.add(Animal(
        animalName: "여우", kind: "포유류", imagePath: "repo/images/fox.png"));
    animalList.add(Animal(
        animalName: "원숭이", kind: "영장류", imagePath: "repo/images/monkey.png"));
    animalList.add(Animal(
        animalName: "돼지", kind: "포유류", imagePath: "repo/images/pig.png"));
    animalList.add(Animal(
        animalName: "늑대", kind: "포유류", imagePath: "repo/images/wolf.png"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Listview Example"),
        ),
        body: TabBarView(
          // 탭바 화면 정의
          controller: controller,
          children: <Widget>[
            FirstApp(list: animalList), // 첫 번째 페이지
            SecondApp(list: animalList) // 두 번째 페이지
          ],
        ),
        bottomNavigationBar: TabBar(
          // 하단 탭바 : 아이콘과 색상
          tabs: const <Tab>[
            Tab(
              icon: Icon(Icons.looks_one, color: Colors.blue),
            ),
            Tab(
              icon: Icon(Icons.looks_two, color: Colors.blue),
            )
          ],
          controller: controller,
        ));
  }

  @override
  void dispose() {
    // 컨트롤러 객체 제거
    controller?.dispose();
    super.dispose();
  }
}
