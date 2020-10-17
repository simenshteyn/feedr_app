import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();
  test("GET /link/[:link] returns 200 OK", () async {
    final postResponse = await harness.agent.post('vote', body: {
        "askMessage": "Please, leave your feedback",
        "client": {"mobilePhone": "79232440002", "fullName": "Vasily"},
        "servant": {"name": "MasterName"},
        "feedback": {"message": "Everything is ok", "stars": 5},
      });
    expectResponse(postResponse, 200);
    
    final voteLinkId = postResponse.body.as<Map>()["linkId"];
    final getResponse = await harness.agent.get("/link/$voteLinkId");
      expect(
          getResponse,
          hasBody(partial({
            "createdTime": isTimestamp,
            "voteTime": isNull,
            "askMessage": "Please, leave your feedback",
            "linkId": isString,
            "client": isNotNull,
            "servant": isNotNull,
            "feedback": isNotNull,
          })));

  });
}

