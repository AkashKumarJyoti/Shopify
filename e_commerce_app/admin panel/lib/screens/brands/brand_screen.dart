import 'package:e_commerce_app/screens/brands/component/brand_header.dart';
import 'package:e_commerce_app/utility/constants.dart';
import 'package:e_commerce_app/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'component/add_brand_form.dart';
import 'component/brand_list_section.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: <Widget>[
            const BrandHeader(),
            const Gap(defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "My Brands", style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                      defaultPadding,
                    ),
                  ),
                  onPressed: () {
                    showBrandForm(context,null);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add New"),
                ),
                const Gap(20),
                IconButton(
                    onPressed: () {
                      context.dataProvider.getAllBrand(showSnack: true);
                    },
                    icon: const Icon(Icons.refresh)),
              ],
            ),
            const Gap(defaultPadding),
            const BrandListSection(),
          ],
        ),
      )
    );
  }
}
