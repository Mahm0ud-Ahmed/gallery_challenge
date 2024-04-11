import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gellary_challenge/src/presentation/view/common/app_fade_shimmer.dart';
import 'package:gellary_challenge/src/presentation/view/pages/home/widgets/gallery_grid.dart';

import '../../../../../core/config/l10n/generated/l10n.dart';
import '../../../../../data/models/gallery_model.dart';
import '../../../../view_model/blocs/data_bloc/api_data_bloc.dart';
import '../../../../view_model/blocs/data_bloc/api_data_state.dart';
import '../../../common/image_widget.dart';
import '../../../common/text_widget.dart';

class HomeBody extends StatelessWidget {
  final ApiDataBloc<GalleryModel> apiDataBloc;
  const HomeBody({
    super.key,
    required this.apiDataBloc,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: BlocBuilder<ApiDataBloc<GalleryModel>, ApiDataState<GalleryModel>>(
        bloc: apiDataBloc,
        builder: (context, state) {
          return state.maybeMap(
            loading: (value) => GalleryGrid(
              length: 10,
              itemBuilder: (index) {
                return const AppFadeShimmer(
                  width: double.infinity,
                  height: double.infinity,
                  radius: 20,
                );
              },
            ),
            success: (value) {
              if (value.data != null && value.data!.images.isNotEmpty) {
                return GalleryGrid(
                  length: value.data!.images.length,
                  itemBuilder: (index) {
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ImageWidget(image: value.data!.images[index]),
                      ),
                    );
                  },
                );
              }
              return SliverToBoxAdapter(child: TextWidget(text: S.of(context).home_page_no_data));
            },
            error: (value) => SliverToBoxAdapter(child: TextWidget(text: value.error?.errorMessage ?? '')),
            orElse: () => const SliverToBoxAdapter(),
          );
        },
      ),
    );
  }
}
