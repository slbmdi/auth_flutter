class UserModel {
  final int? id;
  final String firstName;
  final String lastName;
  final String mobile;

  const UserModel(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.mobile});
  
  UserModel.fromJson(Map json)
      : id = json['id'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        mobile = json['mobile'];
}
