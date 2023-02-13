import 'package:flutter/material.dart';

import '../../../core/constants/asset_base_path.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
    child: Image.asset("$pngAssetsBasePath/nestle.png"),
    );
  }
}
