part of 'messages_bloc.dart';

abstract class MessagesEvent extends Equatable {
  final Message message;
  MessagesEvent(this.message);

  @override
  List<Object> get props => [];
}

class NewMessagesEvent extends MessagesEvent {
  NewMessagesEvent(message) : super(message);

  @override
  List<Object> get props => [message];
}
