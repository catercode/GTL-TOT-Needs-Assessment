import 'package:flutter/material.dart';
import 'package:recipe_app/controller/bookmark_manager.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/service/bookmark_recipe.dart';

//TODO: GET ALL BOOKMARKED RECIPES
//TODO: DELETE RECIPE

class BookmarkView extends StatefulWidget {
  BookmarkView({Key? key}) : super(key: key);

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  final BookmarkService _bookmarkService = BookmarkService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text('Bookmark'),
      ),
      body: FutureBuilder<List<RecipeModel>?>(
          future: BookmarkManager.allBookmarks(),
          builder: (context, snapshot) {
            return ListView(
              children: snapshot.data != null
                  ? snapshot.data!
                      .map(
                        (myid) => Card(
                          child: Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              // height: 80,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        myid.image,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                    myid.title,
                                  )),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        BookmarkManager.delete(myid.id)
                                            .then((_) {
                                          setState(() {});
                                        });
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.amberAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      )
                      .toList()
                  : [],
            );
          }),
    );
  }
}
