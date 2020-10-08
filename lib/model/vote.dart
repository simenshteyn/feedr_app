import 'package:aqueduct/aqueduct.dart';

class Vote extends ManagedObject<_Vote> implements _Vote {}

class _Vote {
  @primaryKey
  int id;

  @Column()
  DateTime createdTime;

  @Column()
  String askMessage;

  @Column()
  int clientPhone;

  @Column()
  int servantId;

  @Column()
  String servantName;

  @Column()
  String linkId;
}
