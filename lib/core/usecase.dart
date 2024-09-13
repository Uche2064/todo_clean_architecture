import 'package:dartz/dartz.dart';
import 'package:todo_app_clean_architecture/core/errors/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class Params<T>  {
  final T data;
  Params(this.data);
}

class NoParams<T> {
  NoParams();
}
