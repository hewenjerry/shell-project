import static com.sun.btrace.BTraceUtils.*;
    import com.hehua.item.manager.PropertyManager;
    import com.sun.btrace.annotations.*;
    import com.sun.btrace.AnyType;
    import com.hehua.item.domain.PropertyValueI;
    import java.lang.reflect.Field;
    /**
     * * 监控方法耗时,方法返回对象的属性值
     * *
     * * @author jerry
     * */
    @BTrace
    public class GetReturnObjAttribute{

        /**
         * * 开始时间
         * */
        @TLS
        private static long startTime = 0;

        /**
         * * 方法开始时调用
         * */
        @OnMethod(clazz = "com.hehua.item.manager.PropertyManager", method = "getPropertyValue",
                location = @Location(Kind.ENTRY))
        public static void startMethod(int pvid,@ProbeClassName String pcn,@ProbeMethodName String pmn) {
            println(strcat("class=",pcn));
            println(strcat("method=", pmn));
            println(pvid);
            startTime = timeMillis();
        }

        /**
         * * 方法结束时调用<br>
         * * Kind.RETURN这个注解很重要
         * */
        @SuppressWarnings("deprecation")
        @OnMethod(
                clazz="com.hehua.item.manager.PropertyManager",
                method="getPropertyValue",
                location=@Location(Kind.RETURN)
        )
        public static void endMethod(@Self PropertyManager instance,@Return PropertyValueI command) {
            println(command);
            println(get(field("com.hehua.item.domain.PropertyValueI", "name"),command));

            print(strcat(strcat(name(probeClass()), "."), probeMethod()));

            print(" [");
            print(strcat("Time taken : ", str(timeMillis() - startTime)));
            println("]");
        }
    }
