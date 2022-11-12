import 'package:http/http.dart';
import 'package:kiwi/kiwi.dart';
import 'data/network/page_data_source.dart';
import 'data/repository/post_repository.dart';
import 'presentation/bloc/post_bloc.dart';

void initInjection() {
  KiwiContainer()
    ..registerInstance(Client())
    ..registerFactory((container) => PostDataSource(container.resolve()))
    ..registerFactory((container) => PostRepository(container.resolve()))
    ..registerFactory((container) => PostBloc(container.resolve()));
}
