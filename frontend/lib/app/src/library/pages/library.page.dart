import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prymo_mobile_app/app/src/library/bloc/library_bloc.dart';
import 'package:prymo_mobile_app/app/src/library/models/library.models.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  LibraryBloc? libraryBloc;

  @override
  void initState() {
    libraryBloc = context.read<LibraryBloc>()..add(LoadLibrary());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text("Visuals"),
        )),
        body: BlocBuilder<LibraryBloc, LibraryState>(
          builder: (context, state) {
            if (state is LibraryLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LibraryLoadingError) {
              return Center(child: Text(state.message));
            } else if (state is LibraryLoaded) {
              return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.models.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.8),
                  itemBuilder: (context, index) =>
                      VisualsView(model: state.models[index]));
            }
            return Container(child: Center(child: Text(state.toString())));
          },
        ));
  }
}

class VisualsView extends StatelessWidget {
  final VisualModel model;
  const VisualsView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Hero(
            tag: model.imageUrl,
            child: GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return FullImagePage(model.imageUrl);
              })),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(model.imageUrl,
                    width: double.infinity, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FullImagePage extends StatelessWidget {
  final String imageLink;

  const FullImagePage(this.imageLink);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context))),
        body: Center(
          child: Hero(
            tag: imageLink,
            child: Image.network(imageLink),
          ),
        ));
  }
}
