import 'package:flutter/foundation.dart';

import '../models/news_model.dart';

class SavedNewsService extends ChangeNotifier {
  static final List<NewsModel> _savedNews = [];

  static List<NewsModel> get savedNews =>
      List.unmodifiable(_savedNews);

  static bool isSaved(NewsModel news) {
    return _savedNews.any(
          (item) => item.title == news.title,
    );
  }

  static void toggleSaved(NewsModel news) {
    final index = _savedNews.indexWhere(
          (item) => item.title == news.title,
    );

    if (index >= 0) {
      _savedNews.removeAt(index);
    } else {
      _savedNews.add(news);
    }
  }
}