import 'package:admin/src/app/users/models/user.model.dart';
import 'package:admin/src/app/users/repository/users.repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository repository;
  UserBloc(this.repository) : super(UserInitial()) {
    on<UserEvent>((event, emit) async{
       if (event is LoadUsers) {
          try {
            emit(UsersLoading());
            var users = await repository.getUsers();
            emit(UsersLoaded(users));
          } catch (e) {
            print(e.toString());

            emit(UsersLoadingError(e.toString()));
          }
        }
    });
  }
}
