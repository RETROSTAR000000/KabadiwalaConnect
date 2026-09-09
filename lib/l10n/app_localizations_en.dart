// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'KabadiwalaConnect';

  @override
  String get home => 'Home';

  @override
  String get newLot => 'New Lot';

  @override
  String get todayPrices => 'Today\'s Prices';

  @override
  String get findRecycler => 'Find Recycler';

  @override
  String get myLedger => 'My Ledger';

  @override
  String get safetyGuide => 'Safety Guide';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get hindi => 'Hindi';

  @override
  String get marathi => 'Marathi';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get noTransactions => 'No transactions yet';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get retakePhoto => 'Retake Photo';

  @override
  String get useThisPhoto => 'Use this photo';

  @override
  String get photoRequired => 'Please take a photo of the material';

  @override
  String get selectCategory => 'Select Material Type';

  @override
  String get materialPCB => 'PCB / Circuit Board';

  @override
  String get materialCRT => 'Old TV (CRT)';

  @override
  String get materialLCD => 'LCD Screen';

  @override
  String get materialCable => 'Cable / Wire';

  @override
  String get materialBattery => 'Battery';

  @override
  String get materialMotor => 'Motor';

  @override
  String get materialPlastic => 'Mixed Plastic';

  @override
  String get enterWeight => 'Enter Weight';

  @override
  String get weightInKg => 'Weight (kg)';

  @override
  String get weightPrompt => 'How many kilograms?';

  @override
  String get weightRequired => 'Please enter weight';

  @override
  String estimatedValue(String value) {
    return 'Estimated Value: ₹$value';
  }

  @override
  String priceRange(String low, String high) {
    return 'Market Range: ₹$low - ₹$high';
  }

  @override
  String get perKg => 'per kg';

  @override
  String get saveLot => 'Save Lot';

  @override
  String get lotSaved => 'Lot saved successfully!';

  @override
  String get lotSavedFindRecycler => 'Lot saved! Find a recycler?';

  @override
  String get findRecyclerForLot => 'Find Recycler for This Lot';

  @override
  String get priceBoardTitle => 'Price Board';

  @override
  String lastUpdated(String time) {
    return 'Last updated: $time';
  }

  @override
  String get tapToHearPrice => 'Tap any item to hear its price';

  @override
  String pricePerKg(String price) {
    return '₹$price/kg';
  }

  @override
  String get priceTrend => 'Price Trend';

  @override
  String get priceUp => 'Price is rising';

  @override
  String get priceDown => 'Price is falling';

  @override
  String get priceStable => 'Price is stable';

  @override
  String get recyclerListTitle => 'Nearby Recyclers';

  @override
  String get noRecyclersFound => 'No recyclers found nearby';

  @override
  String distance(String km) {
    return '$km km away';
  }

  @override
  String get authorized => 'Authorized';

  @override
  String get pickupAvailable => 'Pickup Available';

  @override
  String offersRate(String rate) {
    return 'Offers: ₹$rate/kg';
  }

  @override
  String acceptsCategory(String categories) {
    return 'Accepts: $categories';
  }

  @override
  String get contactRecycler => 'Contact Recycler';

  @override
  String get callRecycler => 'Call';

  @override
  String get selectRecycler => 'Select This Recycler';

  @override
  String get handoverTitle => 'Handover Receipt';

  @override
  String handoverReference(String ref) {
    return 'Reference: $ref';
  }

  @override
  String get material => 'Material';

  @override
  String get weight => 'Weight';

  @override
  String get agreedPrice => 'Agreed Price';

  @override
  String get collector => 'Collector';

  @override
  String get recycler => 'Recycler';

  @override
  String get location => 'Location';

  @override
  String get dateTime => 'Date & Time';

  @override
  String get recyclerConfirmed => 'Recycler Confirmed';

  @override
  String get pending => 'Pending';

  @override
  String get confirmed => 'Confirmed';

  @override
  String get generateHandover => 'Generate Handover Record';

  @override
  String get shareHandover => 'Share Receipt';

  @override
  String get ledgerTitle => 'My Earnings';

  @override
  String get totalEarnings => 'Total Earnings';

  @override
  String get pendingDues => 'Pending Dues';

  @override
  String get completedSales => 'Completed Sales';

  @override
  String get transactionHistory => 'Transaction History';

  @override
  String get paid => 'Paid';

  @override
  String get unpaid => 'Unpaid';

  @override
  String get safetyTitle => 'Safety Guide';

  @override
  String get safetyWarning => 'WARNING: Dangerous Practice';

  @override
  String get safetySafe => 'Safe Practice';

  @override
  String get doNotBurn => 'Do not burn cables or wires';

  @override
  String get doNotOpenBatteries => 'Do not open or puncture batteries';

  @override
  String get doNotBreakCRT => 'Do not break CRT screens - they contain lead';

  @override
  String get doNotAcidLeach => 'Do not use acid to extract metals from PCBs';

  @override
  String get wearGloves => 'Always wear gloves when handling e-waste';

  @override
  String get wearMask => 'Wear a mask when sorting dusty materials';

  @override
  String get washHands => 'Wash hands after handling e-waste';

  @override
  String get keepAwayChildren => 'Keep e-waste away from children';

  @override
  String get handleBatteriesSafely =>
      'Handle batteries carefully - risk of fire';

  @override
  String get listenSafety => 'Tap to hear safety guidance';

  @override
  String get offline => 'Offline - Data will sync when connected';

  @override
  String get online => 'Online';

  @override
  String get syncing => 'Syncing data...';

  @override
  String get syncComplete => 'Data synced successfully';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get done => 'Done';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get close => 'Close';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get welcomeMessage => 'Welcome to KabadiwalaConnect!';

  @override
  String collectorId(String id) {
    return 'Collector ID: $id';
  }

  @override
  String get lotCreated => 'Lot Created';

  @override
  String lotStatus(String status) {
    return 'Status: $status';
  }

  @override
  String get created => 'Created';

  @override
  String get quoted => 'Quoted';

  @override
  String get accepted => 'Accepted';

  @override
  String get handedOver => 'Handed Over';

  @override
  String get completed => 'Completed';

  @override
  String get condition => 'Condition';

  @override
  String get conditionIntact => 'Intact / Good';

  @override
  String get conditionBroken => 'Broken / Damaged';

  @override
  String get conditionMixed => 'Mixed';

  @override
  String get ttsGreeting =>
      'Welcome to Kabadiwala Connect. What would you like to do?';

  @override
  String get ttsPriceBoard =>
      'Today\'s prices. Tap any item to hear its price.';

  @override
  String ttsPriceInfo(String material, String price) {
    return '$material price today is $price rupees per kilo';
  }

  @override
  String ttsLotSaved(String value) {
    return 'Your lot has been saved. Estimated value is $value rupees.';
  }

  @override
  String ttsRecyclerFound(String count) {
    return 'Found $count recyclers near you.';
  }
}
