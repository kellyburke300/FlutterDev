import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class PostBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    debugPrint(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint(transition.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    debugPrint(error);
    super.onError(cubit, error, stackTrace);
  }
}
