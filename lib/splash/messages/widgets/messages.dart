import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmpp_simple_chat/messages/bloc/messages_bloc.dart';
import './message.dart' as widget;

class Messages extends StatefulWidget {
  late final ScrollController scroll;
  late final String me;
  Messages({Key? key, required this.scroll, required this.me})
      : super(key: key);

  @override
  _MessagesState createState() => _MessagesState(scroll, me);
}

class _MessagesState extends State<Messages> {
  late ScrollController scroll;
  late String me;
  _MessagesState(this.scroll, this.me);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MessagesBloc, MessagesState>(
        bloc: BlocProvider.of<MessagesBloc>(context),
        builder: (context, state) {
          return Container(
            child: ListView.builder(
              controller: scroll,
              itemCount: state.messages.length,
              itemBuilder: (BuildContext context, int index) {
                final fromMe = messageIsFromMe(state.messages[index].from);
                return widget.Messsage(
                    message: state.messages[index], fromMe: fromMe);
              },
            ),
          );
        },
      ),
    );
  }

  messageIsFromMe(String from) {
    final userAtDomain = from;
    final indexOfAt = userAtDomain.indexOf('@');

    if (indexOfAt > 0) {
      final user = userAtDomain.substring(0, indexOfAt);
      return user == me;
    }

    return false;
  }
}
