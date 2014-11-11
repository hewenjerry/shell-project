import static com.sun.btrace.BTraceUtils.*;
import com.sun.btrace.annotations.*;
import com.sun.btrace.AnyType;

@BTrace
public class TraceMethodArgsAndReturn{

    @OnMethod(
            clazz="com.hehua.order.dao.OrdersDAO",
            method="getById",
            location=@Location(Kind.RETURN)
    )
    public static void traceExecute(AnyType sSrc,@Return Object result){
        println("return OrdersDAO.getById");
        println(strcat("sSrc is:",str(sSrc)));

        println(strcat("result is:",str(result)));
    }
    @OnMethod(
            clazz="com.hehua.order.dao.OrdersDAO",
            method="getById"
    )
    public static void traceEnterExecute(AnyType sSrc){
        println("enter OrdersDAO.getById");
        println(strcat("sSrc is:",str(sSrc)));
    }
}

