import 'package:flutter/material.dart';
import 'package:weather_app/utility/constants.dart';
import 'package:weather_app/widgets/search_box.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Align(
        alignment: const Alignment(0, 0.6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Weather app",
                style: TextStyle(
                  fontSize: 32,
                  color: blackCon,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: SerarchBox());
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: whiteCon,
                      border: Border.all(width: 1, color: blackCon)),
                  child: Icon(
                    Icons.search,
                    size: 28,
                    color: blackCon,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
