import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/language_service.dart';
import '../services/saved_news_service.dart';
import '../widgets/news_card.dart';

class SavedScreen extends StatefulWidget {
  final AuthService authService;
  final LanguageService languageService;

  const SavedScreen({
    super.key,
    required this.authService,
    required this.languageService,
  });

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  String translate(String key) {
    return widget.languageService.translate(key);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final savedNews = SavedNewsService.savedNews;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: colorScheme.onSurface,
        ),
        title: Text(
          translate('saved'),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: savedNews.isEmpty
          ? _buildEmptyState(colorScheme)
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: savedNews.length,
        itemBuilder: (context, index) {
          return NewsCard(
            key: ValueKey(
              savedNews[index].title,
            ),
            news: savedNews[index],
            authService: widget.authService,
            languageService: widget.languageService,
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color:
                colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bookmark_outline,
                size: 55,
                color:
                colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              translate('no_saved_news'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              translate('save_articles_later'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}