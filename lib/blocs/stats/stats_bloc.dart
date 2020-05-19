import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:goalsflutter/blocs/blocs.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StreamSubscription _goalsSubscription;

  StatsBloc({GoalsBloc goalsBloc}) : assert(goalsBloc != null) {
    _goalsSubscription = goalsBloc.listen((state) {
      if (state is GoalsLoaded) {
        add(UpdateStats(state.goals));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      int numActive =
          event.goals.where((goal) => !goal.complete).toList().length;
      int numCompleted =
          event.goals.where((goal) => goal.complete).toList().length;
      yield StatsLoaded(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    _goalsSubscription?.cancel();
    return super.close();
  }
}
