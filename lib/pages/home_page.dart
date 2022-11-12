import 'package:covid/models/DateUtil.dart';
import 'package:covid/models/covid_items.dart';
import 'package:covid/services/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateUtil _dateUtil = DateUtil();
  late Future<Covid> _futureCovid;
  // func add comma to number
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  @override
  void initState() {
    super.initState();
    _futureCovid = _fetchData();
  }

  Future<Covid> _fetchData() async {
    return await Api().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ไล่สีพื้นหลัง
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [Colors.teal, Colors.indigo],
        //     // colors: [Color(0xFFA16AE8), Color(0xFF583c7d)],
        //   ),
        // ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: FutureBuilder<Covid>(
          future: _futureCovid,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              final dateTime = DateTime.parse(data!.update_date);
              return ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: double.infinity,
                  minWidth: double.infinity,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildHeader(data!, dateTime),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 10,
                      ),
                      _buildShowStatPanel(data!),
                      const SizedBox(
                        width: double.infinity,
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ผิดพลาด: ${snapshot.error}'),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _futureCovid = _fetchData();
                        });
                      },
                      child: const Text('ลองใหม่'),
                    ),
                  ],
                ),
              );
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _buildHeader(Covid data, DateTime dateTime) {
    return Center(
      child: Column(
        children: [
          Text(
            'สถานการณ์ COVID-19',
            style: GoogleFonts.kanit(
              color: Colors.white,
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'ในประเทศไทย ประจำสัปดาห์',
            style: GoogleFonts.kanit(
              color: Colors.white,
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Card(
            elevation: 50,
            shadowColor: Colors.black,
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'อัปเดตเมื่อวันที่ ${dateTime.day} ${_dateUtil.getThaiMonth(dateTime.month)} ${dateTime.year + 543}',
                style: GoogleFonts.kanit(
                  color: Colors.black45,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowStatPanel(Covid data) {
    return Card(
      color: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: Colors.black45,
      margin: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            // row 1
            SizedBox(
              height: 180.0,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: const Color(0xFF99CB58),
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ผู้ป่วยรายใหม่",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "+${data.new_case.toString().replaceAllMapped(reg, mathFunc)}",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Container(
                      color: const Color(0xFF84BA3E),
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ผู้ป่วยสะสม",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${data.total_case.toString().replaceAllMapped(reg, mathFunc)}",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 5.0,
            ),

            // row 2
            SizedBox(
              height: 130.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: const Color(0xFFDD5A6A),
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ผู้ป่วยรักษาหายรายใหม่",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data.new_recovered != 0
                                    ? "+${data.new_recovered.toString().replaceAllMapped(reg, mathFunc)}"
                                    : "-",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Container(
                      color: const Color(0xFFDF776C),
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ผู้ป่วยรักษาหายสะสม",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${data.total_recovered.toString().replaceAllMapped(reg, mathFunc)}",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 5.0,
            ),

            // row 3
            SizedBox(
              height: 130.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: const Color(0xFFA2C6EA),
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ผู้ป่วยที่มาจากต่างประเทศ",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data.case_foreign != 0
                                    ? "+${data.case_foreign.toString().replaceAllMapped(reg, mathFunc)}"
                                    : "-",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Container(
                      color: const Color(0xFF9B99CB),
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "ผู้ป่วยที่เข้ามารับการตรวจ",
                                    style: GoogleFonts.kanit(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Text(
                                    "ณ จุดบริการ",
                                    style: GoogleFonts.kanit(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${data.case_walkin.toString().replaceAllMapped(reg, mathFunc)}",
                              style: GoogleFonts.kanit(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Container(
                      color: const Color(0xFF7F7F7F),
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "เสียชีวิตเพิ่ม",
                              style: GoogleFonts.kanit(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              data.new_death != 0
                                  ? "${data.new_death.toString().replaceAllMapped(reg, mathFunc)}"
                                  : "-",
                              style: GoogleFonts.kanit(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 150.0,
                              child: Divider(
                                thickness: 1.0,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "เสียชีวิตสะสม",
                                  style: GoogleFonts.kanit(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "${data.total_death.toString().replaceAllMapped(reg, mathFunc)}",
                                  style: GoogleFonts.kanit(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
