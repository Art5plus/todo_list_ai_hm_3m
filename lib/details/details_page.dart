import 'package:flutter/material.dart';
import 'package:todo_list08flu/database/todo.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list08flu/details/details_cubit.dart';
import 'package:todo_list08flu/details/details_state.dart';
import 'package:todo_list08flu/main.dart';
import 'package:todo_list08flu/utils/app_snackbar.dart';

class DetailsPage extends StatefulWidget {
  final Todo todo;
  final DetailsCubit cubit;
  final int index;

  const DetailsPage({
    super.key,
    required this.index,
    required this.todo,
    required this.cubit,
  });

  @override
  //Выделяет память для виджета с состоянием
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late TextEditingController _textEditingController;
  late DetailsCubit _cubit;

  //занимает память, то есть в этот момент виджет появляется в оперативной памяти
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //готовим данные, подгружаем данные с локального хранилища, с сервера посредстовм интернета
    //инициализируем свойства
    //запускать анимации, либо таймеры
    print("AddPage initState");
    _cubit = widget.cubit;
    _textEditingController = TextEditingController(text: widget.todo.title);
  }

  //рисует интерфейс
  @override
  Widget build(BuildContext context) {
    print("AddPage build");
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Редактирование задачи"),
        actions: [
          IconButton(
            onPressed: () => _onDeleteTap(),
            icon: Icon(Icons.delete, color: Colors.blue),
          ),
        ],
      ),
      body: BlocListener<DetailsCubit, DetailsState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state.status == .saved) {
            showAppSnackBar(
              text: "Изменения успешно сохранены",
              backgroundColor: Colors.green,
              icon: Icons.check,
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 30, 22, 12),
            child: Column(
              children: [
                TextField(
                  controller: _textEditingController,
                  onChanged: (_) => _cubit.checkUpdates(
                    widget.index,
                    _textEditingController.text,
                    widget.todo.title,
                  ),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: widget.todo.title,
                    hintText: 'введите название задачи',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
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
                  child: BlocBuilder<DetailsCubit, DetailsState>(
                    builder: (context, state) {
                      if (state.status == .initial) {
                        return ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Сохранить',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      } else {
                        return ElevatedButton(
                          onPressed: _onSaveTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Сохранить',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSaveTap() async {
    _cubit.updateTodo(widget.index, _textEditingController.text);
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }

  void _onDeleteTap() {
    _cubit.deleteTodo(widget.index);
    Navigator.pop(context);
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
