import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:tut_app/presentation/resources/color_manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
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
        },
      ),
    );
  }

  Widget contentScreenWidget() {
    return StreamBuilder<List<Service>>(
      stream: _viewModel.outputServices,
      builder: (context, snapshot) {
        return _getServicesWidget(snapshot.data);
      },
    );
  }

  Widget _getServicesWidget(List<Service>? services) {
    if (services != null) {
      return ListView(
        children: services.map((service) {
          return Padding(
            padding: const EdgeInsets.all(AppSizeManger.size16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizeManger.size12),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    service.image,
                    fit: BoxFit.cover,
                    height: AppSizeManger.size140,
                    width: AppSizeManger.size140,
                  ),
                ),
                const SizedBox(
                  width: AppSizeManger.size20,
                ),
                Text(
                  service.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: ColorManger.primary,
                ),
              ],
            ),
          );
        }).toList(),
      );
    } else {
      return Container();
    }
  }
}
