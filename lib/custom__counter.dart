import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String get progressMessage {
    if (_counter > 5) {
      return "Great progress!";
    } else {
      return "";
    }
  }
  int _counter = 0;

  void _incrementCounter() {
    if (_counter < 10) {
      setState(() {
        _counter++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Maximum limit reached."),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _decrementCounter() {
    if (_counter != 0) {
      setState(() {
        _counter--;
      });
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // To make gradient visible behind AppBar
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // Remove AppBar shadow
        title: Text(
          widget.title, // Using widget.title for dynamic title
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: Icon(Icons.emoji_events, color: Colors.yellowAccent), // Changed icon and color
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white), // Changed icon and color
            onPressed: () {
              // Add settings functionality here if needed
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.info_outline, color: Colors.white), // Changed icon and color
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontSize: 72),
            ),
            if (_counter > 5)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  progressMessage, // Using the getter for conditional text
                  style: TextStyle(fontSize: 18, color: Colors.lightGreenAccent, fontWeight: FontWeight.w500),
                ),
              ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0), // Reduced horizontal padding
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.add_circle_outline, color: Colors.white),
                    label: Text("Increment", style: TextStyle(color: Colors.white)),
                    onPressed: _incrementCounter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.withOpacity(0.8),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12), // Reduced padding
                      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Reduced font size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0), // Reduced horizontal padding
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.refresh, color: Colors.white),
                    label: Text("Reset", style: TextStyle(color: Colors.white)),
                    onPressed: _resetCounter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent.withOpacity(0.8),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12), // Reduced padding
                      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Reduced font size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0), // Reduced horizontal padding
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.remove_circle_outline, color: Colors.white),
                    label: Text("Decrement", style: TextStyle(color: Colors.white)),
                    onPressed: _decrementCounter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.withOpacity(0.8),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12), // Reduced padding
                      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Reduced font size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ), // Closing SingleChildScrollView
          ],
        ),
      ), // Closing Center
      ), // Closing Container
    );
  }
}
