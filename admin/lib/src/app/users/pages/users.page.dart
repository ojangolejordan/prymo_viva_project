import 'package:admin/src/app/users/bloc/user_bloc.dart';
import 'package:admin/src/app/users/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_table/json_table.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  UserBloc? userBloc;
  @override
  void initState() {
    userBloc = context.read<UserBloc>()..add(LoadUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text("Users")),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UsersLoaded) {
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
    DataColumn(label: Text('UserName')),
    DataColumn(label: Text('Email')),
    DataColumn(label: Text('First Name')),
    DataColumn(label: Text('Last Name'))
  ];
}

List<DataRow> _createRows(List<UserModel> models) {
  return models
      .map((model) => DataRow(cells: [
            DataCell(Text(model.username)),
            DataCell(Text(model.email)),
            DataCell(Text(model.firstName)),
            DataCell(Text(model.lastName)),
          ]))
      .toList();
}
