import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../add_question/model/question_model.dart';

import '../../../../core/init/localStorage/storage.dart';
import '../../../../product/component/firebase/storage_functions.dart';
import '../../../login/model/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.context) : super(ProfileInitial()) {
    init();
  }

  BuildContext context;
  UserModel? userModel;
  List<QuestionModel>? myQuestions;

  bool isLoading = false;

  void changeLoading() {
    isLoading = !isLoading;
    emit(ProfileLoading());
  }

  Future<void> init() async {
    changeLoading();
    await getUserDatasFromFirebase();
    await getUserQuestionsFromFirebase();
    changeLoading();
  }

  Future<void> getUserDatasFromFirebase() async {
    userModel = await FirebaseStorageFunctions().getUserDatas(userId: context.read<LocaleManager>().token);
  }

  Future<void> getUserQuestionsFromFirebase() async {
    myQuestions = await FirebaseStorageFunctions().getUserOwnQuestions(userId: context.read<LocaleManager>().token);
  }

  
}
