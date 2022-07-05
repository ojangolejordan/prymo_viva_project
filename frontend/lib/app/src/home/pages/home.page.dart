import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prymo_mobile_app/app/src/home/bloc/home_bloc.dart';
import 'package:prymo_mobile_app/app/src/home/models/home.models.dart';
import 'package:prymo_mobile_app/app/src/video/pages/video.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  HomeBloc? homeBloc;

  @override
  void initState() {
    homeBloc = context.read<HomeBloc>()..add(GetHomeVideos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text("Prymo"),
        )),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            print(state.toString());
            if (state is HomeLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeLoadingError) {
              return Center(child: Text(state.message));
            } else if (state is HomeLoaded) {
              var videos = state.videos;
              return ListView.builder(
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return HomeVideoView(model: state.videos[index]);
                  });
            }
            return Center(
              child: Text(state.toString()),
            );
          },
        ));
  }
}

class HomeVideoView extends StatelessWidget {
  final VideoModel model;
  const HomeVideoView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VideoPage(video: model))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(model.imageUrl, fit: BoxFit.cover)),
            ),
            SizedBox(height: 10),
            Text(model.title),
            SizedBox(height: 2),
            Text("Prymo", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
