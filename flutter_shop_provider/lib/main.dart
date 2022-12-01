// ignore_for_file: unused_import

import 'dart:io'; // 윈도우 플랫폼 확인에 필요
import 'package:flutter/foundation.dart'; // Provider 및 웹(kIsWeb) 확인에 필요
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart'; // 플랫폼 별 윈도우 조정
import 'package:provider/provider.dart';
import 'package:flutter_shop_provider/common/theme.dart';
import 'package:flutter_shop_provider/models/cart.dart';
import 'package:flutter_shop_provider/models/catalog.dart';
import 'package:flutter_shop_provider/screens/cart.dart';
import 'package:flutter_shop_provider/screens/catalog.dart';
import 'package:flutter_shop_provider/screens/login.dart';

void main() {
  setupWindow(); // 플랫폼 체크 후 사이즈 설정
  runApp(const MyApp());
}

const double windowWidth = 400;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized(); // runApp 이전 실행에 바인딩 초기화
    setWindowTitle('Provider Demo');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get appTheme => null;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()), // 생성 부분 정의
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          // CatalogModel에 종속적
          create: (context) => CartModel(), // 초기 CatalogModel 처음 생성
          update: (context, catalog, cart) {
            // 종속된 데이터 변경되면 rebuild
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog; // 빈 경우 초기화
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const MyLogin(),
          '/catalog': (context) => const MyCatalog(),
          '/cart': (context) => const MyCart(),
        },
      ),
    );
  }
}
