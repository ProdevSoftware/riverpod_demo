import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/user/data/models/user_response_model.dart';
import 'package:riverpod_demo/user/domain/repositories/user_repository.dart';

final userUseCaseProvider = Provider(
  (ref) => UserUseCase(
    repository: ref.read(userRepositoryProvider),
  ),
);

class UserUseCase {
  UserUseCase({required this.repository});

  final UserRepository repository;

  Future<(String?, List<User>?)> userList() async {
    return await repository.userList();
  }
}
