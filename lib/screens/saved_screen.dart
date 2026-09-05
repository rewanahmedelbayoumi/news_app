import 'package:flutter/material.dart';

import '../services/saved_news_service.dart';
import '../widgets/news_card.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    final savedNews = SavedNewsService.savedNews;

    return Scaffold(
      // Saved is always Light
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

        title: const Text(
          'Saved',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: savedNews.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: savedNews.length,
        itemBuilder: (context, index) {
          return NewsCard(
            key: ValueKey(
              savedNews[index].title,
            ),
            news: savedNews[index],
          );
        },
      ),
    );
  }

  // ----------------------------------------------------------
  // Empty State
  // ----------------------------------------------------------

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bookmark_outline,
                size: 55,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'No Saved News',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Save articles you want to read later.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}