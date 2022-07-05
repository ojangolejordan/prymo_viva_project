import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prymo_mobile_app/app/meta/constants.dart';
import 'package:prymo_mobile_app/app/src/home/models/home.models.dart';

import '../bloc/comment_bloc.dart';

class CommentsAddingView extends StatelessWidget {
  final VideoModel model;

  CommentsAddingView(this.model);

  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var commentBloc = context.read<CommentBloc>();
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoaded) commentController.clear();
        return Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
          child: Container(
              height: 30,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Container(
                          height: 30,
                          color: Colors.grey[900],
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0, left: 5),
                              child: TextField(
                                controller: commentController,
                                decoration: InputDecoration(
                                  hintText: "Type Here",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(width: 5),
                  Expanded(child: BlocBuilder<CommentBloc, CommentState>(
                    builder: (context, state) {
                      return MaterialButton(
                        color: Colors.yellow,
                        onPressed: state is CommentLoading
                            ? null
                            : () async {
                                var username = await HiveRepository.getUserName();
                                commentBloc.add(AddComment(Comment(
                                    createdOn: DateTime.now(),
                                    content: commentController.text,
                                    name: username,
                                    video: model.id)));
                              },
                        child: Center(
                          child: Text(
                            state is CommentLoading ? "Loading" : "Discuss",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ))
                ],
              )),
        );
      },
    );
  }
}
