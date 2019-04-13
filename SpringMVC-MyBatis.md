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
   * 关于如何在Eclipse中配置JavaWeb环境，这里有总结，请[点击](https://github.com/zixi5534/LinuxAndJavaNote/blob/master/Eclipse配置.md)查看   
   ### 第一回 懵懵懂懂项目初建  仔仔细细结构分析

   **注意**：有两种创建web项目的方式，一种是创建Dynamic Web Project（其中的第三方jar包是在lib文件夹下面，需要由程序员自行去官网 查找下载）。 一种是MavenProject，这种方法有一个方便的地方就是，通过pom.xml文件做了jar文件的版本管理，开发的 时候，在pom文件中直接进行配置，保存后，Eclipse将会根据你的配置，自动去下载所需要的jar包，不需要程序员进行干涉。这里我们鉴于已经有下载好的jar包，便用Dynamic Web Project这种方式做以下总结。

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
springmvc.xml，mybatis.xml，applicationContext.xml，db.proerties，log4j.properties这些配置文件。除    了web.xml文件在WEB-INF下面之外，其余文件都在资源文件config中。

   * web.xml

#### web.xml文件是用来配置：过滤器，Springmvc前端控制器，编码方式，mybatis配置文件，spring配置文件等等。

   ###### 下面给出的是简单web项目中所需的配置（这次项目中web.xml配置）
```xml
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
```
   * springmvc.xml        
#### springmvc.xml文件是给springmvc做相关的配置。拦截方式，视图处理器，前端拦截器等。

   ###### 下面给出的是简单web项目中所需的配置（这次项目中springmvc.xml的配置）
```xml
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
```

   * mybatis.xml
#### mybatis.xml文件是给mybatis做相关的配置。注解开发，扫描配置，数据源配置，数据库连接配置，sqlSessionFactory配置等等。

   ###### 下面给出的是简单web项目中所需的配置（这次项目中mybatis.xml的配置）
```xml
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
```

   * applicationContext.xml
#### applicationContext.xml文件是给spring做相关的配置，事务管理等配置。

   ###### 下面给出的是简单web项目中所需的配置（这次项目中applicationContext.xml的配置）
```xml
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

      <!-- 扫描huaxiren.neepu包下面的java文件，有Spring的相关注解的类，则把这些类注册为Spring的bean -->
            <context:component-scan base-package="huaxiren.neepu"/>
           <!-- 使用PropertyOverrideConfigurer后处理器加载数据源参数 -->
           <context:property-override location="classpath:db.properties"/>
           <!-- 配置c3p0数据源 -->
           <bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource"/>
		  <!-- 创建sqlSessionFactory。生产sqlSession -->
		  <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
		    <property name="dataSource" ref="dataSource"></property>
	      </bean>
	      <!-- 配置mybatis接口代理开发sqlSessionFactory 是上面sqlSession工厂id-->
	      <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
		    <property name="basePackage" value="huaxiren.neepu.mapper"></property>
		    <property name="sqlSessionFactoryBeanName" value="sqlSessionFactory"></property>
	      </bean>
           <!-- JDBC事务管理器 -->
           <bean id="transactionManager" 
           class="org.springframework.jdbc.datasource.DataSourceTransactionManager"
               p:dataSource-ref="dataSource"/>
           <!-- 启用支持annotation注解方式事务管理 -->
           <tx:annotation-driven transaction-manager="transactionManager"/>
        </beans>
```

   * db.proerties
#### db.proerties文件是数据库连接信息配置文件。

   ###### 下面给出的是以mysql数据库为例的配置文件(注意自己数据库的用户名和密码，以及数据库名)
```properties
 dataSource.driverClass=com.mysql.jdbc.Driver
 dataSource.jdbcUrl=jdbc:mysql://127.0.0.1:3306/huaxiren?   useUnicode=true&amp;characterEncoding=utf8
 dataSource.user=root
 dataSource.password=root
 dataSource.maxPoolSize=20
 dataSource.maxIdleTime = 1000
 dataSource.minPoolSize=6
 dataSource.initialPoolSize=5
```

   * log4j.properties
#### log4j.properties文件是log4j日志信息配置文件。

   ###### 下面给出的是以log4j日志管理作出的配置
```properties
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
```
   ### 第三回  控制生成还需注解  前端拦截切勿心急
做好前面所有的配置以后，关于配置文件先告一段落，不再重提。话说这是基于java开发网站，到现在为止，java代码却迟迟不现身，那么这回，就将开始做java代码的编写工作，为了让读者能很直观看到自己的网站能运行，先不做特别复杂的业务代码编写，这里先写出 一个控制器，调试通自己的网站即可（也可以测试自己前面的配置文件是否正确配置）

####  WEB-INF文件夹下面新建index.jsp文件，huaxiren.neepu.controller包下面新建UserController类

   ###### 下面给出的是UserController类完整代码
```java
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
```
#### 运行项目，鼠标点击选中项目，右击Run As-->Run As Server-->添加你的项目-->Finish

#### 查看控制台，log4j正常打印日志，服务器完全起来之后，将会在Eclipse中呼出一个浏览器，你只需要在地址栏后面添加index，回车即可。

以上笔记主要介绍了，java web开发过程中环境的搭建、配置文件的编写等一些列准备工作，真正的java代码开发编写，数据库CRUD操作至此尚未涉及，接下来的笔记将开始web开发之旅。主要实现的功能有系统登录注册、数据库CRUD、Shiro密码盐值加密、上传下载、ajax校验码生成，GoEasy消息实时发送，等功能。
   ### 第四回  网站访问提前注册  登录校验数据查询
网站开发过程中，必然要提供用户注册登录功能，不然怎么能知道是哪些用户访问了网站，怎么样给用户提供权限，管理员和普通用户所访问的资源是不一样的，这就必然涉及到用户信息的统一化管理。这回笔者将提到登录之前到实现登录所做的一些列工作。

#### 建立数据库，创建用户登录信息数据表 user_inf

创建项目所需数据库，以mysql数据库为例，通过Navicat数据库管理工具，很方便创建一张数据表 user_inf
如果有需要的，这里有安装数据库和创建教程[https://blog.csdn.net/weixin_44644403/article/details/88306003](https://blog.csdn.net/weixin_44644403/article/details/88306003)  

  **user_inf创建的sql代码**   数据库引擎采用mysql默认的InnoDB引擎，编码格式UTF-8，id设置为自增 AUTO_INCREMENT（读者根据自己的实际需求创建字段）

```mysql
     CREATE TABLE `user_inf` (
     `id` int(11) NOT NULL AUTO_INCREMENT,
  	 `username` varchar(255) DEFAULT NULL,
 	 `password` varchar(255) DEFAULT NULL,
	  PRIMARY KEY (`id`)
	 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

数据库创建好了之后，数据库就先告一段落，但这个时候，你得明确，数据库目前情况下没有一条用户信息，即use_inf 目前是一张空表

#### 通过逆向工程，生成mapper.xml以及数据库java实体pojo

   这一步的操作其实很简单
   * 第一步：在mybatis官网上提供下载提供好的逆向工程（包括所依赖jar）逆向工程已经上传至本仓库
   * 第二步：将此逆向工程部署在java project项目中，修改配置文件中的数据库属性（）
   * 第三步：运行java application 应用程序即可生成所需文件。

  完整逆向工程之后，将POJO实体类和Mapper.java(接口),mapper.xml(实现类)copy到web项目中即可。

####  编写前端jsp注册登录页面（提前写好，已经上传至仓库，jsp部分，笔者不再提供代码解析）

####  编写java代码创建操作数据库



* 第一步：编写修改Mapper.java中的接口方法，增加或者删除一些方法定义

  ```java
  public interface UserMapper {
      int deleteByPrimaryKey(Integer id);
      int insert(User record);  //插入接口
      int insertSelective(User record);
      User selectByPrimaryKey(Integer id);
      int updateByPrimaryKeySelective(User record);
      int updateByPrimaryKey(User record);
      //方法包含多参数时  记得使用@Param注解
      User selectUserByName(@Param("username")String username, @Param("password")String password);
  }
  ```

  

* 第二步：编写修改Mapper.xml中的实现方法，可以保留自己有用的一些sql

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
  <mapper namespace="huaxiren.neepu.mapper.UserMapper">
    <!-- 插入方法具体实现到sql语句，这里注意，id必须和UserMapper.java中的方法名一直，必须一致 -->
    <insert id="insert" parameterType="huxiren.neepu.po.User">
      insert into user_inf (id, username, password)
      values (#{id,jdbcType=INTEGER}, #{username,jdbcType=VARCHAR}, #{password,jdbcType=VARCHAR})
    </insert>
    <!--登录方法具体实现到sql语句，这里注意，id必须和UserMapper.java中的方法名一直，必须一致 -->
    <select id="selectUserByName" parameterType="java.lang.String"          resultType="huxiren.neepu.po.User">
       select * from user_inf where username = #{username,jdbcType=VARCHAR} and password = # {password,jdbcType=VARCHAR}
    </select>
  </mapper>
  ```

  

* 第二步：编写前端页面提交后的拦截Controller，编写Controller中业务逻辑代码，完成插入

  ```java
  @Controller
  public class UserController {
  	@Resource
     //接口实现类，通过注解，直接生成一个实现类对象userMapper
      private UserMapper userMapper;
  	//注册页面跳转控制器
  	@RequestMapping("/regist")
  	public String regist() {
  		return "/regist";
  	}
  	//注册页面提交成功后跳转到登录界面
  		@RequestMapping("/login")
  		public String login() {
  			return "/login";
  	}
  	//登录成功跳转到成功页面index	
  		@RequestMapping("/index")
  		public String index() {
  			return "/index";
  	}
  
  	//注册业务实现类    注册页面输入  admin  123456
  	@RequestMapping("/addUser")
  	public ModelAndView addUser(ModelAndView mv,@RequestParam("username")String username,
  			@RequestParam("password")String password) {
  	    //这里将用户信息封装到user对象中
  		User user = new User();
  		user.setUsername(username);
  		user.setPassword(password);
  		//将user对象作为参数出入掺入方法
  		userMapper.insert(user);
  		mv.setViewName("redirect:/login");
  		return mv;
  	}
  	//登录业务实现类   登录页面admin   123456
  	@RequestMapping("/toLogin")
  	public ModelAndView toLogin(ModelAndView mv,@RequestParam("username")String username,
  			@RequestParam("password")String password) {
  	    //这里通过用户的用户名和密码去数据库查询，看是否有此用户
  		User user = userMapper.selectUserByName(username,password);
  		if(user!=null) {
  			mv.setViewName("redirect:/index");//登录成功跳转到index页面
  		}else {
  			mv.setViewName("redirect:/login");//重定向到登录页面
  		}
  		return mv;
  	}
  }
  
  ```

  

   [持续更新完善中，敬请期待...](https://github.com/zixi5534/LinuxAndJavaNote/blob/master/SpringMVCAndMyBatis.md)  
   这篇文章出自本人自己总结编写，未经授权，禁止引用！

   

   

   

   

   

   

   

   

   

   

   

   
