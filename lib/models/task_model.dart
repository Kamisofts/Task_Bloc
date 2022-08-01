import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String title;
  final String description;
  final String id;
  bool? isDone;
  bool? isDeleted;

  TaskModel(
      {required this.id,
      required this.title,
      required this.description,
      this.isDone = false,
      this.isDeleted = false});

  TaskModel copyWith(
      {String? id, String? title,String? description, bool? isDone, bool? isDeleted}) {
    return TaskModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isDone: isDone ?? this.isDone,
        isDeleted: isDeleted ?? this.isDeleted);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "isDone": isDone,
      "isDeleted": isDeleted
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map["id"] ?? '',
      title: map["title"] ?? '',
      description: map["description"] ?? '',
      isDone: map["isDone"] ?? '',
      isDeleted: map["isDeleted"] ?? '',
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        description ,
        isDone,
        isDeleted,
      ];
}
