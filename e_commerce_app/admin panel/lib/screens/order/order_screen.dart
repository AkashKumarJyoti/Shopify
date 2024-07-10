import 'package:e_commerce_app/screens/order/component/order_header.dart';
import 'package:e_commerce_app/screens/order/component/order_list_section.dart';
import 'package:e_commerce_app/screens/order/component/view_order_form.dart';
import 'package:e_commerce_app/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: <Widget>[
            const OrderHeader(),
            const Gap(defaultPadding),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("My Order", style: Theme.of(context).textTheme.titleMedium),
                ),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding,
                    ),
                  ),
                  onPressed: () {
                    showOrderForm(context, null);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add New"),
                ),
                const Gap(20),
                IconButton(
                  onPressed: () {
                    //TODO: should complete getAllCategory
                  },
                  icon: const Icon(Icons.refresh)
                ),
              ],
            ),
            const Gap(defaultPadding),
            const OrderListSection()
          ],
        ),
      )
    );
  }
}
