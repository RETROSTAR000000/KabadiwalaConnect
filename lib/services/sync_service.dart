import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SyncItem {
  final String tableName;
  final String recordId;
  final String action;
  
  SyncItem(this.tableName, this.recordId, this.action);
}

class SyncService extends ChangeNotifier {
  bool _isOnline = true;
  int _pendingSyncCount = 0;
  
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<dynamic>? _subscription;
  
  final List<SyncItem> _syncQueue = [];

  SyncService() {
    startMonitoring();
  }

  bool get isOnline => _isOnline;
  int get pendingSyncCount => _pendingSyncCount;

  void startMonitoring() {
    _subscription = _connectivity.onConnectivityChanged.listen((dynamic event) {
      bool online = false;
      // Handle both pre-5.0 (ConnectivityResult) and post-5.0 (List<ConnectivityResult>)
      if (event is List<ConnectivityResult>) {
        online = event.isNotEmpty && !event.contains(ConnectivityResult.none);
      } else if (event is ConnectivityResult) {
        online = event != ConnectivityResult.none;
      }

      if (_isOnline != online) {
        _isOnline = online;
        notifyListeners();
        if (_isOnline && _pendingSyncCount > 0) {
          syncPendingItems();
        }
      }
    });
  }

  Future<void> syncPendingItems() async {
    if (!_isOnline) return;
    
    // Stub: Simulate network synchronization processing
    await Future.delayed(const Duration(seconds: 2));
    
    _syncQueue.clear();
    _pendingSyncCount = 0;
    notifyListeners();
  }

  void addToSyncQueue(String tableName, String recordId, String action) {
    _syncQueue.add(SyncItem(tableName, recordId, action));
    _pendingSyncCount = _syncQueue.length;
    notifyListeners();
    
    if (_isOnline) {
      syncPendingItems();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
