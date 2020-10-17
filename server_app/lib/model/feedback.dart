import 'package:aqueduct/aqueduct.dart';
import 'package:feedr_app/model/vote.dart';

class Feedback extends ManagedObject<_Feedback> implements _Feedback {}

class _Feedback {
  @primaryKey
  int id;

  Vote vote;

  @Column(nullable: true)
  String message;

  @Column(nullable: true)
  int stars;
}
