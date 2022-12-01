import 'package:flutter/material.dart';

class CatalogModel {
  static List<String> itemNames = [
    // 정적 멤버 변수 : 리스트 선언, 클래스 이름으로 접근 가능
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];
  Item getById(int id) =>
      Item(id, itemNames[id % itemNames.length]); // 카탈로그 문자열 무작위 루프

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // 스크롤 시에 카탈로그의 위치 리턴
    return getById(position);
  }
}

@immutable // 불변 객체임을 명시
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  Item(this.id, this.name)
      : color = Colors.primaries[id % Colors.primaries.length]; // 견본 색상 랜덤 설정

  @override
  int get hashCode => id; // 불변 객체를 사용할 때 항상 hashCode 오버라이드

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
