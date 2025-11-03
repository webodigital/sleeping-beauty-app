import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';


class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RewardsScreen'),
      ),
      body: const Center(
        child: Text('RewardsScreen!'),
      ),
    );
  }
}
