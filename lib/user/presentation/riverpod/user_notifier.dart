import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_demo/user/data/models/user_response_model.dart';
import 'package:riverpod_demo/user/domain/use_case/user_use_case.dart';

part 'user_state.dart';

part 'user_notifier.freezed.dart';

final userResultNotifier = NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);

class UserNotifier extends Notifier<UserState> {
  late UserUseCase useCase;

  @override
  UserState build() {
    useCase = ref.read(userUseCaseProvider);
    return UserState.initial();
  }

  Future<void> userList() async {

    try {
      state = state.copyWith(
        userStatus: UserStatus.loading,
      );
      final (
        String? errorMessage,
        List<User>? user,
      ) = await useCase.userList();
      if (errorMessage == null && user != null) {
        print('state if');
        state = state.copyWith(
          users: user,
          userStatus: UserStatus.success,
        );
      } else {
        print('state else');
        state = state.copyWith(
          userStatus: UserStatus.error,
        );
      }
    } catch (e, stackTrace) {
      Logger().e(e.toString());
      Logger().e(stackTrace.toString());
      state = state.copyWith(
        userStatus: UserStatus.error,
      );
    }
  }
}
