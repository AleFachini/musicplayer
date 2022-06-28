import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/src/helpers/helpers.dart';
import 'package:musicplayer/src/model/audio_player.dart';
import 'package:musicplayer/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatelessWidget {
  MusicPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BackGroundGradient(),
        Column(
          children: [
            CustomAppBar(),
            DiscCoverAndDuration(),
            TiltePlay(),
            Expanded(child: Lyrics())
          ],
        ),
      ],
    ));
  }
}

class BackGroundGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: screenSize.height * 0.80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.center,
            colors: [
              Color(0xff33333e),
              Color(0xff201e28),
            ]),
      ),
    );
  }
}

class Lyrics extends StatelessWidget {
  Lyrics({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lyrics =
        getLyrics(); //retora una lista de strings o versos en este caso

    return Container(
      child: ListWheelScrollView(
        itemExtent: 42,
        children: lyrics
            .map((verse) => Text(
                  verse,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ))
            .toList(),
        diameterRatio: 1.5,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}

class TiltePlay extends StatefulWidget {
  TiltePlay({
    Key? key,
  }) : super(key: key);

  @override
  State<TiltePlay> createState() => _TiltePlayState();
}

class _TiltePlayState extends State<TiltePlay>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  AnimationController? iconAnimation;

  @override
  void initState() {
    //El mixin SingleTickProvider... es requerido para el vsync del controller
    iconAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    iconAnimation!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      margin: EdgeInsets.only(top: 50),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                'Far Away',
                style: TextStyle(
                    fontSize: 30, color: Colors.white.withOpacity(0.8)),
              ),
              Text(
                '-Breaking Benjamin-',
                style: TextStyle(
                    fontSize: 15, color: Colors.white.withOpacity(0.8)),
              ),
            ],
          ),
          Spacer(),
          FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            onPressed: () {
              final audioPlayerModel =
                  Provider.of<AudioPlayerModel>(context, listen: false);
              if (isPlaying) {
                iconAnimation!.reverse(from: 1);
                isPlaying = false;
                audioPlayerModel.controller.stop();
              } else {
                iconAnimation!.forward(from: 0);
                isPlaying = true;
                audioPlayerModel.controller.repeat();
              }
            },
            backgroundColor: Color(0xfff8cb51),
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: iconAnimation!,
            ),
          )
        ],
      ),
    );
  }
}

class DiscCoverAndDuration extends StatelessWidget {
  DiscCoverAndDuration({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 70),
      child: Row(
        children: [
          DiscCover(),
          SizedBox(width: 40),
          ProgressBar(),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final thisStyle = TextStyle(color: Colors.white.withOpacity(0.4));

    return Container(
      child: Column(
        children: [
          Text('00:00', style: thisStyle),
          Stack(
            children: [
              Container(
                width: 3,
                height: 230,
                color: Colors.white.withOpacity(0.1),
              ),
              Positioned(
                //Hace que el contenedor blanco comience desde abajo
                bottom: 0,
                child: Container(
                  width: 3,
                  height: 200,
                  color: Colors.white.withOpacity(0.8),
                ),
              )
            ],
          ),
          Text('00:00', style: thisStyle),
        ],
      ),
    );
  }
}

class DiscCover extends StatelessWidget {
  DiscCover({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    return Container(
      padding: EdgeInsets.all(20),
      width: 250,
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SpinPerfect(
                duration: Duration(seconds: 10),
                infinite: true,
                manualTrigger: true,
                controller: (animationController) =>
                    audioPlayerModel.controller = animationController,
                child: Image(image: AssetImage('assets/aurora.jpg'))),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Color(0xff1c1c25),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              Color(0xff484750),
              Color(0xff1e1c24),
            ],
          )),
    );
  }
}
