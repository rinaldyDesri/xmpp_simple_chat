import 'package:authentication_repository/authentication_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xmpp_simple_chat/login/bloc/login_bloc.dart';

class MockAuthRepository extends Mock implements AuthenticationRepository {}

void main() {
  late LoginBloc loginBloc;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    loginBloc = LoginBloc(authenticationRepository: repository);
  });

  tearDown(() {
    loginBloc.close();
  });
}

void tearDown(Null Function() param0) {}

void setUp(Null Function() param0) {}
