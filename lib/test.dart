// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food/FeaturesStore/Data/HomeScoffee/home_coffee_cubit.dart';
//
// class test extends StatelessWidget {
//   const test({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: BlocConsumer<HomeCoffeeCubit, HomeCoffeeState>(
//         listener: (context, state) {
//           // TODO: implement listener
//         },
//         builder: (context, state) {
//           return Column(
//             children: [
//               Text(HomeCoffeeCubit.get(context).userModel!.name)
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoid=YoutubePlayer.convertUrlToId("https://youtu.be/cYxONdI40pk");
    _controller = YoutubePlayerController(
      initialVideoId: videoid!, // Replace with your video ID
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),

      ),
    );
  }
}

