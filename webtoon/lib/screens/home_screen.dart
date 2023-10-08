import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3, //elevation is a shadow func
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰s",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),

      ///statefullwidgetd을 사용하면 initstate을 사용하여 초기화 시켜주고
      ///future data를 받아오는 동안 setstate을 돌려주면서 refresh 시켜주는데,
      ///stateless를 사용하면 futurebuild라는 심박한 widget을 사용하여 future 맞춤 로직을 짤 수 있음
      body: FutureBuilder(
        future: webtoons,

        ///shapshot은 http로 받아오는 response 내용을 들고 있음
        ///snapshot dot 하고 나오는 option들 체크하여 사용. snapshot이라는 변수명은 마음대로 바꿀 수 있음
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ///데이터가 너무 많을 때는 column이나 row를 쓰지 않음. ListView를 사용하면 알아서 scrollview가 됨
            return ListView(
              children: [
                for (var webtoon in snapshot.data!) Text(webtoon.title)
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
