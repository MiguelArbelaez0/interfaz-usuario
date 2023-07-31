class UserData {
  late String name;
  late String last_name;
  late String mobile_phone;
  late String email;
  late String password;

  UserData(
    this.name,
    this.last_name,
    this.mobile_phone,
    this.email,
    this.password,
  );

  UserData.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    last_name = json["lastName"] ?? "";
    mobile_phone = json["mobilePhone"] ?? "";
    email = json["email"] ?? "";
    password = json["password"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "lastName": last_name,
      "mobilePhone": mobile_phone,
      "email": email,
      "password": password,
    };
  }
}
