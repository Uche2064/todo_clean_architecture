import 'package:dartz/dartz.dart';
import 'package:todo_app_clean_architecture/core/errors/failure.dart';
import 'package:todo_app_clean_architecture/core/usecase.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/entities/todo.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/repositories/todo_repo.dart';

class DeleteTodoUsecase implements Usecase<void, Params<Todo>>{

  final TodoRepo repo;
  DeleteTodoUsecase(this.repo);

  @override
  Future<Either<Failure, void>> call(Params<Todo> todo) {
    return repo.deleteTodo(todo.data);
  }
  
}