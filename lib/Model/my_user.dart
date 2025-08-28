class MyUser {
  final String uid;
  final String email;
  final String username;
  final String password;
  final String displayName;
  final String avatarUrl;
  final String gender;
  final bool isLoadingStartupData;
  final int accountCreated;

  MyUser({
    required this.uid,
    required this.email,
    this.password = "",
    this.username = "",
    this.displayName = "",
    this.avatarUrl = "",
    this.gender = "",
    this.isLoadingStartupData = true,
    this.accountCreated = 0,
  });

  // ✅ Create MyUser from Firestore document (Map)
  factory MyUser.fromDocument(Map<String, dynamic> doc) {
    return MyUser(
      uid: doc["uid"] ?? "",
      email: doc["email"] ?? "",
      password: doc["password"] ?? "",
      username: doc["username"] ?? "",
      displayName: doc["displayName"] ?? "",
      avatarUrl: doc["avatarUrl"] ?? "",
      gender: doc["gender"] ?? "",
      isLoadingStartupData: doc["isLoadingStartupData"] ?? true,
      accountCreated: doc["accountCreated"] ?? 0,
    );
  }

  // ✅ Create MyUser from Map (for consistency)
  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      uid: map["uid"] ?? "",
      email: map["email"] ?? "",
      password: map["password"] ?? "",
      username: map["username"] ?? "",
      displayName: map["displayName"] ?? "",
      avatarUrl: map["avatarUrl"] ?? "",
      gender: map["gender"] ?? "",
      isLoadingStartupData: map["isLoadingStartupData"] ?? true,
      accountCreated: map["accountCreated"] ?? 0,
    );
  }

  // ✅ Convert MyUser to JSON (Firestore safe)
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "password": password,
      "username": username,
      "displayName": displayName,
      "avatarUrl": avatarUrl,
      "gender": gender,
      "isLoadingStartupData": isLoadingStartupData,
      "accountCreated": accountCreated,
    };
  }

  // ✅ Convert MyUser to Map (general purpose)
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "password": password,
      "username": username,
      "displayName": displayName,
      "avatarUrl": avatarUrl,
      "gender": gender,
      "isLoadingStartupData": isLoadingStartupData,
      "accountCreated": accountCreated,
    };
  }
}
