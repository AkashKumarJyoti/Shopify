import 'package:e_commerce_app/screens/posters/component/add_poster_form.dart';
import 'package:e_commerce_app/screens/posters/component/poster_header.dart';
import 'package:e_commerce_app/screens/posters/component/poster_list_section.dart';
import 'package:e_commerce_app/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';

class PosterScreen extends StatelessWidget {
  const PosterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: <Widget>[
              const PosterHeader(),
              const Gap(defaultPadding),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text("My Poster", style: Theme.of(context).textTheme.titleMedium),
                  ),
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding,
                      ),
                    ),
                    onPressed: () {
                      showAddPosterForm(context, null);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add New"),
                  ),
                  const Gap(20),
                  IconButton(
                      onPressed: () {
                        context.dataProvider.getAllPoster(showSnack: true);
                      },
                      icon: const Icon(Icons.refresh)
                  ),
                ],
              ),
              const Gap(defaultPadding),
              const PosterListSection()
            ],
          ),
        )
    );
  }
}
