import 'package:todo_list08flu/database/todo.dart';
import 'package:hive/hive.dart';

//Service
class AppDatabase {
  final Box box = Hive.box('todoBox');

  List<Todo> _todoList = [];

  AppDatabase() {
    loadTodos();
  }

  void loadTodos() {
    final data = box.get('todos', defaultValue: []);

    _todoList = List<Map>.from(data).map((e) {
      return Todo(
        id: e['id'],
        title: e['title'],
        createdAt: e['createdAt'],
        isDone: e['isDone'],
      );
    }).toList();
  }

  void saveTodos() {
    final data = _todoList.map((todo) {
      return {
        "id": todo.id,
        "title": todo.title,
        "createdAt": todo.createdAt,
        "isDone": todo.isDone,
      };
    }).toList();

    box.put('todos', data);
  }

  //CRUD operations
  //READ
  List<Todo> getTodoList() {
    return _todoList;
  }

  //CREATE
  void addTodo(Todo todo) {
    _todoList.insert(0, todo);
    saveTodos();
  }

  //UPDATE
  void updateTodo(int index, String title) {
    _todoList[index].title = title;
    saveTodos();
  }

  void updateTodoStatus(int index, bool isDone) {
    _todoList[index].isDone = isDone;
    saveTodos();
  }

  //DELETE
  void deleteTodo(int index) {
    _todoList.removeAt(index);
    saveTodos();
  }
}
