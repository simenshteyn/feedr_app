import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();
  group("GET: ", () {
    test("GET /vote returns 200 OK", () async {
      final response = await harness.agent.get('/vote');
      expect(response.statusCode, 200);
    });
    test("POST /vote/[:id] return 200 OK after request", () async {
      final postResponse = await harness.agent.post('vote', body: {
        "askMessage": "Please, leave your feedback",
        "client": {"mobilePhone": "79232440000", "fullName": "Vasily"},
        "servant": {"name": "MasterName"},
        "feedback": {"message": "Everything is ok", "stars": 5},
      });
      expectResponse(postResponse, 200);
    });
  });
}
