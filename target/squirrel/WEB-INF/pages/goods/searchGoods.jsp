<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>鲁大二手工坊</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/index.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/index.bundle.js" ></script>
    <link rel="stylesheet" href="<%=basePath%>css/materialize-icon.css" />
    <link rel="stylesheet" href="<%=basePath%>css/squirrel.min.css" />
    <script>
        function showLogin() {
            if($("#signup-show").css("display")=='block'){
                $("#signup-show").css("display","none");
            }
            if($("#login-show").css("display")=='none'){
                $("#login-show").css("display","block");
            }else{
                $("#login-show").css("display","none");
            }
        }
        function showSignup() {
            if($("#login-show").css("display")=='block'){
                $("#login-show").css("display","none");
            }
            if($("#signup-show").css("display")=='none'){
                $("#signup-show").css("display","block");
            }else{
                $("#signup-show").css("display","none");
            }
        }
        function ChangeName() {
            if($("#changeName").css("display")=='none'){
                $("#changeName").css("display","block");
            }else{
                $("#changeName").css("display","none");
            }
        }
    </script>
<body ng-view="ng-view">
<!--

    描述：顶部
-->
<div ng-controller="headerController" class="header stark-components navbar-fixed ng-scope ">
    <nav class="white squirrel-list-nav" style="text-align: center;">
        <div class="squirrel-top-head">
            <ul class="squirrel-top-login">
                <c:if test="${empty cur_user}">
                    <li>
                        <a onclick="showLogin()">登录</a>
                    </li>
                    <li>
                        <a onclick="showSignup()">注册</a>
                    </li>
                </c:if>
            </ul>
            <span>
                <a href="<%=basePath%>goods/homeGoods">
                    皖皖闲置交易网站
                </a>
            </span>
            <ul class="right">
                <c:if test="${empty cur_user}">
                    <li class="release-btn">
                        <span onclick="showLogin()"
                              title="您需要先登录哦！" 	>
                            我要发布</span>
                    </li>
                </c:if>
                <c:if test="${!empty cur_user}">
                    <li class="squirrel-publish-btn">
                        <a href="<%=basePath%>goods/publishGoods">我要发布</a>
                    </li>
                    <%--<li>--%>
                        <%--<a href="<%=basePath%>user/allGoods">我发布的商品</a>--%>
                    <%--</li>--%>
                    <li>
                        <a>${cur_user.username}</a>
                    </li>
                    <li class="changemore">
                        <a class="changeMoreVertShow()">
                            <i class="iconfont"></i>
                        </a>
                        <div class="more-vert">
                            <ul class="dropdown-content">
                                <li><a href="<%=basePath%>user/home">个人中心</a></li>
                                <li><a href="<%=basePath%>user/allFocus">我的关注</a></li>
                                <li><a onclick="ChangeName()">更改用户名</a></li>
                                <li><a href="<%=basePath%>user/logout">退出登录</a></li>
                            </ul>
                        </div>
                    </li>
                </c:if>
            </ul>
            <form class="squirrel-top-search" action="<%=basePath%>goods/search">
                <div class="squirrel-input">
                    <input id="search" name="str" placeholder="搜点什么吧..." class="squirrel-top-input"/>
                    <button type="submit" class="squirrel-top-btn">搜索</button>
                </div>
            </form>
        </div>
    </nav>
</div>
<!--描述：登录-->
<div  class="login-reg-container"  id="login-show">
    <div class="mask"  onclick="showLogin()"></div>
    <div class="squirrel-login-container squirrel-login">
        <span class="exit" onclick="showLogin()">×</span>
        <form action="<%=basePath%>user/login" method="post" role="form">
            <input type="text" name="phone" autocomplete='off' id="login_phone" required="required" pattern="^1[0-9]{10}$"
                   placeholder="请输入手机号"
                   class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched form-input login-phone" />
            <input type="password" id="login_password"  name="password" required="required" autocomplete='new-password'
                   placeholder="请输入密码"
                   class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required form-input login-password" />
            <button type="submit" id="loginIn" class="form-btn">登录</button>
            <div class="go-regist">没有账号？赶快<a onclick="showSignup()" class="signup-btn">注册</a>吧！
            </div>
        </form>
    </div>
</div>
<!--描述：注册-->
<div class="login-reg-container"  id="signup-show" >
    <div class="mask" onclick="showSignup()"></div>
    <div class="squirrel-login-container squirrel-regist">
        <span class="exit" onclick="showSignup()">×</span>
        <form action="<%=basePath%>user/addUser" method="POST" role="form" id="signup_form">
            <input type="text" name="username" autocomplete='off' required="required"
                   placeholder="请输入用户名"
                   class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched form-input login-name" />
            <input type="text" name="phone" id="phone" autocomplete='off' required="required" pattern="^1[0-9]{10}$"
                   placeholder="请输入手机号"
                   class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched form-input login-phone" />
            <input type="password" name="password" autocomplete='new-password' required="required"
                   placeholder="请输入密码"
                   class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required form-input login-password" />
            <button type="submit" id="register" class="form-btn">注册</button>
            <div class="go-regist">已有账号？去<a onclick="showLogin()">登录</a></div>
        </form>
    </div>
</div>

<!--更改用户名-->
<div  class="login-reg-container"  id="changeName">
    <div class="mask"  onclick="ChangeName()"></div>
    <div class="squirrel-login-container squirrel-change-name">
        <span class="exit" onclick="ChangeName()">×</span>
        <h3>修改用户名</h3>
        <form action="<%=basePath%>user/changeName" method="post"  role="form">
            <div class="input-field col s12">
                <input type="text" name="username" required="required"
                       placeholder="请输入新的用户名"
                       class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched form-input login-name" />
                <button type="submit" class="form-btn">确认</button>
            </div>
        </form>
    </div>
</div>

<!-- 描述：左侧导航条-->
<nav ng-controller="sidebarController" class="sidebar  ng-scope squirrel-nav">
    <ul class="squirrel-nav-list">
        <li ng-class="{true: 'active'}[isAll]" >
            <a href="<%=basePath%>goods/catelog" class="index">最新发布</a>
        </li>/
        <li ng-class="{true: 'active'}[isDigital]">
            <a href="<%=basePath%>goods/catelog/1" class="digital">闲置数码</a>
        </li>/
        <li ng-class="{true: 'active'}[isRide]">
            <a href="<%=basePath%>goods/catelog/2" class="ride">校园代步</a>
        </li>/
        <li ng-class="{true: 'active'}[isCommodity]">
            <a href="<%=basePath%>goods/catelog/3" class="commodity">电器日用</a>
        </li>/
        <li ng-class="{true: 'active'}[isBook]">
            <a href="<%=basePath%>goods/catelog/4" class="book">图书教材</a>
        </li>/
        <li ng-class="{true: 'active'}[isMakeup]">
            <a href="<%=basePath%>goods/catelog/5" class="makeup">美妆衣物</a>
        </li>/
        <li ng-class="{true: 'active'}[isSport]">
            <a href="<%=basePath%>goods/catelog/6" class="sport">运动棋牌</a>
        </li>/
        <li ng-class="{true: 'active'}[isSmallthing]">
            <a href="<%=basePath%>goods/catelog/7" class="smallthing">票券小物</a>
        </li>
    </ul>
</nav>
<!--

    描述：显示部分
-->
<div class="squirrel-list-container">
    <!--
        描述：最新发布
    -->
    <div class="squirrel-list-top-nav">
        <span>首页</span>/<span  class="squirrel-list-item-name" style="color: #ffa323;">搜索产品</span>
    </div>
    <div class="squirrel-list-content">

        <div class="squirrel-list-title">
            <h2><c:if test="${empty catelog.name}"><a href="">搜索</a></c:if>
                <c:if test="${!empty catelog.name}"><a href="">${catelog.name}</a></c:if></h2>
            <h3>所有产品</h3>
        </div>
        <div class="squirrel-list-item-content">
            <c:forEach var="item" items="${goodsExtendList}">
                <div class="squirrel-list-item">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                    <div class="squirrel-list-item-img">
                        <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                    </div>
                    <p class="name"><c:out value="${item.goods.name}"></c:out></p>
                    <p class="money">￥<c:out value="${item.goods.price}"></c:out></p>
                    <p class="time">发布时间：<c:out value="${item.goods.startTime}"></c:out></p>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>