import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:flutter_share/flutter_share.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: StoryPageView(),
    );
  }
}

final Uri _url = Uri.parse('https://flutter.dev');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

class StoryPageView extends StatefulWidget {
  const StoryPageView({super.key});

  @override
  State<StoryPageView> createState() => _StoryPageViewState();
}

Future<void> share() async {
  await FlutterShare.share(
      title: 'Example share',
      text: 'Example share text',
      linkUrl: 'https://flutter.dev/',
      chooserTitle: 'Example Chooser Title');
}

class _StoryPageViewState extends State<StoryPageView> {
  final _storyController = StoryController();
  final controller = StoryController();

  final List<StoryItem> storyItems = [
    StoryItem.pageImage(
        url: "https://picsum.photos/600", controller: StoryController()),
    StoryItem.pageImage(
        url: "https://picsum.photos/700", controller: StoryController()),
    StoryItem.pageImage(
        url: "https://picsum.photos/800", controller: StoryController()),
    StoryItem.pageImage(
        url: "https://picsum.photos/500", controller: StoryController()),
  ];

  @override
  void initState() {
    // TODO: implement initState
    int ran = Random().nextInt(100) * 10;
    int ran2 = Random().nextInt(100) * 10;
    Future.delayed(const Duration(milliseconds: 500));
    storyItems.removeAt(0);

    storyItems.add(
      StoryItem.pageImage(
          url: "https://random.imagecdn.app/$ran/$ran2",
          controller: _storyController),
    );
    super.initState();
  }

  void tryinh() {
    int ran = Random().nextInt(100) + 50 * 10;
    int ran2 = Random().nextInt(100) + 50 * 10;
    Future.delayed(const Duration(milliseconds: 500));
    storyItems.add(
      StoryItem.pageImage(
          url: "https://random.imagecdn.app/$ran/$ran2",
          controller: _storyController),
    );
    storyItems.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    final List<StoryItem> storyItemsnew = [
      storyItems[0],
    ];
    return Material(
      child: Stack(
        children: [
          SizedBox(
            child: StoryView(
              storyItems: storyItems,
              controller: controller,
              repeat: true,
              onComplete: () {
                // int ran = Random().nextInt(100) * 10;
                // int ran2 = Random().nextInt(100) * 10;
                // Future.delayed(const Duration(milliseconds: 500));
                // storyItems.removeAt(0);

                // storyItems.add(
                //   StoryItem.pageImage(
                //       url: "https://random.imagecdn.app/$ran/$ran2",
                //       controller: _storyController),
                // );
                setState(() {
                  tryinh();
                });
              },
            ),
          ),
          Positioned(
            right: 65,
            top: 58,
            child: InkWell(
              onTap: share,
              child: Transform.rotate(
                angle: -0.5,
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
              right: 30,
              top: 60,
              child: InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                ),
              )),
          Positioned(
            bottom: 50,
            left: 140,
            child: InkWell(
              onTap: _launchUrl,
              child: Column(
                children: [
                  Transform.rotate(
                    angle: 1.55,
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Material(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    elevation: 10,
                    child: Container(
                      height: 30,
                      //width: 90,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade400,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.link,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              'Read More',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
