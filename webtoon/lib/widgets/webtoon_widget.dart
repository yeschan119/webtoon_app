import 'package:flutter/material.dart';
import 'package:webtoon/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ///route은 웨젯을 애니메이션 효과로 감싸서 스크린처럼 보이게 하는 것
        ///사실은 또 다른 위젯을 실행시켰을 뿐인데 새로운 화면으로 들어가는 듯한 효과를 줌
        ///보통 navigator로 route을 push한다고 함
        ///builder is a function to create route
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
            ),
            //fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 250,

            ///edge를 등굴게 하려고 borderRadius를 설정하는데 clipBehavior에서 부모의 침범여부?를 설정해 주어야 적용됨
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5,
                  offset: Offset(5, 5),
                  color: Colors.black45,
                ),
              ],
            ),
            child: Image.network(
              thumb,

              ///http에서 User-Agent는 서버 또는 클라이언트의 소프트웨어 버전이나 OS 버전을 나타내는 헤더인데, 얘를 넣어 줘야 이미지를 제대로 불러옴
              ///https://gist.github.com/preinpost/941efd33dff90d9f8c7a208da40c18a9
              headers: const {
                "User-Agent":
                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
