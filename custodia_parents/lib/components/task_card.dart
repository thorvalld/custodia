import 'package:custodia_parents/models/task.dart';
import 'package:custodia_parents/models/user.dart';
import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

List<String> actions = ["Edit", "Delete"];
List<IconData> actionIcons = [
  FeatherIcons.edit3,
  FeatherIcons.trash,
  FeatherIcons.flag,
];

class TaskCard extends StatefulWidget {
  final Task mTask;

  const TaskCard({this.mTask});
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    User parent = User(fullname: "Anis", avatarUrl: "assets/images/p1.png");
    //parent = AuthServices.getUserObj(widget.mTask.originalPoster);
    User child = User(fullname: "Arthur", avatarUrl: "assets/images/c1.png");
    //child = AuthServices.getUserObj(widget.mTask.assignedTo);
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.all(1),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.orange,
                    child: Image.asset(parent.avatarUrl),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "add by ${parent.fullname} • ${widget.mTask.createdAt}",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 10),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.calendar,
                            size: 14,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            widget.mTask.dueDate,
                            style: TextStyle(color: Colors.red, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.money_dollar_circle,
                          color: Colors.blue,
                          size: 16,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.mTask.taskPoints.toString(),
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkResponse(
                      onTap: () {
                        triggerTaskBottomSheet(context);
                      },
                      child: Icon(
                        CupertinoIcons.ellipsis_vertical,
                        size: 18,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    CupertinoIcons.pencil_outline,
                    size: 14,
                    color: Colors.blue[600],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.mTask.taskTitle,
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 22),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    CupertinoIcons.doc_text,
                    size: 14,
                    color: Colors.blue[600],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(
                      widget.mTask.taskDesc,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black87, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.app_fill,
                          color: UIColors.primary_a,
                          size: 12,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '${widget.mTask.taskStatus}',
                          style: TextStyle(
                              color: UIColors.primary_a,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    "assigned to ${child.fullname}",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 12.0,
                    backgroundColor: Colors.orange,
                    child: Image.asset(child.avatarUrl),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void triggerTaskBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext ctx, StateSetter stateSetter) {
            return Container(
              child: Wrap(
                children: <Widget>[
                  new Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(64.0)),
                    ),
                    margin: EdgeInsets.only(
                        left: 140.0, right: 140.0, top: 8.0, bottom: 6.0),
                    height: 2.0,
                  ),
                  new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Container(
                        child: new Container(
                          margin: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 6.0, bottom: 6.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Text(
                                "More actions",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              Spacer(),
                              InkWell(
                                splashColor: Colors.red[100],
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  FeatherIcons.x,
                                  color: Colors.red[300],
                                  size: 22.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    reverse: false,
                    itemCount: actions.length,
                    itemBuilder: (BuildContext context, int idx) {
                      return ListTile(
                        onTap: () async {
                          setState(() {
                            if (idx == 0) {
                              //update
                              //Navigator.of(context).pop();
                              //triggerUpdateThreadBottomsheet(documentID);
                            } else if (idx == 1) {
                              Navigator.of(context).pop();
                              triggerConfirmDeleteBottomsheet();
                            }
                          });
                        },
                        title: Text(
                          actions[idx],
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontWeight: FontWeight.w300),
                        ),
                        leading: Icon(actionIcons[idx],
                            color: Colors.black87, size: 20.0),
                        trailing: Icon(
                          FeatherIcons.arrowRightCircle,
                          color: Colors.black87,
                          size: 14,
                        ),
                      );
                    },
                  ),
                  Container(
                    height: 14.0,
                  ),
                ],
              ),
            );
          });
        });
  }

  void triggerConfirmDeleteBottomsheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext ctx, StateSetter stateSetter) {
            return Container(
              child: Wrap(
                children: <Widget>[
                  new Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(64.0)),
                    ),
                    margin: EdgeInsets.only(
                        left: 140.0, right: 140.0, top: 8.0, bottom: 6.0),
                    height: 2.0,
                  ),
                  new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Container(
                        child: new Container(
                          margin: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 6.0, bottom: 6.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Text(
                                "Are you sure you want to delete this post?",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              Spacer(),
                              InkWell(
                                splashColor: Colors.red[100],
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  FeatherIcons.x,
                                  color: Colors.red[300],
                                  size: 22.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            onPressed: () {},
                            color: Colors.red[400],
                            child: Text(
                              'DELETE POST',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 14.0,
                  ),
                ],
              ),
            );
          });
        });
  }
}
