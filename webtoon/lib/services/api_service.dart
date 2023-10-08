//url로 뭔가를 가져오려면 http package를 설치해야 함
///flutter, dart의 추가 패키지를 설치하려면 pub.dev로 가서 필요한 패키지를 검색하면 됩
///검색으로 나온 패키지를 클릭하고 installing을 선택하면 필요한 방법들이 적혀 있음
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_model.dart';

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  //async keyword가 붙은 함수는 비동기 처리를 하겠다는 것이고 함수 안에 await keyword가 사용된다.
  //async를 쓸 경우 반환값에 Future<>를 감싸줘야 함 void일 때는 노상관
  Future<List<WebtoonModel>> getTodaysToons() async {
    //get은 http패키지에 있는 애인데 이름이 너무 범용적이어서 namefspace를 지정하여 http를 붙여줌
    //get 요청을 보낼 때는 Uri type으로 가져와야 하므로… (get 속성을 확인)
    final url = Uri.parse('$baseUrl/$today');

    ///http.get 동작은 실행 즉시 결과를 반환하는 것이 아니라 시간이 좀 걸림(네트워크 장애 등.. )
    ///http.get 속성을 보면 return type이 response이고 앞에 future가 붙는데, 이는 바로 결과를 반환하는 것이 아니라 나중에 반환한다는 것
    ///await keyword를 사용하지 않으면 이 함수를 실행하고 그냥 다음 스텝으로 가는데,
    ///현재는 get으로 오는 결과를 바로 다음 스텝에서 사용해야 하기 때문에 await keyword를 사용(결과를 기다리라는 의미)
    final response = await http.get(url);
    //http.get() 실행할 때 macos에서 "Unhandled Exception: Connection failed" 이런 에러가 뜨면 터미널에서 아래 명령어 수행
    ///flutter build macos
    ///open macos/Runner.xcworkspace
    ///실행하면 창이 뜨는 데, 거기서
    ///Runner/DebugProfile,  Runner/Release 두 항목을 찾아 com.apple.security.network.client 를 추가하고 true 설정을 해주면 됨. 맥은 보안 절차가 까다로워서 그런듯
    List<WebtoonModel> webtoonInstances = [];
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);

      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
