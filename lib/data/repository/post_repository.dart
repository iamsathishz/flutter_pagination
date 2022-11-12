import '../../core/exception.dart';
import '../model/post_model.dart';
import '../network/page_data_source.dart';

class PostRepository {
  final PostDataSource _pageDataSource;
  PostRepository(this._pageDataSource);

  Future<List<Postmodel>> fetchPost() async {
    final postResults = await _pageDataSource.getPost();
    if (postResults.isEmpty) throw PostReachedException();
    return postResults;
  }
}
