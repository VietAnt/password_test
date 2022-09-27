class Category {
  int? id;
  late String name;

  Category({
    this.id,
    required this.name,
  });

  Category.fromMap(dynamic obj) {
    this.id = obj['categoryId'];
    this.name = obj['categoryName'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'categoryName': name,
    };

    return map;
  }
}
