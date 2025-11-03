import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';


class JourneyScreen extends StatefulWidget {
  const JourneyScreen({Key? key}) : super(key: key);

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JourneyScreen'),
      ),
      body: const Center(
        child: Text('JourneyScreen'),
      ),
    );
  }
}
