最近公司安排做功能，其中涉足做自定义拉条slider，现在记录下做的过程

参考代码：https://github.com/Maling1255/MGSlider

非常感谢该码农的代码分享

我的代码就是在该代码的基础上加了左右2个按钮，可以用于控制拉条的位置；




在开发过程发现2个开发的相关知识

1：原代码的bug：

该控件的bug 该控件用个bug 就是点+ - 按钮，第一下会往前跳动一下，实际开发中用这段代码强行求正 

if (self.slider.progress >0.8) {

    //该控件的bug  该控件用个bug 就是点+ - 按钮，第一下会往前跳动一下，实际开发中用这段代码强行求正

    CGRect frame =  self.slider.valveIV.frame;

    if (frame.origin.x >= 90.0) {

        frame.origin.x = 90.0;

        self.slider.valveIV.frame = frame;

    }

    NSLog(@"x= %f",frame.origin.x);

}

2：实际中计算赔率用到的知识

小数向上取整，指小数部分直接进1：

 x = 2.222，ceilf(x) = 3。

小数向下取整，指直接去掉小数部分：

 x = 2.222，floor(x) = 2。

小数四舍五入，指>0.5向上加1 ，小于0.5去掉小数部分 ：

x = 2.222，round(x) = 2;

y = 2.555，round(y) = 3。
