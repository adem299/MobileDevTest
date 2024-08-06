import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobiledev_test_app/model/user_model.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = [];
  int _currentPage = 1;
  bool _hasMoreData = true;
  bool _isLoading = false;
  String _selectedUserName = "No user selected";

  List<UserModel> get users => _users;
  bool get hasMoreData => _hasMoreData;
  bool get isLoading => _isLoading;
  String get selectedUserName => _selectedUserName;

  Future<void> fetchUsers({int page = 1, int perPage = 10}) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    final url = 'https://reqres.in/api/users?page=$page&per_page=$perPage';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<UserModel> fetchedUsers = (data['data'] as List).map((userJson) => UserModel.fromJson(userJson)).toList();

      if (fetchedUsers.length < perPage) {
        _hasMoreData = false;
      }

      if (page == 1) {
        _users = fetchedUsers;
      } else {
        _users.addAll(fetchedUsers);
      }

      _currentPage = page;
    } else {
      throw Exception('Failed to load users');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshUsers() async {
    _hasMoreData = true;
    await fetchUsers(page: 1);
  }

  Future<void> loadMoreUsers() async {
    if (_hasMoreData) {
      await fetchUsers(page: _currentPage + 1);
    }
  }

  set selectedUserName(String name) {
    _selectedUserName = name;
    notifyListeners();
  }
}
