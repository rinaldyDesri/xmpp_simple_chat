import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({required this.body, required this.from});

  final String body;
  final String from;

  @override
  List<Object> get props => [from, body];
}
