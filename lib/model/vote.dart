import 'package:aqueduct/aqueduct.dart';
import 'package:feedr_app/model/client.dart';
import 'package:feedr_app/model/feedback.dart';
import 'package:feedr_app/model/servant.dart';

class Vote extends ManagedObject<_Vote> implements _Vote {}

class _Vote {
  @primaryKey
  int id;

  DateTime createdTime;

  DateTime voteTime;

  String askMessage;

  @Relate(#votes)
  Client client;

  @Relate(#votes)
  Servant servant;

  Feedback feedback;

  String linkId;
}
