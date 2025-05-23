// ignore: dangling_library_doc_comments
/// IMPORTANT NOTE (dev8 - Lusayo Nyondo - May 12, 2025):
/// The following code is mostly AI generated. I made edits to make it work on my devices.
/// However, I'm limited to testing on Linux, Windows, and Android,
/// so I can't guarantee this works on all platforms.
/// I will however still submit the code. subject to review.

import 'dart:io' show Platform;
import 'dart:developer';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Do NOT import android_id here directly to avoid compile issues on desktop

/// Helper function to get Android ID only on Android using platform channel
/// or a separate plugin with conditional imports (not shown here).
/// For simplicity, returns null on non-Android platforms.
Future<String?> getAndroidId() async {
  if (!Platform.isAndroid) return null;

  DeviceIdService deviceIdService = DeviceIdService();
  return deviceIdService.getDeviceId();
}

Future<DeviceInfo> collectDeviceInfo() async {
  final deviceInfoPlugin = DeviceInfoPlugin();

  String model = 'unknown';
  String os = 'unknown';
  String deviceCode = 'unknown';
  String deviceName = 'unknown';

  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      model = androidInfo.model;
      os = 'Android ${androidInfo.version.release}';
      deviceCode =
          await getAndroidId() ?? 'unknown'; // Android ID if implemented
      deviceName = androidInfo.device;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      model = iosInfo.utsname.machine;
      os = 'iOS ${iosInfo.systemVersion}';
      deviceCode = iosInfo.identifierForVendor ?? 'unknown';
      deviceName = iosInfo.name;
    } else if (Platform.isWindows) {
      WindowsDeviceInfo windowsInfo = await deviceInfoPlugin.windowsInfo;
      model = windowsInfo.computerName;
      os = 'Windows ${windowsInfo.productName}';
      deviceCode = 'N/A';
      deviceName = windowsInfo.computerName;
    } else if (Platform.isMacOS) {
      MacOsDeviceInfo macInfo = await deviceInfoPlugin.macOsInfo;
      model = macInfo.model;
      os = 'macOS ${macInfo.osRelease}';
      deviceCode = 'N/A';
      deviceName = macInfo.computerName;
    } else if (Platform.isLinux) {
      LinuxDeviceInfo linuxInfo = await deviceInfoPlugin.linuxInfo;
      model = linuxInfo.name;
      os = '${linuxInfo.prettyName} ${linuxInfo.version ?? ''}';
      deviceCode = 'N/A';
      deviceName = linuxInfo.name;
    }
  } catch (e) {
    print("Couldn't fetch device info: ${e.toString()}");

    log(
      "Couldn't fetch device info: ${e.toString()}",
      name: 'device_info_local_task',
    );
  }

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appVersion = packageInfo.version;

  String fcmToken = '';
  //await FirebaseMessaging.instance.getToken() ?? '';

  DateTime now = DateTime.now();

  return DeviceInfo(
    model: model,
    os: os,
    deviceCode: deviceCode,
    deviceName: deviceName,
    appVersion: appVersion,
    fcmToken: fcmToken,
    createdAt: now,
    updatedAt: now,
    isActive: true,
    isAuthorised: true,
  );
}

class DeviceIdService {
  DeviceIdService._();
  static DeviceIdService instance = DeviceIdService._();
  factory DeviceIdService() {
    return instance;
  }

  static const MethodChannel _channel = MethodChannel(
    'com.example.speechapp/android_id',
  );
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String?> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        final String? androidId = await _channel.invokeMethod('getAndroidId');
        return androidId;
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return iosInfo.identifierForVendor;
      }
      return null;
    } catch (e) {
      log('Error getting device ID: $e');
      return null;
    }
  }
}

class DeviceInfo {
  final String model;
  final String os;
  final String deviceCode;
  final String deviceName;
  // Might be subject to change
  final String appVersion;
  final String fcmToken;

  final DateTime createdAt;
  final DateTime updatedAt;

  final bool isActive;
  final bool isAuthorised;

  DeviceInfo({
    required this.model,
    required this.os,
    required this.deviceCode,
    required this.deviceName,
    required this.appVersion,
    required this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isAuthorised,
  });

  factory DeviceInfo.fromJson(dynamic json) {
    if (!json is Map<String, dynamic>) {
      throw Exception(
        "Can't parse object into device data object. Must be an instance of Map<String, dynamic>.",
      );
    }

    return DeviceInfo(
      model: json['model'],
      os: json['os'],
      deviceCode: json['device_code'],
      deviceName: json['device_name'],
      appVersion: json['app_version'],
      fcmToken: json['fcm_token'],
      createdAt: json['created'],
      updatedAt: json['updated'],
      isActive: json['activated'],
      isAuthorised: json['authorised'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'os': os,
      'device_code': deviceCode,
      'device_name': deviceName,
      'app_version': appVersion,
      'fcm_token': fcmToken,
      'created': createdAt.toIso8601String(),
      'updated': updatedAt.toIso8601String(),
      'active': isActive,
      'authorised': isAuthorised,
    };
  }
}
