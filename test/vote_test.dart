import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();
  group("GET: ", () {
    test("GET /vote returns 200 OK", () async {
      final response = await harness.agent.get('/vote');
      expect(response.statusCode, 200);
    });
  });
}
