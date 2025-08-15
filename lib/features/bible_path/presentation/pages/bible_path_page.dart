import 'package:flutter/material.dart';

import '../widgets/bible_path_page_body.dart';

class BiblePathPage extends StatelessWidget {
  const BiblePathPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: BiblePathPageBody()));
  }
}
