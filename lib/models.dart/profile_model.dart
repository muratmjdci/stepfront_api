
import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    ProfileModel({
        required this.userId,
        required this.name,
        required this.surname,
        required this.email,
        required this.phoneNumber,
        required this.languageCode,
        required this.profilePicturePath,
    });

    String userId;
    String name;
    String surname;
    String email;
    String phoneNumber;
    String languageCode;
    String profilePicturePath;

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        userId: json["userId"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        languageCode: json["languageCode"],
        profilePicturePath: json["profilePicturePath"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "surname": surname,
        "email": email,
        "phoneNumber": phoneNumber,
        "languageCode": languageCode,
        "profilePicturePath": profilePicturePath,
    };
}
