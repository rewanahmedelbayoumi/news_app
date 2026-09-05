import 'package:flutter/material.dart';

import '../data/news_data.dart';
import '../models/news_model.dart';
import '../services/auth_service.dart';
import '../services/language_service.dart';
import '../services/theme_service.dart';
import '../widgets/app_bar.dart';
import '../widgets/category_chip.dart';
import '../widgets/featured_news.dart';
import '../widgets/news_card.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'saved_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final AuthService? authService;
  final ThemeService? themeService;
  final LanguageService? languageService;

  const HomeScreen({
    super.key,
    this.authService,
    this.themeService,
    this.languageService,
  });

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

  bool get isLoggedIn {
    return widget.authService?.isLoggedIn ?? false;
  }

  String translate(String key) {
    return widget.languageService?.translate(key) ?? key;
  }

  String translateCategory(String category) {
    switch (category) {
      case 'All':
        return translate('all');
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

  void _openLogin() {
    final authService = widget.authService;

    if (authService == null) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(
          authService: authService,
          languageService: widget.languageService,
        ),
      ),
    );
  }

  void _openRegister() {
    final authService = widget.authService;

    if (authService == null) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegisterScreen(
          authService: authService,
          languageService: widget.languageService,
        ),
      ),
    );
  }

  void _openSaved() {
    if (!isLoggedIn) {
      Navigator.pop(context);
      _openLoginRequired();
      return;
    }

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SavedScreen(
          authService: widget.authService!,
          languageService: widget.languageService!,
        ),
      ),
    );
  }

  void _openSettings() {
    Navigator.pop(context);

    final themeService = widget.themeService;
    final languageService = widget.languageService;

    if (themeService == null || languageService == null) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsScreen(
          themeService: themeService,
          languageService: languageService,
        ),
      ),
    );
  }

  void _openLoginRequired() {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              25,
              25,
              25,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant
                        .withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color:
                    colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outline,
                    size: 35,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  translate('login_required'),
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  translate('login_or_register'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _openLogin();
                    },
                    child: Text(
                      translate('login'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _openRegister();
                    },
                    child: Text(
                      translate('register'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBarWidget(
        languageService: widget.languageService!,
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
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              if (!isLoggedIn) ...[
                _buildLoginMessage(colorScheme),
                const SizedBox(height: 20),
              ],
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

  Widget _buildLoginMessage(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.onSurface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              color: colorScheme.surface,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  translate('get_full_experience'),
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  translate('login_to_save_read'),
                  style: TextStyle(
                    color:
                    colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _openLogin,
                      child: Text(
                        translate('login'),
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          decoration:
                          TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: _openRegister,
                      child: Text(
                        translate('register'),
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          decoration:
                          TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          translate('good_morning'),
          style: TextStyle(
            fontSize: 16,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          translate('whats_happening_today'),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryChip(
            title:
            translateCategory(categories[index]),
            isSelected:
            selectedCategory == index,
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

  Widget _buildFeaturedSection(
      ColorScheme colorScheme,
      ) {
    if (NewsData.news.isEmpty) {
      return const SizedBox.shrink();
    }

    final featuredNews = NewsData.news.first;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          translate('featured_news'),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        FeaturedNews(
          news: featuredNews,
          authService: widget.authService,
          languageService: widget.languageService,
        ),
      ],
    );
  }

  Widget _buildLatestNewsHeader(
      ColorScheme colorScheme,
      ) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(
          translate('latest_news'),
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
            translate('see_all'),
            style: TextStyle(
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewsList(
      ColorScheme colorScheme,
      ) {
    if (filteredNews.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
        ),
        child: Center(
          child: Text(
            translate('no_news_found'),
            style: TextStyle(
              color:
              colorScheme.onSurfaceVariant,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics:
      const NeverScrollableScrollPhysics(),
      itemCount: filteredNews.length,
      itemBuilder: (context, index) {
        final news = filteredNews[index];

        return NewsCard(
          key: ValueKey(news.title),
          news: news,
          authService: widget.authService,
          languageService: widget.languageService,
        );
      },
    );
  }

  Widget _buildDrawer(
      ColorScheme colorScheme,
      ) {
    return Drawer(
      backgroundColor: colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  translate('news'),
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
                translate('home'),
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
                translate('saved'),
                style: TextStyle(
                  color: colorScheme.onSurface,
                ),
              ),
              onTap: _openSaved,
            ),
            ListTile(
              leading: Icon(
                Icons.settings_outlined,
                color: colorScheme.onSurface,
              ),
              title: Text(
                translate('settings'),
                style: TextStyle(
                  color: colorScheme.onSurface,
                ),
              ),
              onTap: _openSettings,
            ),
            const Spacer(),
            if (!isLoggedIn) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _openLogin();
                    },
                    child: Text(
                      translate('login'),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _openRegister();
                    },
                    child: Text(
                      translate('register'),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}