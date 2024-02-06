import 'package:equatable/equatable.dart';
import '/features/batch/domain/entity/batch_entity.dart';
import '/features/course/domain/entity/course_entity.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final String phone;
  final BatchEntity batch;
  final List<CourseEntity> courses;
  final String username;
  final String password;

  @override
  List<Object?> get props =>
      [id, fname, lname, image, phone, batch, courses, username, password];

  const AuthEntity({
    this.id,
    required this.fname,
    required this.lname,
    this.image,
    required this.phone,
    required this.batch,
    required this.courses,
    required this.username,
    required this.password,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) => AuthEntity(
        id: json["id"],
        fname: json["fname"],
        lname: json["lname"],
        image: json["image"],
        phone: json["phone"],
        batch: BatchEntity.fromJson(json["batch"]),
        courses: List<CourseEntity>.from(
            json["courses"].map((x) => CourseEntity.fromJson(x))),
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fname": fname,
        "lname": lname,
        "image": image,
        "phone": phone,
        // ignore: prefer_null_aware_operators, unnecessary_null_comparison
        "batch": batch == null ? null : batch.toJson(),
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
        "username": username,
        "password": password,
      };
}
