import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MainApp());
}

/// App shell. It is stateless: no mutable data lives here.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Stateful Counter',
      home: CounterPage(),
    );
  }
}

/// A [StatefulWidget] is immutable. It describes the UI and creates a
/// [State] object that holds the mutable data.
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

/// The state object. [State] survives rebuilds, so `_count` keeps its value
/// between frames. It is the only mutable field in the app.
class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  /// `setState` mutates the field and tells Flutter to rebuild this widget.
  void _increment() => setState(() => _count += 1);

  /// The guard keeps the non-negative invariant: decrement is a no-op at 0.
  void _decrement() => setState(() {
        if (_count > 0) _count -= 1;
      });

  void _reset() => setState(() => _count = 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stateful Counter')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The displayed value is derived from state on every build; it is
            // never stored twice.
            Text(
              '$_count',
              key: const ValueKey('counter-value'),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove),
                  tooltip: 'Decrement',
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: _increment,
                  icon: const Icon(Icons.add),
                  tooltip: 'Increment',
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Reset',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
