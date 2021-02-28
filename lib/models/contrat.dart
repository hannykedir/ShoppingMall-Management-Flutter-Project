class Contrat {
  int id;
  int tenantid;
  String roomnumber;
  String startdate;
  String enddate;
  double price;

  Contrat(
      {this.id,
      this.tenantid,
      this.roomnumber,
      this.startdate,
      this.enddate,
      this.price});

  factory Contrat.fromMap(Map<String, dynamic> json) => new Contrat(
        id: json["id"],
        tenantid: json["tenantid"],
        roomnumber: json["roomnumber"],
        startdate: json["startdate"],
        enddate: json["enddate"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tenantid": tenantid,
        "roomnumber": roomnumber,
        "startdate": startdate,
        "enddate": enddate,
        "price": price
      };

  static Map<String, dynamic> toJson(Contrat contrat) {
    return {
      "id": contrat.id,
      "tenantid": contrat.tenantid,
      "roomnumber": contrat.roomnumber,
      "startdate": contrat.startdate,
      "enddate": contrat.enddate,
      "price": contrat.price
    };
  }
}
