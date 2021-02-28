class Tenant {
  int id;
  int userid;
  String username;
  String password;
  String fullname;
  String tinnumber;
  String companyname;
  String phonenumber;
  String address;

  Tenant(
      {this.id,
      this.username,
      this.password,
      this.fullname,
      this.tinnumber,
      this.companyname,
      this.phonenumber,
      this.address,
      this.userid});

  factory Tenant.fromMap(Map<String, dynamic> json) => new Tenant(
        id: json["id"],
        userid: json["userid"],
        username: json["username"],
        password: json["password"],
        fullname: json["fullname"],
        tinnumber: json["tinnumber"],
        companyname: json["companyname"],
        phonenumber: json["phonenumber"],
        address: json["address"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "password": password,
        "fullname": fullname,
        "tinnumber": tinnumber,
        "companyname": companyname,
        "phonenumber": phonenumber,
        "address": address,
      };

  static Map<String, dynamic> toJson(Tenant tenant) {
    return {
      "id": tenant.id,
      "userid": tenant.userid,
      "username": tenant.username,
      "password": tenant.password,
      "fullname": tenant.fullname,
      "tinnumber": tenant.tinnumber,
      "companyname": tenant.companyname,
      "phonenumber": tenant.phonenumber,
      "address": tenant.address,
    };
  }
}
