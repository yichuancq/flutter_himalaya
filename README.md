# flutter_himalaya
- 项目只供学习参考非商业用途 
- developer: yichuan  email:1012027293@qq.com

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

- 播放界面1（不带滑动模块） UI

<img src="https://github.com/yichuancq/flutter_himalaya/blob/master/screenshot/screenshot_01.png" width="40%" height="40%">

- 专辑界面 UI

<img src="https://github.com/yichuancq/flutter_himalaya/blob/master/screenshot/screenshot_02.png" width="40%" height="40%">


- 播放界面3（唱片中间加入播放和暂停动作，点击联动,背景模糊和根据专辑主色调动态改变）UI

<img src="https://github.com/yichuancq/flutter_himalaya/blob/master/screenshot/screenshot_03.png" width="40%" height="40%">

- 播放界面底部专辑列表 UI

<img src="https://github.com/yichuancq/flutter_himalaya/blob/master/screenshot/screenshot_04.png" width="40%" height="40%">

- 推荐列表界面

<img src="https://github.com/yichuancq/flutter_himalaya/blob/master/screenshot/screenshot_05.png" width="40%" height="40%">

```dart
  ///播放控制按钮组
  Widget _playerControlBar() {
    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.reorder, color: Colors.white),
            onPressed: () {
              showModalSheet();
            },
          ),

          //返回前一首
          IconButton(
            icon: Icon(Icons.skip_previous, color: Colors.white),
            onPressed: () {
              _prev();
            },
          ),
          // 播放，暂停
          IconButton(
            //判断是否播放中，返回不同按钮状态
            icon: playFlag == true
                ? Icon(Icons.pause, color: Colors.red) //暂停
                : Icon(Icons.play_arrow, color: Colors.white),
            // 播放
            onPressed: () {
              setState(() {
                controlPlay();
              });
            },
          ),
          //一下首
          IconButton(
            icon: Icon(Icons.skip_next, color: Colors.white),
            onPressed: () {
              _next();
            },
          ),

          IconButton(
            icon: Icon(Icons.timer, color: Colors.white),
            onPressed: () {
              // _showModalSheet();
            },
          ),
        ],
      ),
    );
  }
```

