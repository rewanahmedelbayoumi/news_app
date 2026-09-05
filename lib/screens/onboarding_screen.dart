import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../services/language_service.dart';

class OnboardingScreen extends StatefulWidget {
  final AuthService authService;
  final LanguageService? languageService;

  const OnboardingScreen({
    super.key,
    required this.authService,
    this.languageService,
  });

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  final List<_OnboardingItem> pages = const [
    _OnboardingItem(
      icon: Icons.newspaper_rounded,
      titleKey: 'onboarding_title_1',
      descriptionKey: 'onboarding_description_1',
    ),
    _OnboardingItem(
      icon: Icons.public_rounded,
      titleKey: 'onboarding_title_2',
      descriptionKey: 'onboarding_description_2',
    ),
    _OnboardingItem(
      icon: Icons.bookmark_rounded,
      titleKey: 'onboarding_title_3',
      descriptionKey: 'onboarding_description_3',
    ),
  ];

  String translate(String key) {
    return widget.languageService?.translate(key) ?? key;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            25,
            30,
            25,
            25,
          ),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: _finishOnboarding,
                  child: Text(
                    translate('skip'),
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = pages[index];

                    return Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: colorScheme.onSurface,
                            borderRadius:
                            BorderRadius.circular(45),
                          ),
                          child: Icon(
                            page.icon,
                            size: 75,
                            color: colorScheme.surface,
                          ),
                        ),
                        const SizedBox(height: 55),
                        Text(
                          translate(page.titleKey),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: 29,
                            fontWeight: FontWeight.bold,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          translate(page.descriptionKey),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                            colorScheme.onSurfaceVariant,
                            fontSize: 15,
                            height: 1.6,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                      (index) {
                    final isActive =
                        index == currentPage;

                    return AnimatedContainer(
                      duration:
                      const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      width: isActive ? 28 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isActive
                            ? colorScheme.onSurface
                            : colorScheme
                            .surfaceContainerHighest,
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton(
                  onPressed: _nextPage,
                  child: Text(
                    currentPage == pages.length - 1
                        ? translate('get_started')
                        : translate('continue'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingItem {
  final IconData icon;
  final String titleKey;
  final String descriptionKey;

  const _OnboardingItem({
    required this.icon,
    required this.titleKey,
    required this.descriptionKey,
  });
}