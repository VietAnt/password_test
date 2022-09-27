class InterBanking {
  int? idbanking;
  int? usernamebanking;
  String? passwordbanking;
  String? category;

  //Contructor
  InterBanking({
    this.idbanking,
    this.usernamebanking,
    this.passwordbanking,
    this.category,
  });

  //FromMap:
  InterBanking.fromMap(dynamic obj) {
    this.idbanking = obj['bankingId'];
    this.usernamebanking = obj['bankingName'];
    this.passwordbanking = obj['bankingPasse'];
    this.category = obj['FK_banking_category'];
  }

  //ToMap
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'bankingName': usernamebanking,
      'bankingPasse': passwordbanking,
      'FK_banking_category': category,
    };
    return map;
  }
}
