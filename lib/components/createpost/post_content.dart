import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tumblrx/components/createpost/post_text_field.dart';
import 'package:tumblrx/components/createpost/video_player_preview.dart';
import 'dart:io';
import 'package:tumblrx/utilities/constants.dart';

class PostContent extends StatelessWidget {
  final List<dynamic> postContent;

  PostContent({this.postContent});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getPostContent(),
    );
  }

  List<Widget> getPostContent() {
    List<Widget> postContentList = [];
    for (int i = 0; i < postContent.length; i++) {
      if (postContent[i]['type'] == PostContentType.text) {
        postContentList.add(
          PostTextField(
            index: i,
            focus: postContent[i]['content']['data'].focusNode,
            textStyle: postContent[i]['content']['data'].textStyle,
            textEditingController:
                postContent[i]['content']['data'].textEditingController,
          ),
        );
      } else if (postContent[i]['type'] == PostContentType.gif) {
        postContentList.add(Image.network(
          postContent[i]['content']['link'],
          headers: {'accept': 'image/*'},
        ));
      } else if (postContent[i]['type'] == PostContentType.link) {
        postContentList.add(AnyLinkPreview(
          link: postContent[i]['content']['link'],
          displayDirection: UIDirection.UIDirectionHorizontal,
          showMultimedia: false,
          bodyMaxLines: 5,
          bodyTextOverflow: TextOverflow.ellipsis,
          titleStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ));
      } else if (postContent[i]['type'] == PostContentType.image) {
        postContentList.add(kIsWeb
            ? Image.network(postContent[i]['content'].path)
            : Image.file(File(postContent[i]['content'].path)));
      } else if (postContent[i]['type'] == PostContentType.video) {
        postContentList
            .add(VideoPlayerPreview(file: postContent[i]['content']));
      }
    }
    return postContentList;
  }
}
