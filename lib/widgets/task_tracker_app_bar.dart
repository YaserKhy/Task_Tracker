import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_ex/globals/app_colors.dart';

class TaskTrackerAppBar extends StatelessWidget {
  final bool back;
  const TaskTrackerAppBar({super.key, required this.back});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: back ? const BackButton(color: Colors.white) : null,
      backgroundColor: mainColor,
      centerTitle: true,
      title: Text(
        "Task Tracker",
        style: GoogleFonts.signikaNegative(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w700
        )
      )
    );
  }
}