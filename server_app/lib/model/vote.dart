import 'package:aqueduct/aqueduct.dart';
import 'package:server_app/model/client.dart';
import 'package:server_app/model/feedback.dart';
import 'package:server_app/model/servant.dart';

class Vote extends ManagedObject<_Vote> implements _Vote {}

class _Vote {
  @primaryKey
  int id;

  DateTime createdTime;

  @Column(nullable: true)
  DateTime voteTime;

  String askMessage;

  @Relate(#votes)
  Client client;

  @Relate(#votes)
  Servant servant;

  @Relate(#vote)
  Feedback feedback;

  @Column(nullable: true)
  String linkId;
}
