import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_list_event.dart';
import 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(const TodoListState()) {
    
    on<AddTodo>((event, emit) {
      final updatedTodos = List.of(state.todos)..add(event.todo);
      emit(state.copyWith(todos: updatedTodos));
    });

    on<ToggleTodo>((event, emit) {
      final updatedTodos = state.todos.map((todo) {
        if (todo.id == event.id) {
          if (!todo.isDone) {
            return todo.copyWith(
              isDone: true,
              completedAt: DateTime.now(),
            );
          } else {
            return todo.copyWith(
              isDone: false,
              completedAt: null,
            );
          }
        }
        return todo;
      }).toList();

      emit(state.copyWith(todos: updatedTodos));
    });

    on<DeleteTodo>((event, emit) {
      final updatedTodos = state.todos.where((todo) => todo.id != event.id).toList();
      emit(state.copyWith(todos: updatedTodos));
    });

    on<EditTodo>((event, emit) {
      final updatedTodos = state.todos.map((todo) {
        if (todo.id == event.id) {
          return todo.copyWith(
            title: event.newTitle,
            description: event.newDescription,
          );
        }
        return todo;
      }).toList();

      emit(state.copyWith(todos: updatedTodos));
    });
  }
}
