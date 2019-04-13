<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<head lang="en">
    <meta charset="UTF-8">
    <title>用户登录</title>
    <link rel="stylesheet" href="css/base.css"/>
    <link rel="stylesheet" href="css/login.css"/>

<style type="text/css">
html {
overflow-x:hidden;
overflow-y:hidden;
}
</style>
<script>

setTimeout(function(){document.getElementById("test").style.display="none";},2000);
//1000是多久被隐藏，单位毫秒
</script>
</head>
<body style="width:1360px;height:620px;">
<div style="width: 1360px;height:54px; background-color:RGB(247,248,252) ">
      <ul style="margin-left: 40px;top: 0px">
        <li style="display: inline-block;"><h1><a href="invalidate.do" style="color: green">AjaxCheck</a></h1></li>
        <li style="display: inline-block; margin-left: 40px;"><p style="font-size:14px;color: rgb(130,130,130)">用户登陆</p></li>
        <li style="display: inline-block; margin-left: 520px;"><a href="invalidate.do" style="font-size:14px; ">AjaxCheck</a></li>
        <li style="display: inline-block; margin-left: 64px;"><a href="#" style="font-size:14px; ">帮助与文档</a></li>
        <li style="display: inline-block; margin-left: 64px;"><a href="#" style="font-size:14px;">客服电话：4008864211</a></li>
      </ul>
    </div>
<div id="main">
    
    <div class="container">
        <div class="bgPic"><img src="img/bg.jpg" alt=""/></div>
        <div class="register" style="height: 320px;margin-left:-260px;" >
            <div class="title">
                <span>登录</span>
            </div>
            
            <form action="${pageContext.request.contextPath}/toLogin" method="post"> 
                <div class="default">
                    <input id="uname" name="username" data-form="uname" type="text" placeholder="请输入用户名" value=""/>
                </div>
                <div class="default">
                    <input id="upwd" name="password"   data-form="upwd" type="password" placeholder="请输入账号密码 " />
                </div>
                <div class="submit">
               
                
                   <font size="2px">没有账号？</font>
                   <a href="javascript:;" onclick="location.href='regist.do';" style="color: red; font-size: 14px">立即注册</a>  
                        <span class="notice">
                          <a href="javascript:;" onclick="location.href='findpassword.do';">忘记密码</a>
                        </span>
                    <button class="s_hover" data-form="submit">登录</button>
                     <span id="test" style="color: red"><small>${Msg}</small></span>
                </div>
            </form>
                
            
        </div>
    </div>
</div>
</body>
</html>