part of 'user_notifier.dart';

enum UserStatus {
  none,
  success,
  error,
  loading,
}

@freezed
class UserState with _$UserState {
  const factory UserState({
    required UserStatus userStatus,
    List<User>? users,
  }) = _UserState;

  factory UserState.initial() => const UserState(
        userStatus: UserStatus.none,
      );
}
