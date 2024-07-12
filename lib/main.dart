import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imake/tasks/data/local/data_sources/login_data_provider.dart';
import 'package:imake/tasks/data/repository/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:imake/routes/app_router.dart';
import 'package:imake/bloc_state_observer.dart';
import 'package:imake/routes/pages.dart';
import 'package:imake/tasks/data/local/data_sources/tasks_data_provider.dart';
import 'package:imake/tasks/data/repository/task_repository.dart';
import 'package:imake/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:imake/utils/color_palette.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocStateOberver();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initializeDateFormatting('pt_BR', null).then((_) => runApp(MyApp(
        preferences: preferences,
      )));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;

  const MyApp({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) => TaskRepository(
                taskDataProvider: TaskDataProvider(preferences))),
        RepositoryProvider(
            create: (context) => LoginRepository(
                loginDataProvider: LoginDataProvider(preferences)))
      ],
      child: BlocProvider(
          create: (context) => TasksBloc(
              context.read<TaskRepository>(), context.read<LoginRepository>()),
          child: MaterialApp(
            title: 'IMake - Gerenciador de Tarefas',
            debugShowCheckedModeBanner: false,
            initialRoute: Pages.initial,
            onGenerateRoute: onGenerateRoute,
            theme: ThemeData(
              fontFamily: 'Sora',
              visualDensity: VisualDensity.adaptivePlatformDensity,
              canvasColor: Colors.transparent,
              colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
              useMaterial3: true,
            ),
          )),
    );
  }
}
