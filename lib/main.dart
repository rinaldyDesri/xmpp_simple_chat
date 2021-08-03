import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmpp_simple_chat/messages/bloc/messages_bloc.dart';
import 'package:xmpp_communication/xmpp_communication.dart';

import 'AppView.dart';
import 'authentication/bloc/authentication_bloc.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  final userRepository = UserRepository();
  runApp(MyApp(
    authenticationRepository:
        AuthenticationRepository(userRepository: userRepository),
    userRepository: userRepository,
    xmppManager: XmppManager(),
  ));
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final XmppManager xmppManager;

  MyApp({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
    required this.xmppManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AuthenticationBloc(
                    authenticationRepository: authenticationRepository,
                    userRepository: userRepository,
                  )),
          BlocProvider(
            lazy: false,
            create: (context) => MessagesBloc(
              authenticationRepository: authenticationRepository,
              userRepository: userRepository,
              xmppManager: xmppManager,
            ),
          )
        ],
        child: AppView(),
      ),
    );
  }
}
