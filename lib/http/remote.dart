import 'dart:convert';
import 'package:business_wallet/http/base.dart';
import 'package:http/http.dart' as http;
import '../model/event.dart';
import '../model/user.dart';
import '../util/pair.dart';

class Remote extends BaseHttp {
  static late User user;

  Future<Result> getMe() async {
    String path = "/api/user/me";
    var response = await http.get(
      setUri(path),
      headers: addHeaders(true),
    );

    Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode != 200) {
      return Result("", Error(data["error"]));
    }

    user = User.fromJson(data);

    return Result(user, null);
  }

  Future<Result> createEvent(Event e) async {
    String path = "/api/event";
    var response = await http.post(
      setUri(path),
      headers: addHeaders(true),
      body: json.encode(e.toCreateRequest()),
    );

    Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode != 200) {
      return Result("", Error(data["error"]));
    }

    Event event = Event.fromJson(data);

    return Result(event, null);
  }

  Future<Result<List<Event>>> pastEvents() async {
    var url = setUri("/api/event/past");
    final response = await http.get(url, headers: addHeaders(true));

    var data = json.decode(response.body);

    if (response.statusCode != 200) {
      return Result([], Error(data["error"]));
    }

    List<Event> pastEvents =
        List<Event>.from(data.map((d) => Event.fromJson(d)).toList());

    return Result(pastEvents, null);
  }

  Future<Result<List<Event>>> activeEvents() async {
    var url = setUri("/api/event/active");
    final response = await http.get(url, headers: addHeaders(true));

    var data = json.decode(response.body);

    if (response.statusCode != 200) {
      return Result([], Error(data["error"]));
    }

    List<Event> activeEvents =
        List<Event>.from(data.map((d) => Event.fromJson(d)).toList());

    return Result(activeEvents, null);
  }

  Future<Result<List<Event>>> currentEvents() async {
    var url = setUri("/api/event/current");
    final response = await http.get(url, headers: addHeaders(true));

    var data = json.decode(response.body);

    if (response.statusCode != 200) {
      return Result([], Error(data["error"]));
    }

    List<Event> currentEvents =
        List<Event>.from(data.map((d) => Event.fromJson(d)).toList());

    return Result(currentEvents, null);
  }

  Future<Result> getEvent(int id) async {
    String path = "/api/event/$id";
    var response = await http.get(setUri(path), headers: addHeaders(true));

    var data = json.decode(response.body);

    if (response.statusCode != 200) {
      return Result("", Error(data["error"]));
    }

    Event e = Event.fromJson(json.decode(response.body));

    return Result(e, null);
  }

  Future<Result<bool>> attendEvent(int id) async {
    String path = "/api/event/$id/attend";
    var response = await http.post(setUri(path), headers: addHeaders(true));
    if (response.statusCode == 200) {
      return Result(true, null);
    } else {
      var data = json.decode(response.body);
      return Result(false, data["error"]);
    }
  }

  Future<Result<bool>> leaveEvent(int id) async {
    String path = "/api/event/$id/leave";
    var response = await http.post(setUri(path), headers: addHeaders(true));
    if (response.statusCode == 200) {
      return Result(true, null);
    } else {
      var data = json.decode(response.body);
      return Result(false, data["error"]);
    }
  }

  Future<Result<bool>> deleteEvent(int id) async {
    String path = "/api/event/$id/delete";
    var response = await http.delete(setUri(path), headers: addHeaders(true));
    if (response.statusCode == 200) {
      return Result(true, null);
    } else {
      var data = json.decode(response.body);
      return Result(false, data["error"]);
    }
  }

  Future<Result<List<Event>>> eventTogether(int id) async {
    String path = "/api/event/$id/together";
    var response = await http.get(setUri(path), headers: addHeaders(true));

    var data = json.decode(response.body);

    if (response.statusCode != 200) {
      return Result([], Error(data["error"]));
    }

    List<Event> eventTogether =
        List<Event>.from(data.map((d) => Event.fromJson(d)).toList());

    return Result(eventTogether, null);
  }

  Future<Result> getContact(int id) async {
    String path = "/api/user/contact/$id";
    var response = await http.get(setUri(path), headers: addHeaders(true));

    Map<String, dynamic> data = json.decode(response.body);
    data["ID"] = id;

    if (response.statusCode != 200) {
      return Result("", Error(data["error"]));
    }
    User u = User.fromJson(data);
    return Result(u, null);
  }

  Future<Result<bool>> addContact(int id) async {
    String path = "/api/user/contact/$id";
    var response = await http.post(setUri(path), headers: addHeaders(true));
    if (response.statusCode == 200) {
      return Result(true, null);
    } else {
      var data = json.decode(response.body);
      return Result(false, data["error"]);
    }
  }

  Future<Result<bool>> deleteContact(int id) async {
    String path = "/api/user/contact/$id";
    var response = await http.delete(setUri(path), headers: addHeaders(true));
    if (response.statusCode == 200) {
      return Result(true, null);
    } else {
      var data = json.decode(response.body);
      return Result(false, data["error"]);
    }
  }
}
