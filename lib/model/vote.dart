import 'package:aqueduct/aqueduct.dart';
import 'package:feedr_app/model/client.dart';
import 'package:feedr_app/model/servant.dart';

class Vote extends ManagedObject<_Vote> implements _Vote {}

class _Vote {
  @primaryKey
  int id;

  @Column()
  DateTime createdTime;

  @Column()
  DateTime voteTime;

  @Column()
  String askMessage;

  @Relate(#votes)
  Client client;

  @Relate(#votes)
  Servant servant;

  @Column()
  String linkId;
}
