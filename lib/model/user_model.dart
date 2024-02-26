class UserModel {
  String? uId;
  String? fullName;
  String? emailAddress;
  String? number;
  String? address;
  String? gender;

  UserModel(
      {this.uId,
      this.fullName,
      this.emailAddress,
      this.number,
      this.address,
      this.gender});

  toJson() {
    return {
      'id': uId,
      'fullName': fullName,
      'email': emailAddress,
      'contact': number,
      'address': address,
      'gender': gender
    };
  }
}
