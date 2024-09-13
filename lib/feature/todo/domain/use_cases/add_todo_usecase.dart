import 'package:dartz/dartz.dart';
import 'package:todo_app_clean_architecture/core/errors/failure.dart';
import 'package:todo_app_clean_architecture/core/usecase.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/entities/todo.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/repositories/todo_repo.dart';

class AddTodoUsecase implements Usecase<Todo, Params<Todo>> {
  final TodoRepo repo;
  AddTodoUsecase(this.repo);

  @override
  Future<Either<Failure, Todo>> call(Params<Todo> todo) async {
    return await repo.addTodo(todo.data);
  }
}