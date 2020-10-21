import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:Flutter_Infinite_List/bloc/bloc.dart';
import 'package:Flutter_Infinite_List/post.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient}) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    yield null;
  }
}
