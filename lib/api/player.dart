class Player {
  final String id;
  final String firstName;
  final String lastName;
  final String nickname;
  final int number;

  Player(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.nickname,
      required this.number});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        nickname: json['nickname'] ?? '',
        number: json['number']);
  }
}
