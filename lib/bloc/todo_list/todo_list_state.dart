import 'package:equatable/equatable.dart';
import '../../domain/model/data_classes/todo.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;

  const TodoListState({this.todos = const []});

  TodoListState copyWith({List<Todo>? todos}) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }

  List<Todo> get completed => todos.where((t) => t.isDone).toList();
  List<Todo> get pending => todos.where((t) => !t.isDone).toList();

  @override
  List<Object?> get props => [todos];
}
