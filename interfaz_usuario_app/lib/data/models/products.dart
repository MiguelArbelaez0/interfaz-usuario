class LoginData {
  late String email;
  late String password;

  LoginData(
    this.email,
    this.password,
  );

  LoginData.fromJson(Map<String, dynamic> json) {
    email = json["email"] ?? "";
    password = json["password"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
