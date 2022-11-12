part of 'post_bloc.dart';

@immutable
class PostState {
  final bool isLoading;
  final List<Postmodel> searchResults;
  final String errorMessage;
  final bool hasReachedEndOfResults;
  const PostState({
    required this.isLoading,
    required this.searchResults,
    required this.errorMessage,
    required this.hasReachedEndOfResults,
  });

  bool get hasError => errorMessage.isNotEmpty;

  factory PostState.initial() {
    return const PostState(
        errorMessage: '',
        isLoading: false,
        searchResults: [],
        hasReachedEndOfResults: false);
  }
  factory PostState.loading(List<Postmodel> data) {
    return PostState(
        errorMessage: '',
        isLoading: true,
        searchResults: data,
        hasReachedEndOfResults: false);
  }
  factory PostState.failure(List<Postmodel> data, {required String error}) {
    return PostState(
        errorMessage: error,
        isLoading: false,
        searchResults: data,
        hasReachedEndOfResults: false);
  }
  factory PostState.success(List<Postmodel> data) {
    return PostState(
        errorMessage: '',
        isLoading: false,
        searchResults: data,
        hasReachedEndOfResults: false);
  }
  factory PostState.pageReached(List<Postmodel> data,
      {required String message}) {
    return PostState(
        errorMessage: message,
        isLoading: false,
        searchResults: data,
        hasReachedEndOfResults: true);
  }
}
