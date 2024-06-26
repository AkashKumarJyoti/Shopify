import 'package:e_commerce_app/screens/sub_category/component/sub_category_header.dart';
import 'package:e_commerce_app/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'component/add_sub_category_form.dart';
import 'component/sub_category_list_section.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: <Widget>[
            const SubCategoryHeader(),
            const Gap(defaultPadding),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "My Sub Categories", style: Theme.of(context).textTheme.titleMedium,
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
                        showAddSubCategoryForm(context,null);
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
                const SubCategoryListSection(),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
