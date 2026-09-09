import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_mr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('mr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'KabadiwalaConnect'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @newLot.
  ///
  /// In en, this message translates to:
  /// **'New Lot'**
  String get newLot;

  /// No description provided for @todayPrices.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Prices'**
  String get todayPrices;

  /// No description provided for @findRecycler.
  ///
  /// In en, this message translates to:
  /// **'Find Recycler'**
  String get findRecycler;

  /// No description provided for @myLedger.
  ///
  /// In en, this message translates to:
  /// **'My Ledger'**
  String get myLedger;

  /// No description provided for @safetyGuide.
  ///
  /// In en, this message translates to:
  /// **'Safety Guide'**
  String get safetyGuide;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @marathi.
  ///
  /// In en, this message translates to:
  /// **'Marathi'**
  String get marathi;

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactions;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @retakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Retake Photo'**
  String get retakePhoto;

  /// No description provided for @useThisPhoto.
  ///
  /// In en, this message translates to:
  /// **'Use this photo'**
  String get useThisPhoto;

  /// No description provided for @photoRequired.
  ///
  /// In en, this message translates to:
  /// **'Please take a photo of the material'**
  String get photoRequired;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Material Type'**
  String get selectCategory;

  /// No description provided for @materialPCB.
  ///
  /// In en, this message translates to:
  /// **'PCB / Circuit Board'**
  String get materialPCB;

  /// No description provided for @materialCRT.
  ///
  /// In en, this message translates to:
  /// **'Old TV (CRT)'**
  String get materialCRT;

  /// No description provided for @materialLCD.
  ///
  /// In en, this message translates to:
  /// **'LCD Screen'**
  String get materialLCD;

  /// No description provided for @materialCable.
  ///
  /// In en, this message translates to:
  /// **'Cable / Wire'**
  String get materialCable;

  /// No description provided for @materialBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get materialBattery;

  /// No description provided for @materialMotor.
  ///
  /// In en, this message translates to:
  /// **'Motor'**
  String get materialMotor;

  /// No description provided for @materialPlastic.
  ///
  /// In en, this message translates to:
  /// **'Mixed Plastic'**
  String get materialPlastic;

  /// No description provided for @enterWeight.
  ///
  /// In en, this message translates to:
  /// **'Enter Weight'**
  String get enterWeight;

  /// No description provided for @weightInKg.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightInKg;

  /// No description provided for @weightPrompt.
  ///
  /// In en, this message translates to:
  /// **'How many kilograms?'**
  String get weightPrompt;

  /// No description provided for @weightRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter weight'**
  String get weightRequired;

  /// No description provided for @estimatedValue.
  ///
  /// In en, this message translates to:
  /// **'Estimated Value: ₹{value}'**
  String estimatedValue(String value);

  /// No description provided for @priceRange.
  ///
  /// In en, this message translates to:
  /// **'Market Range: ₹{low} - ₹{high}'**
  String priceRange(String low, String high);

  /// No description provided for @perKg.
  ///
  /// In en, this message translates to:
  /// **'per kg'**
  String get perKg;

  /// No description provided for @saveLot.
  ///
  /// In en, this message translates to:
  /// **'Save Lot'**
  String get saveLot;

  /// No description provided for @lotSaved.
  ///
  /// In en, this message translates to:
  /// **'Lot saved successfully!'**
  String get lotSaved;

  /// No description provided for @lotSavedFindRecycler.
  ///
  /// In en, this message translates to:
  /// **'Lot saved! Find a recycler?'**
  String get lotSavedFindRecycler;

  /// No description provided for @findRecyclerForLot.
  ///
  /// In en, this message translates to:
  /// **'Find Recycler for This Lot'**
  String get findRecyclerForLot;

  /// No description provided for @priceBoardTitle.
  ///
  /// In en, this message translates to:
  /// **'Price Board'**
  String get priceBoardTitle;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: {time}'**
  String lastUpdated(String time);

  /// No description provided for @tapToHearPrice.
  ///
  /// In en, this message translates to:
  /// **'Tap any item to hear its price'**
  String get tapToHearPrice;

  /// No description provided for @pricePerKg.
  ///
  /// In en, this message translates to:
  /// **'₹{price}/kg'**
  String pricePerKg(String price);

  /// No description provided for @priceTrend.
  ///
  /// In en, this message translates to:
  /// **'Price Trend'**
  String get priceTrend;

  /// No description provided for @priceUp.
  ///
  /// In en, this message translates to:
  /// **'Price is rising'**
  String get priceUp;

  /// No description provided for @priceDown.
  ///
  /// In en, this message translates to:
  /// **'Price is falling'**
  String get priceDown;

  /// No description provided for @priceStable.
  ///
  /// In en, this message translates to:
  /// **'Price is stable'**
  String get priceStable;

  /// No description provided for @recyclerListTitle.
  ///
  /// In en, this message translates to:
  /// **'Nearby Recyclers'**
  String get recyclerListTitle;

  /// No description provided for @noRecyclersFound.
  ///
  /// In en, this message translates to:
  /// **'No recyclers found nearby'**
  String get noRecyclersFound;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'{km} km away'**
  String distance(String km);

  /// No description provided for @authorized.
  ///
  /// In en, this message translates to:
  /// **'Authorized'**
  String get authorized;

  /// No description provided for @pickupAvailable.
  ///
  /// In en, this message translates to:
  /// **'Pickup Available'**
  String get pickupAvailable;

  /// No description provided for @offersRate.
  ///
  /// In en, this message translates to:
  /// **'Offers: ₹{rate}/kg'**
  String offersRate(String rate);

  /// No description provided for @acceptsCategory.
  ///
  /// In en, this message translates to:
  /// **'Accepts: {categories}'**
  String acceptsCategory(String categories);

  /// No description provided for @contactRecycler.
  ///
  /// In en, this message translates to:
  /// **'Contact Recycler'**
  String get contactRecycler;

  /// No description provided for @callRecycler.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get callRecycler;

  /// No description provided for @selectRecycler.
  ///
  /// In en, this message translates to:
  /// **'Select This Recycler'**
  String get selectRecycler;

  /// No description provided for @handoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Handover Receipt'**
  String get handoverTitle;

  /// No description provided for @handoverReference.
  ///
  /// In en, this message translates to:
  /// **'Reference: {ref}'**
  String handoverReference(String ref);

  /// No description provided for @material.
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get material;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @agreedPrice.
  ///
  /// In en, this message translates to:
  /// **'Agreed Price'**
  String get agreedPrice;

  /// No description provided for @collector.
  ///
  /// In en, this message translates to:
  /// **'Collector'**
  String get collector;

  /// No description provided for @recycler.
  ///
  /// In en, this message translates to:
  /// **'Recycler'**
  String get recycler;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @dateTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get dateTime;

  /// No description provided for @recyclerConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Recycler Confirmed'**
  String get recyclerConfirmed;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @generateHandover.
  ///
  /// In en, this message translates to:
  /// **'Generate Handover Record'**
  String get generateHandover;

  /// No description provided for @shareHandover.
  ///
  /// In en, this message translates to:
  /// **'Share Receipt'**
  String get shareHandover;

  /// No description provided for @ledgerTitle.
  ///
  /// In en, this message translates to:
  /// **'My Earnings'**
  String get ledgerTitle;

  /// No description provided for @totalEarnings.
  ///
  /// In en, this message translates to:
  /// **'Total Earnings'**
  String get totalEarnings;

  /// No description provided for @pendingDues.
  ///
  /// In en, this message translates to:
  /// **'Pending Dues'**
  String get pendingDues;

  /// No description provided for @completedSales.
  ///
  /// In en, this message translates to:
  /// **'Completed Sales'**
  String get completedSales;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaid;

  /// No description provided for @safetyTitle.
  ///
  /// In en, this message translates to:
  /// **'Safety Guide'**
  String get safetyTitle;

  /// No description provided for @safetyWarning.
  ///
  /// In en, this message translates to:
  /// **'WARNING: Dangerous Practice'**
  String get safetyWarning;

  /// No description provided for @safetySafe.
  ///
  /// In en, this message translates to:
  /// **'Safe Practice'**
  String get safetySafe;

  /// No description provided for @doNotBurn.
  ///
  /// In en, this message translates to:
  /// **'Do not burn cables or wires'**
  String get doNotBurn;

  /// No description provided for @doNotOpenBatteries.
  ///
  /// In en, this message translates to:
  /// **'Do not open or puncture batteries'**
  String get doNotOpenBatteries;

  /// No description provided for @doNotBreakCRT.
  ///
  /// In en, this message translates to:
  /// **'Do not break CRT screens - they contain lead'**
  String get doNotBreakCRT;

  /// No description provided for @doNotAcidLeach.
  ///
  /// In en, this message translates to:
  /// **'Do not use acid to extract metals from PCBs'**
  String get doNotAcidLeach;

  /// No description provided for @wearGloves.
  ///
  /// In en, this message translates to:
  /// **'Always wear gloves when handling e-waste'**
  String get wearGloves;

  /// No description provided for @wearMask.
  ///
  /// In en, this message translates to:
  /// **'Wear a mask when sorting dusty materials'**
  String get wearMask;

  /// No description provided for @washHands.
  ///
  /// In en, this message translates to:
  /// **'Wash hands after handling e-waste'**
  String get washHands;

  /// No description provided for @keepAwayChildren.
  ///
  /// In en, this message translates to:
  /// **'Keep e-waste away from children'**
  String get keepAwayChildren;

  /// No description provided for @handleBatteriesSafely.
  ///
  /// In en, this message translates to:
  /// **'Handle batteries carefully - risk of fire'**
  String get handleBatteriesSafely;

  /// No description provided for @listenSafety.
  ///
  /// In en, this message translates to:
  /// **'Tap to hear safety guidance'**
  String get listenSafety;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline - Data will sync when connected'**
  String get offline;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @syncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing data...'**
  String get syncing;

  /// No description provided for @syncComplete.
  ///
  /// In en, this message translates to:
  /// **'Data synced successfully'**
  String get syncComplete;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to KabadiwalaConnect!'**
  String get welcomeMessage;

  /// No description provided for @collectorId.
  ///
  /// In en, this message translates to:
  /// **'Collector ID: {id}'**
  String collectorId(String id);

  /// No description provided for @lotCreated.
  ///
  /// In en, this message translates to:
  /// **'Lot Created'**
  String get lotCreated;

  /// No description provided for @lotStatus.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String lotStatus(String status);

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @quoted.
  ///
  /// In en, this message translates to:
  /// **'Quoted'**
  String get quoted;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @handedOver.
  ///
  /// In en, this message translates to:
  /// **'Handed Over'**
  String get handedOver;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @condition.
  ///
  /// In en, this message translates to:
  /// **'Condition'**
  String get condition;

  /// No description provided for @conditionIntact.
  ///
  /// In en, this message translates to:
  /// **'Intact / Good'**
  String get conditionIntact;

  /// No description provided for @conditionBroken.
  ///
  /// In en, this message translates to:
  /// **'Broken / Damaged'**
  String get conditionBroken;

  /// No description provided for @conditionMixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed'**
  String get conditionMixed;

  /// No description provided for @ttsGreeting.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Kabadiwala Connect. What would you like to do?'**
  String get ttsGreeting;

  /// No description provided for @ttsPriceBoard.
  ///
  /// In en, this message translates to:
  /// **'Today\'s prices. Tap any item to hear its price.'**
  String get ttsPriceBoard;

  /// No description provided for @ttsPriceInfo.
  ///
  /// In en, this message translates to:
  /// **'{material} price today is {price} rupees per kilo'**
  String ttsPriceInfo(String material, String price);

  /// No description provided for @ttsLotSaved.
  ///
  /// In en, this message translates to:
  /// **'Your lot has been saved. Estimated value is {value} rupees.'**
  String ttsLotSaved(String value);

  /// No description provided for @ttsRecyclerFound.
  ///
  /// In en, this message translates to:
  /// **'Found {count} recyclers near you.'**
  String ttsRecyclerFound(String count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'mr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'mr':
      return AppLocalizationsMr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
