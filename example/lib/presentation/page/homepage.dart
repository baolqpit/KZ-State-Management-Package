import 'package:dio/dio.dart';
import 'package:example/presentation/model/user.dart';
import 'package:flutter/material.dart';
import 'package:kz_state_management/kz_state_management.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Dio _dio = Dio();
  final KzStateManager<bool> buttonStateManagement =
      KzStateManager<bool>(false);
  final KzStateManager<List<User>> listUsersStateManagement =
      KzStateManager<List<User>>([]);

  @override
  void dispose() {
    buttonStateManagement.dispose();
    listUsersStateManagement.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    Response response =
        await _dio.get("https://jsonplaceholder.typicode.com/posts");

    final List<User> listUsers =
        response.data.map<User>((json) => User.fromJson(json)).toList();

    listUsersStateManagement.update(listUsers);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<bool>(
          stream: buttonStateManagement.stateStream,
          builder: (context, snapshot) {
            bool isActive = snapshot.data ?? false;

            return ElevatedButton(
              onPressed: () async {
                buttonStateManagement.update(!buttonStateManagement.state);
                if (isActive) {
                  listUsersStateManagement.update([]);
                } else {
                  await fetchData();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: isActive ? Colors.green : Colors.red),
              child: Text(
                isActive ? "Active" : "Inactive",
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
          initialData: buttonStateManagement.state,
        ),
        Expanded(
            child: StreamBuilder(
          stream: listUsersStateManagement.stateStream,
          builder: (context, snapshot) {
            final List<User> listUsers = snapshot.data ?? [];

            if (listUsers.isEmpty) {
              return const Center(
                child: Text('No data found!'),
              );
            }
            return ListView.builder(
                itemCount: listUsers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(listUsers[index].id.toString()),
                    title: Text(listUsers[index].title),
                    subtitle: Text(listUsers[index].body),
                  );
                });
          },
          initialData: listUsersStateManagement.state,
        ))
      ],
    );
  }
}
