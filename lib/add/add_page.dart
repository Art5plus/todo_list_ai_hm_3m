import 'package:flutter/material.dart';
import 'package:todo_list08flu/database/todo.dart';
import 'dart:async';

import 'package:todo_list08flu/main.dart';
import 'package:todo_list08flu/utils/app_snackbar.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  //Выделяет память для виджета с состоянием
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _textEditingController = TextEditingController();

  //занимает память, то есть в этот момент виджет появляется в оперативной памяти
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //готовим данные, подгружаем данные с локального хранилища, с сервера посредстовм интернета
    //инициализируем свойства
    //запускать анимации, либо таймеры
    print("AddPage initState");
  }

  //рисует интерфейс
  @override
  Widget build(BuildContext context) {
    print("AddPage build");
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Добавить задачу"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 30, 22, 12),
          child: Column(
            children: [
              TextField(
                controller: _textEditingController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'введите название задачи',
                  hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 20,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: onSaveTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D82FF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Сохранить',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSaveTap() {
    final title = _textEditingController.text;
    try {
      saveToDatabase(title);
    } catch (e) {
      showAppSnackBar(
        text: e.toString(),
        backgroundColor: Colors.red,
        icon: Icons.error,
      );
    }
  }

  void saveToDatabase(String title) {
    final createdAt = DateTime.now().toString();
    if (title.length == 0) {
      throw TextFieldTitleException("Поле не должно быть пустым");
    } else {
      appDatabase.addTodo(
        Todo(id: 1, title: title, createdAt: createdAt, isDone: false),
      );
      Navigator.of(context).pop(_textEditingController.text);
    }
  }

  //уничтожает виджет из памяти (освобождает)
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("AddPage dispose");
    _textEditingController.dispose();
    //остановить анимацию
    //остановить таймер или другие фоновые процессы
    //остановить контроллеры
    //остановить стримы (stream)
  }
}

class TextFieldTitleException implements Exception {
  final String message;

  TextFieldTitleException(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return "$message";
  }
}
