import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'vote_service.dart';

@Component(
  selector: 'vote',
  styleUrls: ['vote_component.css'],
  templateUrl: 'vote_component.html',
  directives: [
    MaterialFabComponent,
    MaterialIconComponent,
    NgIf,
  ],
  providers: [ClassProvider(VoteService)],
)
class VoteComponent implements OnInit {
  final VoteService voteService;
  int stars;
  VoteComponent(this.voteService);

  @override
  Future<Null> ngOnInit() async {
    stars = await voteService.getRating();
  }

  void vote(int rating) {
    stars = rating;
  }
}
