import 'package:e_commerce_app/screens/notification/component/notification_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utility/constants.dart';
import 'component/notification_list_section.dart';
import 'component/send_notification_form.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: <Widget>[
            const NotificationHeader(),
            const Gap(defaultPadding),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("My Notification", style: Theme.of(context).textTheme.titleMedium),
                ),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding,
                    ),
                  ),
                  onPressed: () {
                    sendNotificationFormForm(context);
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
            const NotificationListSection()
          ],
        ),
      ),
    );
  }
}
