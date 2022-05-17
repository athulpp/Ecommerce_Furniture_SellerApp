class Address {
  String? name;
  String? address;
  String? pincode;
  String? PhoneNumber;

  Address({this.name, this.address, this.pincode, this.PhoneNumber});
  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "pincode": pincode,
        "phoneNumber": PhoneNumber
      };

  static Address fromJson(dynamic json) {
    print("${json['name']} ${json['address']}  ${json['pincode']}  ${json['phoneNumber']} ");
    return Address(
        name: json['name'],
        address: json['address'],
        pincode: json['pincode'],
        PhoneNumber: json['phoneNumber']);
  }

  // static fromMap(Map<String, dynamic> map) {}

  // toMap() {}
}
