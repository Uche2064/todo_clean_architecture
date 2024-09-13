import 'package:get/get.dart';
import 'package:todo_app_clean_architecture/feature/todo/data/database/todo_remote_db.dart';
import 'package:todo_app_clean_architecture/feature/todo/data/repo/todo_repo_impl.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/repositories/todo_repo.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/use_cases/add_todo_usecase.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/use_cases/delete_todo_usecase.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/use_cases/edit_todo_usecase.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/use_cases/list_todo_usecase.dart';
import 'package:todo_app_clean_architecture/feature/todo/presentation/controller/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoRemoteDb>(() => TodoRemoteDbImpl());
    Get.lazyPut<TodoRepo>(() => TodoRepoImpl(remoteDb: Get.find()));
    Get.lazyPut(() => AddTodoUsecase(Get.find()));
    Get.lazyPut(() => ListTodoUsecase(Get.find()));
    Get.lazyPut(() => DeleteTodoUsecase(Get.find()));
    Get.lazyPut(() => EditTodoUsecase(Get.find()));
    Get.lazyPut<TodoController>(
      () => TodoController(
          addTodoUsecase: Get.find(),
          listTodoUsecase: Get.find(),
          deleteTodoUsecase: Get.find(),
          editTodoUsecase: Get.find()),
    );
  }
}
