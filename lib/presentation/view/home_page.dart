import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../../data/model/post_model.dart';
import '../bloc/post_bloc.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  final _postBloc = KiwiContainer().resolve<PostBloc>();
  @override
  void initState() {
    _postBloc.add(FetchPostEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _postBloc,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(widget.title, style: const TextStyle(fontSize: 22)),
        ),
        body: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state.hasReachedEndOfResults) {
              showSnackBar(state.errorMessage);
            }
            if (state.hasError) {
              showSnackBar(state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state.isLoading && state.searchResults.isEmpty) {
              return _buildLoaderListItem();
            }
            if (state.searchResults.isNotEmpty) {
              return buildPostList(state);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget buildPostList(PostState state) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.separated(
        controller: scrollController,
        itemCount: _calculateListItemCount(state),
        itemBuilder: (BuildContext context, int index) {
          return index >= state.searchResults.length
              ? _buildLoaderListItem()
              : _post(state.searchResults[index]);
        },
        separatorBuilder: (context, index) {
          return const Divider(color: Colors.black);
        },
      ),
    );
  }

  int _calculateListItemCount(PostState state) {
    if (state.hasReachedEndOfResults) {
      return state.searchResults.length;
    } else {
      return state.searchResults.length + 1;
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        scrollController.position.extentAfter == 0) {
      _postBloc.add(FetchPostEvent());
    }
    return false;
  }

  Widget _buildLoaderListItem() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(color: Colors.black),
      ),
    );
  }

  Widget _post(Postmodel post) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${post.id}. ${post.title}",
            style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Text(post.body, style: const TextStyle(fontSize: 16.0))
        ],
      ),
    );
  }

  void showSnackBar(String message) {
    final snackBar =
        SnackBar(content: Text(message, style: const TextStyle(fontSize: 16)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _postBloc.close();
    super.dispose();
  }
}
