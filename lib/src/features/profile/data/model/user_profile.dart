class UserProfile {
  final String name;
  final String surname;
  UserProfile({
    required this.name,
    required this.surname,
  });

  UserProfile copyWith({
    String? name,
    String? surname,
  }) {
    return UserProfile(
      name: name ?? this.name,
      surname: surname ?? this.surname,
    );
  }
}
