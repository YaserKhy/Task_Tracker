import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_ex/blocs/home_bloc/home_bloc.dart';
import 'package:todo_ex/extensions/screen_size.dart';
import 'package:todo_ex/globals/app_colors.dart';
import 'package:todo_ex/screens/add_screen.dart';
import 'package:todo_ex/widgets/no_tasks_view.dart';
import 'package:todo_ex/widgets/task_tracker_app_bar.dart';
import 'package:todo_ex/widgets/view_tasks.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<HomeBloc>();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(context.getWidth(), context.getHeight(divideBy: MediaQuery.orientationOf(context) == Orientation.landscape ? 10 : 15)),
            child: const TaskTrackerAppBar(back: false)
          ),
          body: SafeArea(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                bloc.add(ShowTasksEvent());
                if (state is ShowTasksState) {
                  if(state.tasks.isNotEmpty) {
                    return ViewTasks(
                      tasks: state.tasks,
                      completedTasks: state.completedTasks,
                      unCompletedTasks: state.unCompletedTasks,
                      bloc: bloc,
                    );
                  }
                }
                return const NoTasksView();
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: mainColor,
            shape: const OvalBorder(),
            child: const Icon(Icons.add, size: 30, color: Colors.white),
            onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => const AddScreen())).then((v) => bloc.add(ShowTasksEvent()))
          ),
        );
      }),
    );
  }
}