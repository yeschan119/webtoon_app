import 'package:flutter/material.dart';
import 'package:webtoon/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //모든 위젯은 key를 가지고 있고, 이 key는 flutter가 웨젯을 찾을 때 사용하는 ID 이다.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
