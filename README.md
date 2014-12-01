shell-project
=============
1、The example below will dump the top 5 stack of using the most CPU time.
   #./jcpu.sh [pid]
shell 
add btrace about online monitor

2、跟踪方法中调用的方法

@OnMethod(
        clazz="com.hehua.item.service.ItemService",
        method = "isSellable",
        location=@Location(value=Kind.CALL, clazz="java.util.Map",method="get")
    )
public static void entryMethod(@TargetInstance Object instance) {
        print("instance=");
        println(instance);
}
