import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    ///navigation으로 build하면 home screen이 사라지고 새로운 screen이 생성되므로 scaffold를 새로 만들어줌
    ///AppBar까지 리턴해주는 이유는 웹툰을 클릭했을 때 웹툰 타이틀을 AppBar에서 보여주고 싶어서
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3, //elevation is a shadow func
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
            ],
          ),
        ],
      ),
    );
  }
}
