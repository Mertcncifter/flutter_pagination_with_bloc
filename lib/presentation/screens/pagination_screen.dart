import 'dart:async';
import 'package:blocpagination/feature/pagination/bloc/pagination_bloc.dart';
import 'package:blocpagination/feature/pagination/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginationScreen extends StatefulWidget {
  const PaginationScreen({Key? key}) : super(key: key);

  @override
  _PaginationScreenState createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  final scrollController = ScrollController();
  void setupScrollController() {
    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PaginationBloc>(context)
            ..add(PaginationPageRequest());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: _userList(),
    );
  }

  Widget _userList() {
    return BlocBuilder<PaginationBloc, PaginationState>(
        builder: (context, state) {
      if (state is PaginationLoading && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<User> posts = [];
      bool isLoading = false;

      if (state is PaginationLoading) {
        posts = state.oldUser;
        isLoading = true;
      } else if (state is PaginationLoaded) {
        posts = state.users;
      }

      return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < posts.length)
            return _post(posts[index], context);
          else {
            Timer(Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });

            return _loadingIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: posts.length + (isLoading ? 1 : 0),
      );
    });
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _post(User post, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${post.id}",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(
            "${post.guid}",
          ),
          SizedBox(height: 10.0),
          Text(
            "${post.name}",
          ),
        ],
      ),
    );
  }
}
