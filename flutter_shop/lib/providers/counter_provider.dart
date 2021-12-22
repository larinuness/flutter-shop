import 'package:flutter/material.dart';

//mostrando como funciona o inheritedWidget
class CounterState {
  int _value = 0;

  void inc() => _value++;
  void dec() => _value--;

  int get value => _value;

  bool diff(CounterState old) {
    return old._value != _value;
  }
}

class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  CounterProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  //pode ser null
  static CounterProvider? of(BuildContext context) {
    //pega uma instancia da arvore de componentes
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    //atualizar se for diferente
    return oldWidget.state.diff(state);
  }
}
