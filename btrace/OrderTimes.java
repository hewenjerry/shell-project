import static com.sun.btrace.BTraceUtils.*;
import com.hehua.mis.controller.OrderController;
import com.sun.btrace.annotations.*;
import com.sun.btrace.AnyType;
/**
 * * 监控方法耗时
 * *
 * * @author jerry
 * */
@BTrace
public class OrderTimes {

/**
 * * 开始时间
 * */
@TLS
private static long startTime = 0;

/**
 * * 方法开始时调用
 * */
@OnMethod(clazz = "com.hehua.mis.controller.OrderController", method = "detail",
location = @Location(Kind.ENTRY))
public static void startMethod(AnyType s1,AnyType s2, long orderId,@ProbeClassName String pcn,@ProbeMethodName String pmn) {
println(strcat("class=",pcn));
println(strcat("method=", pmn));
println(s1);
println(s1);
println(orderId);
startTime = timeMillis();
}

/**
 * * 方法结束时调用<br>
 * * Kind.RETURN这个注解很重要
 * */
@SuppressWarnings("deprecation")
@OnMethod(
	    clazz="com.hehua.mis.controller.OrderController",
            method="detail",
            location=@Location(Kind.RETURN)	 
)
public static void endMethod(@Self OrderController instance) {
print(strcat("orderController is private parameter",":"));
Object obj = get(field("com.hehua.mis.controller.OrderController", "ordersDAO"), instance);
println(obj);
print(strcat(strcat(name(probeClass()), "."), probeMethod()));
print(" [");
print(strcat("Time taken : ", str(timeMillis() - startTime)));
println("]");
}
}
