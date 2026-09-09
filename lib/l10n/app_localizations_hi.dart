// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'कबाड़ीवाला कनेक्ट';

  @override
  String get home => 'होम';

  @override
  String get newLot => 'नया माल';

  @override
  String get todayPrices => 'आज का भाव';

  @override
  String get findRecycler => 'रिसायकलर खोजें';

  @override
  String get myLedger => 'मेरा हिसाब';

  @override
  String get safetyGuide => 'सुरक्षा गाइड';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get language => 'भाषा';

  @override
  String get english => 'अंग्रेज़ी';

  @override
  String get hindi => 'हिंदी';

  @override
  String get marathi => 'मराठी';

  @override
  String get recentTransactions => 'हाल की बिक्री';

  @override
  String get noTransactions => 'अभी कोई बिक्री नहीं हुई';

  @override
  String get takePhoto => 'फ़ोटो लें';

  @override
  String get chooseFromGallery => 'गैलरी से चुनें';

  @override
  String get retakePhoto => 'दोबारा फ़ोटो लें';

  @override
  String get useThisPhoto => 'यह फ़ोटो इस्तेमाल करें';

  @override
  String get photoRequired => 'कृपया माल की फ़ोटो लें';

  @override
  String get selectCategory => 'माल का प्रकार चुनें';

  @override
  String get materialPCB => 'पीसीबी / सर्किट बोर्ड';

  @override
  String get materialCRT => 'पुराना टीवी (CRT)';

  @override
  String get materialLCD => 'एलसीडी स्क्रीन';

  @override
  String get materialCable => 'तार / केबल';

  @override
  String get materialBattery => 'बैटरी';

  @override
  String get materialMotor => 'मोटर';

  @override
  String get materialPlastic => 'मिक्स प्लास्टिक';

  @override
  String get enterWeight => 'वज़न डालें';

  @override
  String get weightInKg => 'वज़न (किलो)';

  @override
  String get weightPrompt => 'कितना किलो?';

  @override
  String get weightRequired => 'कृपया वज़न डालें';

  @override
  String estimatedValue(String value) {
    return 'अनुमानित कीमत: ₹$value';
  }

  @override
  String priceRange(String low, String high) {
    return 'बाज़ार रेंज: ₹$low - ₹$high';
  }

  @override
  String get perKg => 'प्रति किलो';

  @override
  String get saveLot => 'माल सेव करें';

  @override
  String get lotSaved => 'माल सेव हो गया!';

  @override
  String get lotSavedFindRecycler => 'माल सेव हो गया! रिसायकलर खोजें?';

  @override
  String get findRecyclerForLot => 'इस माल के लिए रिसायकलर खोजें';

  @override
  String get priceBoardTitle => 'भाव पट्टी';

  @override
  String lastUpdated(String time) {
    return 'अंतिम अपडेट: $time';
  }

  @override
  String get tapToHearPrice => 'भाव सुनने के लिए किसी पर टैप करें';

  @override
  String pricePerKg(String price) {
    return '₹$price/किलो';
  }

  @override
  String get priceTrend => 'भाव का रुझान';

  @override
  String get priceUp => 'भाव बढ़ रहा है';

  @override
  String get priceDown => 'भाव गिर रहा है';

  @override
  String get priceStable => 'भाव स्थिर है';

  @override
  String get recyclerListTitle => 'नज़दीकी रिसायकलर';

  @override
  String get noRecyclersFound => 'आस-पास कोई रिसायकलर नहीं मिला';

  @override
  String distance(String km) {
    return '$km किमी दूर';
  }

  @override
  String get authorized => 'अधिकृत';

  @override
  String get pickupAvailable => 'पिकअप उपलब्ध';

  @override
  String offersRate(String rate) {
    return 'रेट: ₹$rate/किलो';
  }

  @override
  String acceptsCategory(String categories) {
    return 'स्वीकार करता है: $categories';
  }

  @override
  String get contactRecycler => 'रिसायकलर से संपर्क करें';

  @override
  String get callRecycler => 'कॉल करें';

  @override
  String get selectRecycler => 'इस रिसायकलर को चुनें';

  @override
  String get handoverTitle => 'हैंडओवर रसीद';

  @override
  String handoverReference(String ref) {
    return 'संदर्भ: $ref';
  }

  @override
  String get material => 'माल';

  @override
  String get weight => 'वज़न';

  @override
  String get agreedPrice => 'तय कीमत';

  @override
  String get collector => 'कबाड़ीवाला';

  @override
  String get recycler => 'रिसायकलर';

  @override
  String get location => 'जगह';

  @override
  String get dateTime => 'तारीख और समय';

  @override
  String get recyclerConfirmed => 'रिसायकलर ने पुष्टि की';

  @override
  String get pending => 'बाकी';

  @override
  String get confirmed => 'पुष्टि हो गई';

  @override
  String get generateHandover => 'हैंडओवर रसीद बनाएं';

  @override
  String get shareHandover => 'रसीद शेयर करें';

  @override
  String get ledgerTitle => 'मेरी कमाई';

  @override
  String get totalEarnings => 'कुल कमाई';

  @override
  String get pendingDues => 'बकाया राशि';

  @override
  String get completedSales => 'पूरी बिक्री';

  @override
  String get transactionHistory => 'लेन-देन इतिहास';

  @override
  String get paid => 'भुगतान हो गया';

  @override
  String get unpaid => 'भुगतान बाकी';

  @override
  String get safetyTitle => 'सुरक्षा गाइड';

  @override
  String get safetyWarning => 'चेतावनी: खतरनाक तरीका';

  @override
  String get safetySafe => 'सुरक्षित तरीका';

  @override
  String get doNotBurn => 'तार या केबल न जलाएं';

  @override
  String get doNotOpenBatteries => 'बैटरी न खोलें या न छेदें';

  @override
  String get doNotBreakCRT => 'CRT स्क्रीन न तोड़ें - इसमें सीसा होता है';

  @override
  String get doNotAcidLeach =>
      'PCB से धातु निकालने के लिए एसिड का उपयोग न करें';

  @override
  String get wearGloves => 'ई-कचरा संभालते समय हमेशा दस्ताने पहनें';

  @override
  String get wearMask => 'धूल भरे माल को छांटते समय मास्क पहनें';

  @override
  String get washHands => 'ई-कचरा संभालने के बाद हाथ धोएं';

  @override
  String get keepAwayChildren => 'ई-कचरे को बच्चों से दूर रखें';

  @override
  String get handleBatteriesSafely => 'बैटरी सावधानी से संभालें - आग का खतरा';

  @override
  String get listenSafety => 'सुरक्षा जानकारी सुनने के लिए टैप करें';

  @override
  String get offline => 'ऑफ़लाइन - कनेक्ट होने पर डेटा सिंक होगा';

  @override
  String get online => 'ऑनलाइन';

  @override
  String get syncing => 'डेटा सिंक हो रहा है...';

  @override
  String get syncComplete => 'डेटा सफलतापूर्वक सिंक हो गया';

  @override
  String get ok => 'ठीक है';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get save => 'सेव करें';

  @override
  String get delete => 'हटाएं';

  @override
  String get edit => 'बदलें';

  @override
  String get next => 'आगे';

  @override
  String get back => 'पीछे';

  @override
  String get done => 'हो गया';

  @override
  String get yes => 'हां';

  @override
  String get no => 'नहीं';

  @override
  String get close => 'बंद करें';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get error => 'कुछ गड़बड़ हो गई';

  @override
  String get retry => 'दोबारा कोशिश करें';

  @override
  String get welcomeMessage => 'कबाड़ीवाला कनेक्ट में आपका स्वागत है!';

  @override
  String collectorId(String id) {
    return 'कलेक्टर आईडी: $id';
  }

  @override
  String get lotCreated => 'माल बनाया गया';

  @override
  String lotStatus(String status) {
    return 'स्थिति: $status';
  }

  @override
  String get created => 'बनाया गया';

  @override
  String get quoted => 'भाव मिला';

  @override
  String get accepted => 'स्वीकार किया';

  @override
  String get handedOver => 'सौंप दिया';

  @override
  String get completed => 'पूरा हो गया';

  @override
  String get condition => 'हालत';

  @override
  String get conditionIntact => 'सही / अच्छा';

  @override
  String get conditionBroken => 'टूटा / खराब';

  @override
  String get conditionMixed => 'मिला-जुला';

  @override
  String get ttsGreeting =>
      'कबाड़ीवाला कनेक्ट में आपका स्वागत है। आप क्या करना चाहते हैं?';

  @override
  String get ttsPriceBoard => 'आज का भाव। किसी भी चीज़ पर टैप करके भाव सुनें।';

  @override
  String ttsPriceInfo(String material, String price) {
    return 'आज $material का भाव $price रुपये किलो है';
  }

  @override
  String ttsLotSaved(String value) {
    return 'आपका माल सेव हो गया। अनुमानित कीमत $value रुपये है।';
  }

  @override
  String ttsRecyclerFound(String count) {
    return 'आपके पास $count रिसायकलर मिले।';
  }
}
