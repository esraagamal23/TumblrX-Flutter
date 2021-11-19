import 'package:flutter/material.dart';
import 'package:tumblrx/Components/constant.dart';
import 'package:tumblrx/Components/edit/edit.dart';
import 'blog_screen_search/blog_screen_search.dart';

/// this class display header image of blog screen ,icons and drop down list
class HeaderImage extends StatefulWidget {
  @override
  _HeaderImageState createState() => _HeaderImageState();
}

class _HeaderImageState extends State<HeaderImage> {
  String selectItem = Constant.toLengthFifteen(Constant.tumblrsBlog[0]);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        ///the Top Icons (search /edit /share/setting)
        child: Container(
            margin: EdgeInsets.only(left: 15.0, top: 25),
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Text(selectItem,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    PopupMenuButton<dynamic>(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      onSelected: (value) {
                        setState(() {
                          ///every time we select item from drop down list
                          selectItem =
                              Constant.toLengthFifteen(value.toString());

                          ///function if numbers of character more than 15 make it 15
                        });
                      },
                      itemBuilder: (BuildContext context) {
                        return 
                        [
                          for (var i = 0; i < Constant.tumblrsBlog.length; i++)

                            ///loop  to display all blogs

                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Container(
                                    child: Image(
                                      height: 30,
                                      width: 30,
                                      image: AssetImage('images/avatar.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(Constant.tumblrsBlog[i])
                                ],
                              ),
                              value: Constant.tumblrsBlog[i],
                            ),
                          PopupMenuDivider(),
                          Constant.createNewTumblr(),

                          ///create new blogs
                        ];
                       },
                     )
                   ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, /// to start from  begining in vertical
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.search,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,

                            ///go to search pages
                            MaterialPageRoute(builder: (context) => Search()));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.color_lens),
                      color: Colors.white,
                      onPressed: () {
                        //go to edit page
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Edit()));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      color: Colors.white,
                      onPressed: () {
                        print('share is pressed');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      color: Colors.white,
                      onPressed: () {
                        print('setting is pressed');
                      },
                    ),
                  ],
                )
              ],
            )),
        //color: Colors.green,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Constant.headerImgPath),
                fit: BoxFit.fill)), //dummy image
        height: MediaQuery.of(context).size.height / 3.6, //(200)
      ),
      onTap: () {
        showModalBottomSheet(///to pop the bottom sheet when when click in header image
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            context: context,
            builder: Constant.buildBottomSheetHeaderImage);
      },
    );
  }
}
