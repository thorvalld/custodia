import 'package:custodia_parents/components/exports.dart';
import 'package:custodia_parents/models/task.dart';
import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> tabs = ["all", "idle", "in review", "completed"];

Task task = new Task(
  taskTitle: "Clean up your room",
  taskDesc: "You need to clean up your room and get your toys out of the way",
  createdAt: "2 days ago",
  dueDate: "4th April, 2021",
  taskPoints: "67",
  taskStatus: TaskStatus.IDLE,
);

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          //margin: EdgeInsets.only(top: 14, left: 14, right: 14),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Head(),
              Container(
                margin: EdgeInsets.only(top: 14, left: 14, right: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedTab = 0;
                        });
                      },
                      child: StatusTab(
                        text: tabs[0],
                        icon: CupertinoIcons.layers_alt_fill,
                        isSelected: selectedTab == 0 ? true : false,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedTab = 1;
                        });
                      },
                      child: StatusTab(
                        text: tabs[1],
                        icon: CupertinoIcons.pause_circle_fill,
                        isSelected: selectedTab == 1 ? true : false,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedTab = 2;
                        });
                      },
                      child: StatusTab(
                        text: tabs[2],
                        icon: CupertinoIcons.question_diamond_fill,
                        isSelected: selectedTab == 2 ? true : false,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedTab = 3;
                        });
                      },
                      child: StatusTab(
                        text: tabs[3],
                        icon: CupertinoIcons.checkmark_seal_fill,
                        isSelected: selectedTab == 3 ? true : false,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 32,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              UIColors.primary_a,
                              Colors.greenAccent,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.2),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.add,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'add',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: "Netflix",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white,
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
              SizedBox(
                height: 22,
              ),
              Visibility(
                visible: selectedTab == 0 || selectedTab == 1 ? true : false,
                //replacement: _emptyListState(),
                child: Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 14, right: 14),
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    reverse: false,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskCard(
                        mTask: task,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StatusTab extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  //final int active;
  //final int idx;

  const StatusTab({
    this.text,
    this.icon,
    this.isSelected,
  });
  @override
  _StatusTabState createState() => _StatusTabState();
}

class _StatusTabState extends State<StatusTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Visibility(
                  visible: widget.isSelected ? true : false,
                  child: Row(
                    children: [
                      Icon(
                        widget.icon,
                        size: 14,
                        color: widget.isSelected
                            ? UIColors.primary_a
                            : Colors.transparent,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  )),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: widget.isSelected ? 16 : 14,
                  color: widget.isSelected ? UIColors.primary_a : Colors.grey,
                  fontWeight:
                      widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            height: 3,
            width: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color:
                  widget.isSelected ? UIColors.primary_a : Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}

/*Widget _emptyListState() {
  return Container(
    margin: EdgeInsets.only(top: 28),
    child: Center(
        child: Image.asset(
      "assets/images/empty.png",
      height: 256,
      width: 256,
    )),
  );
}*/
