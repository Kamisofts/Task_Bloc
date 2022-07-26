import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String title;
  bool? isDone;
  bool? isDeleted;

  TaskModel({required this.title, this.isDone = false, this.isDeleted = false});

  TaskModel copyWith({String? title, bool? isDone, bool? isDeleted}) {
    return TaskModel(
        title: title ?? this.title,
        isDone: isDone ?? this.isDone,
        isDeleted: isDeleted ?? this.isDeleted);
  }

  Map<String, dynamic> toMap() {
    return {"title": title, "isDone": isDone, "isDeleted": isDeleted};
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map["title"] ?? '',
      isDone: map["isDone"] ?? '',
      isDeleted: map["isDeleted"] ?? '',
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        isDone,
        isDeleted,
      ];
}
