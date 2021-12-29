/*
Author: Passant Abdelgalil
Description: 
    The post header widget that contains blog name, follow button,
    and options icon
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/user_blog_view.dart';
import 'package:tumblrx/services/content.dart';
import 'package:tumblrx/utilities/constants.dart';

class PostHeader extends StatelessWidget {
  /// blog object of the post
  final int _index;
  final bool _showOptionsIcon;

  // constants to size widgets
  final double avatarSize = 40;
  final double postHeaderHeight = 60;

  PostHeader({@required int index, bool showOptionsIcon = true})
      : _index = index,
        _showOptionsIcon = showOptionsIcon;

  @override
  Widget build(BuildContext context) {
    final Post post =
        Provider.of<Content>(context, listen: false).posts[_index];

    final bool isRebloged = post.reblogKey != null && post.reblogKey.isNotEmpty;
    final bool showFollowButton = post.blogTitle !=
        Provider.of<User>(context, listen: false).getActiveBlogTitle();
    return SizedBox(
      height: postHeaderHeight,
      child: post.blogTitle == null
          ? Center(
              child: Icon(
                Icons.error,
              ),
            )
          : Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: InkWell(
                onTap: () => showBlogProfile(context, post.blogId),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    blogAvatar(post.blogAvatar),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          blogInfo(post.blogTitle, isRebloged, post.reblogKey),
                          showFollowButton
                              ? TextButton(
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                  onPressed: () =>
                                      Provider.of<User>(context, listen: false)
                                          .followUser(context, post.blogId),
                                  child: Text('Follow'),
                                )
                              : emptyContainer(),
                        ],
                      ),
                    ),
                    _showOptionsIcon
                        ? IconButton(
                            onPressed: () =>
                                showBlogOptions(post.publishedOn, context),
                            icon: Icon(Icons.more_horiz),
                          )
                        : emptyContainer(),
                  ],
                ),
              ),
            ),
    );
  }

  /// navigate to the blog screen to view blog info
  void showBlogProfile(BuildContext context, String blogId) {
    if (Provider.of<User>(context, listen: false).isUserBlog(blogId))
      Navigator.of(context).pushNamed('blog_screen');
    else {
   
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserBlogView(id: blogId,
                
                )),
      );
    }
  }

  /// callback to open a dialog with blog options
  void showBlogOptions(DateTime publishedOn, BuildContext context) {
    final String pinOptionMessage =
        'This will appear at the top of your blog and replace any previous pinned post.Are you sure?';
    final String muteNotificationMessage =
        'Would you like to mute push notifications for this particular post?';
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Pin post'),
            onTap: () => showAlert(pinOptionMessage, context, null, 'Pin'),
          ),
          ListTile(
            title: Text('Mute notifications'),
            onTap: () => showAlert(muteNotificationMessage, context,
                () => muteNotifications, 'Mute'),
          ),
          ListTile(
            title: Text('Copy link'),
            onTap: null,
          ),
        ],
      ),
    );
  }

  void muteNotifications(BuildContext context) {
    Provider.of<Content>(context, listen: false)
        .posts[_index]
        .mutePushNotification()
        .then((value) => null)
        .catchError((err) {
      showSnackBarMessage(context, 'Something went wrong', Colors.red);
    });
  }

  void showAlert(String alertMessage, BuildContext context,
      void Function() callBack, String confirmationText) {
    AlertDialog(
      actions: [
        TextButton(
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop('dialog'),
            child: Text('Nevermind'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.grey),
            )),
        TextButton(
            onPressed: callBack,
            child: Text(confirmationText),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary),
            )),
      ],
    );
  }

  Widget errorAvatar() => CircleAvatar(
        child: Icon(Icons.error),
      );

  Widget emptyContainer() => Container(
        width: 0,
        height: 0,
      );

  Widget blogInfo(String blogTitle, bool isRebloged, String reblogKey) =>
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 5.0),
        child: isRebloged
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    blogTitle,
                    style: TextStyle(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.repeat_outlined,
                        color: Colors.grey,
                      ),
                      Flexible(
                        child: Text(
                          reblogKey,
                          style: TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              )
            : Text(
                blogTitle,
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
      );

  Widget blogAvatar(String blogAvatar) => CachedNetworkImage(
        width: avatarSize,
        height: avatarSize,
        imageUrl: blogAvatar,
        placeholder: (context, url) => SizedBox(
          width: avatarSize,
          height: avatarSize,
          child: Center(child: const CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => errorAvatar(),
      );
}
