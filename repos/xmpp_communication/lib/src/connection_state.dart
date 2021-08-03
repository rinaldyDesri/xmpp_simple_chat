import 'dart:async';

import 'package:xmpp_communication/src/message_listner.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

class ConnectionStateChangedListener
    implements xmpp.ConnectionStateChangedListener {
  late xmpp.Connection _connection;
  late MessagesListener _messagesListener;
  late StreamSubscription<String> _subscription;
  late xmpp.PresenceManager _presenceManager;
  late xmpp.RosterManager _rosterManager;
  late xmpp.MessageHandler _messageHandler;
  late String _receiver;

  MessagesListener get listener => _messagesListener;

  ConnectionStateChangedListener(
    xmpp.Connection connection,
    MessagesListener messagesListener,
    String receiver,
  )   : _connection = connection,
        _messagesListener = messagesListener,
        _receiver = receiver {
    xmpp.Log.logLevel = xmpp.LogLevel.VERBOSE;
    xmpp.Log.logXmpp = true;

    _connection.connectionStateStream.listen(onConnectionStateChanged);
  }

  @override
  void onConnectionStateChanged(xmpp.XmppConnectionState state) {
    print(state);

    if (state == xmpp.XmppConnectionState.Ready) {
      _messageHandler = xmpp.MessageHandler.getInstance(_connection);
      _rosterManager = xmpp.RosterManager.getInstance(_connection);
      _messageHandler.messagesStream.listen(_messagesListener.onNewMessage);

      final receiverJid = xmpp.Jid.fromFullJid(_receiver);

      _rosterManager.addRosterItem(xmpp.Buddy(receiverJid)).then((result) {
        if (result.description != null) {
          print('add roster ${result.description}');
        }
      });

      _presenceManager = xmpp.PresenceManager.getInstance(_connection);
      _presenceManager.presenceStream.listen(onPresence);
    }
  }

  void onPresence(xmpp.PresenceData event) {
    print(
        'presence Event from ${event.jid.fullJid} PRESENCE: ${event.showElement.toString()}');
  }

  void dispose() {
    _subscription.cancel();
    _connection.close();
  }
}
