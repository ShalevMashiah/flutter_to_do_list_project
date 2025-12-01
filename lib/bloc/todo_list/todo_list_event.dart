import 'package:equatable/equatable.dart';
import '../../domain/model/data_classes/todo.dart';

abstract class TodoListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTodo extends TodoListEvent {
  final Todo todo;
  AddTodo(this.todo);

  @override
  List<Object?> get props => [todo];
}

class ToggleTodo extends TodoListEvent {
  final String id;
  ToggleTodo(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteTodo extends TodoListEvent {
  final String id;
  DeleteTodo(this.id);

  @override
  List<Object?> get props => [id];
}

class EditTodo extends TodoListEvent {
  final String id;
  final String newTitle;
  final String newDescription;

  EditTodo({
    required this.id,
    required this.newTitle,
    required this.newDescription,
  });

  @override
  List<Object?> get props => [id, newTitle, newDescription];
}
