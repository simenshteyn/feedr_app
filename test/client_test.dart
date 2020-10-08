import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();
  group("GET: ", () {
    test("GET /client returns 200 OK", () async {
      final response = await harness.agent.get('/client');
      expect(response.statusCode, 200);
    });
    test("POST, GET /client/[:id] return 200 OK after request", () async {
      final postResponse = await harness.agent.post('client', body: {
        "mobilePhone": "79231234567",
        "fullName": "Sergey",
      });
      expectResponse(postResponse, 200);
      final clientId = postResponse.body.as<Map>()["id"];
      final getResponse = await harness.agent.get("/client/$clientId");
      expectResponse(getResponse, 200, body: {
        "id": clientId,
        "mobilePhone": "79231234567",
        "fullName": "Sergey",
      });
    });
  });
}
