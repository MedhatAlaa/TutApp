import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/resources/color_manger.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';
import 'package:tut_app/presentation/store_details/view_model/store_details_view_model.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
    // dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStringManger.storeDetails.tr()),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: ColorManger.white,
            size: AppSizeManger.size16,
          ),
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, contentScreenWidget(),
                  () {
                _viewModel.start();
              }) ??
              contentScreenWidget();
        },
      ),
    );
  }

  Widget contentScreenWidget() {
    return SingleChildScrollView(
      child: StreamBuilder<StoreDetails>(
        stream: _viewModel.outputStoreDetails,
        builder: (context, snapshot) {
          return _getItems(snapshot.data);
        },
      ),
    );
  }

  Widget _getItems(StoreDetails? storeDetails) {
    if (storeDetails != null) {
      return Padding(
        padding: const EdgeInsets.all(AppSizeManger.size12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              storeDetails.image,
              fit: BoxFit.cover,
              height: AppSizeManger.size200,
              width: double.infinity,
            ),
            const SizedBox(height: AppSizeManger.size20),
            _getSection(AppStringManger.details.tr()),
            const SizedBox(height: AppSizeManger.size8),
            _getTextInfo(storeDetails.details),
            const SizedBox(height: AppSizeManger.size14),
            _getSection(AppStringManger.services.tr()),
            const SizedBox(height: AppSizeManger.size8),
            _getTextInfo(storeDetails.services),
            const SizedBox(height: AppSizeManger.size14),
            _getSection(AppStringManger.aboutStore.tr()),
            const SizedBox(height: AppSizeManger.size8),
            _getTextInfo(storeDetails.about),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getSection(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _getTextInfo(String textInfo) {
    return Text(
      textInfo,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

/////
// SingleChildScrollView
// (
// child: StreamBuilder<StoreDetails>
// (
// stream: _viewModel.outputStoreDetails,builder: (
// context, snapshot) {
// return _getItems(snapshot.data);
// },
// )
// ,
// )
