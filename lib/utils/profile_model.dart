class Profile {
  final int? id;
  final String name;
  final String email;
  final String country;

  Profile(
      {this.id,
      required this.name,
      required this.email,
      required this.country});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'country': country,
    };
  }
}
