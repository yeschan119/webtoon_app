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
            ///But, ListView는 모든 아이템을 한꺼번에 보여주기 때문에 이런식으로 쓰면 메모리가 터짐
            /*
            return ListView(
              children: [
                for (var webtoon in snapshot.data!) Text(webtoon.title)
              ],
            );
            */
            ///ListView.builder는 ListView의 upgrade 버전
            ///한번에 얼마만큼 보여줄지 선택하려면 ListView.builder widget사용
            ///itemBuilder는 ListView.builder가 아이템을 빌드할때 호출하는 함수. index는 현재 사용자가 보는 아이템의 index number.
            ///사용자가 현재 보지 않는 아이템은 메모리에서 날림
            ///builder대신에 seperated를 쓰면 builder에 separatorBuilder라는 게 추가됨
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              //한번에 얼마만큼 보여줄지 선택
              //여기로 들어올 때는 데이터 요청을 보내고 결과를 받는 순간이기 때문에 전체 데이터가 아닌 일부 데이터임
              //그 일부만 보여주는 거
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var webtoon = snapshot.data![index];
                return Text(webtoon.title);
              },
              //이 웨젯을 사용하면 아이템 사이에 뭔가를 추가할 수 있음
              separatorBuilder: (context, index) => const SizedBox(
                width: 20,
              ),
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
