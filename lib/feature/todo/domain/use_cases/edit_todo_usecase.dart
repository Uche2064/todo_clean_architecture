import 'package:dartz/dartz.dart';
import 'package:todo_app_clean_architecture/core/errors/failure.dart';
import 'package:todo_app_clean_architecture/core/usecase.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/entities/todo.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/repositories/todo_repo.dart';

class EditTodoUsecase implements Usecase<Todo, Params<Todo>> {

  final TodoRepo repo;
  EditTodoUsecase(this.repo);


  @override
  Future<Either<Failure, Todo>> call(Params<Todo> params) {
    return repo.editTodo(params.data);
  }
}