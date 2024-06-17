import 'package:flutter/material.dart';
import 'package:registration/registration.dart';
import 'package:flutter_logs/flutter_logs.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterLogs.initLogs(
    logLevelsEnabled:[
      LogLevel.INFO,
      LogLevel.WARNING,
      LogLevel.ERROR,
      LogLevel.SEVERE
    ],
    timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
    directoryStructure: DirectoryStructure.FOR_DATE,
    logTypesEnabled: ["KaamConnect Assignment","network","errors"],
    logFileExtension: LogFileExtension.LOG,
    logsExportDirectoryName: "KaamConnect Assignment",
    debugFileOperations: true,
    isDebuggable: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: register()
    );
  }
}

