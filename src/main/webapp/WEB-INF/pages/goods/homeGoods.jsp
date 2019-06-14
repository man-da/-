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
    <title>皖皖闲置交易网站</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/index.css" />
    <link rel="stylesheet" href="<%=basePath%>css/materialize-icon.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
    <link rel="stylesheet" href="<%=basePath%>css/squirrel.min.css" />
    <link rel="stylesheet" href="<%=basePath%>css/swiper.min.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/index.bundle.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/swiper.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/swiper.min.js" ></script>

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
        
        $(document).ready(function(){
            //异步验证
            $("#phone").blur(function(){
              var phone=$(this).val();
              $.ajax({
    				url:'<%=basePath%>user/register',
    				type:'POST',
    				data:{phone:phone},
    				dataType:'json',
    				success:function(json){
    					if(json.flag){
    						 $("#errorPhone").html("账号已被注册，请重新输入!");
    						 $("#register").attr("disabled",true);
    					}else{
    						 $("#errorPhone").empty();
    						 $("#register").attr("disabled",false);
    					}
    				},
    				error:function(){
    					alert('请求超时或系统出错!');
    				}
    			});
               
            });
        });
        
        
    </script>
<body ng-view="ng-view">
<!--描述：顶部-->
<div ng-controller="headerController" class="header stark-components navbar-fixed ng-scope">
    <nav class="white nav1" style="text-align: center;">
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
                    <li class="release-btn">
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
<!--描述：登录 -->

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

<div class="squirrel-container">

<header class="squirrel-index-head">
    <!--描述：右侧banner（图片）部分-->
    <div class="slider-wapper">
        <div class="content-part part-tese">
            <div class="gallery_container">
                <div class="gallery_wrap threeD_gallery_wrap" style="margin-left: -360px; margin-top: -260px;">
                    <div href="javascript:;" class="gallery_item threeD_gallery_item gallery_left_middle">
                        <img src="<%=basePath%>/img/index/index_banner_7.jpg" class="show">
                        <div class="line-t">
                        </div>
                        <div class="line-r">
                        </div>
                        <div class="line-b">
                        </div>
                        <div class="line-l">
                        </div>
                    </div>
                    <div href="javascript:;" class="gallery_item threeD_gallery_item front_side">
                        <img src="<%=basePath%>/img/index/index_banner_1.jpg" class="show">
                        <div class="line-t">
                        </div>
                        <div class="line-r">
                        </div>
                        <div class="line-b">
                        </div>
                        <div class="line-l">
                        </div>
                    </div>
                    <div href="javascript:;" class="gallery_item threeD_gallery_item gallery_right_middle">
                        <img src="<%=basePath%>/img/index/index_banner_9.jpg" class="show">
                        <div class="line-t">
                        </div>
                        <div class="line-r">
                        </div>
                        <div class="line-b">
                        </div>
                        <div class="line-l">
                        </div>
                    </div>
                    <div href="javascript:;" class="gallery_item threeD_gallery_item gallery_out">
                        <img src="<%=basePath%>/img/index/index_banner_10.jpg" class="show">
                        <div class="line-t">
                        </div>
                        <div class="line-r">
                        </div>
                        <div class="line-b">
                        </div>
                        <div class="line-l">
                        </div>
                    </div>
                </div>
                <a class="prev" href="javascript:;"></a> <a class="next" href="javascript:;"></a>
            </div>
        </div>
    </div>
    <!-- 描述：左侧导航条-->
    <nav ng-controller="sidebarController" class="sidebar  ng-scope squirrel-nav">
        <ul class="squirrel-nav-list">
            <li ng-class="{true: 'active'}[isAll]">
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
</header>
<!--描述：下侧显示部分-->
    <!--描述：下侧显示部分-->
    <div class="squirrel-index-content">
        <!--描述：最新发布-->
        <div class="index-latest">
            <div class="index-item-title index-latest-title">
                <h3>最新发布<br/>Latest Release</h3>
            </div>
            <!-- Swiper -->
            <div class="latest-swiper">
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <c:forEach var="item" items="${catelogGoods}">
                            <div class="swiper-slide latest-slide">
                                <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                                    <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                    <!-- Add Pagination -->
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-pagination"></div>
                </div>
            </div>
        </div>
        <!-- 描述：闲置数码      -->
        <div class="index-digit index-part-second">
            <div class="index-item-title">
                <h3>闲置数码<br/>IDLE DIGIT</h3>
            </div>
            <div class="index-second-content">
                <c:forEach var="item" items="${catelogGoods1}">
                    <div class="index-second-item">
                        <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="index-book index-part-second">
            <div class="index-item-title">
                <h3>图书教材<br/>Books And Teaching Materials</h3>
            </div>
            <div class="index-second-content">
                <c:forEach var="item" items="${catelogGoods4}">
                    <div class="index-second-item">
                        <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="index-beauty index-part-second">
            <div class="index-item-title">
                <h3>美妆衣物<br/>Beauty Clothes</h3>
            </div>
            <div class="beauty-swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach var="item" items="${catelogGoods5}">
                        <div class="swiper-slide beauty-slide">
                            <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                                <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                                <p class="beauty-slide-name"><c:out value="${item.goods.name}"></c:out></p>
                                <p class="beauty-slide-in">加入购物车</p>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<footer class="squirrel-footer">

</footer>
<script>
    $(function(){
        $('.content-part.part-tese').addClass('show');
        $('.gallery_container').gallery_slider({imgNum: 4});
    })
</script>
<script>
    var swiper = new Swiper('.swiper-container', {
        slidesPerView: 4,
        loop : true,
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
    });
    var swiperTwo = new Swiper('.beauty-swiper-container', {
        slidesPerView: 5,
        spaceBetween: 10
    });
</script>
</body>
</html>