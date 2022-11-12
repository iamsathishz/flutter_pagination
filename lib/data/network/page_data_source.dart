import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post_model.dart';
import '../../core/exception.dart';

const int MAX_SEARCH_RESULTS = 7;
int pageCount = 0;

class PostDataSource {
  final http.Client client;

  PostDataSource(this.client);

  Future<List<Postmodel>> getPost() async {
    pageCount = pageCount + 1;
    final String postBaseUrl =
        "https://jsonplaceholder.typicode.com/posts?_page=$pageCount&_limit=$MAX_SEARCH_RESULTS";
    final urlEncoded = Uri.encodeFull(postBaseUrl);
    try {
      final response = await client.get(Uri.parse(urlEncoded));
      if (response.statusCode == 200) {
        List<Postmodel> postList = [];
        for (var element in json.decode(response.body)) {
          final postItem = Postmodel.fromJson(element);
          postList.add(postItem);
        }
        return postList;
      } else {
        throw PostSearchException(
            json.decode(response.body)['error']['message']);
      }
    } catch (e) {
      throw SomethingWentWrongException();
    }
  }
}
