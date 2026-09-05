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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,

      // App Bar
      appBar: AppBarWidget(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        onSearchPressed: () {
          // Search will be added later
        },
      ),

      // Side Drawer
      drawer: _buildDrawer(),

      // Home Content
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(),

              const SizedBox(height: 25),

              _buildCategories(),

              const SizedBox(height: 30),

              _buildFeaturedSection(),

              const SizedBox(height: 30),

              _buildLatestNewsHeader(),

              const SizedBox(height: 10),

              _buildNewsList(),

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

  Widget _buildGreeting() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good Morning 👋',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),

        SizedBox(height: 5),

        Text(
          'What’s happening today?',
          style: TextStyle(
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

  Widget _buildFeaturedSection() {
    if (NewsData.news.isEmpty) {
      return const SizedBox.shrink();
    }

    final featuredNews = NewsData.news.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Featured News',
          style: TextStyle(
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

  Widget _buildLatestNewsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Latest News',
          style: TextStyle(
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
          child: const Text(
            'See all',
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // News List
  // ----------------------------------------------------------

  Widget _buildNewsList() {
    if (filteredNews.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Text(
            'No news found',
            style: TextStyle(
              color: Colors.grey,
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

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  'News',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.home_outlined,
              ),
              title: const Text(
                'Home',
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.bookmark_outline,
              ),
              title: const Text(
                'Saved',
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.settings_outlined,
              ),
              title: const Text(
                'Settings',
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