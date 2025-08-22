import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyUser {
  String? uid;
  String? email;
  String? password;
  String? username;
  String? displayName;
  String? avatarUrl;
  String? friendUid;
  String? chatRoomid;
  String? gender;
  String? phone;
  DateTime? accountCreeated;
  bool isLoadingStartupData;
  MyUser({
    this.uid,
    this.email,
    this.password,
    this.username,
    this.displayName,
    this.avatarUrl,
    this.friendUid,
    this.chatRoomid,
    this.gender,
    this.phone,
    this.accountCreeated,
    required this.isLoadingStartupData,
  });

  MyUser copyWith({
    String? uid,
    String? email,
    String? password,
    String? username,
    String? displayName,
    String? avatarUrl,
    String? friendUid,
    String? chatRoomid,
    String? gender,
    String? phone,
    DateTime? accountCreeated,
    bool? isLoadingStartupData,
  }) {
    return MyUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      friendUid: friendUid ?? this.friendUid,
      chatRoomid: chatRoomid ?? this.chatRoomid,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      accountCreeated: accountCreeated ?? this.accountCreeated,
      isLoadingStartupData: isLoadingStartupData ?? this.isLoadingStartupData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'password': password,
      'username': username,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'friendUid': friendUid,
      'chatRoomid': chatRoomid,
      'gender': gender,
      'phone': phone,
      'accountCreeated': accountCreeated?.millisecondsSinceEpoch,
      'isLoadingStartupData': isLoadingStartupData,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      uid: map['uid'] != null ? map['uid'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      displayName: map['displayName'] != null ? map['displayName'] as String : null,
      avatarUrl: map['avatarUrl'] != null ? map['avatarUrl'] as String : null,
      friendUid: map['friendUid'] != null ? map['friendUid'] as String : null,
      chatRoomid: map['chatRoomid'] != null ? map['chatRoomid'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      accountCreeated: map['accountCreeated'] != null ? DateTime.fromMillisecondsSinceEpoch(map['accountCreeated'] as int) : null,
      isLoadingStartupData: map['isLoadingStartupData'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) =>
      MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyUser(uid: $uid, email: $email, password: $password, username: $username, displayName: $displayName, avatarUrl: $avatarUrl, friendUid: $friendUid, chatRoomid: $chatRoomid, gender: $gender, phone: $phone, accountCreeated: $accountCreeated, isLoadingStartupData: $isLoadingStartupData)';
  }

  @override
  bool operator ==(covariant MyUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.email == email &&
      other.password == password &&
      other.username == username &&
      other.displayName == displayName &&
      other.avatarUrl == avatarUrl &&
      other.friendUid == friendUid &&
      other.chatRoomid == chatRoomid &&
      other.gender == gender &&
      other.phone == phone &&
      other.accountCreeated == accountCreeated &&
      other.isLoadingStartupData == isLoadingStartupData;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      email.hashCode ^
      password.hashCode ^
      username.hashCode ^
      displayName.hashCode ^
      avatarUrl.hashCode ^
      friendUid.hashCode ^
      chatRoomid.hashCode ^
      gender.hashCode ^
      phone.hashCode ^
      accountCreeated.hashCode ^
      isLoadingStartupData.hashCode;
  }
}
