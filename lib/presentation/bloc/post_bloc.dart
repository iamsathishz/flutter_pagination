import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/exception.dart';
import '../../../data/model/post_model.dart';
import '../../../data/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  PostBloc(this._postRepository) : super(PostState.initial()) {
    on<FetchPostEvent>(_fetchPostEvent);
  }

  FutureOr<void> _fetchPostEvent(
      FetchPostEvent event, Emitter<PostState> emit) async {
    emit(PostState.loading(state.searchResults));
    try {
      final searchResults = await _postRepository.fetchPost();
      emit(PostState.success(state.searchResults + searchResults));
    } on PostSearchException catch (e) {
      emit(PostState.failure(state.searchResults, error: e.errorMessage));
    } on SomethingWentWrongException catch (e) {
      emit(PostState.failure(state.searchResults, error: e.errorMessage));
    } on PostReachedException catch (e) {
      emit(PostState.pageReached(state.searchResults, message: e.errorMessage));
    }
  }
}
