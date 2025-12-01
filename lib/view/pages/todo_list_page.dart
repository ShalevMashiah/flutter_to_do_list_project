import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/todo_list/todo_list_bloc.dart';
import '../../bloc/todo_list/todo_list_event.dart';
import '../../bloc/todo_list/todo_list_state.dart';
import '../widgets/todo_item_widget.dart';
import '../../domain/model/data_classes/todo.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter To-Do List'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ADD TASK SECTION
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                // ADD TASK BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Task'),
                    onPressed: () {
                      if (_titleController.text.isNotEmpty) {
                        final todo = Todo(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: _titleController.text,
                          description: _descController.text,
                          createdAt: DateTime.now(),
                        );

                        context.read<TodoListBloc>().add(AddTodo(todo));

                        _titleController.clear();
                        _descController.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          // TASK LIST SECTION
          Expanded(
            child: BlocBuilder<TodoListBloc, TodoListState>(
              builder: (_, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // COUNTERS
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Pending: ${state.pending.length}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              'Completed: ${state.completed.length}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // PENDING TASKS
                      if (state.pending.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Pending Tasks',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ...state.pending
                          .map((todo) => TodoItemWidget(todo: todo)),

                      // COMPLETED TASKS
                      if (state.completed.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Completed Tasks',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ...state.completed
                          .map((todo) => TodoItemWidget(todo: todo)),

                      // EMPTY STATE
                      if (state.todos.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              'No tasks yet. Add some!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
