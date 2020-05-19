import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goalsflutter/screens/app_screen.dart';
import 'package:goalsflutter/screens/login_screen.dart';
import 'package:user_repository/user_repository.dart';

import 'blocs/authentication_bloc/bloc.dart';
import 'blocs/blocs.dart';
import 'screens/screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = FirebaseUserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatefulWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String id;

  void setId() async {
    id = await widget._userRepository.getUserId();
    print('$id');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: widget._userRepository);
          }
          if (state is Authenticated) {
            setId();
            return AppScreen(state.props[0]);
          }
          if (state is Uninitialized) {
            return LoginScreen(userRepository: widget._userRepository);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
