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
   
    return Address(
        name: json['name'],
        address: json['address'],
        pincode: json['pincode'],
        PhoneNumber: json['phoneNumber']);
  }


}
