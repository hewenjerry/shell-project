import static com.sun.btrace.BTraceUtils.*;
import com.hehua.order.service.OrdersService;
import com.sun.btrace.annotations.*;
import com.sun.btrace.AnyType;
/**
 * * 监控方法耗时
 * *
 * * @author jerry
 * */
@BTrace
public class DAOTimes {

/**
 * * 开始时间
 * */
@TLS
private static long startTime = 0;

/**
 * * 方法开始时调用
 * */
@OnMethod(clazz = "com.hehua.order.service.OrdersService", method = "genOrderInfo",
location = @Location(Kind.ENTRY))
public static void startMethod(AnyType s1,@ProbeClassName String pcn,@ProbeMethodName String pmn) {
println(strcat("class=",pcn));
println(strcat("method=", pmn));
println(s1);
println(get(field(classOf(s1),"id"),s1));
println(get(field(classOf(s1),"userid"),s1));
startTime = timeMillis();
}

/**
 * * 方法结束时调用<br>
 * * Kind.RETURN这个注解很重要
 * */
@SuppressWarnings("deprecation")
@OnMethod(
	    clazz="com.hehua.order.service.OrdersService",
            method="genOrderInfo",
            location=@Location(Kind.RETURN)	 
)
public static void endMethod(@Self OrdersService instance) {
print(strcat(strcat(name(probeClass()), "."), probeMethod()));
print(" [");
print(strcat("Time taken : ", str(timeMillis() - startTime)));
println("]");
}
}
