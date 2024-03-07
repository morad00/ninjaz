import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjaz/common/constants/app_colors.dart';
import 'package:ninjaz/common/constants/asset_paths.dart';
import 'package:ninjaz/features/dashboard/application/posts/posts_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostsList extends StatelessWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state.isLoadingTab) {
          return const Center(child: CupertinoActivityIndicator(color: AppColors.primaryColor));
        } else if (state.showErrorPage) {
          return Center(
            child: FilledButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: AppColors.secondaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onPressed: () {
                PostsEvents.getPosts(context, pageIndex: 0, loadMore: false);
              },
              child: const Text("No Internet connection\nRetry connecting",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
            ),
          );
        } else if (state.postsList.isEmpty) {
          return const Center(child: Text("Empty List"));
        } else {
          return SmartRefresher(
            controller: state.tabRefreshController,
            onRefresh: () => PostsEvents.refreshPostsList(context),
            onLoading: () => PostsEvents.loadMorePosts(
              context,
              pageIndex: state.postsPageIndex,
            ),
            enablePullDown: true,
            enablePullUp: true,
            child: ListView.builder(
              itemCount: state.postsList.length,
              itemBuilder: (context, index) {
                final postItem = state.postsList[index];
                return Card(
                  color: AppColors.whiteColor,
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Image.network(
                                postItem.owner.picture,
                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                  AssetPaths.imgIcon,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${postItem.owner.firstName} ${postItem.owner.lastName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${DateTime.now().difference(postItem.publishDate).inDays} days ago',
                              style: const TextStyle(color: AppColors.greyColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Image.network(
                          postItem.image,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            AssetPaths.imgLogo,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: postItem.tags.map(
                                (tag) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2),
                                    child: Chip(
                                      visualDensity: VisualDensity.compact,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      color: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) => AppColors.primaryColor.withOpacity(0.3),
                                      ),
                                      side: BorderSide.none,
                                      label: Text(tag),
                                    ),
                                  );
                                },
                              ).toList()),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          postItem.text,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.heart_fill),
                            const SizedBox(width: 5),
                            Text('${postItem.likes} likes'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
