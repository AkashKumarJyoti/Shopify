import 'package:e_commerce_app/screens/variant/component/variant_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utility/constants.dart';
import 'component/add_variant_form.dart';
import 'component/variants_list_section.dart';

class VariantsScreen extends StatelessWidget {
  const VariantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            const VariantsHeader(),
            const Gap(defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "All Variants", style: Theme.of(context).textTheme.titleMedium,
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
                    showAddVariantForm(context,null);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add New"),
                ),
                const Gap(20),
                IconButton(
                    onPressed: () {
                      //TODO: should complete call getAllSubCategory
                    },
                    icon: const Icon(Icons.refresh)),
              ],
            ),
            const Gap(defaultPadding),
            const VariantsListSection(),
          ],
        ),
      )
    );
  }
}
