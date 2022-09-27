class MenuBanking {
  int? id;
  late String name;

  MenuBanking({
    this.id,
    required this.name,
  });

  MenuBanking.fromMap(dynamic obj) {
    this.id = obj['menuId'];
    this.name = obj['menuName'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'menuName': name,
    };

    return map;
  }
}
