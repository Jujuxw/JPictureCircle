# JPictureCircle
NSTimer ScrollView UIImageView



### 前提

------

​	之前写图片轮播的时候一直用的是（N+2）的方式添加图片，但是想到如果我要添加很多很多图片的话，那就gg了。

​	现在可以有一种只添加3个imageView的方式就可以实现图片轮播的方式，加上NSTimer这就更完美了，可以无限循环的哦。（此时我想到了面试一般会问到Runloop是干嘛的！此时结合一下，我就可以感觉到了O(∩_∩)O~）

------

- 加载ScrollView
- 定义3个imageView来承载图片
- 加载PageController
- 实现<UIScrollViewDelegate>的协议方法
- 定义定时器实现循环