import 'package:flutter/material.dart';
import 'package:projet_yw/programmeD/Chest_routine.dart';
import 'package:projet_yw/programmeD/back_biceps.dart';
import 'programPage.dart';
import '../programmeD/pec.dart';
import '../programmeD/biceps.dart';
import '../programmeD/jambes.dart';
import '../programme.dart';


class ProgramListD extends StatefulWidget {
  @override
  _ProgramListDState createState() => _ProgramListDState();
}

class _ProgramListDState extends State<ProgramListD> {
  final List<ProgramPage> programs = [ProgramPage(program: back_biceps), ProgramPage(program: chest_routine)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: programs.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(programs[index].program.titre),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              ),
            ),
            secondaryBackground: Container(
              color: Color(0xff92140C),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Spacer(),
                    Icon(
                      Icons.description,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Description  ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: Card(
              child: ListTile(
                title: Text(programs[index].program.titre),
                leading: Icon(Icons.fitness_center),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => programs[index],
                    ),
                  );
                },
              ),
            ),
            direction: DismissDirection.horizontal,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProgramDescription(programs[index].program),

                  ),
                );
                return false;
              }
            },
          );
        },
      ),
    );
  }
}

class ProgramDescription extends StatelessWidget {
  final Programme programme;

  ProgramDescription(this.programme);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(programme.titre),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
           /* Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Images",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),*/
            SizedBox(height: 8.0),
            SizedBox(
              height: 400.0,
              child: ListView.builder(
                itemCount: programme.images?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(programme.images![index]),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Description",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(programme.description ?? ""),
            ),
          ],
        ),
      ),
    );
  }
}
