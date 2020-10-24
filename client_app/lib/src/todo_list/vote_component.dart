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
    NgClass,
    NgFor,
  ],
  providers: [ClassProvider(VoteService)],
)
class VoteComponent implements OnInit {
  final VoteService voteService;
  int stars;
  String comment;
  List<Remark> remarks;
  VoteComponent(this.voteService);

  bool get isNotFiveStars => stars < 5 ? true : false;

  @override
  Future<Null> ngOnInit() async {
    stars = await voteService.getRating();
    remarks = await voteService.getRemarks();
  }

  void vote(int rating) {
    stars = rating;
  }

  void checkRemark(int index) {
    if (remarks[index].status == false) {
      remarks[index].status = true;
    } else {
      remarks[index].status = false;
    }
  }
}

class Remark {
  String description;
  bool status = false;
  Remark(this.description);
}
