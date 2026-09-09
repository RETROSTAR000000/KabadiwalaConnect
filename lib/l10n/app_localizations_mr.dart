// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'कबाडीवाला कनेक्ट';

  @override
  String get home => 'होम';

  @override
  String get newLot => 'नवीन माल';

  @override
  String get todayPrices => 'आजचे भाव';

  @override
  String get findRecycler => 'रिसायकलर शोधा';

  @override
  String get myLedger => 'माझा हिशोब';

  @override
  String get safetyGuide => 'सुरक्षा मार्गदर्शक';

  @override
  String get settings => 'सेटिंग्ज';

  @override
  String get language => 'भाषा';

  @override
  String get english => 'इंग्रजी';

  @override
  String get hindi => 'हिंदी';

  @override
  String get marathi => 'मराठी';

  @override
  String get recentTransactions => 'अलीकडील व्यवहार';

  @override
  String get noTransactions => 'अजून कोणतेही व्यवहार नाहीत';

  @override
  String get takePhoto => 'फोटो काढा';

  @override
  String get chooseFromGallery => 'गॅलरीतून निवडा';

  @override
  String get retakePhoto => 'पुन्हा फोटो काढा';

  @override
  String get useThisPhoto => 'हा फोटो वापरा';

  @override
  String get photoRequired => 'कृपया मालाचा फोटो काढा';

  @override
  String get selectCategory => 'मालाचा प्रकार निवडा';

  @override
  String get materialPCB => 'पीसीबी / सर्किट बोर्ड';

  @override
  String get materialCRT => 'जुना टीव्ही (CRT)';

  @override
  String get materialLCD => 'एलसीडी स्क्रीन';

  @override
  String get materialCable => 'वायर / केबल';

  @override
  String get materialBattery => 'बॅटरी';

  @override
  String get materialMotor => 'मोटर';

  @override
  String get materialPlastic => 'मिक्स प्लास्टिक';

  @override
  String get enterWeight => 'वजन टाका';

  @override
  String get weightInKg => 'वजन (किलो)';

  @override
  String get weightPrompt => 'किती किलो?';

  @override
  String get weightRequired => 'कृपया वजन टाका';

  @override
  String estimatedValue(String value) {
    return 'अंदाजे किंमत: ₹$value';
  }

  @override
  String priceRange(String low, String high) {
    return 'बाजार श्रेणी: ₹$low - ₹$high';
  }

  @override
  String get perKg => 'प्रति किलो';

  @override
  String get saveLot => 'माल सेव्ह करा';

  @override
  String get lotSaved => 'माल सेव्ह झाला!';

  @override
  String get lotSavedFindRecycler => 'माल सेव्ह झाला! रिसायकलर शोधायचा?';

  @override
  String get findRecyclerForLot => 'या मालासाठी रिसायकलर शोधा';

  @override
  String get priceBoardTitle => 'भाव पट्टी';

  @override
  String lastUpdated(String time) {
    return 'शेवटचे अपडेट: $time';
  }

  @override
  String get tapToHearPrice => 'भाव ऐकण्यासाठी कोणत्याही वस्तूवर टॅप करा';

  @override
  String pricePerKg(String price) {
    return '₹$price/किलो';
  }

  @override
  String get priceTrend => 'भावाचा कल';

  @override
  String get priceUp => 'भाव वाढत आहे';

  @override
  String get priceDown => 'भाव कमी होत आहे';

  @override
  String get priceStable => 'भाव स्थिर आहे';

  @override
  String get recyclerListTitle => 'जवळचे रिसायकलर';

  @override
  String get noRecyclersFound => 'जवळपास कोणताही रिसायकलर सापडला नाही';

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
    return 'दर: ₹$rate/किलो';
  }

  @override
  String acceptsCategory(String categories) {
    return 'स्वीकारतो: $categories';
  }

  @override
  String get contactRecycler => 'रिसायकलरशी संपर्क करा';

  @override
  String get callRecycler => 'कॉल करा';

  @override
  String get selectRecycler => 'हा रिसायकलर निवडा';

  @override
  String get handoverTitle => 'हँडओव्हर पावती';

  @override
  String handoverReference(String ref) {
    return 'संदर्भ: $ref';
  }

  @override
  String get material => 'माल';

  @override
  String get weight => 'वजन';

  @override
  String get agreedPrice => 'ठरलेली किंमत';

  @override
  String get collector => 'कबाडीवाला';

  @override
  String get recycler => 'रिसायकलर';

  @override
  String get location => 'ठिकाण';

  @override
  String get dateTime => 'तारीख आणि वेळ';

  @override
  String get recyclerConfirmed => 'रिसायकलरने पुष्टी केली';

  @override
  String get pending => 'बाकी';

  @override
  String get confirmed => 'पुष्टी झाली';

  @override
  String get generateHandover => 'हँडओव्हर पावती तयार करा';

  @override
  String get shareHandover => 'पावती शेअर करा';

  @override
  String get ledgerTitle => 'माझी कमाई';

  @override
  String get totalEarnings => 'एकूण कमाई';

  @override
  String get pendingDues => 'बाकी रक्कम';

  @override
  String get completedSales => 'पूर्ण विक्री';

  @override
  String get transactionHistory => 'व्यवहार इतिहास';

  @override
  String get paid => 'पैसे मिळाले';

  @override
  String get unpaid => 'पैसे बाकी';

  @override
  String get safetyTitle => 'सुरक्षा मार्गदर्शक';

  @override
  String get safetyWarning => 'चेतावणी: धोकादायक पद्धत';

  @override
  String get safetySafe => 'सुरक्षित पद्धत';

  @override
  String get doNotBurn => 'वायर किंवा केबल जाळू नका';

  @override
  String get doNotOpenBatteries => 'बॅटरी उघडू नका किंवा छिद्र पाडू नका';

  @override
  String get doNotBreakCRT => 'CRT स्क्रीन फोडू नका - त्यात शिसे असते';

  @override
  String get doNotAcidLeach => 'PCB मधून धातू काढण्यासाठी अ‍ॅसिड वापरू नका';

  @override
  String get wearGloves => 'ई-कचरा हाताळताना नेहमी हातमोजे घाला';

  @override
  String get wearMask => 'धूळ असलेला माल वेगळा करताना मास्क घाला';

  @override
  String get washHands => 'ई-कचरा हाताळल्यानंतर हात धुवा';

  @override
  String get keepAwayChildren => 'ई-कचरा मुलांपासून दूर ठेवा';

  @override
  String get handleBatteriesSafely => 'बॅटरी काळजीपूर्वक हाताळा - आगीचा धोका';

  @override
  String get listenSafety => 'सुरक्षा माहिती ऐकण्यासाठी टॅप करा';

  @override
  String get offline => 'ऑफलाइन - कनेक्ट झाल्यावर डेटा सिंक होईल';

  @override
  String get online => 'ऑनलाइन';

  @override
  String get syncing => 'डेटा सिंक होत आहे...';

  @override
  String get syncComplete => 'डेटा यशस्वीरित्या सिंक झाला';

  @override
  String get ok => 'ठीक आहे';

  @override
  String get cancel => 'रद्द करा';

  @override
  String get save => 'सेव्ह करा';

  @override
  String get delete => 'हटवा';

  @override
  String get edit => 'बदला';

  @override
  String get next => 'पुढे';

  @override
  String get back => 'मागे';

  @override
  String get done => 'झाले';

  @override
  String get yes => 'हो';

  @override
  String get no => 'नाही';

  @override
  String get close => 'बंद करा';

  @override
  String get loading => 'लोड होत आहे...';

  @override
  String get error => 'काहीतरी चूक झाली';

  @override
  String get retry => 'पुन्हा प्रयत्न करा';

  @override
  String get welcomeMessage => 'कबाडीवाला कनेक्ट मध्ये आपले स्वागत!';

  @override
  String collectorId(String id) {
    return 'कलेक्टर आयडी: $id';
  }

  @override
  String get lotCreated => 'माल तयार झाला';

  @override
  String lotStatus(String status) {
    return 'स्थिती: $status';
  }

  @override
  String get created => 'तयार';

  @override
  String get quoted => 'भाव मिळाला';

  @override
  String get accepted => 'स्वीकारले';

  @override
  String get handedOver => 'सोपवले';

  @override
  String get completed => 'पूर्ण';

  @override
  String get condition => 'स्थिती';

  @override
  String get conditionIntact => 'चांगले / व्यवस्थित';

  @override
  String get conditionBroken => 'तुटलेले / खराब';

  @override
  String get conditionMixed => 'मिश्र';

  @override
  String get ttsGreeting =>
      'कबाडीवाला कनेक्ट मध्ये आपले स्वागत. आपल्याला काय करायचे आहे?';

  @override
  String get ttsPriceBoard =>
      'आजचे भाव. भाव ऐकण्यासाठी कोणत्याही वस्तूवर टॅप करा.';

  @override
  String ttsPriceInfo(String material, String price) {
    return 'आज $material चा भाव $price रुपये किलो आहे';
  }

  @override
  String ttsLotSaved(String value) {
    return 'तुमचा माल सेव्ह झाला. अंदाजे किंमत $value रुपये आहे.';
  }

  @override
  String ttsRecyclerFound(String count) {
    return 'तुमच्या जवळ $count रिसायकलर सापडले.';
  }
}
