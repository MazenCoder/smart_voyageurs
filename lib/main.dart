import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:smart_voyageurs/core/util/app_utils_impl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'core/injection/injection_container.dart' as di;
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';




void main() async {
  var db = AppDatabase.instance;
  WidgetsFlutterBinding.ensureInitialized();
  await di.setup();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('fr', 'FR'),
      ],
      path: 'assets/translations',
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppUtilsImpl()),
          // ChangeNotifierProvider(create: (_) => NoteNotifier()),
          Provider<AppDatabase>(
            create: (_) => db,
            dispose: (context, value) => value.close(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Smart Voyageurs',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: HomePageTest(),
      home: FutureBuilder<List<User>>(
        future: db.usersDao.getAllUsers(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting: return Center(
              child: CircularProgressIndicator(),
            );
            default:
              if (snapshot.data.isNotEmpty)
                return HomePage(snapshot.data.first);
              return HomePage(null);
          }
        },
      ),
      // home: HomePage(null),//SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

