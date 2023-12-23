class FeedbackModel {
  final String barcode;
  final String profilePic;
  final String name;
  final int age;
  final String classes;

  FeedbackModel({
    required this.barcode,
    required this.profilePic,
    required this.name,
    required this.age,
    required this.classes,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      profilePic: json['ProfilePic'],
      barcode: json['Barcode'],
      name: json['Name'],
      age: json['Age'],
      classes: json['Class'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profilePic': profilePic,
      'Barcode': barcode,
      'Name': name,
      'Age': age,
      'Class': classes,
    };
  }}