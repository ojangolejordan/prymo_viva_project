import 'package:admin/src/app/home/bloc/video_bloc.dart';
import 'package:admin/src/app/home/models/video.models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> with AutomaticKeepAliveClientMixin {
    @override
  bool get wantKeepAlive => true;
  VideoBloc? videoBloc;

  @override
  void initState() {
    videoBloc = context.read<VideoBloc>()..add(GetVideos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title : Text("Videos")),
      body: BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        if (state is VideoLoading) {
          return Center(child: CircularProgressIndicator());
        } else if(state is VideoLoaded){
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: _createColumns(), rows: _createRows(state.videos)),
          );
        }
        return Center(child: Text(state.toString()));
      },
    )
        // body: Container(
        //     width: double.infinity,
        //     child: DataTable(columns: _createColumns(), rows: _createRows())),
        );
  }
}

List<DataColumn> _createColumns() {
  return [
    DataColumn(label: Text('Title')),
    DataColumn(label: Text('Video Url')),
    DataColumn(label: Text('Image Url'))
  ];
}

List<DataRow> _createRows(List<VideoModel> models) {
  return models.map((model)=>DataRow(cells: [
    DataCell(Text(model.title)),
    DataCell(Text(model.videoUrl)),
    DataCell(Text(model.imageUrl)),
  ])).toList();
 
}
