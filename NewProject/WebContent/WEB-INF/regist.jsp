<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>用户注册</title>
    <link rel="stylesheet" href="css/base.css"/>
    <link rel="stylesheet" href="css/register.css"/>
     <script>
     setTimeout(function(){document.getElementById("test").style.display="none";},2000);
      //1000是多久被隐藏，单位毫秒
     </script>
     
     <style type="text/css">
html {
overflow-x:hidden;
overflow-y:hidden;
}
</style>

</head>
<body style="width:1354px;height:620px;">
    
    <div style="width: 1360px;height:54px; background-color:RGB(247,248,252) ">
      <ul style="margin-left: 40px;top: 0px">
        <li style="display: inline-block;"><h1><a href="invalidate.do" style="color: green">AjaxCheck</a></h1></li>
        <li style="display: inline-block; margin-left: 40px;"><p style="font-size:14px;color: rgb(130,130,130)">用户注册</p></li>
        <li style="display: inline-block; margin-left: 520px;"><a href="invalidate.do" style="font-size:14px;">AjaxCheck</a></li>
        <li style="display: inline-block; margin-left: 64px;"><a href="#" style="font-size:14px; ">帮助与文档</a></li>
        <li style="display: inline-block; margin-left: 64px;"><a href="#" style="font-size:14px; ">客服电话：4008864211</a></li>
      </ul>
    </div>
    
    <div id="main">
        <div class="container">
            <div class="bgPic"><img src="img/bg.jpg" alt=""/></div>
            
            <div class="register"style="height: 300px;margin-left:-260px;">
                <div class="title">
                    <span>注册</span>
                </div>
                
                <form action="${pageContext.request.contextPath}/addUser" method="get">
                    <div class="default">
                       
                        
                        <input id="uname" name="username" data-form="uname" type="text" placeholder="用户名       汉字、字母、数字的组合"/>
                        
                    </div>
                    <div class="default">
                       
                        <input id="upwd" name="password" data-form="upwd" type="password" placeholder="密码          6-16位数字和字母的组合"/>
                       
                    </div>
                    <div class="submit">
                        
                        <span class="notice">点击"注册"代表您同意遵守
                            <a href="#">用户协议</a>
                                                                                                                      和
                            <a href="#">隐私条款</a>
                        </span>
                        <button class="s_hover" data-form="submit" >注册</button>
                        <span  id="test" style="color: red" ><small>${Msg}</small></span>
                    </div>
                    
                </form>
               
                    
                
            </div>
        </div>
        
    </div>
</body>
</html>