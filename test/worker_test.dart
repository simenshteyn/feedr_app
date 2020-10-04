import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  group("GET: ", () {
    test("GET /worker retutrn 200 OK", () async {
      final response = await harness.agent.get('/worker');
      expect(response.statusCode, 405);
    });
  });
}
