# Python decorator使用

> 装饰器是程序开发中经常会用到的一个功能，用好了装饰器，开发效率如虎添翼，所以这也是Python面试中必问的问题，但对于好多小白来讲，这个功能 有点绕，自学时直接绕过去了，然后面试问到了就挂了，因为装饰器是程序开发的基础知识，这个都 不会，别跟人家说你会Python, 看了下面的文章，保证你学会装饰器。

1. 先明白这段代码
    ```
    def foo():
        print 'foo'
    
    foo     #表示是函数
    foo()   #表示执行foo函数
    ```
    ```
    def foo():
        print 'foo'
    
    foo = lambda x: x + 1
    
    foo()   # 执行下面的lambda表达式，而不再是原来的foo函数，因为函数 foo 被重新定义了
    ```
2. 需求来了

    > 初创公司有N个业务部门，1个基础平台部门，基础平台负责提供底层的功能，如：数据库操作、redis调用、监控API等功能。业务部门使用基础功能时，只需调用基础平台提供的功能即可。如下：

    > 基础平台提供的功能如下
    ```
        def f1():
            print 'f1'
        
        def f2():
            print 'f2'
        
        def f3():
            print 'f3'
        
        def f4():
            print 'f4'
    ```
    > 业务部门A 调用基础平台提供的功能
    ```
        f1()
        f2()
        f3()
        f4()
    ```
    > 业务部门B 调用基础平台提供的功能
    ```
        f1()
        f2()
        f3()
        f4()
    ```

    >目前公司有条不紊的进行着，但是，以前基础平台的开发人员在写代码时候没有关注验证相关的问题，即：基础平台的提供的功能可以被任何人使用。现在需要对基础平台的所有功能进行重构，为平台提供的所有功能添加验证机制，即：执行功能前，先进行验证。

    > 老大把工作交给 Low B，他是这么做的：

    >跟每个业务部门交涉，每个业务部门自己写代码，调用基础平台的功能之前先验证。诶，这样一来基础平台就不需要做任何修改了。

    >当天Low B 被开除了…

    >老大把工作交给 Low BB，他是这么做的：

    > 基础平台提供的功能如下 
    ```
        def f1():
            # 验证1
            # 验证2
            # 验证3
            print 'f1'
        
        def f2():
            # 验证1
            # 验证2
            # 验证3
            print 'f2'
        
        def f3():
            # 验证1
            # 验证2
            # 验证3
            print 'f3'
        
        def f4():
            # 验证1
            # 验证2
            # 验证3
            print 'f4'
    ```
    > 业务部门不变 
    > 业务部门A 调用基础平台提供的功能
    ```
    f1()
    f2()
    f3()
    f4()
    ```
    > 业务部门B 调用基础平台提供的功能
    ```
    f1()
    f2()
    f3()
    f4()
    ```

    >过了一周 Low BB 被开除了…

    >老大把工作交给 Low BBB，他是这么做的：

    >只对基础平台的代码进行重构，其他业务部门无需做任何修改

    > 基础平台提供的功能如下
    ```
        def check_login():
            # 验证1
            # 验证2
            # 验证3
            pass
        
        
        def f1():
            check_login()
            print 'f1'
        
        def f2():
            check_login()
            print 'f2'
        
        def f3():
            check_login()
            print 'f3'
        
        def f4():
            check_login()
            print 'f4'
    ```
    >老大看了下Low BBB 的实现，嘴角漏出了一丝的欣慰的笑，语重心长的跟Low BBB聊了个天：

    >老大说：

    >写代码要遵循开发封闭原则，虽然在这个原则是用的面向对象开发，但是也适用于函数式编程，简单来说，它规定已经实现的功能代码不允许被修改，但可以被扩展，即：

    >封闭：已实现的功能代码块
    >开放：对扩展开发

    >如果将开放封闭原则应用在上述需求中，那么就不允许在函数 f1 、f2、f3、f4的内部进行修改代码，老板就给了Low BBB一个实现方案：
    ```
        def w1(func):
            def inner():
                # 验证1
                # 验证2
                # 验证3
                return func()
            return inner
        
        @w1
        def f1():
            print 'f1'
        @w1
        def f2():
            print 'f2'
        @w1
        def f3():
            print 'f3'
        @w1
        def f4():
            print 'f4'
    ```
    > 对于上述代码，也是仅仅对基础平台的代码进行修改，就可以实现在其他人调用函数 f1 f2 f3 f4 之前都进行【验证】操作，并且其他业务部门无需做任何操作。

    >Low BBB心惊胆战的问了下，这段代码的内部执行原理是什么呢？

    >老大正要生气，突然Low BBB的手机掉到地上，恰恰屏保就是Low BBB的女友照片，老大一看一紧一抖，喜笑颜开，交定了Low BBB这个朋友。详细的开始讲解了：

    > 单独以f1为例：
    ```
    def w1(func):
        def inner():
            # 验证1
            # 验证2
            # 验证3
            return func()
        return inner
    
    @w1
    def f1():
        print 'f1'
    ```
    >当写完这段代码后（函数未被执行、未被执行、未被执行），python解释器就会从上到下解释代码，步骤如下：

    >def w1(func):  ==>将w1函数加载到内存
    >@w1

    >没错，从表面上看解释器仅仅会解释这两句代码，因为函数在没有被调用之前其内部代码不会被执行。

    >从表面上看解释器着实会执行这两句，但是 @w1 这一句代码里却有大文章，@函数名 是python的一种语法糖。

    >如上例@w1内部会执行一下操作：

    >执行w1函数，并将 @w1 下面的 函数 作为w1函数的参数，即：@w1 等价于 w1(f1)

    >所以，内部就会去执行：
    ```
    def inner:
        #验证
        return f1()   # func是参数，此时 func 等于 f1
    return inner     # 返回的 inner，inner代表的是函数，非执行函数
    ```
    >其实就是将原来的 f1 函数塞进另外一个函数中

    >将执行完的 w1 函数返回值赋值给@w1下面的函数的函数名

    > w1函数的返回值是：
    ```
        def inner:
            #验证
        return f1()  # 此处的 f1 表示原来的f1函数
    ```
    >然后，将此返回值再重新赋值给 f1，即：
    ```
        f1 = def inner:
            #验证
            return f1() # 原来f1()
    ```
    >所以，以后业务部门想要执行 f1 函数时，就会执行 新f1 函数，在 新f1 函数内部先执行验证，再执行原来的f1函数，然后将 原来f1 函数的返回值 返回给了业务调用者。

    >如此一来， 即执行了验证的功能，又执行了原来f1函数的内容，并将原f1函数返回值 返回给业务调用着

    >Low BBB 你明白了吗？要是没明白的话，我晚上去你家帮你解决吧！！！

    >先把上述流程看懂，之后还会继续更新…

3. 各类装饰起

    > 带参数都装饰器

    > 一个参数

    ```
    def w1(func):
        def inner(arg):
            # 验证1
            # 验证2
            # 验证3
            return func(arg)
        return inner
    
    @w1
    def f1(arg):
        print 'f1'
    ```

    > 两个参数
    ```
    def w1(func):
        def inner(arg1,arg2):
            # 验证1
            # 验证2
            # 验证3
            return func(arg1,arg2)
        return inner

    @w1
    def f1(arg1,arg2):
        print 'f1'
    ```

    > 三个参数
    ```
    def w1(func):
        def inner(arg1,arg2,arg3):
            # 验证1
            # 验证2
            # 验证3
            return func(arg1,arg2,arg3)
        return inner
    
    @w1
    def f1(arg1,arg2,arg3):
        print 'f1'
    ```

    > n个参数的函数的装饰器
    ```
    def w1(func):
        def inner(*args,**kwargs):
            # 验证1
            # 验证2
            # 验证3
            return func(*args,**kwargs)
        return inner
    
    @w1
    def f1(arg1,arg2,arg3):
        print 'f1'
    ```

    > 一个函数被多个装饰器装饰
    ```
    def w1(func):
        def inner(*args,**kwargs):
            # 验证1
            # 验证2
            # 验证3
            return func(*args,**kwargs)
        return inner
    
    def w2(func):
        def inner(*args,**kwargs):
            # 验证1
            # 验证2
            # 验证3
            return func(*args,**kwargs)
        return inner
    
    
    @w1
    @w2
    def f1(arg1,arg2,arg3):
        print 'f1'
    ```
    > 装饰器带参数
    ```
    #!/usr/bin/env python
    #coding:utf-8
    
    def Before(request,kargs):
        print 'before'
        
    def After(request,kargs):
        print 'after'
    
    
    def Filter(before_func,after_func):
        def outer(main_func):
            def wrapper(request,kargs):
                
                before_result = before_func(request,kargs)
                if(before_result != None):
                    return before_result;
                
                main_result = main_func(request,kargs)
                if(main_result != None):
                    return main_result;
                
                after_result = after_func(request,kargs)
                if(after_result != None):
                    return after_result;
                
            return wrapper
        return outer
        
    @Filter(Before, After)
    def Index(request,kargs):
        print 'index'
    ```
