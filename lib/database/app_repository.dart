import 'package:todo_list08flu/database/app_database.dart';
import 'package:todo_list08flu/database/todo.dart';

abstract class AppRepository {
  List<Todo> getTodoList();

  void addTodo(Todo todo);

  void updateTodo(int index, String title);

  void updateTodoStatus(int index, bool isDone);

  void deleteTodo(int index);
}

class AppRepositoryImpl extends AppRepository {
  final AppDatabase db;

  AppRepositoryImpl({required this.db});

  @override
  List<Todo> getTodoList() {
    return db.getTodoList();
  }

  @override
  void addTodo(Todo todo) {
    db.addTodo(todo);
  }

  @override
  void updateTodo(int index, String title) {
    db.updateTodo(index, title);
  }

  @override
  void updateTodoStatus(int index, bool isDone) {
    db.updateTodoStatus(index, isDone);
  }

  @override
  void deleteTodo(int index) {
    db.deleteTodo(index);
  }
}
