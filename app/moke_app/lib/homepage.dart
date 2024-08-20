import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moke_app/network/bloc/auth_bloc.dart';
import 'package:moke_app/network/bloc/auth_event.dart';
import 'package:moke_app/network/bloc/auth_state.dart';
import 'package:moke_app/network/bloc/data_bloc.dart';
import 'package:moke_app/network/bloc/data_event.dart';
import 'package:moke_app/network/bloc/data_state.dart';

class Auth extends StatefulWidget {
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<Auth> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Map<String, dynamic> initialData = {};
  Map<String, dynamic> ratioData = {};
  Map<String, dynamic> dathealthData = {};
  Map<String, dynamic> conclusionData = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    LoginRequested(
                      _usernameController.text,
                      _passwordController.text,
                    ),
                  );
            },
            child: Text('Login'),
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthenticationFailed) {
                return Text('Login failed: ${state.error}');
              }
              if (state is Authenticated) {
                return Text('Login successful');
              }
              return Container();
            },
          ),
          ElevatedButton(
            onPressed: () {
              context.read<DataBloc>().add(FetchInitialData());
              context.read<DataBloc>().add(FetchRatioData());
              context.read<DataBloc>().add(FetchHealthData());
              context.read<DataBloc>().add(FetchConclusionData());
            },
            child: Text('Fetch Data'),
          ),
          BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              if (state is DataInitial) {
                return Text('Please press the button to fetch data.');
              } else if (state is DataLoading) {
                return CircularProgressIndicator();
              } else if (state is DataFetched) {
                // Handle the DataFetched state

                return Column(
                  children: [
                    Text('Initial Data: ${state.initialData.toString()}'),
                    Text('Ratio Data: ${state.ratioData.toString()}'),
                    Text('Health Data: ${state.healthData.toString()}'),
                    Text('Conclusion Data: ${state.conclusionData.toString()}'),
                  ],
                );
              } else if (state is DataError) {
                return Text('Error: ${state.message}');
              } else if (state is DataFetchFailed) {
                return Text('Failed: ${state.error}');
              } else {
                return Text('Unexpected state');
              }
            },
          )
        ],
      ),
    );
  }
}
