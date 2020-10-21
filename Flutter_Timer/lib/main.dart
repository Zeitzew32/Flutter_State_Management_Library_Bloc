import 'package:Flutter_Timer/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Flutter_Timer/ticker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(109, 234, 255, 1),
        accentColor: Color.fromRGBO(72, 74, 126, 1),
        brightness: Brightness.dark,
      ),
      title: 'Flutter Timer',
      home: BlocProvider(
        create: (context) => TimerBloc(ticker: Ticker()),
        child: Timer(),
      ),
    );
  }
}

class Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
        timerBloc: BlocProvider.of<TimerBloc>(context),
      ),
    );
  }

  List<Widget> _mapStateToActionButtons({
    TimerBloc timerBloc,
  }) {
    final TimerState currentState = timerBloc.state;
    if (currentState is TimerInitial) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () =>
              timerBloc.add(TimerStarted(duration: currentState.duration)),
        ),
      ];
    }
    if (currentState is TimerRunInProgress) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => timerBloc.add(TimerPaused()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
      ];
    }
    if (currentState is TimerRunPause) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBloc.add(TimerResumed()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
      ];
    }
    if (currentState is TimerRunComplete) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
      ];
    }
    return [];
  }
}

@override
Widget build(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: _mapStateToActionButtons(
      timerBloc: BlocProvider.of<TimerBloc>(context),
    ),
  );
}

List<Widget> _mapStateToActionButtons({
  TimerBloc timerBloc,
}) {
  final TimerState currentState = timerBloc.state;
  if (currentState is TimerInitial) {
    return [
      FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () =>
            timerBloc.add(TimerStarted(duration: currentState.duration)),
      )
    ];
  }
  if (currentState is TimerRunInProgress) {
    return [
      FloatingActionButton(
        child: Icon(Icons.pause),
        onPressed: () => timerBloc.add(TimerPaused()),
      ),
      FloatingActionButton(
        child: Icon(Icons.replay),
        onPressed: () => timerBloc.add(TimerReset()),
      ),
    ];
  }
  if (currentState is TimerRunPause) {
    return [
      FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () => timerBloc.add(TimerResumed()),
      ),
      FloatingActionButton(
        child: Icon(Icons.replay),
        onPressed: () => timerBloc.add(TimerReset()),
      ),
    ];
  }
  if (currentState is TimerRunComplete) {
    return [
      FloatingActionButton(
        child: Icon(Icons.replay),
        onPressed: () => timerBloc.add(TimerReset()),
      )
    ];
  }
  return [];
}

class Timer extends StatelessWidget {
  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Timer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 100.0),
            child: Center(
              child: BlocBuilder<TimerBloc, TimerState>(
                builder: (context, state) {
                  final String minutesStr = ((state.duration / 60) % 60)
                      .floor()
                      .toString()
                      .padLeft(2, '0');
                  final String secondsStr =
                      (state.duration % 60).floor().toString().padLeft(2, '0');
                  return Text(
                    '$minutesStr:$secondsStr',
                    style: Timer.timerTextStyle,
                  );
                },
              ),
            ),
          ),
          BlocBuilder<TimerBloc, TimerState>(
            buildWhen: (previousState, state) =>
                state.runtimeType != previousState.runtimeType,
            builder: (context, state) => Actions(),
          )
        ],
      ),
    );
  }
}
