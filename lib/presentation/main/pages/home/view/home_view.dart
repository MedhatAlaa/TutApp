import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:tut_app/presentation/resources/color_manger.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';

import '../../../../resources/routes_manger.dart';
import '../../../../store_details/view_model/store_details_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data?.getScreenWidget(
                    context,
                    contentScreenWidget(),
                    () {
                      _viewModel.start();
                    },
                  ) ??
                  contentScreenWidget();
            }),
      ),
    );
  }

  Widget contentScreenWidget() {
    return Padding(
      padding: const EdgeInsets.all(AppSizeManger.size18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getBannerCarousel(),
          const SizedBox(
            height: AppSizeManger.size8,
          ),
          _getSection(AppStringManger.services.tr()),
          const SizedBox(
            height: AppSizeManger.size8,
          ),
          _getServices(),
          const SizedBox(
            height: AppSizeManger.size8,
          ),
          _getSection(AppStringManger.stores.tr()),
          const SizedBox(
            height: AppSizeManger.size8,
          ),
          _getStores(),
        ],
      ),
    );
  }

  Widget _getBannerCarousel() {
    return StreamBuilder<List<BannerAd>>(
        stream: _viewModel.outputBanners,
        builder: (context, snapshot) {
          return _getBannerWidget(snapshot.data);
        });
  }

  Widget _getBannerWidget(List<BannerAd>? banners) {
    if (banners != null) {
      return CarouselSlider(
        items: banners
            .map(
              (banner) => SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: AppSizeManger.size1_5,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: ColorManger.primary,
                        width: AppSizeManger.size1_5),
                    borderRadius: BorderRadius.circular(
                      AppSizeManger.size12,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppSizeManger.size12,
                    ),
                    child: Image.network(
                      banner.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: AppSizeManger.size200,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      );
    } else {
      return Container();
    }
  }

  _getSection(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _getServices() {
    return StreamBuilder<List<Service>>(
        stream: _viewModel.outputServices,
        builder: (context, snapshot) {
          return _getServicesWidget(snapshot.data);
        });
  }

  Widget _getServicesWidget(List<Service>? services) {
    if (services != null) {
      return SizedBox(
        height: AppSizeManger.size140,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: services.map((service) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizeManger.size12),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizeManger.size12),
                    child: Image.network(
                      height: AppSizeManger.size100,
                      service.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: AppSizeManger.size6,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      service.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStores() {
    return StreamBuilder<List<Store>>(
        stream: _viewModel.outputStores,
        builder: (context, snapshot) {
          return _getStoresWidget(snapshot.data);
        });
  }

  Widget _getStoresWidget(List<Store>? stores) {
    if (stores != null) {
      return Flex(
        direction: Axis.vertical,
        children: [
          GridView.count(
            crossAxisCount: AppIntManger.gridCount,
            mainAxisSpacing: AppSizeManger.size8,
            crossAxisSpacing: AppSizeManger.size8,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: List.generate(stores.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.storeDetailsRoute);
                },
                child: Card(
                  child: Image.network(
                    stores[index].image,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
