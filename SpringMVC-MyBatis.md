   ![图片添加方式](https://github.com/zixi5534/LinuxAndJavaNote/blob/master/images/logo1.png)   
    文 | 花袭人 图 | 网络
   # 告知读者
     本仓库是关于SSM框架中的重要组成SpringMVC和MyBatis的笔记，将基于本人网站做全面总结。
   ## 进阶热身
   * 需要掌握java基础，了解javaweb中的MVC模式，springmvc的工作原理。这里有完整的[总结](https://github.com/frank-lam/SpringMVC_MyBatis_Learning) 
   * 下载jdk，建议jdk1.8系列版本(虽然已经发布12了)。[官网](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
   * 下载Tomcat，建议Tomcat8.5系列版本。[官网](http://tomcat.apache.org/)
   * 安装Eclipse，配置好java环境，确定能正常打开。[官网](https://www.eclipse.org/downloads/packages/)
   * 项目所需jar，仓库中已经上传(lib文件就是)。
   * 关于如何在Eclipse中配置JavaWeb环境，这里有总结，请[点击](https://github.com/zixi5534/LinuxAndJavaNote/edit/master/Eclipse配置.md)查看   
   ### 第一回 懵懵懂懂项目初建  仔仔细细结构分析
       注意：有两种创建web项目的方式，一种是创建Dynamic Web Project（其中的第三方jar包是在lib文件夹下面，需要由程序员自行
       去官网 查找下载）。 一种是MavenProject，这种方法有一个方便的地方就是，通过pom.xml文件做了jar文件的版本管理，开发的
       时候，在pom文件中直接进行配置，保存后，Eclipse将会根据你的配置，自动去下载所需要的jar包，不需要程序员进行干涉。
   这里我们鉴于已经有下载好的jar包，便用Dynamic Web Project这种方式做以下总结。
   #### 1.打开Eclipse，File-->New-->Dynamic Web Project(如下图) 
   ![图片添加方式](https://github.com/zixi5534/LinuxAndJavaNote/blob/master/images/第一步，新建动态web项目.png) 
   #### 2.添加项目名-->选择Tomcat版本-->选择工作集(可选)-->Next
   ![图片添加方式](https://github.com/zixi5534/LinuxAndJavaNote/blob/master/images/第一步，新建动态web项目01.png) 
   #### 3.选择生成web.xml文件-->Finish  
   ![图片添加方式](https://github.com/zixi5534/LinuxAndJavaNote/blob/master/images/第一步，新建动态web项目02.png)
   <font color="red">至此项目已经创建完成</font> 
   #### 4.打开项目结构(如下图) 
   ![图片添加方式](https://github.com/zixi5534/LinuxAndJavaNote/blob/master/images/第一步，新建动态web项目03.png)
   #### 5.需要程序员编写的是src下面的java文件和一些配置资源文件以及WebContent下面和WEB-INF下面的lib（jar包）web.xml(配置文件)。 
   #### 6.需要将下载好的jar文件直接复制到lib文件夹下面，选中全部的jar文件，右键Bulid Path-->Add to Bulid Path  
   #### 7.选中项目名，右键New-->Source Folder (如果找不到，就New-->Other-->搜索框搜索一下) -->命名为config 
   #### 8.选中WebContent，New-->Folder-->命名为css,New-->Folder-->命名为image ,New-->Folder-->命名为js(新建这三个文件夹目的是为了存放前端的css样式，图片和JavaScript文件)
   #### 9.选中WEB-INF，New-->Folder-->命名为pages(前端页面文件夹)  
   到此，项目结构成型（成型如下图）
   ![图片添加方式](https://github.com/zixi5534/LinuxAndJavaNote/blob/master/images/第一步，新建动态web项目04.png)
   ### 第二回 文件配置我有妙招  峰回路转更进一步 
       这一回是至关重要的一回，关系到你项目中各个中间件能否按照你的预期和谐的配合工作。这回里面将总结web.xml，
       springmvc.xml，mybatis.xml，applicationContext.xml，db.proerties，log4j.properties这些配置文件。除了web.xml
       文件在WEB-INF下面之外，其余文件都在资源文件config中。
   * web.xml
   ##### web.xml文件是用来配置：过滤器，Springmvc前端控制器，编码方式，mybatis配置文件，spring配置文件等等。
   ###### 下面给出的是简单web项目中所需的配置（这次项目中web.xml配置）
        <?xml version="1.0" encoding="UTF-8"?>
       <web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	            xmlns="http://java.sun.com/xml/ns/javaee"
	            xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
	            version="3.0">
	      <!-- Spring MVC配置 -->
            <servlet>
               <servlet-name>springmvc</servlet-name>
               <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
                <!-- 可以自定义servlet.xml配置文件的位置和名称，默认为WEB-INF目录下，名称为[<servlet-name>]-servlet.xml，
                如spring-servlet.xml-->
               <init-param>
                  <param-name>contextConfigLocation</param-name>
                  <param-value>classpath:springmvc.xml</param-value>
               </init-param>
               <load-on-startup>1</load-on-startup>
                <!--Servlet3.0以上文件上传配置 -->
                 <multipart-config>
                     <!--上传文件的最大限制5MB -->
                     <max-file-size>5242880</max-file-size>
                     <!--请求的最大限制20MB -->
                     <max-request-size>20971520</max-request-size>
                     <!--当文件的大小超过临界值时将写入磁盘 -->
                     <file-size-threshold>0</file-size-threshold>
                 </multipart-config>
            </servlet>
            <!--所有请求都会被springmvc拦截 -->
            <servlet-mapping>
               <servlet-name>springmvc</servlet-name>
               <url-pattern>/</url-pattern>
            </servlet-mapping>
            <!-- Spring配置 -->
            <listener>
               <listener-class>
                 org.springframework.web.context.ContextLoaderListener
               </listener-class>
            </listener>
            <!-- 指定Spring Bean的配置文件所在目录。默认配置在WEB-INF目录下 -->
            <context-param>
                <param-name>contextConfigLocation</param-name>
                <param-value>classpath*:applicationContext.xml</param-value>
            </context-param>
            <!-- Spring MVC字符过滤器配置 -->
            <filter>
               <filter-name>characterEncodingFilter</filter-name>
               <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
               <init-param>
                  <param-name>encoding</param-name>
                  <param-value>UTF-8</param-value>
               </init-param>
               <init-param>
                  <param-name>forceEncoding</param-name>
                  <param-value>true</param-value>
               </init-param>
            </filter>
            <filter-mapping>
               <filter-name>characterEncodingFilter</filter-name>
               <url-pattern>/*</url-pattern>
            </filter-mapping>
     </web-app>
   * springmvc.xml        
   ##### springmvc.xml文件是给springmvc做相关的配置。拦截方式，视图处理器，前端拦截器等。
   ###### 下面给出的是简单web项目中所需的配置（这次项目中springmvc.xml的配置）
            <?xml version="1.0" encoding="UTF-8"?>
         <beans xmlns="http://www.springframework.org/schema/beans"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mvc="http://www.springframework.org/schema/mvc"
            xmlns:context="http://www.springframework.org/schema/context"
            xsi:schemaLocation="http://www.springframework.org/schema/beans 
                  http://www.springframework.org/schema/beans/spring-beans-4.3.xsd 
                  http://www.springframework.org/schema/mvc 
                  http://www.springframework.org/schema/mvc/spring-mvc-4.3.xsd 
                  http://www.springframework.org/schema/context 
                  http://www.springframework.org/schema/context/spring-context-4.3.xsd">

            <!-- 用于使用@ResponseBody后返回中文避免乱码 -->
            <bean
               class="org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter">
               <property name="messageConverters">
                  <list>
                     <bean id="stringHttpMessageConverter"
                        class="org.springframework.http.converter.StringHttpMessageConverter">
                        <property name="writeAcceptCharset" value="false" />
                        <!-- 用于避免响应头过大 -->
                        <property name="supportedMediaTypes">
                           <list>
                              <value>text/html;charset=UTF-8</value>
                           </list>
                        </property>
                     </bean>
                  </list>
               </property>
            </bean>
            <!-- 扫描controller注解、,多个包中间使用半角逗号分隔 -->
            <context:component-scan base-package="com.neepu.controller" />
            <!-- 支持mvc注解驱动 -->
            <mvc:annotation-driven enable-matrix-variables="true" />
            <!-- Spring MVC不处理静态资源 -->
            <mvc:default-servlet-handler />
            <!-- 视图解析器 -->
            <bean
               class="org.springframework.web.servlet.view.InternalResourceViewResolver"
               id="internalResourceViewResolver">
               <!-- 前缀 -->
               <property name="prefix" value="/WEB-INF/" />
               <!-- 后缀 -->
               <property name="suffix" value=".jsp" />
            </bean>
         <!--文件上传解析器 -->
             <!--Spring MVC默认不能识别multipart格式的文件内容 -->
             <bean id="multipartResolver"
                 class="org.springframework.web.multipart.support.StandardServletMultipartResolver">
              </bean>
            </beans>
   
   * mybatis.xml
   ##### mybatis.xml文件是给mybatis做相关的配置。注解开发，扫描配置，数据源配置，数据库连接配置，sqlSessionFactory配置等等。
   ###### 下面给出的是简单web项目中所需的配置（这次项目中mybatis.xml的配置）
               <?xml version="1.0" encoding="UTF-8" ?>  
            <!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN"  
            "http://mybatis.org/dtd/mybatis-3-config.dtd">  
            <configuration>  
                <!-- 配置mybatis的缓存，延迟加载等等一系列属性 -->  
                <settings>  
                    <!-- 全局映射器启用缓存 -->  
                    <setting name="cacheEnabled" value="true" />  
                    <!-- 查询时，关闭关联对象即时加载以提高性能 -->  
                    <setting name="lazyLoadingEnabled" value="true" />  
                    <!-- 设置关联对象加载的形态，此处为按需加载字段(加载字段由SQL指 定)，不会加载关联表的所有字段，以提高性能 -->  
                    <setting name="aggressiveLazyLoading" value="false" />  
                    <!-- 对于未知的SQL查询，允许返回不同的结果集以达到通用的效果 -->  
                    <setting name="multipleResultSetsEnabled" value="true" />  
                    <!-- 允许使用列标签代替列名 -->  
                    <setting name="useColumnLabel" value="true" />  
                    <!-- 允许使用自定义的主键值(比如由程序生成的UUID 32位编码作为键值)，数据表的PK生成策略将被覆盖 -->  
                    <setting name="useGeneratedKeys" value="true" />  
                    <!-- 给予被嵌套的resultMap以字段-属性的映射支持 -->  
                    <setting name="autoMappingBehavior" value="FULL" />  
                    <!-- 对于批量更新操作缓存SQL以提高性能 -->  
                    <!-- <setting name="defaultExecutorType" value="BATCH" />   -->
                    <!-- 数据库超过25000秒仍未响应则超时 -->  
                    <setting name="defaultStatementTimeout" value="25000" />  
                </settings>  
            </configuration>  

   * applicationContext.xml
   ##### applicationContext.xml文件是给spring做相关的配置，事务管理等配置。
   ###### 下面给出的是简单web项目中所需的配置（这次项目中applicationContext.xml的配置）
               <?xml version="1.0" encoding="UTF-8"?>
            <beans xmlns="http://www.springframework.org/schema/beans" 
               xmlns:mybatis="http://mybatis.org/schema/mybatis-spring"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xmlns:p="http://www.springframework.org/schema/p"
               xmlns:context="http://www.springframework.org/schema/context"
               xmlns:mvc="http://www.springframework.org/schema/mvc"
               xmlns:tx="http://www.springframework.org/schema/tx"
               xsi:schemaLocation="http://www.springframework.org/schema/beans 
                                 http://www.springframework.org/schema/beans/spring-beans-4.2.xsd
                                 http://www.springframework.org/schema/context
                                 http://www.springframework.org/schema/context/spring-context-4.2.xsd
                                 http://www.springframework.org/schema/mvc
                                 http://www.springframework.org/schema/mvc/spring-mvc-4.2.xsd
                                 http://www.springframework.org/schema/tx
                                 http://www.springframework.org/schema/tx/spring-tx-4.1.xsd
                                 http://mybatis.org/schema/mybatis-spring 
                                 http://mybatis.org/schema/mybatis-spring.xsd ">

                <!-- mybatis:scan会扫描huaxiren.neepu.dao包里的所有接口当作Spring的bean配置，之后可以进行依赖注入-->  
                <mybatis:scan base-package="huaxiren.neepu.dao"/>   

                <!-- 扫描huaxiren.neepu包下面的java文件，有Spring的相关注解的类，则把这些类注册为Spring的bean -->
                <context:component-scan base-package="huaxiren.neepu"/>

               <!-- 使用PropertyOverrideConfigurer后处理器加载数据源参数 -->
               <context:property-override location="classpath:db.properties"/>

               <!-- 配置c3p0数据源 -->
               <bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource"/>

               <!-- 配置SqlSessionFactory，org.mybatis.spring.SqlSessionFactoryBean是Mybatis社区开发用于整合Spring的bean -->
               <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
                   <property name="dataSource" ref="dataSource" />
                    <!--关键：增加的是这一句-->
                    <!-- 指定Mybatis配置文件地址，我这里是在classpath下，如果你的不同，需要制定具体路径 -->
                    <property name="configLocation" value="classpath:mybatis.xml" />
                 </bean>
               <!-- JDBC事务管理器 -->
               <bean id="transactionManager" 
               class="org.springframework.jdbc.datasource.DataSourceTransactionManager"
                   p:dataSource-ref="dataSource"/>
               <!-- 启用支持annotation注解方式事务管理 -->
               <tx:annotation-driven transaction-manager="transactionManager"/>
            </beans>

   * db.proerties
   ##### db.proerties文件是数据库连接信息配置文件。
   ###### 下面给出的是以mysql数据库为例的配置文件(注意自己数据库的用户名和密码，以及数据库名)
         dataSource.driverClass=com.mysql.jdbc.Driver
	 dataSource.jdbcUrl=jdbc:mysql://127.0.0.1:3306/personnel?useUnicode=true&amp;characterEncoding=utf8
	 dataSource.user=root
	 dataSource.password=root
	 dataSource.maxPoolSize=20
	 dataSource.maxIdleTime = 1000
	 dataSource.minPoolSize=6
	 dataSource.initialPoolSize=5

   * log4j.properties
   ##### log4j.properties文件是log4j日志信息配置文件。
   ###### 下面给出的是以log4j日志管理作出的配置
         log4j.rootLogger=DEBUG,Console,File   
         log4j.appender.Console=org.apache.log4j.ConsoleAppender  
         log4j.appender.Console.Target=System.out  
         log4j.appender.Console.layout = org.apache.log4j.PatternLayout  
         log4j.appender.Console.layout.ConversionPattern=[%c] - %m%n   
         log4j.appender.File = org.apache.log4j.RollingFileAppender
         log4j.appender.File.File = logs/ssm.log    
         log4j.appender.File.MaxFileSize = 10MB    
         log4j.appender.File.Threshold = ALL  
         log4j.appender.File.layout = org.apache.log4j.PatternLayout  
         log4j.appender.File.layout.ConversionPattern =[%p] [%d{yyyy-MM-dd HH\:mm\:ss}][%c]%m%n  
   ### 第三回  控制生成还需注解  前端拦截切勿心急
       做好前面所有的配置以后，关于配置文件先告一段落，不再重提。话说这是基于java开发网站，到现在为止，java代码迟迟不现身，
       这回，将开始做java代码的编写工作，为了让读者，能首先看到自己的网站能运行，先不做特别复杂的业务代码编写，这里先写出
       一个控制器，调试通自己的网站即可（也可以测试自己前面的配置文件是否正确配置）
   ##### WEB-INF文件夹下面新建index.jsp文件，huaxiren.neepu.controller包下面新建UserController类
   ###### 下面给出的是UserController类完整代码
	   package huaxiren.neepu.controller;
	   import org.springframework.stereotype.Controller;
	   import org.springframework.web.bind.annotation.RequestMapping;

	   @Controller
	   public class UserController {
		@RequestMapping("/index")
		public String index() {
			return "/index";
		}
	    }
   ##### 运行项目，鼠标点击选中项目，右击Run As-->Run As Server-->添加你的项目-->Finish
   ##### 查看控制台，log4j正常打印日志，服务器完全起来之后，将会在Eclipse中呼出一个浏览器，你只需要在地址栏后面添加index，回车即可。
   
    
   [持续更新完善中，敬请期待...](https://github.com/zixi5534/LinuxAndJavaNote/blob/master/SpringMVCAndMyBatis.md)  
   这篇文章出自本人自己总结编写，未经授权，禁止引用！
   
