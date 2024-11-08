// View my sub agents, as well as a button to launch form for adding new one

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_template/core/http/http.dart';
import 'package:flutter_template/core/utils/toast.dart';
import 'package:flutter_template/core/widget/loading_dialog.dart';
import 'package:flutter_template/generated/i18n.dart';
import 'package:flutter_template/page/index.dart';
import 'package:flutter_template/utils/provider.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter_template/page/details-form.dart';
import 'package:flutter_template/page/subagent/agent-form.dart';
import 'package:flutter_template/utils/sputils.dart';



class AgentPage extends ConsumerStatefulWidget {
  final bool isLoginCodeScreen; // same design used for viewing subagents and getting their login codes

  AgentPage({Key? key, this.isLoginCodeScreen = false}) : super(key: key);

  @override
  _AgentPageState createState() => _AgentPageState(isLoginCodeScreen);
}


class _AgentPageState extends ConsumerState<AgentPage> {
  FocusNode blankNode = FocusNode();
  final bool isLoginCodeScreen;
  // TextEditingController _otpController = TextEditingController();

  _AgentPageState(this.isLoginCodeScreen) : super();

  // array of subAgents to add
  // final List subAgents = [
  //   {"name": "Jacob Tetteh", "email": "p1-1@example.com", "phone": "0240010001", "hasSignedUp": true},
  //   {"name": "Eugenia Doe", "email": "p1-2@example.com", "hasSignedUp": false}
  // ];

  ///
  // Widget processSubAgent(var input) {
  //   return Text("Ok here i am");
  // }

  final List<Widget> agentWidgets = [];
  // [
  //   Column(children: [
  //     Text("Name One"), Text("0240010001"), Divider()
  //   ],),
  //   Column(children: [
  //     Text("Name Two"), Text("blah@example.com"), Divider()
  //   ],)
  // ];


  @override
  void initState() {
    super.initState();
    // get the subAgents
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: _leading(context),
        title: Text(I18n.of(context)!.subAgents),
        //actions: <Widget>[],
      ),
      body: SizedBox.expand( // make child column take up the whole width
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // show 'add agent' button
              isLoginCodeScreen ? SizedBox.shrink()
              : //Padding(
                //padding: const EdgeInsets.only(top: 28.0),
                //child: 
                  //Row(
                  //children: <Widget>[
                    //Expanded(child: Builder(builder: (context) {
                      //return 
                      ElevatedButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColor,
                            padding: EdgeInsets.all(15.0)),
                        child: Text(I18n.of(context)!.addSubAgents,
                            style: TextStyle(color: Colors.white)),
                        onPressed: () { // navigate to screen for adding subagents
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return AgentFormPage(numAgentsAdded: 0,); // TODO: set numAgentsAdded
                            }
                          ));
                        },
                      ),//;
                    //})),
                  //],
                //),
              //)
              Divider(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: agentWidgets.length,
                itemBuilder: (BuildContext context, int index) {
                  // return Container(
                  //   //width: 400, // added
                  //   height: 50,
                  //   color: Colors.amber[100+200*index],
                  //   child: Center(child: Text('Entry $index')),
                  // );
                  return agentWidgets[index];
                  //Column(
                          // children: [
                          //   Text('My name'),
                          //   Text('my email address'),
                          //   Text('my phone number'),
                          //   Text('Not signed up', style: TextStyle(color: Colors.red),),
                          //   //SizedBox(width: 50, height: 25, )
                          //   Divider()
                          // ],
                  //);
                }
              )
            ],
          )
        
        )
        
    );
  }


  /// get subAgents on init
  Future getSubAgentsQuery() async {
    try {
      var response = await XHttp.get('/subagents');
      int status = response.statusCode;

      if (status == 200) {
        // update agentWidgets
        setState(() {
          
        });

      } else if (status == 400) {
        debugPrint('GET /subagents error: ${response?.data?.errMsg}');
        ToastUtils.error(response.data?.errMsg);
      } else {
        debugPrint('GET /subagents error 500');
        ToastUtils.error(I18n.of(context)!.somethingWentWrong);
      }

    } catch (exc) {
      debugPrint("caught exc on getSubAgentsQuery: $exc");
      ToastUtils.error(I18n.of(context)!.somethingWentWrong);
    }


    return 5;
  }


  // void closeKeyboard(BuildContext context) {
  //   FocusScope.of(context).requestFocus(blankNode);
  // }

  ///
  // Future onSubmit(BuildContext context) async {
  //   closeKeyboard(context);

  //   // show loading dialog/spinner
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return LoadingDialog(
  //         showContent: false,
  //         backgroundColor: Colors.black38,
  //         loadingView: SpinKitCircle(color: Colors.white),
  //       );
  //     }
  //   );

  //   // send data 
  // }


}
