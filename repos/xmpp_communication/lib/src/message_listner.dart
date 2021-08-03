import 'package:xmpp_communication/xmpp_communication.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;
import 'dart:async';

class MessagesListener implements xmpp.MessagesListener {
  final _streamController = StreamController<Message>();

  Stream<Message> get messageStream async* {
    yield* _streamController.stream;
  }

  @override
  void onNewMessage(xmpp.MessageStanza message) {
    if (message.body != null) {
      print(
          'New Message from ${message.fromJid.userAtDomain} message: ${message.body}');
      _streamController
          .add(Message(message.fromJid.userAtDomain, message.body));
    }
  }

  dispose() {
    _streamController.close();
  }
}
