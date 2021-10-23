import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/service/bookmark_recipe.dart';

class BookmarkManager {
  static final BookmarkService _bookmarkService = BookmarkService();
  static Future<List<RecipeModel>?> allBookmarks() async {
    // Directory _dir = await getApplicationDocumentsDirectory();
    // print(_dir.path);
    // String path = join(_dir.path, 'databases/recipe.db');
    await _bookmarkService.open('recipe.db');
    return _bookmarkService.getAllRecipe();
  }

  static Future<dynamic> addRecipe(RecipeModel recipe) async {
    await _bookmarkService.open('recipe.db');
    return _bookmarkService.insert(recipe);
  }

  static Future<RecipeModel?> getRecipeByTitle(String title) async {
    await _bookmarkService.open('recipe.db');
    return _bookmarkService.getRecipeByTitle(title);
  }

  static Future<int> deleteAll() async {
    return _bookmarkService.deleteAll();
  }

  static Future<int> delete(int? id) async {
    return _bookmarkService.delete(id!);
  }
}
