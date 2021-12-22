import 'package:flutter/material.dart';
import '../providers/counter_provider.dart';

//mostrando como funciona o inheritedWidget
class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo Contador'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(CounterProvider.of(context)!.state.value.toString()),
            IconButton(
              onPressed: () {
                setState(() {
                  CounterProvider.of(context)!.state.inc();
                });
                // ignore: avoid_print
                print(CounterProvider.of(context)!.state);
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  CounterProvider.of(context)!.state.dec();
                });
                // ignore: avoid_print
                print(CounterProvider.of(context)!.state);
              },
              icon: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
