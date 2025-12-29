import 'package:flutter/material.dart';
import 'package:image_search/data/api.dart';

class PhotoProvider extends InheritedWidget {
  //Main 코드의 HomeScreen의 의존성 주입을 생성자로 하지 않게끔 하기 위함.
  //이렇게 될 경우 HomeScreen에서 하위 컴포넌트들에 api가 필요할 경우 계속 해당 객체가 전달이 되어야 함.
  //이 경우 아래와 같은 2가지 문제점이 있다.
  // 1. 루트 컴포넌트들에는 하위 컴포넌트에 필요한 온갖 것들을 갖고 있을 수 있음.
  // 2. react의 props처럼 계속해서 하위 컴포넌트로 전달전달 해야함.

  //그렇기 때문에 InheritedWidget으로 어떤 위젯에든지 원하는 객체를 강제로 주입하게끔 바꾸는 것이 좋다.

  final PixabayApi api;


  const PhotoProvider({Key? key, required Widget child, required this.api})
    : super(key: key, child: child);

  // 컨텍스트를 통해 트리 상단의 근접 노드 중에서 PhotoProvider를 효율적으로 찾아주는 static 메서드입니다.
  // 하위 위젯에서 `PhotoProvider.of(context)`를 호출하여 의존성을 주입받을 수 있습니다.
  static PhotoProvider of(BuildContext context){
    final PhotoProvider? result = context.dependOnInheritedWidgetOfExactType<PhotoProvider>();
    assert(result != null, 'No PhotoProvider found in context');
    return result!;
  }


  // 데이터(api)가 변경되었을 때 하위 위젯들을 리빌드(rebuild)할지 결정합니다.
  // 여기서는 api 객체가 교체되었을 때만 하위 위젯에 알림을 보냅니다.
  @override
  bool updateShouldNotify(PhotoProvider oldWidget) {
    return oldWidget.api != api;
  }
}
