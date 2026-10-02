import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list08flu/database/app_repository.dart';
import 'package:todo_list08flu/details/details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final AppRepository repo;

  DetailsCubit({required this.repo}) : super(DetailsState(status: .initial));

  void checkUpdates(int index, String controllerText, String title) {
    if (controllerText == title) {
      emit(state.copyWith(status: .initial));
    } else {
      emit(state.copyWith(status: .edited));
    }
    print("$controllerText, $title");
  }

  void updateTodo(int index, String title) {
    repo.updateTodo(index, title);
    emit(state.copyWith(status: .saved));
  }

  void deleteTodo(int index) {
    repo.deleteTodo(index);
  }
}
