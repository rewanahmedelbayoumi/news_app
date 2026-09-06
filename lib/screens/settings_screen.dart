import 'package:flutter/material.dart';

import '../services/language_service.dart';
import '../services/theme_service.dart';

class SettingsScreen extends StatefulWidget {
  final ThemeService themeService;
  final LanguageService languageService;

  const SettingsScreen({
    super.key,
    required this.themeService,
    required this.languageService,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

  final List<Map<String, String>> languages = const [
    {
      'code': 'en',
      'name': 'English',
      'nativeName': 'English',
    },
    {
      'code': 'ar',
      'name': 'Arabic',
      'nativeName': 'العربية',
    },
    {
      'code': 'es',
      'name': 'Spanish',
      'nativeName': 'Español',
    },
    {
      'code': 'fr',
      'name': 'French',
      'nativeName': 'Français',
    },
    {
      'code': 'de',
      'name': 'German',
      'nativeName': 'Deutsch',
    },
    {
      'code': 'ja',
      'name': 'Japanese',
      'nativeName': '日本語',
    },
    {
      'code': 'zh',
      'name': 'Chinese',
      'nativeName': '中文',
    },
  ];

  String translate(String key) {
    return widget.languageService.translate(key);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isDarkMode =
        widget.themeService.isDarkMode;

    final currentLanguage = languages.firstWhere(
          (language) =>
      language['code'] ==
          widget.languageService.languageCode,
      orElse: () => languages.first,
    );

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
        theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          translate('settings'),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            translate('preferences'),
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _SettingsSwitch(
            icon: Icons.notifications_none,
            title: translate('notifications'),
            subtitle: translate(
              'notifications_description',
            ),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),
          const SizedBox(height: 10),
          _SettingsSwitch(
            icon: Icons.dark_mode_outlined,
            title: translate('dark_mode'),
            subtitle: translate(
              'dark_mode_description',
            ),
            value: isDarkMode,
            onChanged: (value) {
              widget.themeService.toggleTheme(value);
            },
          ),
          const SizedBox(height: 30),
          Text(
            translate('general'),
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _SettingsOption(
            icon: Icons.language,
            title: translate('language'),
            subtitle: currentLanguage['nativeName']!,
            onTap: () {
              _showLanguageDialog(context);
            },
          ),
          _SettingsOption(
            icon: Icons.info_outline,
            title: translate('about'),
            subtitle: translate('about_description'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName:
                translate('application_name'),
                applicationVersion: '1.0.0',
                applicationLegalese:
                '© 2026 News App',
              );
            },
          ),
          _SettingsOption(
            icon: Icons.privacy_tip_outlined,
            title: translate('privacy_policy'),
            subtitle: translate(
              'privacy_description',
            ),
            onTap: () {
              _showPrivacyPolicy(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            translate('language'),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final language = languages[index];
                final code = language['code']!;

                final isSelected =
                    widget.languageService
                        .languageCode ==
                        code;

                return ListTile(
                  leading: Icon(
                    Icons.language,
                    color: colorScheme.onSurface,
                  ),
                  title: Text(
                    language['name']!,
                  ),
                  subtitle: Text(
                    language['nativeName']!,
                  ),
                  trailing: isSelected
                      ? Icon(
                    Icons.check,
                    color:
                    colorScheme.primary,
                  )
                      : null,
                  onTap: () async {
                    await widget.languageService
                        .changeLanguage(code);

                    if (!context.mounted) return;

                    Navigator.pop(dialogContext);

                    setState(() {});
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            translate('privacy_policy'),
          ),
          content: SingleChildScrollView(
            child: Text(
              translate('privacy_description'),
              style: TextStyle(
                color:
                colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                translate('close'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SettingsSwitch extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitch({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color:
        colorScheme.surfaceContainerHighest,
        borderRadius:
        BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: colorScheme.onSurface,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color:
                    colorScheme.onSurface,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: colorScheme
                        .onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _SettingsOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
          colorScheme.surfaceContainerHighest,
          borderRadius:
          BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: colorScheme.onSurface,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color:
          colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color:
        colorScheme.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }
}