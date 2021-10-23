import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipe_app/controller/bookmark_manager.dart';
import 'package:recipe_app/model/recipe_model.dart' as recipe_model;
import 'package:recipe_app/views/video_player_view.dart';

class DetialViewExample extends StatefulWidget {
  late recipe_model.RecipeModel recipe;

  @override
  DetialViewExample({Key? key, required this.recipe}) : super(key: key);

  @override
  State<DetialViewExample> createState() => _DetialViewExampleState();
}

class _DetialViewExampleState extends State<DetialViewExample> {
  final BookmarkManager _bookmanager = BookmarkManager();
  recipe_model.RecipeModel? _bookmodel;
  bool isFavorite = false;

  Widget build(BuildContext context) {
    BookmarkManager.getRecipeByTitle(widget.recipe.title).then((model) {
      setState(() {
        isFavorite = model != null;
      });
      _bookmodel = model;
    });
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.network(
              widget.recipe.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.white12,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          VideoPlayerView(videoUrl: widget.recipe.video),
                    ));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.play_arrow,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 60,
                    ),
                    radius: 40,
                  ),
                ),
                const Spacer(),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color:
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(.6),
                  elevation: 0,
                  margin: const EdgeInsets.all(24),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 6,
                        ),
                        Center(
                          child: Container(
                            width: 60,
                            height: 8,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(90)),
                          ),
                        ),
                        Text(
                          widget.recipe.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.recipe.category,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.recipe.rate.toString(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          elevation: 0,
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(.6),
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  children: widget.recipe.ingredents.map((val) {
                                return Row(
                                  children: [
                                    Text(
                                      val.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      val.quantity,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                );
                              }).toList())),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.grey.shade300)),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: BackButton(),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _bookmodel == null
                            ? BookmarkManager.addRecipe(widget.recipe)
                            : BookmarkManager.delete(_bookmodel!.id);

                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: !isFavorite
                            ? const Icon(
                                Icons.bookmark_border_outlined,
                                color: Colors.black,
                              )
                            : const Icon(Icons.bookmark_border_outlined),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.grey.shade300))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
