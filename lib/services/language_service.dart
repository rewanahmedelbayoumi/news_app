import 'package:flutter/foundation.dart';

class LanguageService extends ChangeNotifier {
  String _languageCode = 'en';

  String get languageCode => _languageCode;

  static const List<String> supportedLanguages = [
    'en',
    'ar',
    'es',
    'fr',
    'de',
    'ja',
    'zh',
  ];

  void changeLanguage(String languageCode) {
    if (!supportedLanguages.contains(languageCode)) {
      return;
    }

    if (_languageCode == languageCode) {
      return;
    }

    _languageCode = languageCode;
    notifyListeners();
  }

  String translate(String key) {
    return _translations[_languageCode]?[key] ??
        _translations['en']?[key] ??
        key;
  }

  static const Map<String, Map<String, String>> _translations = {
    'en': {
      'news': 'News',
      'home': 'Home',
      'saved': 'Saved',
      'profile': 'Profile',
      'settings': 'Settings',
      'login': 'Login',
      'register': 'Register',
      'logout': 'Logout',
      'cancel': 'Cancel',
      'save': 'Save',
      'close': 'Close',
      'ok': 'OK',
      'language': 'Language',
      'notifications': 'Notifications',
      'dark_mode': 'Dark Mode',
      'about': 'About',
      'privacy_policy': 'Privacy Policy',
      'preferences': 'Preferences',
      'general': 'General',
      'featured_news': 'Featured News',
      'latest_news': 'Latest News',
      'see_all': 'See all',
      'no_news_found': 'No news found',
      'welcome': 'Welcome',
      'welcome_back': 'Welcome Back',
      'create_account': 'Create Account',
      'create_account_description':
      'Create an account to get the full News experience.',
      'edit_profile': 'Edit Profile',
      'saved_articles': 'Saved Articles',
      'reading_history': 'Reading History',
      'notification_preferences':
      'Notification Preferences',
      'login_required': 'Login Required',
      'login_or_register':
      'Login or create an account to continue.',
      'email': 'Email',
      'password': 'Password',
      'confirm_password': 'Confirm Password',
      'full_name': 'Full Name',
      'name': 'Name',
      'remember_me': 'Remember me',
      'forgot_password': 'Forgot Password?',
      'forgot_password_description':
      'Enter your email and we will send you a link to reset your password.',
      'send_reset_link': 'Send Reset Link',
      'already_have_account':
      'Already have an account?',
      'dont_have_account':
      "Don't have an account?",
      'good_morning': 'Good Morning 👋',
      'whats_happening_today':
      'What’s happening today?',
      'get_full_experience':
      'Get the full News experience',
      'login_to_save_read':
      'Login or register to save and read articles.',
      'article': 'Article',
      'about_this_story': 'About this story',
      'story_details':
      'This story provides the latest information and important updates about the topic.',
      'no_saved_news': 'No Saved News',
      'save_articles_later':
      'Save articles you want to read later.',
      'dark_mode_description':
      'Change the appearance of the app',
      'notifications_description':
      'Receive notifications about latest news',
      'about_description':
      'About this application',
      'privacy_description':
      'Read our privacy policy',
      'profile_updated':
      'Profile updated successfully.',
      'logged_out':
      'Logged out successfully.',
      'logout_confirmation':
      'Are you sure you want to logout?',
      'invalid_email_password':
      'Invalid email or password.',
      'fill_all_fields':
      'Please fill in all fields.',
      'password_minimum':
      'Password must be at least 6 characters.',
      'passwords_not_match':
      'Passwords do not match.',
      'account_created':
      'Account created successfully.',
      'enter_email_password':
      'Please enter your email and password.',
      'enter_email':
      'Please enter your email.',
      'enter_password':
      'Please enter your password.',
      'enter_name':
      'Enter your name',
      'create_password':
      'Create a password',
      'confirm_your_password':
      'Confirm your password',
      'check_your_email':
      'Check Your Email',
      'reset_link_sent':
      'A password reset link has been sent to your email.',
      'application_name':
      'News App',
      'technology':
      'Technology',
      'business':
      'Business',
      'sports':
      'Sports',
      'health':
      'Health',
      'all':
      'All',
    },

    'ar': {
      'news': 'الأخبار',
      'home': 'الرئيسية',
      'saved': 'المحفوظات',
      'profile': 'الملف الشخصي',
      'settings': 'الإعدادات',
      'login': 'تسجيل الدخول',
      'register': 'إنشاء حساب',
      'logout': 'تسجيل الخروج',
      'cancel': 'إلغاء',
      'save': 'حفظ',
      'close': 'إغلاق',
      'ok': 'حسنًا',
      'language': 'اللغة',
      'notifications': 'الإشعارات',
      'dark_mode': 'الوضع الداكن',
      'about': 'عن التطبيق',
      'privacy_policy': 'سياسة الخصوصية',
      'preferences': 'التفضيلات',
      'general': 'عام',
      'featured_news': 'أخبار مميزة',
      'latest_news': 'أحدث الأخبار',
      'see_all': 'عرض الكل',
      'no_news_found':
      'لم يتم العثور على أخبار',
      'welcome': 'مرحبًا',
      'welcome_back':
      'مرحبًا بعودتك',
      'create_account':
      'إنشاء حساب',
      'create_account_description':
      'أنشئ حسابًا للحصول على تجربة الأخبار الكاملة.',
      'edit_profile':
      'تعديل الملف الشخصي',
      'saved_articles':
      'المقالات المحفوظة',
      'reading_history':
      'سجل القراءة',
      'notification_preferences':
      'تفضيلات الإشعارات',
      'login_required':
      'تسجيل الدخول مطلوب',
      'login_or_register':
      'سجل الدخول أو أنشئ حسابًا للمتابعة.',
      'email':
      'البريد الإلكتروني',
      'password':
      'كلمة المرور',
      'confirm_password':
      'تأكيد كلمة المرور',
      'full_name':
      'الاسم بالكامل',
      'name':
      'الاسم',
      'remember_me':
      'تذكرني',
      'forgot_password':
      'هل نسيت كلمة المرور؟',
      'forgot_password_description':
      'أدخل بريدك الإلكتروني وسنرسل لك رابطًا لإعادة تعيين كلمة المرور.',
      'send_reset_link':
      'إرسال رابط إعادة التعيين',
      'already_have_account':
      'لديك حساب بالفعل؟',
      'dont_have_account':
      'ليس لديك حساب؟',
      'good_morning':
      'صباح الخير 👋',
      'whats_happening_today':
      'ماذا يحدث اليوم؟',
      'get_full_experience':
      'احصل على تجربة الأخبار الكاملة',
      'login_to_save_read':
      'سجل الدخول أو أنشئ حسابًا لحفظ وقراءة المقالات.',
      'article':
      'المقال',
      'about_this_story':
      'عن هذا الخبر',
      'story_details':
      'يقدم هذا الخبر أحدث المعلومات والتحديثات المهمة حول هذا الموضوع.',
      'no_saved_news':
      'لا توجد أخبار محفوظة',
      'save_articles_later':
      'احفظ المقالات التي تريد قراءتها لاحقًا.',
      'dark_mode_description':
      'تغيير مظهر التطبيق',
      'notifications_description':
      'استقبل إشعارات عن أحدث الأخبار',
      'about_description':
      'معلومات عن التطبيق',
      'privacy_description':
      'اقرأ سياسة الخصوصية',
      'profile_updated':
      'تم تحديث الملف الشخصي بنجاح.',
      'logged_out':
      'تم تسجيل الخروج بنجاح.',
      'logout_confirmation':
      'هل أنت متأكد أنك تريد تسجيل الخروج؟',
      'invalid_email_password':
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
      'fill_all_fields':
      'من فضلك املأ جميع الحقول.',
      'password_minimum':
      'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.',
      'passwords_not_match':
      'كلمتا المرور غير متطابقتين.',
      'account_created':
      'تم إنشاء الحساب بنجاح.',
      'enter_email_password':
      'من فضلك أدخل البريد الإلكتروني وكلمة المرور.',
      'enter_email':
      'من فضلك أدخل بريدك الإلكتروني.',
      'enter_password':
      'من فضلك أدخل كلمة المرور.',
      'enter_name':
      'أدخل اسمك',
      'create_password':
      'أنشئ كلمة مرور',
      'confirm_your_password':
      'أكد كلمة المرور',
      'check_your_email':
      'تحقق من بريدك الإلكتروني',
      'reset_link_sent':
      'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.',
      'application_name':
      'تطبيق الأخبار',
      'technology':
      'تكنولوجيا',
      'business':
      'أعمال',
      'sports':
      'رياضة',
      'health':
      'صحة',
      'all':
      'الكل',
    },

    'es': {
      'news': 'Noticias',
      'home': 'Inicio',
      'saved': 'Guardado',
      'profile': 'Perfil',
      'settings': 'Configuración',
      'login': 'Iniciar sesión',
      'register': 'Registrarse',
      'logout': 'Cerrar sesión',
      'cancel': 'Cancelar',
      'save': 'Guardar',
      'close': 'Cerrar',
      'ok': 'Aceptar',
      'language': 'Idioma',
      'notifications': 'Notificaciones',
      'dark_mode': 'Modo oscuro',
      'about': 'Acerca de',
      'privacy_policy':
      'Política de privacidad',
      'preferences': 'Preferencias',
      'general': 'General',
      'featured_news':
      'Noticias destacadas',
      'latest_news':
      'Últimas noticias',
      'see_all': 'Ver todo',
      'no_news_found':
      'No se encontraron noticias',
      'welcome': 'Bienvenido',
      'welcome_back':
      'Bienvenido de nuevo',
      'create_account':
      'Crear cuenta',
      'create_account_description':
      'Crea una cuenta para disfrutar de la experiencia completa de News.',
      'edit_profile':
      'Editar perfil',
      'saved_articles':
      'Artículos guardados',
      'reading_history':
      'Historial de lectura',
      'notification_preferences':
      'Preferencias de notificaciones',
      'login_required':
      'Inicio de sesión requerido',
      'login_or_register':
      'Inicia sesión o crea una cuenta para continuar.',
      'email':
      'Correo electrónico',
      'password':
      'Contraseña',
      'confirm_password':
      'Confirmar contraseña',
      'full_name':
      'Nombre completo',
      'name':
      'Nombre',
      'remember_me':
      'Recordarme',
      'forgot_password':
      '¿Olvidaste tu contraseña?',
      'forgot_password_description':
      'Introduce tu correo y te enviaremos un enlace para restablecer tu contraseña.',
      'send_reset_link':
      'Enviar enlace',
      'already_have_account':
      '¿Ya tienes una cuenta?',
      'dont_have_account':
      '¿No tienes una cuenta?',
      'good_morning':
      'Buenos días 👋',
      'whats_happening_today':
      '¿Qué está pasando hoy?',
      'get_full_experience':
      'Disfruta de la experiencia completa',
      'login_to_save_read':
      'Inicia sesión o regístrate para guardar y leer artículos.',
      'article':
      'Artículo',
      'about_this_story':
      'Sobre esta noticia',
      'story_details':
      'Esta noticia proporciona la información más reciente y actualizaciones importantes sobre el tema.',
      'no_saved_news':
      'No hay noticias guardadas',
      'save_articles_later':
      'Guarda artículos para leerlos más tarde.',
      'dark_mode_description':
      'Cambia la apariencia de la aplicación',
      'notifications_description':
      'Recibe notificaciones sobre las últimas noticias',
      'about_description':
      'Información sobre esta aplicación',
      'privacy_description':
      'Lee nuestra política de privacidad',
      'profile_updated':
      'Perfil actualizado correctamente.',
      'logged_out':
      'Sesión cerrada correctamente.',
      'logout_confirmation':
      '¿Seguro que quieres cerrar sesión?',
      'invalid_email_password':
      'Correo o contraseña incorrectos.',
      'fill_all_fields':
      'Completa todos los campos.',
      'password_minimum':
      'La contraseña debe tener al menos 6 caracteres.',
      'passwords_not_match':
      'Las contraseñas no coinciden.',
      'account_created':
      'Cuenta creada correctamente.',
      'enter_email_password':
      'Introduce tu correo y contraseña.',
      'enter_email':
      'Introduce tu correo electrónico.',
      'enter_password':
      'Introduce tu contraseña.',
      'enter_name':
      'Introduce tu nombre',
      'create_password':
      'Crea una contraseña',
      'confirm_your_password':
      'Confirma tu contraseña',
      'check_your_email':
      'Revisa tu correo',
      'reset_link_sent':
      'Se ha enviado un enlace para restablecer tu contraseña.',
      'application_name':
      'News App',
      'technology':
      'Tecnología',
      'business':
      'Negocios',
      'sports':
      'Deportes',
      'health':
      'Salud',
      'all':
      'Todo',
    },

    'fr': {
      'news': 'Actualités',
      'home': 'Accueil',
      'saved': 'Enregistré',
      'profile': 'Profil',
      'settings': 'Paramètres',
      'login': 'Connexion',
      'register': 'Créer un compte',
      'logout': 'Déconnexion',
      'cancel': 'Annuler',
      'save': 'Enregistrer',
      'close': 'Fermer',
      'ok': 'OK',
      'language': 'Langue',
      'notifications': 'Notifications',
      'dark_mode': 'Mode sombre',
      'about': 'À propos',
      'privacy_policy':
      'Politique de confidentialité',
      'preferences':
      'Préférences',
      'general': 'Général',
      'featured_news':
      'Actualités à la une',
      'latest_news':
      'Dernières actualités',
      'see_all': 'Voir tout',
      'no_news_found':
      'Aucune actualité trouvée',
      'welcome': 'Bienvenue',
      'welcome_back':
      'Bon retour',
      'create_account':
      'Créer un compte',
      'create_account_description':
      'Créez un compte pour profiter de toute l’expérience News.',
      'edit_profile':
      'Modifier le profil',
      'saved_articles':
      'Articles enregistrés',
      'reading_history':
      'Historique de lecture',
      'notification_preferences':
      'Préférences de notifications',
      'login_required':
      'Connexion requise',
      'login_or_register':
      'Connectez-vous ou créez un compte pour continuer.',
      'email':
      'E-mail',
      'password':
      'Mot de passe',
      'confirm_password':
      'Confirmer le mot de passe',
      'full_name':
      'Nom complet',
      'name':
      'Nom',
      'remember_me':
      'Se souvenir de moi',
      'forgot_password':
      'Mot de passe oublié ?',
      'forgot_password_description':
      'Saisissez votre e-mail et nous vous enverrons un lien pour réinitialiser votre mot de passe.',
      'send_reset_link':
      'Envoyer le lien',
      'already_have_account':
      'Vous avez déjà un compte ?',
      'dont_have_account':
      'Vous n’avez pas de compte ?',
      'good_morning':
      'Bonjour 👋',
      'whats_happening_today':
      'Que se passe-t-il aujourd’hui ?',
      'get_full_experience':
      'Profitez de toute l’expérience News',
      'login_to_save_read':
      'Connectez-vous ou inscrivez-vous pour enregistrer et lire les articles.',
      'article':
      'Article',
      'about_this_story':
      'À propos de cette actualité',
      'story_details':
      'Cette actualité fournit les dernières informations et les mises à jour importantes sur le sujet.',
      'no_saved_news':
      'Aucune actualité enregistrée',
      'save_articles_later':
      'Enregistrez des articles à lire plus tard.',
      'dark_mode_description':
      'Modifier l’apparence de l’application',
      'notifications_description':
      'Recevoir des notifications sur les dernières actualités',
      'about_description':
      'À propos de cette application',
      'privacy_description':
      'Lire notre politique de confidentialité',
      'profile_updated':
      'Profil mis à jour avec succès.',
      'logged_out':
      'Déconnexion réussie.',
      'logout_confirmation':
      'Voulez-vous vraiment vous déconnecter ?',
      'invalid_email_password':
      'E-mail ou mot de passe incorrect.',
      'fill_all_fields':
      'Veuillez remplir tous les champs.',
      'password_minimum':
      'Le mot de passe doit contenir au moins 6 caractères.',
      'passwords_not_match':
      'Les mots de passe ne correspondent pas.',
      'account_created':
      'Compte créé avec succès.',
      'enter_email_password':
      'Veuillez saisir votre e-mail et votre mot de passe.',
      'enter_email':
      'Veuillez saisir votre e-mail.',
      'enter_password':
      'Veuillez saisir votre mot de passe.',
      'enter_name':
      'Saisissez votre nom',
      'create_password':
      'Créez un mot de passe',
      'confirm_your_password':
      'Confirmez votre mot de passe',
      'check_your_email':
      'Vérifiez votre e-mail',
      'reset_link_sent':
      'Un lien de réinitialisation a été envoyé à votre e-mail.',
      'application_name':
      'News App',
      'technology':
      'Technologie',
      'business':
      'Affaires',
      'sports':
      'Sports',
      'health':
      'Santé',
      'all':
      'Tout',
    },

    'de': {
      'news': 'Nachrichten',
      'home': 'Startseite',
      'saved': 'Gespeichert',
      'profile': 'Profil',
      'settings': 'Einstellungen',
      'login': 'Anmelden',
      'register': 'Registrieren',
      'logout': 'Abmelden',
      'cancel': 'Abbrechen',
      'save': 'Speichern',
      'close': 'Schließen',
      'ok': 'OK',
      'language': 'Sprache',
      'notifications':
      'Benachrichtigungen',
      'dark_mode': 'Dunkelmodus',
      'about': 'Über',
      'privacy_policy':
      'Datenschutzrichtlinie',
      'preferences':
      'Einstellungen',
      'general': 'Allgemein',
      'featured_news':
      'Top-Nachrichten',
      'latest_news':
      'Neueste Nachrichten',
      'see_all': 'Alle anzeigen',
      'no_news_found':
      'Keine Nachrichten gefunden',
      'welcome': 'Willkommen',
      'welcome_back':
      'Willkommen zurück',
      'create_account':
      'Konto erstellen',
      'create_account_description':
      'Erstelle ein Konto für das vollständige News-Erlebnis.',
      'edit_profile':
      'Profil bearbeiten',
      'saved_articles':
      'Gespeicherte Artikel',
      'reading_history':
      'Leseverlauf',
      'notification_preferences':
      'Benachrichtigungseinstellungen',
      'login_required':
      'Anmeldung erforderlich',
      'login_or_register':
      'Melde dich an oder erstelle ein Konto, um fortzufahren.',
      'email':
      'E-Mail',
      'password':
      'Passwort',
      'confirm_password':
      'Passwort bestätigen',
      'full_name':
      'Vollständiger Name',
      'name':
      'Name',
      'remember_me':
      'Angemeldet bleiben',
      'forgot_password':
      'Passwort vergessen?',
      'forgot_password_description':
      'Gib deine E-Mail ein und wir senden dir einen Link zum Zurücksetzen deines Passworts.',
      'send_reset_link':
      'Link senden',
      'already_have_account':
      'Du hast bereits ein Konto?',
      'dont_have_account':
      'Du hast noch kein Konto?',
      'good_morning':
      'Guten Morgen 👋',
      'whats_happening_today':
      'Was passiert heute?',
      'get_full_experience':
      'Erlebe News vollständig',
      'login_to_save_read':
      'Melde dich an oder registriere dich, um Artikel zu speichern und zu lesen.',
      'article':
      'Artikel',
      'about_this_story':
      'Über diese Nachricht',
      'story_details':
      'Diese Nachricht enthält die neuesten Informationen und wichtige Updates zu diesem Thema.',
      'no_saved_news':
      'Keine gespeicherten Nachrichten',
      'save_articles_later':
      'Speichere Artikel zum späteren Lesen.',
      'dark_mode_description':
      'Aussehen der App ändern',
      'notifications_description':
      'Benachrichtigungen über aktuelle Nachrichten erhalten',
      'about_description':
      'Über diese Anwendung',
      'privacy_description':
      'Datenschutzrichtlinie lesen',
      'profile_updated':
      'Profil erfolgreich aktualisiert.',
      'logged_out':
      'Erfolgreich abgemeldet.',
      'logout_confirmation':
      'Möchtest du dich wirklich abmelden?',
      'invalid_email_password':
      'Ungültige E-Mail oder ungültiges Passwort.',
      'fill_all_fields':
      'Bitte fülle alle Felder aus.',
      'password_minimum':
      'Das Passwort muss mindestens 6 Zeichen enthalten.',
      'passwords_not_match':
      'Die Passwörter stimmen nicht überein.',
      'account_created':
      'Konto erfolgreich erstellt.',
      'enter_email_password':
      'Bitte gib deine E-Mail und dein Passwort ein.',
      'enter_email':
      'Bitte gib deine E-Mail ein.',
      'enter_password':
      'Bitte gib dein Passwort ein.',
      'enter_name':
      'Gib deinen Namen ein',
      'create_password':
      'Erstelle ein Passwort',
      'confirm_your_password':
      'Bestätige dein Passwort',
      'check_your_email':
      'Überprüfe deine E-Mail',
      'reset_link_sent':
      'Ein Link zum Zurücksetzen des Passworts wurde gesendet.',
      'application_name':
      'News App',
      'technology':
      'Technologie',
      'business':
      'Geschäft',
      'sports':
      'Sport',
      'health':
      'Gesundheit',
      'all':
      'Alle',
    },

    'ja': {
      'news': 'ニュース',
      'home': 'ホーム',
      'saved': '保存済み',
      'profile': 'プロフィール',
      'settings': '設定',
      'login': 'ログイン',
      'register': '登録',
      'logout': 'ログアウト',
      'cancel': 'キャンセル',
      'save': '保存',
      'close': '閉じる',
      'ok': 'OK',
      'language': '言語',
      'notifications': '通知',
      'dark_mode': 'ダークモード',
      'about': 'アプリについて',
      'privacy_policy':
      'プライバシーポリシー',
      'preferences':
      '環境設定',
      'general': '一般',
      'featured_news':
      '注目ニュース',
      'latest_news':
      '最新ニュース',
      'see_all':
      'すべて見る',
      'no_news_found':
      'ニュースが見つかりません',
      'welcome':
      'ようこそ',
      'welcome_back':
      'おかえりなさい',
      'create_account':
      'アカウントを作成',
      'create_account_description':
      'アカウントを作成して、ニュースをもっと楽しみましょう。',
      'edit_profile':
      'プロフィールを編集',
      'saved_articles':
      '保存した記事',
      'reading_history':
      '閲覧履歴',
      'notification_preferences':
      '通知設定',
      'login_required':
      'ログインが必要です',
      'login_or_register':
      '続行するにはログインまたはアカウントを作成してください。',
      'email':
      'メールアドレス',
      'password':
      'パスワード',
      'confirm_password':
      'パスワードを確認',
      'full_name':
      '氏名',
      'name':
      '名前',
      'remember_me':
      'ログイン状態を保持',
      'forgot_password':
      'パスワードをお忘れですか？',
      'forgot_password_description':
      'メールアドレスを入力すると、パスワードリセット用のリンクを送信します。',
      'send_reset_link':
      'リセットリンクを送信',
      'already_have_account':
      'すでにアカウントをお持ちですか？',
      'dont_have_account':
      'アカウントをお持ちでないですか？',
      'good_morning':
      'おはようございます 👋',
      'whats_happening_today':
      '今日は何が起きていますか？',
      'get_full_experience':
      'ニュースをもっと楽しもう',
      'login_to_save_read':
      '記事を保存して読むにはログインまたは登録してください。',
      'article':
      '記事',
      'about_this_story':
      'このニュースについて',
      'story_details':
      'このニュースでは、このテーマに関する最新情報と重要な更新を紹介します。',
      'no_saved_news':
      '保存されたニュースはありません',
      'save_articles_later':
      '後で読みたい記事を保存しましょう。',
      'dark_mode_description':
      'アプリの外観を変更します',
      'notifications_description':
      '最新ニュースの通知を受け取ります',
      'about_description':
      'このアプリについて',
      'privacy_description':
      'プライバシーポリシーを読む',
      'profile_updated':
      'プロフィールを更新しました。',
      'logged_out':
      'ログアウトしました。',
      'logout_confirmation':
      '本当にログアウトしますか？',
      'invalid_email_password':
      'メールアドレスまたはパスワードが正しくありません。',
      'fill_all_fields':
      'すべての項目を入力してください。',
      'password_minimum':
      'パスワードは6文字以上で入力してください。',
      'passwords_not_match':
      'パスワードが一致しません。',
      'account_created':
      'アカウントを作成しました。',
      'enter_email_password':
      'メールアドレスとパスワードを入力してください。',
      'enter_email':
      'メールアドレスを入力してください。',
      'enter_password':
      'パスワードを入力してください。',
      'enter_name':
      '名前を入力してください',
      'create_password':
      'パスワードを作成',
      'confirm_your_password':
      'パスワードを確認してください',
      'check_your_email':
      'メールを確認してください',
      'reset_link_sent':
      'パスワードリセットリンクをメールで送信しました。',
      'application_name':
      'News App',
      'technology':
      'テクノロジー',
      'business':
      'ビジネス',
      'sports':
      'スポーツ',
      'health':
      '健康',
      'all':
      'すべて',
    },

    'zh': {
      'news': '新闻',
      'home': '首页',
      'saved': '已保存',
      'profile': '个人资料',
      'settings': '设置',
      'login': '登录',
      'register': '注册',
      'logout': '退出登录',
      'cancel': '取消',
      'save': '保存',
      'close': '关闭',
      'ok': '确定',
      'language': '语言',
      'notifications': '通知',
      'dark_mode': '深色模式',
      'about': '关于',
      'privacy_policy':
      '隐私政策',
      'preferences':
      '偏好设置',
      'general': '常规',
      'featured_news':
      '精选新闻',
      'latest_news':
      '最新新闻',
      'see_all':
      '查看全部',
      'no_news_found':
      '没有找到新闻',
      'welcome':
      '欢迎',
      'welcome_back':
      '欢迎回来',
      'create_account':
      '创建账户',
      'create_account_description':
      '创建账户，享受完整的新闻体验。',
      'edit_profile':
      '编辑资料',
      'saved_articles':
      '已保存文章',
      'reading_history':
      '阅读历史',
      'notification_preferences':
      '通知偏好',
      'login_required':
      '需要登录',
      'login_or_register':
      '请登录或创建账户以继续。',
      'email':
      '电子邮箱',
      'password':
      '密码',
      'confirm_password':
      '确认密码',
      'full_name':
      '姓名',
      'name':
      '名字',
      'remember_me':
      '记住我',
      'forgot_password':
      '忘记密码？',
      'forgot_password_description':
      '输入你的邮箱，我们会向你发送密码重置链接。',
      'send_reset_link':
      '发送重置链接',
      'already_have_account':
      '已经有账户了吗？',
      'dont_have_account':
      '还没有账户？',
      'good_morning':
      '早上好 👋',
      'whats_happening_today':
      '今天发生了什么？',
      'get_full_experience':
      '享受完整的新闻体验',
      'login_to_save_read':
      '登录或注册以保存和阅读文章。',
      'article':
      '文章',
      'about_this_story':
      '关于这条新闻',
      'story_details':
      '这条新闻提供有关该主题的最新信息和重要更新。',
      'no_saved_news':
      '没有保存的新闻',
      'save_articles_later':
      '保存你以后想阅读的文章。',
      'dark_mode_description':
      '更改应用的外观',
      'notifications_description':
      '接收最新新闻通知',
      'about_description':
      '关于此应用',
      'privacy_description':
      '阅读我们的隐私政策',
      'profile_updated':
      '个人资料更新成功。',
      'logged_out':
      '退出登录成功。',
      'logout_confirmation':
      '确定要退出登录吗？',
      'invalid_email_password':
      '邮箱或密码无效。',
      'fill_all_fields':
      '请填写所有字段。',
      'password_minimum':
      '密码至少需要6个字符。',
      'passwords_not_match':
      '两次输入的密码不一致。',
      'account_created':
      '账户创建成功。',
      'enter_email_password':
      '请输入邮箱和密码。',
      'enter_email':
      '请输入邮箱。',
      'enter_password':
      '请输入密码。',
      'enter_name':
      '请输入姓名',
      'create_password':
      '创建密码',
      'confirm_your_password':
      '确认你的密码',
      'check_your_email':
      '请检查你的邮箱',
      'reset_link_sent':
      '密码重置链接已发送到你的邮箱。',
      'application_name':
      'News App',
      'technology':
      '科技',
      'business':
      '商业',
      'sports':
      '体育',
      'health':
      '健康',
      'all':
      '全部',
    },
  };
}