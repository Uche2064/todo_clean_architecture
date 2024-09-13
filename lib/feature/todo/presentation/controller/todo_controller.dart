import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_clean_architecture/core/usecase.dart';
import 'package:todo_app_clean_architecture/core/utils/random_id.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/entities/todo.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/use_cases/add_todo_usecase.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/use_cases/delete_todo_usecase.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/use_cases/edit_todo_usecase.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/use_cases/list_todo_usecase.dart';
import 'package:uuid/uuid.dart';

class TodoController extends GetxController {
  RxInt count = 0.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var uuid = const Uuid();
  final AddTodoUsecase addTodoUsecase;
  final ListTodoUsecase listTodoUsecase;
  final DeleteTodoUsecase deleteTodoUsecase;
  final EditTodoUsecase editTodoUsecase;
  TodoController({
    required this.addTodoUsecase,
    required this.listTodoUsecase,
    required this.deleteTodoUsecase,
    required this.editTodoUsecase,
  });

  Future<void> addTodo() async {
    Todo newTodo = Todo(
      id: RandomId.getRandomId(),
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
    );
    final results = await addTodoUsecase.call(Params(newTodo));

    results.fold((failure) {
      Get.snackbar(
        'Error',
        failure.message,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }, (todo) {
      clearControllers();

      Get.snackbar(
        'Success',
        'Todo added successfully',
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    });
  }

  Stream<List<Todo>> listTodo() async* {
    final result = await listTodoUsecase.call(NoParams());

    yield* result.fold((failure) {
      Get.snackbar(
        'Error',
        failure.message,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return Stream.value([]);
    }, (listTodo) {
      return listTodo;
    });
  }

  Future<void> deleteTodo(Todo todo) async {
    final result = await deleteTodoUsecase.call(Params(todo));

    result.fold((failure) {
      Get.snackbar(
        'Error',
        failure.message,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }, (_) {
      Get.snackbar(
        'Success',
        'Todo deleted successfully',
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    });
  }

  Future<void> editTodo(Todo todo) async {
    Todo updatedTodo = Todo(
        id: todo.id,
        title: titleController.text.trim(),
        description: descriptionController.text.trim());
    final result = await editTodoUsecase.call(Params(updatedTodo));

    result.fold((failure) {
      Get.snackbar(
        'Error',
        failure.message,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }, (todo) {
      Get.snackbar(
        'Success',
        'Todo edited successfully',
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    });
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
  }
}
