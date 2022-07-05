import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prymo_mobile_app/app/src/comments/bloc/comment_bloc.dart';
import 'package:prymo_mobile_app/app/src/home/models/home.models.dart';
import 'package:video_player/video_player.dart';

import '../../comments/widgets/comment.view.dart';

class VideoPage extends StatefulWidget {
  final VideoModel video;
  const VideoPage({Key? key, required this.video}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController? videoPlayerController;
  List<Comment>? comments;
  ChewieController? chewieController;
  Future<void>? videoPlayerFuture;
  @override
  void initState() {
    super.initState();
    setComments();
    videoPlayerController =
        VideoPlayerController.network(widget.video.videoUrl);
    videoPlayerFuture = videoPlayerController!.initialize();

    chewieController = ChewieController(
      materialProgressColors: ChewieProgressColors(handleColor: Colors.yellow),
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: true,
    );
  }

  void setComments() {
    setState(() {
      comments = widget.video.comments;
    });
  }

  void updateComment(Comment comment) {
    setState(() {
      comments!.add(comment);
    });
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        videoPlayerController!.pause();
        chewieController!.pause();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.video.title)),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(aspectRatio: 16 / 9),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text("Discussions",
                                style: TextStyle(fontSize: 15)),
                          ),
                          BlocListener<CommentBloc, CommentState>(
                            listener: (context, state) {
                              if (state is CommentLoaded) {
                                updateComment(state.comment);
                              } else if (state is CommentLoadingError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Error Adding Comment")));
                              }
                            },
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.video.comments.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return CommentsView(
                                    content: comments![index].content,
                                    username: comments![index].name,
                                  );
                                }),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  ColoredBox(
                    color: Colors.black,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: FutureBuilder(
                        future: videoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Chewie(controller: chewieController!);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ),
                  Spacer(),
                  CommentsAddingView(widget.video)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentsView extends StatelessWidget {
  final String username;
  final String content;

  const CommentsView({required this.username, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          child: Center(
            child: Text(
              username[0],
              style: TextStyle(
                color: Colors.yellow,
              ),
            ),
          ),
        ),
        title: Text(username, style: TextStyle(fontSize: 12)),
        subtitle: Text(
          content,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
