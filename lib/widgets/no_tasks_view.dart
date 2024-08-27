import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_ex/extensions/screen_size.dart';

class NoTasksView extends StatelessWidget {
  const NoTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
      alignment: Alignment.center,
      height: context.getHeight(divideBy: 2),
      child: Text(
        "No Tasks Added Yet",
        style: GoogleFonts.signikaNegative(
          fontSize: 20
          )
        )
      )
    );
  }
}