import 'package:flutter/material.dart';

import '../models/news_model.dart';
import '../services/language_service.dart';
import '../services/saved_news_service.dart';

class NewsDetailsScreen extends StatefulWidget {
  final NewsModel news;
  final LanguageService? languageService;

  const NewsDetailsScreen({
    super.key,
    required this.news,
    this.languageService,
  });

  @override
  State<NewsDetailsScreen> createState() =>
      _NewsDetailsScreenState();
}

class _NewsDetailsScreenState
    extends State<NewsDetailsScreen> {
  bool isSaving = false;

  String translate(String key) {
    return widget.languageService?.translate(key) ?? key;
  }

  String translateCategory(String category) {
    switch (category) {
      case 'Business':
        return translate('business');
      case 'Sports':
        return translate('sports');
      case 'Technology':
        return translate('technology');
      case 'Health':
        return translate('health');
      default:
        return category;
    }
  }

  Future<void> _toggleSaved() async {
    if (isSaving) return;

    setState(() {
      isSaving = true;
    });

    await SavedNewsService.toggleSaved(widget.news);

    if (!mounted) return;

    setState(() {
      isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isSaved = SavedNewsService.isSaved(widget.news);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
          ),
        ),
        title: Text(
          translate('article'),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: isSaving ? null : _toggleSaved,
            icon: isSaving
                ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.onSurfaceVariant,
              ),
            )
                : Icon(
              isSaved
                  ? Icons.bookmark
                  : Icons.bookmark_outline,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
              child: Image.asset(
                widget.news.image,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (
                    context,
                    error,
                    stackTrace,
                    ) {
                  return Container(
                    width: double.infinity,
                    height: 250,
                    color:
                    colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.image_outlined,
                      size: 70,
                      color:
                      colorScheme.onSurfaceVariant,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color:
                      colorScheme.surfaceContainerHighest,
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                    child: Text(
                      translateCategory(
                        widget.news.category,
                      ).toUpperCase(),
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.news.title,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 28,
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 17,
                        color:
                        colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.news.time,
                        style: TextStyle(
                          color:
                          colorScheme.onSurfaceVariant,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text(
                    widget.news.description,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 17,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    translate('about_this_story'),
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    translate('story_details'),
                    style: TextStyle(
                      color:
                      colorScheme.onSurfaceVariant,
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}