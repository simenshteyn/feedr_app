import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();
  group("GET: ", () {
    test("GET /client returns 200 OK", () async {
      final response = await harness.agent.get('/client');
      expect(response.statusCode, 200);
    });
  });
}
