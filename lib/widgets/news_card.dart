import 'package:flutter/material.dart';

import '../models/news_model.dart';
import '../services/saved_news_service.dart';

class NewsCard extends StatefulWidget {
  final NewsModel news;

  const NewsCard({
    super.key,
    required this.news,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSaved = SavedNewsService.isSaved(widget.news);

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------------------------------------
          // News Image
          // --------------------------------------------------

          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              widget.news.image,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 110,
                  height: 110,
                  color: colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.image_outlined,
                    size: 35,
                    color: colorScheme.onSurfaceVariant,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 15),

          // --------------------------------------------------
          // News Content
          // --------------------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.news.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),

                    // --------------------------------------------------
                    // Save Button
                    // --------------------------------------------------

                    IconButton(
                      onPressed: () {
                        setState(() {
                          SavedNewsService.toggleSaved(widget.news);
                        });
                      },
                      icon: Icon(
                        isSaved
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        color: isSaved
                            ? colorScheme.onSurface
                            : colorScheme.onSurfaceVariant,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                // --------------------------------------------------
                // Title
                // --------------------------------------------------

                Text(
                  widget.news.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                // --------------------------------------------------
                // Description
                // --------------------------------------------------

                Text(
                  widget.news.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 7),

                // --------------------------------------------------
                // Time
                // --------------------------------------------------

                Text(
                  widget.news.time,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}