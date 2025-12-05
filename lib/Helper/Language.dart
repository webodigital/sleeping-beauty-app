// translation_manager.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class TranslationManager extends ChangeNotifier {
  // ---- Singleton ----
  static final TranslationManager _instance = TranslationManager._internal();
  factory TranslationManager() => _instance;
  TranslationManager._internal();

  // Current language code: stored in uppercase like 'EN' or 'DE'
  String _languageCode = 'EN';
  String get languageCode => _languageCode;

  // List of translations
  List<Map<String, String>> _translations = [];

  Future<void> init() async {
    _setupTranslations();
    await _loadOrSetDefaultLanguage();
  }

  void _setupTranslations() {
    _translations.clear();
    _translations.addAll([
      {
        "en": "Login to your Account",
        "gr": "Melden Sie sich bei Ihrem Konto an",
      },
      {
        "en": "Login",
        "gr": "Anmelden",
      },
      {
        "en": "Please enter your details",
        "gr": "Bitte geben Sie Ihre Daten ein",
      },
      {
        "en": "Email ID",
        "gr": "E-Mail-Adresse",
      },
      {
        "en": "Password",
        "gr": "Passwort",
      },
      {
        "en": "Forgot Password ?",
        "gr": "Passwort vergessen?",
      },
      {
        "en": "Login",
        "gr": "Anmelden",
      },
      {
        "en": "Don't have an account?",
        "gr": "Sie haben noch kein Konto?",
      },
      {
        "en": "Signup",
        "gr": "Registrieren",
      },
      {
        "en": "Login...",
        "gr": "Anmeldung...",
      },
      {
        "en": "Sending OTP...",
        "gr": "OTP wird gesendet...",
      },
      {
        "en": "Resend otp failed",
        "gr": "OTP erneut senden fehlgeschlagen",
      },
      {
        "en": "Please enter your email",
        "gr": "Bitte geben Sie Ihre E-Mail ein",
      },
      {
        "en": "Please enter a valid email address",
        "gr": "Bitte geben Sie eine gültige E-Mail-Adresse ein",
      },
      {
        "en": "Forgot Password?",
        "gr": "Passwort vergessen?",
      },
      {
        "en": "Dont’ worry we will send you reset Instructions",
        "gr": "Keine Sorge, wir senden Ihnen Anweisungen zum Zurücksetzen",
      },
      {
        "en": "Email ID",
        "gr": "E-Mail-Adresse",
      },
      {
        "en": "Reset Password",
        "gr": "Passwort zurücksetzen",
      },
      {
        "en": "Back to login",
        "gr": "Zurück zur Anmeldung",
      },
      {
        "en": "OTP Verify...",
        "gr": "OTP wird überprüft...",
      },
      {
        "en": "Back to login",
        "gr": "Zurück zur Anmeldung",
      },
      {
        "en": "OTP verify successful!",
        "gr": "OTP-Überprüfung erfolgreich!",
      },
      {
        "en": "Something went wrong please try again",
        "gr": "Etwas ist schiefgelaufen, bitte versuchen Sie es erneut",
      },
      {
        "en": "Sending OTP...",
        "gr": "OTP wird gesendet...",
      },
      {
        "en": "Reset Password?",
        "gr": "Passwort zurücksetzen?",
      },
      {
        "en": "We sent a code to",
        "gr": "Wir haben einen Code gesendet an",
      },
      {
        "en": "Please enter otp",
        "gr": "Bitte OTP eingeben",
      },
      {
        "en": "Didn’t receive the email?",
        "gr": "E-Mail nicht erhalten?",
      },
      {
        "en": "Click to resend",
        "gr": "Klicken Sie hier, um erneut zu senden",
      },
      {
        "en": "Loading...",
        "gr": "Lädt...",
      },
      {
        "en": "Reset password failed",
        "gr": "Passwort zurücksetzen fehlgeschlagen",
      },
      {
        "en": "Please enter your password",
        "gr": "Bitte geben Sie Ihr Passwort ein",
      },
      {
        "en": "• At least 8 characters",
        "gr": "• Mindestens 8 Zeichen",
      },
      {
        "en": "• At least one uppercase letter",
        "gr": "• Mindestens ein Großbuchstabe",
      },
      {
        "en": "• At least one number",
        "gr": "• Mindestens eine Zahl",
      },
      {
        "en": "• At least one special character",
        "gr": "• Mindestens ein Sonderzeichen",
      },
      {
        "en": "Password must include:",
        "gr": "Das Passwort muss enthalten:",
      },
      {
        "en": "New Password",
        "gr": "Neues Passwort",
      },
      {
        "en": "Must be at least 8 characters",
        "gr": "Muss mindestens 8 Zeichen enthalten",
      },
      {
        "en": "New Password",
        "gr": "Neues Passwort",
      },
      {
        "en": "All Done",
        "gr": "Alles erledigt",
      },
      {
        "en": "Your password has been reset Successfully",
        "gr": "Ihr Passwort wurde erfolgreich zurückgesetzt",
      },
      {
        "en": "Continue",
        "gr": "Fortfahren",
      },
      {
        "en": "Please enter your full name",
        "gr": "Bitte geben Sie Ihren vollständigen Namen ein",
      },
      {
        "en": "Please enter your email",
        "gr": "Bitte geben Sie Ihre E-Mail ein",
      },
      {
        "en": "Please enter a valid email address",
        "gr": "Bitte geben Sie eine gültige E-Mail-Adresse ein",
      },
      {
        "en": "Please enter your password",
        "gr": "Bitte geben Sie Ihr Passwort ein",
      },
      {
        "en": "Something went wrong",
        "gr": "Etwas ist schiefgelaufen",
      },
      {
        "en": "No internet connection. Please check your network settings and try again.",
        "gr": "Keine Internetverbindung. Bitte prüfen Sie Ihre Netzwerkeinstellungen und versuchen Sie es erneut.",
      },
      {
        "en": "Signup",
        "gr": "Registrieren",
      },
      {
        "en": "Please enter your details",
        "gr": "Bitte geben Sie Ihre Daten ein",
      },
      {
        "en": "Full Name",
        "gr": "Vollständiger Name",
      },
      {
        "en": "Email ID",
        "gr": "E-Mail-Adresse",
      },
      {
        "en": "Password",
        "gr": "Passwort",
      },
      {
        "en": "Signup",
        "gr": "Registrieren",
      },
      {
        "en": "Already have an account?",
        "gr": "Sie haben bereits ein Konto?",
      },
      {
        "en": "Login",
        "gr": "Anmelden",
      },
      {
        "en": "Login",
        "gr": "Anmelden",
      },
      {
        "en": "Pts",
        "gr": "Pkt",
      },
      {
        "en": "Home",
        "gr": "Start",
      },
      {
        "en": "Journey",
        "gr": "Reise",
      },
      {
        "en": "Rewards",
        "gr": "Prämien",
      },
      {
        "en": "Events",
        "gr": "Ereign",
      },
      {
        "en": "Choose Your Path",
        "gr": "Wähle deinen Weg",
      },
      {
        "en": "Start Now",
        "gr": "Jetzt starten",
      },
      {
        "en": "Journey",
        "gr": "Reise",
      },
      {
        "en": "View Details",
        "gr": "Details anzeigen",
      },
      {
        "en": "Visit",
        "gr": "Besuchen",
      },
      {
        "en": "Description",
        "gr": "Beschreibung",
      },
      {
        "en": "Multimedia",
        "gr": "Multimedia",
      },
      {
        "en": "Opening Hours",
        "gr": "Öffnungszeiten",
      },
      {
        "en": "Offers",
        "gr": "Angebote",
      },
      {
        "en": "Offers",
        "gr": "Angebote",
      },
      {
        "en": "Profile",
        "gr": "Profil",
      },
      {
        "en": "My Events",
        "gr": "Meine Veranstaltungen",
      },
      {
        "en": "My Journey",
        "gr": "Meine Reise",
      },
      {
        "en": "My Favourites",
        "gr": "Meine Favoriten",
      },
      {
        "en": "About App",
        "gr": "Über die App",
      },
      {
        "en": "Reward History",
        "gr": "Prämienverlauf",
      },
      {
        "en": "Helps & FAQs",
        "gr": "Hilfe & FAQs",
      },
      {
        "en": "Sign Out",
        "gr": "Abmelden",
      },
      {
        "en": "Log Out",
        "gr": "Abmelden",
      },
      {
        "en": "Are you sure you want to log out?",
        "gr": "Möchten Sie sich wirklich abmelden?",
      },
      {
        "en": "Cancel",
        "gr": "Abbrechen",
      },
      {
        "en": "Yes",
        "gr": "Ja",
      },
      {
        "en": "Yes",
        "gr": "Ja",
      },
      {
        "en": "You have",
        "gr": "Sie haben",
      },
      {
        "en": "points",
        "gr": "Punkte",
      },
      {
        "en": "Keep exploring to unlock new experiences",
        "gr": "Entdecke weiter, um neue Erlebnisse freizuschalten",
      },
      {
        "en": "Camera",
        "gr": "Kamera",
      },
      {
        "en": "Gallery",
        "gr": "Galerie",
      },
      {
        "en": "My Journey History",
        "gr": "Meine Reiseverläufe",
      },
      {
        "en": "My Journey History",
        "gr": "Meine Reiseverläufe",
      },
      {
        "en": "Reward History",
        "gr": "Prämienverlauf",
      },
      {
        "en": "My Favorite Journeys",
        "gr": "Meine Lieblingsreisen",
      },
      {
        "en": "Search by Romantic, Adventure, Family, Cultural etc",
        "gr": "Suchen nach Romantik, Abenteuer, Familie, Kultur usw.",
      },
      {
        "en": "Password must be at least 6 characters long",
        "gr": "Das Passwort muss mindestens 6 Zeichen lang sein.",
      },
       {
       "en": "You're in! Time to log in and explore.",
       "gr": "Du bist dabei! Melde dich an und entdecke mehr.",
      },
      {
        "en": "Start exploring — your first journey awaits!",
        "gr": "Begib dich auf Entdeckungstour – deine erste Reise wartet!"
      },
      {
        "en": "Upload",
        "gr": "Hochladen"
      },
      {
        "en": "Please select profile photo",
        "gr": "Bitte wählen Sie ein Profilfoto aus"
      },
      {
        "en": "Uploading...",
        "gr": "Wird hochgeladen..."
      },
      {
        "en": "Uploading...",
        "gr": "Wird hochgeladen..."
      },
      {
        "en": "End Journey",
        "gr": "Reise beenden"
      },
      {
        "en": "Are you sure you want to end this journey?",
        "gr": "Sind Sie sicher, dass Sie diese Reise beenden möchten?"
      },
      {
        "en": "End Journey",
        "gr": "Reise beenden"
      },
      {
        "en": "End Visit",
        "gr": "Besuch beenden"
      },
      {
        "en": "Are you sure you want to end this visit?",
        "gr": "Sind Sie sicher, dass Sie diesen Besuch beenden möchten?"
      },
      {
        "en": "Your Location",
        "gr": "Ihr Standort"
      },
      {
        "en": "Fetching current location...",
        "gr": "Aktueller Standort wird abgerufen..."
      },
      {
        "en": "Destination Location",
        "gr": "Zielort"
      },
      {
        "en": "Journey Summary",
        "gr": "Reisezusammenfassung"
      },
      {
        "en": "Total Time Spent",
        "gr": "Gesamte verbrachte Zeit"
      },
      {
        "en": "Total Points Earned",
        "gr": "Gesamtpunkte erzielt"
      },
      {
        "en": "Offers Redeemed",
        "gr": "Eingelöste Angebote"
      },
      {
        "en": "Multimedia",
        "gr": "Multimedia"
      },
      {
        "en": "Stop",
        "gr": "Stopp"
      },
      {
        "en": "Total Distance Covered",
        "gr": "Gesamte zurückgelegte Strecke"
      },
      {
        "en": "Password must be at least 6 characters long and include 1 uppercase letter, 1 lowercase letter, and 1 number.",
        "gr": "Das Passwort muss mindestens 6 Zeichen lang sein und mindestens 1 Großbuchstaben, 1 Kleinbuchstaben und 1 Zahl enthalten."
      },
      {
        "en": "Signup...",
        "gr": "Registrieren"
      },
      {
        "en": "Account deleted successfully",
        "gr": "Konto erfolgreich gelöscht"
      },
      {
        "en": "Delete Account",
        "gr": "Konto löschen"
      },
      {
        "en": "Are you sure you want to delete this account?",
        "gr": "Bist du sicher, dass du dieses Konto löschen möchtest?"
      }

    ]);
  }


  /// Load saved language if exists, otherwise set default/system.
  Future<void> _loadOrSetDefaultLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('Language');

    if (saved != null && saved.isNotEmpty) {
      _languageCode = saved.toUpperCase();
      print(" saved.toUpperCase:-- ${_languageCode}");
      TranslationManager().setLanguage(_languageCode);
    } else {
      final deviceLang = ui.window.locale.languageCode.toLowerCase();
      if (_isSupported(deviceLang)) {
        _languageCode = deviceLang.toUpperCase();
      } else {
        _languageCode = 'EN';
      }
      await prefs.setString('Language', _languageCode);
    }

    notifyListeners();
  }

  bool _isSupported(String code) {
    final lang = code.toLowerCase();
    return ['en', 'gr'].contains(lang);
  }

  Future<void> setLanguage(String code) async {
    final newCode = code.toUpperCase();
    if (newCode == _languageCode) return;
    _languageCode = newCode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Language', _languageCode);
    notifyListeners();
  }


  String translate(String key) {
    try {
      final entry = _translations.firstWhere(
            (e) => e['en'] == key,
        orElse: () => {},
      );
      if (entry.isEmpty) return key;

      final localeKey = _languageCode.toLowerCase();
      return entry[localeKey] ?? entry['en'] ?? key;
    } catch (_) {
      return key;
    }
  }
}

/// Shortcut function
String lngTranslation(String key) => TranslationManager().translate(key);

var selectedSavedLanguage = "";
var isSideMenuOpen = false;