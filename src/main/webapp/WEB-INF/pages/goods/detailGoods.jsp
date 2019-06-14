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
    <script type="text/javascript" src="<%=basePath%>js/jquery.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/index.bundle.js" ></script>
    <link rel="stylesheet" href="<%=basePath%>css/materialize-icon.css" />
    <link rel="stylesheet" href="<%=basePath%>css/detail.css" />
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
    
    <script type="text/javascript">
    
    function  addFocus(id) {
    	location.href = '<%=basePath%>user/addFocus/'+id
    	alert("已关注成功，查看关注列表~")
    	
    }
    
	/* 前往支付 */
    function  toPay(id) {
    	window.location.href = '<%=basePath%>goods/buyId/'+id
    }
	
    </script>
    
    
<body ng-view="ng-view">
<!--

    描述：顶部
-->
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
                    <li class="squirrel-publish-btn">
                        <a href="<%=basePath%>goods/publishGoods">我要发布</a>
                    </li>
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
<!--

    描述：登录
-->
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
<!--显示商品详情-->
<div ng-controller="detailBoxController" class="goods-detail-container">
    <h3 class="goods-detail-title">
        <a href="<%=basePath%>goods/catelog/${catelog.id}">${catelog.name}</a>
        <a class="goods">${goodsExtend.goods.name}</a>
    </h3>
    <div class="goods-detail-content">
        <div class="goods-detail-goods-img slider">
            <ul class="slides" style="height: 350px;">
                <img src="<%=basePath%>upload/${goodsExtend.images[0].imgUrl}" />
            </ul>
            <ul class="indicators">
                <li class="indicator-item"></li>
                <li class="indicator-item"></li>
                <li class="indicator-item"></li>
                <li class="indicator-item"></li>
            </ul>
        </div>
        <div class="goods-detail-goods-des">
            <h4 class="item-name">${goodsExtend.goods.name}</h4>
            <p class="item-price">￥${goodsExtend.goods.price}</p>
            <p class="item-price"><span class="title">原价：</span><span style="text-decoration:line-through;">${goodsExtend.goods.realPrice}</span></p>
            <p class="item-price"><span class="title">可讲价</span><i class="iconfont"></i><span class="title">皖西学院</span></p>
            <div class="item-publisher">
                <p class="item-publisher-p">卖家信息</p>
                <hr>
                <c:if test="${empty cur_user}">
                    <div class="item-contact">
                        <p class="not-login">
                            <span onclick="showLogin()">登录</span>
                            <em>或</em>
                            <span onclick="showSignup()" class="login">注册</span>
                            <em>后查看联系信息</em>
                        </p>
                    </div>
                </c:if>
            </div>
            <c:if test="${!empty cur_user}">
                <ul class="goods-item-contact">
                    <div class="list">
                        <i class="iconfont"></i>
                        <div class="value">${seller.username}</div>
                    </div>
                    <div class="list">
                        <i class="iconfont"></i>
                        <div class="value">${seller.phone}</div>
                    </div>
                    <div class="list">
                        <i class="iconfont"></i>
                        <c:if test="${seller.qq!=null}">
                            <div class="value">${seller.qq}</div>
                        </c:if>
                        <c:if test="${seller.qq==null}">
                            <div class="value">该同学没留下QQ</div>
                        </c:if>
                    </div>
                    <div class="list">
                        <span class="list-btn" onclick="addFocus(${goodsExtend.goods.id})">加入关注</span>
                        <c:if test="${cur_user.id==goodsExtend.goods.userId}">
                            <span class="list-btn" >本人发布</span>
                        </c:if>
                        <c:if test="${cur_user.id!=goodsExtend.goods.userId}">
                            <span class="list-btn" onclick="toPay(${goodsExtend.goods.id})">在线支付</span>
                        </c:if>
                    </div>

                </ul>
            </c:if>
            <p class="item-pub-time item-price">发布时间 ${goodsExtend.goods.startTime}</p>
        </div>
    </div>
    <div class="goods-detail-des-nav">
        <ul>
            <li class="active" id="goodsDes" onclick="selectList(this)">商品描述</li>
            <li id="goodsComment" onclick="selectList(this)">评论</li>
        </ul>
    </div>
    <div class="goods-detail-des-content">
        <div class="goods-detail-des-list" >
            <h1 class="title">商品描述</h1>
            <hr class="hr1" />
            <hr class="hr2" />
            <p class="section">描述：${goodsExtend.goods.describle}</p>
            <p class="section"></p>
            <p class="section">
                联系我的时候，请说明是在“皖皖闲置交易网站”上看见的哦~
            </p>
        </div>
        <div class="goods-detail-comment-list" style="display: none">
            <h1 class="title">评论</h1>
            <hr class="hr1" />
            <hr class="hr2" />
            <c:forEach var="item" items="${CommentExtend.comments}"  >
                <div class="comment-collection">
                    <div class="comment-item ng-scope">
                        <div class="comment-main-content">
                            <em class="name ng-binding">${item.user.username}:</em>
                            <em class="ng-hide">回复</em>
                            <em class="name ng-binding ng-hide">@:</em>
                            <em class="ng-binding">${item.content}</em>
                        </div>
                        <div class="comment-function">
                            <em class="time ng-biinding">${item.createAt}</em>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <form id="addCommentForm" class="form-horizontal" >
                <div class="comment-add row">
                    <div class="input-field col s12">
                        <i class="iconfont prefix"></i>
                        <input id="goodsId" name="goods.id" value="${goodsExtend.goods.id}" type="hidden"/>
                        <input id="commentbox" type="text" name="content" class="validate ng-pristine ng-untouched ng-valid ng-empty"/>
                        <label for="commentbox">这里写下评论</label>
                        <c:if test="${!empty cur_user}">
                            <button type="button" class="waves-effect wave-light btn comment-submit" onclick="addComments()">确认</button>
                        </c:if>
                        <c:if test="${empty cur_user}">
                            <button href="javacript:void(0);" data-toggle="tooltip"  title="您需要先登录哦！" disabled="disabled" class="waves-effect wave-light btn comment-submit">确认</button>
                        </c:if>

                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
<script type="text/javascript">
/* 评论 */
function addComments(){
	$.ajax({
		url:'<%=basePath%>goods/addComments',
		type:'POST',
		data:$('#addCommentForm').serialize(),// 序列化表单值  
		dataType:'json',
	/* 	success:function(json){
			alert(1)
			alert(json.msg)
		},
		error:function(){
			alert('请求超时或系统出错!');
		} */
	});
	alert("您已评论成功~")
	window.location.reload();
}
function selectList(them) {
    var thisId = $(them).attr('id');
    $('.goods-detail-des-nav').find('li').removeClass();
    $("#"+thisId).addClass('active');
    switch (thisId){
        case 'goodsDes':
            $('.goods-detail-des-list').show();
            $('.goods-detail-comment-list').hide();
            break;
        case 'goodsComment':
            $('.goods-detail-des-list').hide();
            $('.goods-detail-comment-list').show();
            break;
    }
}
</script>
</html>