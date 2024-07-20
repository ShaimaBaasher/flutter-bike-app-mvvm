import 'dart:convert';

import 'package:bike_app/core/network/end_points.dart';
import 'package:bike_app/src/home/data/models/cat_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/api_helper.dart';
import '../../../../core/network/errors/exceptions.dart';
import '../../../../core/network/errors/failure.dart';
import '../../../../core/utils/typedaf.dart';
import '../models/product_model.dart';


class HomeRepo {
  HomeRepo(this._repository);
  final APISRepo _repository;

  ResultFuture<dynamic> getNewRequestList() async {
    try {
      var response = await _repository.getRequest(
        apiUrl: GET_PRODUCTS,
        headers: {},
      );
      return Right(ProductModelList.fromJsonList(json.decode(response)));
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  ResultFuture<dynamic> getCatList() async {
    try {
      var response = await _repository.getRequest(
        apiUrl: GET_CAT,
        headers: {},
      );
      return Right(CatModelList.fromJsonList(json.decode(response)));
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }


}
