###  shiro学习笔记

#####  Demo编写

######  jar包准备

  [Spring-Shiro Jar包](https://github.com/zixi5534/LinuxAndJavaNote/tree/master/shiro%E7%9A%84jar)

######  web.xml配置

```xml
<?xml version="1.0" encoding="UTF-8"?>
 <web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns="http://xmlns.jcp.org/xml/ns/javaee" 
	xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee 
	http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd" 
	id="WebApp_ID" version="3.1">
	
	<!-- 配置spring核心监听器，默认会以 /WEB-INF/applicationContext.xml作为配置文件 -->
	<listener>
		<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
	</listener>
	<!-- contextConfigLocation参数用来指定Spring的配置文件 -->
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>classpath:applicationContext.xml</param-value>
	</context-param>
	
	<!-- 定义Spring MVC的前端控制器 -->
  <servlet>
    <servlet-name>springmvc</servlet-name>
    <servlet-class>
        org.springframework.web.servlet.DispatcherServlet
    </servlet-class>
    
    <init-param>
      <param-name>contextConfigLocation</param-name>
      <param-value>classpath:springmvc-config.xml</param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
  </servlet>
  
  <!-- 让Spring MVC的前端控制器拦截所有请求 -->
  <servlet-mapping>
    <servlet-name>springmvc</servlet-name>
    <url-pattern>/</url-pattern>
  </servlet-mapping>
  
  <!-- Shiro Filter is defined in the spring application context: -->
  <!-- 这是入口，拦截前端访问的所有资源 
     1.配置shiro的shiroFilter
     2.DelegatingFilterProxy实际上是Filter的一个代理对象，默认情况下，Spring 会到 IOC容器中
                     查找和<filter-name>对应filter bean,也可以通过targetBeanName的初始化参数来配置filter bean 的id
  -->
    <filter>
        <filter-name>shiroFilter</filter-name>
        <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
        <init-param>
            <param-name>targetFilterLifecycle</param-name>
            <param-value>true</param-value>
        </init-param>
        <!-- <init-param>
           <param-name>targetBeanName</param-name>
           <param-value>abc</param-value>
        </init-param> -->
    </filter>

    <filter-mapping>
        <filter-name>shiroFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
  
  <!-- 编码过滤器 -->
  <filter>
		<filter-name>characterEncodingFilter</filter-name>
		<filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
		<init-param>
			<param-name>encoding</param-name>
			<param-value>UTF-8</param-value>
		</init-param>
 </filter>
	<filter-mapping>
		<filter-name>characterEncodingFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
</web-app>
```

######  springmvc-config.xml配置

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:mvc="http://www.springframework.org/schema/mvc"
    xmlns:context="http://www.springframework.org/schema/context"
    xsi:schemaLocation="
        http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans-4.2.xsd
        http://www.springframework.org/schema/mvc
        http://www.springframework.org/schema/mvc/spring-mvc-4.2.xsd     
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context-4.2.xsd">
    
    <!-- 自动扫描该包，SpringMVC会将包下用了@controller注解的类注册为Spring的controller -->
    <context:component-scan base-package="com.rain.controller"/>
    <!-- 设置默认配置方案 -->
    <mvc:annotation-driven/>
    <!-- 使用默认的Servlet来响应静态文件 -->
    <mvc:default-servlet-handler/>
    <!-- 定义Spring MVC的拦截器 -->
    <!-- 视图解析器  -->
     <bean id="viewResolver"
          class="org.springframework.web.servlet.view.InternalResourceViewResolver"> 
        <!-- 前缀 -->
        <property name="prefix">
            <value>/</value>
        </property>
        <!-- 后缀 -->
        <property name="suffix">
            <value>.jsp</value>
        </property>
    </bean>
</beans>
```

######  applicationContext.xml配置

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
    <!-- 1.配置 SecurityManager-->
    <bean id="securityManager" class="org.apache.shiro.web.mgt.DefaultWebSecurityManager">
        <property name="cacheManager" ref="cacheManager"/>
        <!--只有一个realm的情况下
        <property name="realm" ref="jdbcRealm"/> -->
        <!-- 多个realm的情况下 -->
        <property name="authenticator" ref="authenticator"></property>
        <property name="realms">
          <list>
             <ref  bean="jdbcRealm"/>
             <ref  bean="secondRealm"/>
          </list>
       </property>
    </bean>
     <!-- 
     2.配置 CacheManager
     2.1需要加入ehcache的jar包及其配置文件
     -->
    <bean id="cacheManager" class="org.apache.shiro.cache.ehcache.EhCacheManager">
        <property name="cacheManagerConfigFile" value="classpath:ehcache.xml"/> 
    </bean>
    
    <!--给两个realm配置一个认证器  -->
  <bean id = "authenticator" class="org.apache.shiro.authc.pam.ModularRealmAuthenticator">
      <!--  <property name="realms">
          <list>
             <ref  bean="jdbcRealm"/>
             <ref  bean="secondRealm"/>
          </list>
       </property> -->
      <!--  更换验证策略 -->
       <property name="authenticationStrategy">
           <bean class="org.apache.shiro.authc.pam.AtLeastOneSuccessfulStrategy"></bean>
       </property>
    </bean> 
     <!--
      3.配置Realm
      3.1直接配置实现了Realm接口的Bean
      -->   
      <!-- 第一个realm -->
    <bean id="jdbcRealm" class="com.rain.controller.realms.ShiroRealms">
        <property name="credentialsMatcher">
           <bean class="org.apache.shiro.authc.credential.HashedCredentialsMatcher">
              <property name="hashAlgorithmName" value="MD5"></property>
              <!-- 指定加密的次数 -->
              <property name="hashIterations" value="1024"></property>
           </bean>
        </property>
    </bean>
    <!-- 第二个realm -->
    <bean id="secondRealm" class="com.rain.controller.realms.SecondRealm">
        <property name="credentialsMatcher">
           <bean class="org.apache.shiro.authc.credential.HashedCredentialsMatcher">
              <property name="hashAlgorithmName" value="SHA1"></property>
              <!-- 指定加密的次数 -->
              <property name="hashIterations" value="1024"></property>
           </bean>
        </property>
    </bean>
     <!-- 
     4.配置生命周期的lifecycleBeanPostProcessor.可以自动的来调用配置在spring IOC容器中shiro bean 的生命周期方法
      -->
    <bean id="lifecycleBeanPostProcessor" class="org.apache.shiro.spring.LifecycleBeanPostProcessor"/>

    <!-- 
    5.启用IOC容器中使用shiro的注解，但必须在配置了lifecycleBeanProcessor之后才可以使用
     -->
    <!-- Enable Shiro Annotations for Spring-configured beans.  Only run after
         the lifecycleBeanProcessor has run: -->
    <bean class="org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator"
          depends-on="lifecycleBeanPostProcessor"/>
    <bean class="org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor">
        <property name="securityManager" ref="securityManager"/>
    </bean>
    <!-- 
    6.配置shiroFilter
    6.1   id必须和web.xml文件中配置的DelegatingFilterProxy的<filter-name>一致
                              如果不一致会抛出NoSuchBeanDefinitionException: No bean named 'shiroFilter' is defined
                             因为shiro回来IOC容器中查找和<filter-name>名字对应的 filter bean.
     -->
    <bean id="shiroFilter" class="org.apache.shiro.spring.web.ShiroFilterFactoryBean">
        <property name="securityManager" ref="securityManager"/>
        <!--登录页面-->
        <property name="loginUrl" value="/login.jsp"/>
        <!-- 登录成功的页面 -->
        <property name="successUrl" value="/list.jsp"/>
        <!--没有权限的页面 -->
        <property name="unauthorizedUrl" value="/unauthorized.jsp"/>
        <!-- 配置哪些页面需要受保护
                                       以及访问这些页面需要的权限
             1).  anon表示可以被匿名访问     (即不需要登录就可以访问)
             2).  authc表示必须认证之后（即登陆之后）才可以被访问的页面    
             3).  logout表示登出的过滤器    
             4).  roles 角色过滤器 
            --> 
           
         <property name="filterChainDefinitionMap" ref="filterChainDefinitionMap"></property>   
         
        <!-- <property name="filterChainDefinitions">
        拦截匹配以第一次匹配优先
            <value>
                /login.jsp = anon
                /shiro/login = anon
                /shiro/logout = logout
                /user.jsp = roles[user]
                /admin.jsp = roles[admin]
                
                # everything else requires authentication:
                /** = authc
            </value>
           
             这种情况下，/list.jsp不会被访问到，因为，前面已经优先匹配了/**  
             <value>
                /login.jsp = anon
                # everything else requires authentication:
                /** = authc
               /** =authc
                /list.jsp = anon
            </value>
        </property> -->
    </bean>
   
    <bean id="shiroService" class="com.rain.service.ShiroService"></bean>
    <!--配置一个bean，该bean实际上是一个Map,通过实例工厂方法的方式  -->
    <bean id="filterChainDefinitionMap" factory-bean="filterChainDefinitionMapBuilder"
    factory-method="bulidFilterChainDefinitionMap"></bean>
    <bean id="filterChainDefinitionMapBuilder" 
    class="com.rain.factory.FilterChainDefinitionMapBuilder"></bean>
</beans>

```

######  ehcache.xml配置

```xml
<ehcache>
    <!--  
        指定一个目录：当 EHCache 把数据写到硬盘上时, 将把数据写到这个目录下.
    -->     
    <diskStore path="F:\\tempDirectory"/>

    <!--  
        设置缓存的默认数据过期策略 
    -->    
    <defaultCache
        maxElementsInMemory="10000"
        eternal="false"
        timeToIdleSeconds="120"
        timeToLiveSeconds="120"
        overflowToDisk="true"
        />

       <!--  
           设定具体的命名缓存的数据过期策略。每个命名缓存代表一个缓存区域
           缓存区域(region)：一个具有名称的缓存块，可以给每一个缓存块设置不同的缓存策略。
           如果没有设置任何的缓存区域，则所有被缓存的对象，都将使用默认的缓存策略。即：<defaultCache.../>
           Hibernate 在不同的缓存区域保存不同的类/集合。
            对于类而言，区域的名称是类名。如:com.atguigu.domain.Customer
            对于集合而言，区域的名称是类名加属性名。如com.atguigu.domain.Customer.orders
       -->
       <!--  
           name: 设置缓存的名字,它的取值为类的全限定名或类的集合的名字 
           maxElementsInMemory: 设置基于内存的缓存中可存放的对象最大数目 
         
           eternal: 设置对象是否为永久的, true表示永不过期, 此时将忽略timeToIdleSeconds 和 timeToLiveSeconds属性; 默认值是false 
        　 timeToIdleSeconds:设置对象空闲最长时间,以秒为单位, 超过这个时间,对象过期。当对象过期时,EHCache会把它从缓存中清除。如果此值为0,表示对象可以无限期地　　　　　　　　　　　　　　　　  处于空闲状态。 
           timeToLiveSeconds:设置对象生存最长时间,超过这个时间,对象过期。如果此值为0,表示对象可以无限期地存在于缓存中. 
　　　　　　　　　　　　　　　　该属性值必须大于或等于 timeToIdleSeconds 属性值 
        
           overflowToDisk:设置基于内存的缓存中的对象数目达到上限后,是否把溢出的对象写到基于硬盘的缓存中 
       -->
    <cache name="com.atguigu.hibernate.entities.Employee"
        maxElementsInMemory="1"
        eternal="false"
        timeToIdleSeconds="300"
        timeToLiveSeconds="600"
        overflowToDisk="true"
        />
    <cache name="com.atguigu.hibernate.entities.Department.emps"
        maxElementsInMemory="1000"
        eternal="true"
        timeToIdleSeconds="0"
        timeToLiveSeconds="0"
        overflowToDisk="false"
        />
</ehcache>
```

1.获取当前的Subject，调用SecurityUtils.getSubject();方法

2.测试当前的用户是否已经被认证，即是否已经被登陆     调用subject的isAuthenticated()方法

3.若没有被认证，则把用户名和密码封装为UsernamePasswordToken对象

* 创建一个表单页面
* 把请求提交到springmvc的handler
* 来获取用户名和密码.    

4.执行登录，调用subject 的login(HostAuthenticationToken)方法  UsernamePasswordToken是HostAuthenticationTokend的实现类

5.自定义Realm的方法，从数据库中获取对应的记录，返回给shiro

* 如何创建自定义的Realm
* 实际上需要继承org.apache.shiro.realm.AuthenticatingRealm 类
* 实现doGetAuthenticationInfo(AuthenticationToken)方法

6.由shiro完成密码的比对。

* 密码的比对  通过AuthenticatingRealm  的credentialsMatcher 属性来进行密码的比对

7.如何把一个字符串加密为md5

* 替换当前Realm的credentialsMatcher 属性 ，直接使用HashedCredentialsMatcher  对象，并设置加密算法即可

8.为什么使用MD5盐值加密：因为如果两个用户的密码一样，MD5加密完后结果不一样

9.如何做到MD5盐值加密

* 在doGetAuthenticationInfo() 方法返回值创建SimpleAuthenticationInfo对象的时候，需要使用SimpleAuthenticationInfo(principal, credentials, credentialsSalt, realmName) 构造器
* 使用ByteSource.Util.bytes(“”);来计算盐值
* 盐值需要唯一：一般使用随机字符串或 user id（即username）
* 使用new SimpleHash(algorithmName, source, salt, hashIterations); 来计算盐值加密后密码的值

10.授权

######  Shiro支持三种授权方式

* 编程式：通过写if/else 授权代码块完成
* 注解式：通过在执行的java方法上放置注解完成，没有权限将抛出相应异常
* JSP标签：在JSP页面通过相应的标签完成

###### Shiro中默认拦截器（过滤器）

​	shiro内置了很多默认的拦截器，比如身份验证，授权等相关。默认拦截器可以参考org.apache.shiro.web.filter.mgt.DefaultFilter中的枚举拦截器

```java
public enum DefaultFilter {
        anon(AnonymousFilter.class),   
        authc(FormAuthenticationFilter.class),  //验证相关
        authcBasic(BasicHttpAuthenticationFilter.class),
        logout(LogoutFilter.class),
        noSessionCreation(NoSessionCreationFilter.class),
        perms(PermissionsAuthorizationFilter.class),
        port(PortFilter.class),
        rest(HttpMethodPermissionFilter.class),
        roles(RolesAuthorizationFilter.class),  //授权相关
        ssl(SslFilter.class),
        user(UserFilter.class);
}	
```

  ######  授权需要继承的类  AuthorizingRealm 类，并实现一个抽象方法 doGetAuthorizationInfo()

​	AuthorizingRealm 类继承自AuthenticatingRealm 但没有实现AuthenticatingRealm  中的 doGetAuthenticationInfo方法。所以认证和授权只需要继承 AuthorizingRealm  就可以了，同时实现他的两个抽象方法

```java
        //认证方法的实现
		@Override
		protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws 			AuthenticationException {
        System.out.println("[FirstRealm doGetAuthenticationInfo]");
		//1.把 AuthenticationToken 转换为UsernamePasswordToken
		UsernamePasswordToken upToken =(UsernamePasswordToken)token;
		
		//2.从UsernamePasswordToken中来获取username
		String username = upToken.getUsername();
		
		//3.调用数据库的方法，从数据库中查询username对应的用户记录
		System.out.println("从数据库中获取username: "+username+" 所对应的用户信息.");
		
		//4.若用户不存在，则可以抛出异常UnknownAccountException异常
		if("unknown".equals(username)) {
			throw new UnknownAccountException("用户不存在");
		}
		
		//5.根据用户信息的情况决定是否需要抛出其他的AuthenticationException异常
		if("monster".equals(username)) {
			//比如被锁定异常
			throw new LockedAccountException("用户被锁定");
		}
		
		//6.根据用户的情况，来构建AuthenticationInfo对象并返回，通常使用的实现类为		     SimpleAuthenticationInfo
		//以下信息是从数据库中获取的
		//1.principal:认证的实体信息，可以使username，也可以是数据表对应的用户实体类对象
		Object principal  = username;
		//2.credentials:密码（从数据库中获取的密码）  123456   MD5加密1024次 fc1709d0a95a6be30bc5926fdb7f22f4
		Object credentials = null;//"fc1709d0a95a6be30bc5926fdb7f22f4";
		if("admin".equals(username)) {
			credentials="038bdaf98f2037b31f1e75b5b4c9b26e";
		}else if("user".equals(username)){
			credentials="098d2c478e9c11555ce2823231e02ec1";
		}
		//3.realmName:当前realm对象的name.调用父类的getName()方法即可
		String realmName = getName();
		//4.盐值   这里使用用户名为盐原始值，因为用户名是唯一的
		ByteSource  credentialsSalt = ByteSource.Util.bytes(username);
		SimpleAuthenticationInfo info = null;//new SimpleAuthenticationInfo(principal, credentials, realmName);
		info = new SimpleAuthenticationInfo(principal, credentials, credentialsSalt, realmName);
		
		return info;
	}
        //实现授权的方法
  		@Override 
  		protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
	    // 1.    从PrincipalCollection 中获取登录用户的信息
  			Object principal = principals.getPrimaryPrincipal();
  		//2.  利用登录的用户信息 来获取当前用户的角色或者权限  可能需要查询数据库
  			Set<String> roles = new HashSet<String>();
  			roles.add("user");
  			if("admin".equals(principal)) {
  				//意味着如果是admin登录就同时拥有user的权限
  				roles.add("admin");
  			}
  		//3.  因为AuthorizationInfo 是一个接口，所以必须找到他的实现类，故创建SimpleAuthorizationInfo	         实现类对象，并设置roles属性
  		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(roles);
  		//4. 返回 SimpleAuthorizationInfo对象
  	    System.out.println("--->doGetAuthorizationInfo...");
  		return info;
}
```

######  Shiro标签

* Shiro提供了JSTL标签用于在JSP页面进行权限控制，如根据登录用户显示相应的页面按钮。

* guest标签：用户没有身份验证时显示相应的信息，即游客访问信息。

  ```jsp
  <shiro:guest>
      欢迎游客访问，<a href="login.jsp">登录</a>
  </shiro:guest>
  ```

* user标签：用户已经经过认证/**记住我**登录后显示相应的信息。

  ```jsp
  <shiro:user>
      欢迎[<shiro:principal/>]登录，<a href="login.jsp">登录</a>
  </shiro:user>
  ```

* authenticated标签：用户已经身份验证通过，即Subject.login登录成功，**不是记住我登录的**

  ```jsp
  <shiro:authenticated>
      用户[<shiro:principal/>]已身份验证通过
  </shiro:authenticated>
  ```

* notAuthenticated标签：用户未进行身份验证，即没有调用Subject.login登录，**包括记住我自动登录的**也属于为进行身份验证。

  ```jsp
  <shiro:notAuthenticated>
      未身份验证，（包括记住我）
  </shiro:notAuthenticated>
  ```

* pincipal标签：**显示用户身份信息**，默认调用Subject.getPincipal()获取，即Primary Pincipal.

  ```jsp
  <shiro:principal property="username"/>
  ```

* hasRole标签：如果当前Subject有角色将显示body体内容

  ```jsp
  <shiro:hasRole>
      用户[<shiro:principal/>]拥有角色admin<br/>
  </shiro:hasRole>
  ```

* hasAnyRoles标签：如果当前Subject有任意一个角色(或关系)将显示body体内容

  ```jsp
  <shiro:hasAnyRoles>
      用户[<shiro:principal/>]拥有角色admin 或user<br/>
  </shiro:hasAnyRoles>
  ```

* lacksRole：如果当前Subject没有角色将显示body体内容

  ```jsp
  <shiro:lacksRole name="name">
      用户[<shiro:principal/>]没有角色admin<br/>
  </shiro:lacksRole>
  ```

* hasPermission标签：如果当前Subject有角色将显示body体内容

  ```jsp
  <shiro:hasPermission name="user:create">
      用户[<shiro:principal/>]拥有权限user:create<br/>
  </shiro:hasPermission>
  ```

* lackPermission标签：如果当前Subject没有权限将显示body体内容

  ```jsp
  <shiro:lackPermission name="org:create">
      用户[<shiro:principal/>]拥有权限org:create<br/>
  </shiro:lackPermission>
  ```

  

######  权限注解

* @RequiresAuthentication：表示当前Subject已经通过login进行了身份验证；即Subject.isAuthenticated()返回true

* @RequiresUser：表示当前Subject已经身份验证或者通过**记住我**登录

* @RequiresGuest：表示当前Subject没有身份验证或者通过**记住我**登录过，即使游客身份

* @RequiresRoles(value={"admin","user"},logical=Logical.AND)：表示当前Subject需要角色admin 和 user

* @RequiresPermissions(value={"user:a","user:b"},logical=Logical.OR)：表示当前Subject需要权限user:a和 user:b

  

######  会话管理

* Shiro提供了完整的企业级会话管理功能，不依赖于底层容器（如web容器tomcat），不管JavaSE还是JavaEE环境都可以使用，提供了会话管理，会话事件监听，会话存储/持久化，容器无关的集群，失效/过期支持，对Web的透明支持，SSO单点登录的支持等特性。

######  会话相关的API

* Subject.getSession()：即可获取会话；其等价于Subject.getSession(true)，即如果当前没有创建Session对象会创建一个；Subject.getSession(false),如果当前没有创建Session则返回null
* ssession.getId()：获取当前会话的唯一标识
* session.getHost()：获取当前Subjct的主机地址
* session.getTimeout()   &  session.getTimeout(毫秒)：获取/设置当前Session的过期时间
* session.getStartTimestamp()   &   session.getLastAccessTime()：获取会话的启动时间及最后访问时间；如果是JavaSE应用需要自己定期调用session.touch()去更新最后访问时间；如果是web应用，每次进入ShiroFilter都会自动调用session.touch()去更新最后访问时间
* session.touch() & session.stop()：更新会话最后访问时间及销毁会话；当Subject.logout()时会自动调用stop方法来销毁会话，如果在web中，调用HttpSessiojn.invalidate()也会自动调用Shiro Session.stop()方法进行销毁Shiro会话
* session.setAttribute(key, val)  &  session.getAttribute(key)    &    session.removeAttribute(key)：设置/获取/删除会话属性；在整个会话范围内都可以对这些属性进行操作

###### SessionDao

* AbstractSessionDao 提供了SessionDao的基础实现，如生成会话ID等
* CachingSessionDao提供了对开发者透明的会话缓存的功能，需要设置相应的CacheManager
* MemorySessionDao直接在内存中进行会话的维护
* EnterpriseCacheSessionDao提供了缓存功能的会话维护，默认情况下使用MapCache实现，内部使用ConCurrentHashMap保存缓存的会话

######  Shiro  缓存

* CacheManagerAware 接口  ：Shiro内部相应的组件（DefaultSecurityManager）会自动检测相应的对象（如Realm）是都已经实现了CacheManagerAware并自动注入了相应的CacheManager
* Realm缓存：Shiro提供了CachingRealm，其实现了CacheManagerAware接口，提供了缓存的一些基础实现；AuthenticatingRealm及AuthorizingRealm也分别提供了对AuthenticationInfo 和AuthorizationInfo信息的缓存

######  RememberMe(记住我)

* Shiro提供了记住我（RememberMe）的功能，比如访问如淘宝等一些网站的时候，关闭了浏览器，下次在打开时还是能记住你是谁，下次访问时无需再登录即可访问，基本流程如下
* 1.首先在登录页面选中RememberMe 然后登录成功；如果是浏览器登录，一般会把RememberMe的Cookie写到客户端并保存下来；
* 2.关闭浏览器再重新打开，会发现浏览器还是会记住你的；
* 3.访问一般的网页服务器端还是知道你是谁，且能正常访问；
* 4.但是比如我们访问淘宝时，如果要查看我的订单或进行支付时，此事还是需要再进行身份认证的，以确保当前用户是你。

######  认证和记住我的区别

* subject.isAuthenticated() ：表明用户进行了身份验证登录的；也就是说一定使用了subject.login() 方法进行了登录
* subject.isRememered()：表示用户是通过记住我登录的，此时坑能并不是真正的你在访问
* 两者二选一，即 subject.isAuthenticated()==true，则subject.isRememered()==false;反之一样；
* 建议：
  * 访问一般网页：个人在主页之类的。我们使用user拦截器即可，user拦截器只要用户登录（isRememered()||isAuthenticated()）即可访问成功；
  * 访问特殊网页：如我的订单，提交订单页面，我们使用authc拦截器即可，authc连接器会判断用户是否通过subject.login(isAuthenticated()==true)登录的，如果是才放行，否则会跳转到登录页面叫你重新登录。












