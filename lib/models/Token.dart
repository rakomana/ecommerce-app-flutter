class Token {
  String jwtToken;
  //Map<String ,dynamic> results;
  Token({
    this.jwtToken,
  });
  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      jwtToken: json["jwtToken"] as String,
    );
  }
}
