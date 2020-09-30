import 'package:smart_voyageurs/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:smart_voyageurs/features/login/data/repositories/login_repository_impl.dart';
import 'package:smart_voyageurs/features/splash/domain/repositories/splash_repository.dart';
import 'package:smart_voyageurs/features/login/data/database/login_local_data_source.dart';
import 'package:smart_voyageurs/features/login/domain/repositories/login_repository.dart';
import 'package:smart_voyageurs/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:smart_voyageurs/features/login/presentation/bloc/login_bloc.dart';
import 'package:smart_voyageurs/features/login/domain/usecases/get_login.dart';
import 'package:smart_voyageurs/features/splash/domain/usecases/get_auth.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:smart_voyageurs/core/database/app_database.dart';
import 'package:smart_voyageurs/core/network/network_info.dart';
import 'package:smart_voyageurs/core/util/app_utils_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_voyageurs/core/util/app_utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';


final GetIt sl = GetIt.instance;

Future<void> setup() async {
  try {
    await init();
    await initUtilsImpl();
    await initLoginPage();
    await initSplashPage();
  } catch(e) {
    print('error, setup: $e');
  }
}


///!  init
Future<void> init() async {
  try {

    //! Date
    await initializeDateFormatting('fr_FR', null);

    //! Network
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

    //! External
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => DataConnectionChecker());
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => http.Client());

    //! Database
    final db = AppDatabase.instance;
    sl.registerLazySingleton(() => db);
  } catch(e) {
    print('error, init: $e');
  }
}

///!  initUtilsImpl
Future<void> initUtilsImpl() async {
  // sl.registerLazySingleton<AppUtils>(() => AppUtilsImpl(preferences: sl()));
  sl.registerSingleton<AppUtils>(AppUtilsImpl(preferences: sl(),
      client: sl(), networkInfo: sl(), database: sl()), signalsReady: true);
}

///! SplashPage
Future<void> initSplashPage() async {

  //! Bloc
  sl.registerFactory(() => SplashBloc(getAuth: sl()));

  //! Use cases
  sl.registerLazySingleton(() => GetAuth(repository: sl()));

  //! Repository
  sl.registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImpl(db: sl()),
  );
}

///! LoginPage
Future<void> initLoginPage() async {

  //! Bloc
  sl.registerFactory(() => LoginBloc(getLogin: sl()));

  //! Use cases
  sl.registerLazySingleton(() => GetLogin(repository: sl()));

  //! Repository
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(
        db: sl(),
        preferences: sl(),
        localDataSource: sl(),
    ),
  );


  //! Data sources
  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl(preferences: sl(), db: sl()),
  );

}