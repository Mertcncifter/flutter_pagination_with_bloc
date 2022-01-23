class User {
  String? id;
  String? guid;
  final String? name;

  User({
    this.id,
    this.guid,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": this.name,
      "guid": this.guid,
      "name": this.name,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final id = json["id"] as String;
    final guid = json["guid"] as String;
    final name = json["name"] as String;
    return User(id: id, guid: guid, name: name);
  }
}

class UserPageResponse {
  final List<User> userListings;
  UserPageResponse({required this.userListings});
  factory UserPageResponse.fromJson(dynamic json) {
    final userListings = (json as List)
        .map((listingJson) => User.fromJson(listingJson))
        .toList();
    return UserPageResponse(
      userListings: userListings,
    );
  }
}
