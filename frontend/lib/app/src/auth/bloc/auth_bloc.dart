import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prymo_mobile_app/app/meta/constants.dart';
import 'package:prymo_mobile_app/app/src/auth/models/auth.models.dart';
import 'package:prymo_mobile_app/app/src/auth/repository/auth.repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is TriggerLogin) {
          try {
            emit(AuthLoading());
            LoginResponseModel? model =
                await authRepository.loginUser(event.model);

            if (model!.error) {
              emit(AuthLoadingError(model.data));
            } else {
              HiveRepository.saveToken(model.data);
              emit(AuthLoaded());
            }
          } catch (e) {
            print(e.toString());
            emit(AuthLoadingError("something went wrong, please try again"));
          }
        } else if (event is TriggerSignUp) {
           try {
            emit(AuthLoading());
            LoginResponseModel? model =
                await authRepository.registerUser(event.model);

            if (model.error) {
              emit(AuthLoadingError(model.data));
            } else {
              HiveRepository.saveToken(model.data);
              emit(AuthLoaded());
            }
          } catch (e) {
            print(e.toString());
            emit(AuthLoadingError("something went wrong, please try again"));
          }
        }
      },
    );
  }
}
