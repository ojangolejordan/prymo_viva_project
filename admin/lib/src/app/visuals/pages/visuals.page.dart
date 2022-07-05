import 'package:admin/src/app/visuals/bloc/visuals_bloc.dart';
import 'package:admin/src/app/visuals/models/visuals.models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisualsPage extends StatefulWidget {
  const VisualsPage({Key? key}) : super(key: key);

  @override
  State<VisualsPage> createState() => _VisualsPageState();
}

class _VisualsPageState extends State<VisualsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  VisualsBloc? visualsBloc;

  @override
  void initState() {
    visualsBloc = context.read<VisualsBloc>()..add(LoadVisuals());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title : Text("Visuals")),
      body: BlocBuilder<VisualsBloc, VisualsState>(
      builder: (context, state) {
        if (state is VisualsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if(state is VisualsLoaded){
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: _createColumns(), rows: _createRows(state.models)),
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
    DataColumn(label: Text('Image Url'))
  ];
}

List<DataRow> _createRows(List<VisualModel> models) {
  return models.map((model)=>DataRow(cells: [
    DataCell(Text(model.imageUrl)),
  ])).toList();
 
}
