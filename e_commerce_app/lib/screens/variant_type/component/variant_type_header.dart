import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utility/constants.dart';

class VariantsTypeHeader extends StatelessWidget {
  const VariantsTypeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("Variants Type", style: Theme.of(context).textTheme.titleLarge),
        const Spacer(flex: 2),
        Expanded(
          child: SearchField(
            onChange: (val) {

            }
          ),
        ),
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Text("Angelina Jolie"),
          ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}


class SearchField extends StatelessWidget {
  final Function(String) onChange;
  const SearchField({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Search",
          fillColor: secondaryColor,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding*0.5),
            padding: const EdgeInsets.all(defaultPadding*0.75),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          )
      ),
    );
  }
}