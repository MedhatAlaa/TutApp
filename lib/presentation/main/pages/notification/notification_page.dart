import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';

import '../../../resources/assets_manger.dart';
import '../../../resources/string_manger.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapShot) {
            return Container(
              height: AppSizeManger.size200,
              width: AppSizeManger.size200,
              child: Column(
                children: [
                  Lottie.asset(
                    JsonAssetsManger.loading2,
                    height: AppSizeManger.size160,
                  ),
                  const SizedBox(
                    height: AppSizeManger.size12,
                  ),
                  Text(
                    AppStringManger.fixPage.tr(),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
