import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    required this.titleText,
    required this.subText,
    required this.midContent,
    this.buttonText = "Button",
    this.cardBackgroundColor = const Color(0xFF262A34),
    required this.cardTheme,
    required this.buttonFunction,
  });

  final String titleText;
  final Widget subText;
  final Widget midContent;
  final String buttonText;
  final Color cardBackgroundColor;
  final Color cardTheme;
  final Function buttonFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Card(
        color: (cardBackgroundColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12)),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: cardTheme, width: 6.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 6.0, left: 24, right: 16, bottom: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Title Text
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.8,

                      child: Text(
                        titleText,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          color: cardTheme,
                        ),
                      ),
                    ),
                  ],
                ),

                // Content in the middle of the Card
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: midContent,
                ),

                // Button at the bottom of the Card
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     subText,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
