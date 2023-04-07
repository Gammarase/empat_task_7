import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../logic/logical_classes.dart';
import '../logic/logical_fuctions.dart';

class PostModel extends ChangeNotifier {
  Future<List<PostInfo>> postsContent = downloadAllPosts();
  final List<int> likedId = [];
  final List<int> selectedId = [];
  bool _whiteTheme = true;

  addLike(int id) {
    likedId.add(id);
    notifyListeners();
  }

  removeLike(int id) {
    likedId.remove(id);
    notifyListeners();
  }

  addSelection(int id) {
    selectedId.add(id);
    notifyListeners();
  }

  removeSelection(int id) {
    selectedId.remove(id);
    notifyListeners();
  }

  refreshPosts() {
    postsContent = downloadAllPosts();
    notifyListeners();
  }

  changeTheme() {
    whiteTheme = whiteTheme ? whiteTheme = false : whiteTheme = true;
  }

  set whiteTheme(bool v) {
    _whiteTheme = v;
    SharedPreferences.getInstance().then((pref) {
      pref.setBool('theme', v);
      notifyListeners();
    });
  }

  bool get whiteTheme {
    SharedPreferences.getInstance().then((pref) {
      _whiteTheme = pref.getBool('theme') ?? false;
      notifyListeners();
    });
    return _whiteTheme;
  }
}
