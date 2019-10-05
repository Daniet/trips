import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'package:platzi_trips_app/platzi_trips_cupertino.dart';
import 'package:platzi_trips_app/widgets/button_green.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SingInScreen();

}

class _SingInScreen extends State<SignInScreen>{

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() => StreamBuilder(
    stream: userBloc.streamFirebase,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      print('Stream: ${!snapshot.hasData || snapshot.hasError}');
      if(!snapshot.hasData || snapshot.hasError){
        return signInGoogleUI();
      } else {
        return PlatziTripsCupertino();
      }
    },
  );

  Widget signInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack("", null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Welcome \n This is your Travel App",
                style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "Lato",
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
              ButtonGreen(
                text: 'Login with Gmail',
                onPressed: () => userBloc.singIn().then((user) => print(user)),
                width: 300,
                height: 50,
              )
            ],
          )
        ],
      ),
    );
  }
}