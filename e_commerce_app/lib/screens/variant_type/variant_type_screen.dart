import 'package:e_commerce_app/utility/constants.dart';
import 'package:e_commerce_app/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'component/add_variant_type_form.dart';
import 'component/variant_type_header.dart';
import 'component/variant_type_list_section.dart';

class VariantsTypeScreen extends StatelessWidget {
  const VariantsTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: <Widget>[
            const VariantsTypeHeader(),
            const Gap(defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "My Variant Types", style: Theme.of(context).textTheme.titleMedium,
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
                    showAddVariantsTypeForm(context,null);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add New"),
                ),
                const Gap(20),
                IconButton(
                    onPressed: () {
                      context.dataProvider.getAllVariantType(showSnack: true);
                    },
                    icon: const Icon(Icons.refresh)),
              ],
            ),
            const Gap(defaultPadding),
            const VariantsTypeListSection(),
          ],
        ),
      ),
    );
  }
}
