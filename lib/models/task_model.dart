import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String title;
  final String description;
  final String id;
  final String date;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;

  TaskModel(
      {required this.id,
      required this.title,
      required this.date,
      required this.description,
      this.isFavorite = false,
      this.isDone = false,
      this.isDeleted = false});

  TaskModel copyWith(
      {String? id,
      String? title,
      String? description,
      String? date,
      bool? isDone,
      bool? isDeleted,
      bool? isFavorite}) {
    return TaskModel(
        id: id ?? this.id,
        title: title ?? this.title,
        date: date ?? this.date,
        description: description ?? this.description,
        isDone: isDone ?? this.isDone,
        isFavorite: isFavorite ?? this.isFavorite,
        isDeleted: isDeleted ?? this.isDeleted);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone,
      "isFavorite": isFavorite,
      "isDeleted": isDeleted
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map["id"] ?? '',
      title: map["title"] ?? '',
      description: map["description"] ?? '',
      date: map["date"] ?? '',
      isDone: map["isDone"] ?? '',
      isDeleted: map["isDeleted"] ?? '',
      isFavorite: map["isFavorite"] ?? '',
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        isDone,
        isDeleted,
        isFavorite ,
      ];
}
