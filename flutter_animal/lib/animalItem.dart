// ignore: unused import
import 'package:flutter/material.dart';

class Animal {
  String? imagePath; // dart는 원래 초기화 하지 않으면 에러 - 기본은 non-nullable
  String? animalName; // ?로 null일 수도 있음 표기
  String? kind;
  bool? flyExist = false;

  Animal(
      {required this.animalName, // required 키워드(null 안정성 체크)
      required this.kind,
      required this.imagePath,
      this.flyExist});
}
