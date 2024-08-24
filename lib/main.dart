import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/App.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'Core/BlocObserver.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      'resource://drawable/th',
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white,
        playSound: true,
          channelShowBadge: true
        )
      ],

  );  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  print("Cache is${CacheHelper.getData(key: "idUser")}");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
       const MyApp());
}
