import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'package:xmpp_communication/xmpp_communication.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  late StreamSubscription<AuthenticationStatus> _authStreamSubscription;
  late StreamSubscription<Message> _messageStreamSubscription;

  final _userRepo;
  final _xmppManager;
  final _authRepo;

  UserRepository get userRepository => _userRepo;

  MessagesBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
    required XmppManager xmppManager,
  })  : _userRepo = userRepository,
        _xmppManager = xmppManager,
        _authRepo = authenticationRepository,
        super(MessagesStateInitial()) {
    _authStreamSubscription = _authRepo.status
        .listen((authenticationStatus) => authEvents(authenticationStatus));
  }

  authEvents(e) async {
    if (e == AuthenticationStatus.authenticated) {
      final user = await _userRepo.getUser();
      final receiver =
          user.username == 'aldy' ? 'aldy1@aldy1823.co' : 'aldy2@aldy1823.co';
      _xmppManager.connect(user.username, user.password, '127.0.0.1', receiver);

      _messageStreamSubscription =
          _xmppManager.listener.messageStream.listen((e) => messageHandler(e));
    }
  }

  messageHandler(Message m) {
    add(NewMessagesEvent(m));
  }

  send(String message) {
    _xmppManager.sendMessage(message);
  }

  @override
  Stream<MessagesState> mapEventToState(
    MessagesEvent event,
  ) async* {
    yield state.copyWith(
        messages: List.of(state.messages)
          ..add(Message(event.message.from, event.message.body)));
  }

  @override
  Future<void> close() {
    _authRepo.dispose();
    _xmppManager.dispose();

    _authStreamSubscription.cancel();
    _messageStreamSubscription.cancel();
    return super.close();
  }
}
