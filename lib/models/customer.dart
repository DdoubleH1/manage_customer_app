class Customer {
  final int? id;
  final String name;
  final String emailAddress;
  final String phoneNumber;
  final String? gender;

  Customer(
      {this.id,
      required this.name,
      required this.emailAddress,
      required this.phoneNumber,
      this.gender
      });

  factory Customer.frommap(Map<String, dynamic> json) => Customer(
      id: json['id'],
      name: json['name'],
      emailAddress: json['email'],
      phoneNumber: json['phone'],
      gender: json['gender']
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': emailAddress,
      'phone': phoneNumber,
      'gender': gender
    };
  }
}
