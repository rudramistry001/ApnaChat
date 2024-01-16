// class ChatUser {

// ignore_for_file: non_constant_identifier_names

// }
class ChatUser {
  ChatUser({
    required this.IsOnline,
    required this.Email,
    required this.Id,
    required this.LastActive,
    required this.Image,
    required this.PushToken,
    required this.About,
    required this.Name,
    required this.CreatedAt,
  });
  late final bool IsOnline;
  late final String Email;
  late final String Id;
  late final String LastActive;
  late final String Image;
  late final String PushToken;
  late final String About;
  late final String Name;
  late final String CreatedAt;

  ChatUser.fromJson(Map<String, dynamic> json) {
    IsOnline = json['Is_Online'] ?? '';
    Email = json['Email'] ?? '';
    Id = json['Id'] ?? '';
    LastActive = json['Last_Active'] ?? '';
    Image = json['Image'] ?? '';
    PushToken = json['Push_Token'] ?? '';
    About = json['About'] ?? '';
    Name = json['Name'] ?? '';
    CreatedAt = json['Created_At'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Is_Online'] = IsOnline;
    data['Email'] = Email;
    data['Id'] = Id;
    data['Last_Active'] = LastActive;
    data['Image'] = Image;
    data['Push_Token'] = PushToken;
    data['About'] = About;
    data['Name'] = Name;
    data['Created_At'] = CreatedAt;
    return data;
  }
}
