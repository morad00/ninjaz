import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ninjaz/common/constants/app_colors.dart';
import 'package:ninjaz/common/constants/asset_paths.dart';
import 'package:ninjaz/features/dashboard/domain/model/posts_model.dart';

class OfflinePostsTab extends StatelessWidget {
  const OfflinePostsTab({super.key, required this.postsList});

  final List<PostsListData> postsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: postsList.length,
      itemBuilder: (context, index) {
        final postItem = postsList[index];
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
                      backgroundImage: NetworkImage(postItem.owner.picture),
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
    );
  }
}
