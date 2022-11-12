class Covid {
  final int year;
  final int weeknum;
  final int new_case;
  final int total_case;
  final int new_case_excludeabroad;
  final int total_case_excludeabroad;
  final int new_recovered;
  final int total_recovered;
  final int new_death;
  final int total_death;
  final int case_foreign;
  final int case_prison;
  final int case_walkin;
  final int case_new_prev;
  final int case_new_diff;
  final int death_new_prev;
  final int death_new_diff;
  final String update_date;

  Covid({
    required this.year,
    required this.weeknum,
    required this.new_case,
    required this.total_case,
    required this.new_case_excludeabroad,
    required this.total_case_excludeabroad,
    required this.new_recovered,
    required this.total_recovered,
    required this.new_death,
    required this.total_death,
    required this.case_foreign,
    required this.case_prison,
    required this.case_walkin,
    required this.case_new_prev,
    required this.case_new_diff,
    required this.death_new_prev,
    required this.death_new_diff,
    required this.update_date,
  });

  factory Covid.fromJson(Map<String, dynamic> json) {
    return Covid(
      year: json["year"],
      weeknum: json["weeknum"],
      new_case: json["new_case"],
      total_case: json["total_case"],
      new_case_excludeabroad: json["new_case_excludeabroad"],
      total_case_excludeabroad: json["total_case_excludeabroad"],
      new_recovered: json["new_recovered"],
      total_recovered: json["total_recovered"],
      new_death: json["new_death"],
      total_death: json["total_death"],
      case_foreign: json["case_foreign"],
      case_prison: json["case_prison"],
      case_walkin: json["case_walkin"],
      case_new_prev: json["case_new_prev"],
      case_new_diff: json["case_new_diff"],
      death_new_prev: json["death_new_prev"],
      death_new_diff: json["death_new_diff"],
      update_date: json["update_date"],
    );
  }

  Covid.fromJson2(Map<String, dynamic> json)
      : year = json["year"],
        weeknum = json["weeknum"],
        new_case = json["new_case"],
        total_case = json["total_case"],
        new_case_excludeabroad = json["new_case_excludeabroad"],
        total_case_excludeabroad = json["total_case_excludeabroad"],
        new_recovered = json["new_recovered"],
        total_recovered = json["total_recovered"],
        new_death = json["new_death"],
        total_death = json["total_death"],
        case_foreign = json["case_foreign"],
        case_prison = json["case_prison"],
        case_walkin = json["case_walkin"],
        case_new_prev = json["case_new_prev"],
        case_new_diff = json["case_new_diff"],
        death_new_prev = json["death_new_prev"],
        death_new_diff = json["death_new_diff"],
        update_date = json["update_date"];
}
