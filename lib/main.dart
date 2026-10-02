import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list08flu/add/add_page.dart';
import 'package:todo_list08flu/database/app_database.dart';
import 'package:todo_list08flu/database/app_repository.dart';
import 'package:todo_list08flu/home/home_cubit.dart';
import 'package:todo_list08flu/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:todo_list08flu/utils/app_snackbar.dart';

late final AppDatabase appDatabase;
late final AppRepository appRepository;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final isDarkTheme = preferences.getBool('isDarkTheme') ?? false;

  await Hive.initFlutter();
  await Hive.openBox('todoBox');

  appDatabase = AppDatabase();
  appRepository = AppRepositoryImpl(db: appDatabase);

  print("Dark Theme: $isDarkTheme");
  runApp(MyApp(isDarkTheme: isDarkTheme));
}

class MyApp extends StatefulWidget {
  final bool isDarkTheme;
  const MyApp({super.key, required this.isDarkTheme});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkTheme;
  // late bool _isOnboardShown;
  HomeCubit _cubit = HomeCubit(repo: appRepository);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isDarkTheme = widget.isDarkTheme;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: BlocProvider(
        create: (_) => _cubit,
        child: MyHomePage(
          cubit: _cubit,
          isDarkTheme: _isDarkTheme,
          onThemeChanged: _changeTheme,
        ),
      ),
    );
  }

  void _changeTheme(bool value) {
    setState(() {
      _isDarkTheme = value;
    });
  }
}
