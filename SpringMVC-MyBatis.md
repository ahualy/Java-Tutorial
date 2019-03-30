   ![图片添加方式](https://github.com/zixi5534/LinuxAndJavaNote/blob/master/images/logo1.png)   
    文 | 花袭人 图 | 网络
   # 告知读者
     本仓库是关于SSM框架中的重要组成SpringMVC和MyBatis的笔记，将基于本人网站做全面总结。
   ## 进阶热身
   * 需要掌握java基础，了解javaweb中的MVC模式，springmvc的工作原理。这里有完整的[总结](https://github.com/zixi5534/LinuxAndJavaNote/blob/master/SpringMVCAndMyBatis.md) 
   * 下载jdk，建议jdk1.8系列版本(虽然已经发布12了)。[官网](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
   * 下载Tomcat，建议Tomcat8.5系列版本。[官网](http://tomcat.apache.org/)
   * 安装Eclipse，配置好java环境，确定能正常打开。[官网](https://www.eclipse.org/downloads/packages/)
   * 项目所需jar，仓库中已经上传(lib文件就是)。[下载]()
   * 关于如何在Eclipse中配置JavaWeb环境，请[点击]()   
   ### 第一回 懵懵懂懂项目初建  仔仔细细结构分析
    注意：有两种创建web项目的方式，一种是创建Dynamic Web Project（其中的第三方jar包是在lib文件夹下面，需要由程序员自行
    去官网 查找下载）。 一种是MavenProject，这种方法有一个方便的地方就是，通过pom.xml文件做了jar文件的版本管理，开发的
    时候，在pom文件中直接进行配置，保存后，Eclipse将会根据你的配置，自动去下载所需要的jar包，不需要程序员进行干涉。
   这里我们鉴于已经有下载好的jar包，便用Dynamic Web Project这种方式做以下总结。
   #### 1.打开Eclipse，File-->New-->Dynamic Web Project(如下图) 
   #### 2.添加项目名-->选择Tomcat版本-->选择工作集(可选)-->Next
   #### 3.选择生成web.xml文件-->Finish  
   <font color="red">至此项目已经创建完成</font> 
   #### 4.打开项目结构(如下图) 
   #### 5.需要程序员编写的是src下面的java文件和一些配置资源文件以及WebContent下面和WEB-INF下面的lib（jar包）web.xml(配置文件)。 
   #### 6.需要将下载好的jar文件直接复制到lib文件夹下面，选中全部的jar文件，右键Bulid Path-->Add to Bulid Path  
   #### 7.选中项目名，右键New-->Source Folder (如果找不到，就New-->Other-->搜索框搜索一下) -->命名为config 
   #### 8.选中WebContent，New-->Folder-->命名为css,New-->Folder-->命名为image ,New-->Folder-->命名为js(新建这三个文件夹目的是为了存放前端的css样式，图片和JavaScript文件)
   #### 9.选中WEB-INF，New-->Folder-->命名为pages(前端页面文件夹)  
   到此，项目结构成型（成型如下图）  
   ### 第二回 文件配置我有妙招  峰回路转更进一步 
   这一回是至关重要的一回，关系到你项目中各个中间件能否按照你的预期和谐的配合工作。这回里面将总结web.xml，spring.xml，mybatis.xml，spring-mybatis.xml，db.proerties，log4j.properties这些配置文件。除了web.xml文件在WEB-INF下面之外，其余文件都在资源文件config中。
   * web.xml
   ##### web.xml文件是用来配置：过滤器，Springmvc前端控制器，编码方式，mybatis配置文件，spring配置文件等等。
     <web-app>
      <display-name></display-name>定义了WEB应用的名字 
      <description></description> 声明WEB应用的描述信息 
      <context-param></context-param> context-param元素声明应用范围内的初始化参数。 
      <filter></filter> 过滤器元素将一个名字与一个实现javax.servlet.Filter接口的类相关联。 
      <filter-mapping></filter-mapping> 一旦命名了一个过滤器，就要利用filter-mapping元素把它与一个或多个servlet或JSP页面相关联。 
      <listener></listener>servlet API的版本2.3增加了对事件监听程序的支持，事件监听程序在建立、修改和删除会话或servlet环境时得到通知。 Listener
      元素指出事件监听程序类。 
      <servlet></servlet> 在向servlet或JSP页面制定初始化参数或定制URL时，必须首先命名servlet或JSP页面。Servlet元素就是用来完成此项任务的。 
      <servlet-mapping></servlet-mapping> 服务器一般为servlet提供一个缺省的URL：http://host/webAppPrefix/servlet/ServletName。 但是，常常会
      更改这个URL，以便servlet可以访问初始化参数或更容易地处理相对URL。在更改缺省URL时，使用servlet-mapping元素。 
      <session-config></session-config> 如果某个会话在一定时间内未被访问，服务器可以抛弃它以节省内存。 可通过使用HttpSession的
      setMaxInactiveInterval方法明确设置单个会话对象的超时值，或者可利用session-config元素制定缺省超时值。 
      <mime-mapping></mime-mapping>如果Web应用具有想到特殊的文件，希望能保证给他们分配特定的MIME类型，则mime-mapping元素提供这种保证。 
      <welcome-file-list></welcome-file-list> 指示服务器在收到引用一个目录名而不是文件名的URL时，使用哪个文件。 
      <error-page></error-page> 在返回特定HTTP状态代码时，或者特定类型的异常被抛出时，能够制定将要显示的页面。 
      <taglib></taglib> 对标记库描述符文件（Tag Libraryu Descriptor file）指定别名。此功能使你能够更改TLD文件的位置， 而不用编辑使用这些文件的
      JSP页面。 
      <resource-env-ref></resource-env-ref>声明与资源相关的一个管理对象。 
      <resource-ref></resource-ref> 声明一个资源工厂使用的外部资源。 
      <security-constraint></security-constraint> 制定应该保护的URL。它与login-config元素联合使用 
      <login-config></login-config> 指定服务器应该怎样给试图访问受保护页面的用户授权。它与sercurity-constraint元素联合使用。 
      <security-role></security-role>给出安全角色的一个列表，这些角色将出现在servlet元素内的security-role-ref元素的role-name子元素中。分别地声
      明角色可使高级IDE处理安全信息更为容易。 
      <env-entry></env-entry>声明Web应用的环境项。
      <ejb-ref></ejb-ref>声明一个EJB的主目录的引用。 
      <ejb-local-ref></ejb-local-ref>声明一个EJB的本地主目录的应用。 
     </web-app>
   * spring.xml
   ##### spring.xml文件是给spring做相关的配置。拦截方式，视图处理器，前端拦截器等。
   * mybatis.xml
   ##### mybatis.xml文件是给mybatis做相关的配置。注解开发，扫描配置，数据源配置，数据库连接配置，sqlSessionFactory配置等等。
   * spring-mybatis.xml
   ##### spring-mybatis.xml文件是给spring和mybatis整合做相关的配置，事务管理等配置。
   * db.proerties
   ##### db.proerties文件是数据库连接信息配置文件。
   * log4j.properties
   ##### log4j.properties文件是log4j日志信息配置文件。
   
   
   
     
      
   [持续更新完善中，敬请期待...](https://github.com/zixi5534/LinuxAndJavaNote/blob/master/SpringMVCAndMyBatis.md)  
   这篇文章出自本人自己总结编写，未经授权，禁止引用！
   
