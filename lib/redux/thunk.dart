
import 'state.dart';
import 'action.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';



ThunkAction<AppState> nameData = (Store<AppState> store) async {

  store.dispatch(
      new DemoAction(
       store.state.demoState
       
      )
  );
};