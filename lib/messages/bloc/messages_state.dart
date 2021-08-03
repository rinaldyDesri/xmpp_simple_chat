part of 'messages_bloc.dart';

class MessagesState extends Equatable {
  final List<Message> messages;

  const MessagesState({
    this.messages = const <Message>[],
  });

  MessagesState copyWith({
    List<Message>? messages,
  }) {
    return MessagesState(messages: messages ?? this.messages);
  }

  @override
  String toString() {
    return '''MessageState { messages: ${messages.length} }''';
  }

  @override
  List<Object> get props => [messages];
}

class MessagesStateInitial extends MessagesState {}
