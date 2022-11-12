part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class FetchPostEvent implements PostEvent {}
