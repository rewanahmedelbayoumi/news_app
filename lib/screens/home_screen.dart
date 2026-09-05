import 'package:flutter/material.dart';

import '../data/news_data.dart';
import '../models/news_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/category_chip.dart';
import '../widgets/featured_news.dart';
import '../widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
  GlobalKey<ScaffoldState>();

  int selectedCategory = 0;

  final List<String> categories = [
    'All',
    'Business',
    'Sports',
    'Technology',
    'Health',
  ];

  List<NewsModel> get filteredNews {
    if (selectedCategory == 0) {
      return NewsData.news;
    }

    return NewsData.news
        .where(
          (news) =>
      news.category == categories[selectedCategory],
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      key: _scaffoldKey,

      // Follows the selected Light/Dark theme
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBarWidget(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        onSearchPressed: () {},
      ),

      drawer: _buildDrawer(colorScheme),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(colorScheme),

              const SizedBox(height: 25),

              _buildCategories(),

              const SizedBox(height: 30),

              _buildFeaturedSection(colorScheme),

              const SizedBox(height: 30),

              _buildLatestNewsHeader(colorScheme),

              const SizedBox(height: 10),

              _buildNewsList(colorScheme),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // Greeting
  // ----------------------------------------------------------

  Widget _buildGreeting(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good Morning 👋',
          style: TextStyle(
            fontSize: 16,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'What’s happening today?',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // Categories
  // ----------------------------------------------------------

  Widget _buildCategories() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryChip(
            title: categories[index],
            isSelected: selectedCategory == index,
            onTap: () {
              setState(() {
                selectedCategory = index;
              });
            },
          );
        },
      ),
    );
  }

  // ----------------------------------------------------------
  // Featured News
  // ----------------------------------------------------------

  Widget _buildFeaturedSection(ColorScheme colorScheme) {
    if (NewsData.news.isEmpty) {
      return const SizedBox.shrink();
    }

    final featuredNews = NewsData.news.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured News',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        FeaturedNews(
          news: featuredNews,
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // Latest News Header
  // ----------------------------------------------------------

  Widget _buildLatestNewsHeader(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Latest News',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        TextButton(
          onPressed: () {
            setState(() {
              selectedCategory = 0;
            });
          },
          child: Text(
            'See all',
            style: TextStyle(
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // News List
  // ----------------------------------------------------------

  Widget _buildNewsList(ColorScheme colorScheme) {
    if (filteredNews.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Text(
            'No news found',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredNews.length,
      itemBuilder: (context, index) {
        final news = filteredNews[index];

        return NewsCard(
          key: ValueKey(news.title),
          news: news,
        );
      },
    );
  }

  // ----------------------------------------------------------
  // Drawer
  // ----------------------------------------------------------

  Widget _buildDrawer(ColorScheme colorScheme) {
    return Drawer(
      backgroundColor: colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  'News',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: colorScheme.onSurface,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: colorScheme.onSurface,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: Icon(
                Icons.bookmark_outline,
                color: colorScheme.onSurface,
              ),
              title: Text(
                'Saved',
                style: TextStyle(
                  color: colorScheme.onSurface,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: Icon(
                Icons.settings_outlined,
                color: colorScheme.onSurface,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: colorScheme.onSurface,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}