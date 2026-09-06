import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/news_model.dart';

class SavedNewsService {
  static final List<NewsModel> _savedNews = [];

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static List<NewsModel> get savedNews =>
      List.unmodifiable(_savedNews);

  static bool isSaved(NewsModel news) {
    return _savedNews.any(
          (item) => item.title == news.title,
    );
  }

  static Future<void> loadSavedNews() async {
    final User? user = _auth.currentUser;

    if (user == null) {
      _savedNews.clear();
      return;
    }

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('saved_news')
          .orderBy(
        'savedAt',
        descending: true,
      )
          .get();

      final List<NewsModel> loadedNews = [];

      for (final document in snapshot.docs) {
        final data = document.data();

        loadedNews.add(
          NewsModel(
            category: data['category'] as String? ?? '',
            title: data['title'] as String? ?? '',
            description:
            data['description'] as String? ?? '',
            time: data['time'] as String? ?? '',
            image: data['image'] as String? ?? '',
          ),
        );
      }

      _savedNews
        ..clear()
        ..addAll(loadedNews);
    } catch (e) {
      debugPrint(
        'Failed to load saved news: $e',
      );
    }
  }

  static Future<void> toggleSaved(
      NewsModel news,
      ) async {
    final User? user = _auth.currentUser;

    if (user == null) {
      return;
    }

    final documentId = _createDocumentId(
      news.title,
    );

    final savedNewsReference = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('saved_news')
        .doc(documentId);

    final index = _savedNews.indexWhere(
          (item) => item.title == news.title,
    );

    try {
      if (index >= 0) {
        await savedNewsReference.delete();

        _savedNews.removeAt(index);
      } else {
        await savedNewsReference.set({
          'category': news.category,
          'title': news.title,
          'description': news.description,
          'time': news.time,
          'image': news.image,
          'savedAt': FieldValue.serverTimestamp(),
        });

        _savedNews.add(news);
      }
    } catch (e) {
      debugPrint(
        'Failed to update saved news: $e',
      );
      rethrow;
    }
  }

  static String _createDocumentId(String title) {
    final documentId = title
        .toLowerCase()
        .replaceAll(
      RegExp(r'[^a-z0-9]+'),
      '_',
    )
        .replaceAll(
      RegExp(r'^_+|_+$'),
      '',
    );

    if (documentId.isEmpty) {
      return 'saved_news_${title.hashCode}';
    }

    return documentId;
  }
}