import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjaz/common/router/blocs.dart';
import 'package:ninjaz/features/connection_status/applicataion/connection_status_bloc.dart';
import 'package:ninjaz/features/dashboard/application/posts/posts_bloc.dart';
import 'package:ninjaz/features/dashboard/presentation/widgets/post_card_item.dart';

class PostsTabScreen extends StatelessWidget {
  const PostsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ConnectionStatusBloc>(context).add(CheckConnectionStatus());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocProvider<PostsBloc>(
        create: (context) => Blocs.postsBloc()
          ..add(
            const GetPosts(
              pageIndex: 0,
              loadMore: false,
              isLoadingTab: true,
            ),
          ),
        child: const PostsList(),
      ),
    );
  }
}
