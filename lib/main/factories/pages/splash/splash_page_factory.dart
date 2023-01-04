import 'package:flutter/material.dart';

import '../../../../ui/pages/pages.dart';
import 'splash_presenter_factory.dart';

Widget makeSplashPage() => SplashPage(presenter: makeGetxSplashPresenter());
