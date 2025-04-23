import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'AGL Quiz App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 49, 255, 100)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  bool showImage = false;
  void getNext() {
    showImage = !showImage;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Track the cursor position
  Offset _cursorPosition = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: MouseRegion(
        onEnter: (_) {},
        onExit: (_) {},
        onHover: (PointerEvent details) {
          setState(() {
            _cursorPosition = details.localPosition;  // Update cursor position
          });
        },
        child: Stack(
          children: [
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NameText(),
                  SizedBox(height: 50),
                  if (appState.showImage)
                    Image.asset(
                      'assets/tlf_agl_img.png',
                      width: 200,
                      height: 200,
                    ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          appState.getNext(); // Show image
                        },
                        child: Text(appState.showImage ? 'Hide Image' : 'Show Image'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Cursor position in the bottom right
            Positioned(
              bottom: 20,
              right: 20,
              child: Text(
                '(${_cursorPosition.dx.toStringAsFixed(2)}, ${_cursorPosition.dy.toStringAsFixed(2)})',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NameText extends StatelessWidget {
  const NameText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text('Amr Elkenawy', style: style),
      ),
    );
  }
}

// Favorites Page
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Image'),
        ),
      ],
    );
  }
}

