import 'package:e_commerce_app/screens/coupon_code/component/add_coupon_form.dart';
import 'package:e_commerce_app/screens/coupon_code/component/coupon_code_header.dart';
import 'package:e_commerce_app/screens/coupon_code/component/coupon_list_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utility/constants.dart';

class CouponCodeScreen extends StatelessWidget {
  const CouponCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: <Widget>[
              const CouponCodeHeader(),
              const Gap(defaultPadding),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text("My CouponCode", style: Theme.of(context).textTheme.titleMedium),
                  ),
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding,
                      ),
                    ),
                    onPressed: () {
                      showAddCouponForm(context, null);
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
              const CouponListSection()
            ],
          ),
        )
    );
  }
}
