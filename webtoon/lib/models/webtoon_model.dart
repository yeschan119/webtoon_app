class WebtoonModel {
  final String title, thumb, id;

/*아래처럼 정석으로 하지 않고 named constructor라는 개념을 사용하면 좀 더 힙하게? 할 수 있음
  WebtoonModel({
    required this.title,
    required this.thumb,
    required this.id,
  });
*/
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
