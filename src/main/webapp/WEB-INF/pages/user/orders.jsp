<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>订单中心</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/user.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/squirrel.min.css"/>

    <!-- bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css"/>
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>

    <script type="text/javascript">

        function ordersDeliver(orderNum) {

            location.href = '<%=basePath%>orders/deliver/' + orderNum

            alert("发货成功，请送货给对方，并等待确认收货~")
        }

        function ordersReceipt(orderNum, orderPrice, goodsId) {
            location.href = '<%=basePath%>orders/receipt?orderNum=' + orderNum + '&orderPrice=' + orderPrice + '&goodsId=' + goodsId;

            alert("收货成功，感谢您的信任~")
        }


    </script>

</head>
<body>
<div class="pre-2" id="big_img">
    <img src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif"
         class="jcrop-preview jcrop_preview_s">
</div>
<div id="cover" style="min-height: 100vh;">
    <div class="user-home-header">
        <div class="user-home-header-center">
            <h2><a href="<%=basePath%>goods/homeGoods">皖皖闲置交易平台</a></h2>
            <h2><a href="/user/home">个人中心</a></h2>
            <a href="<%=basePath%>user/logout" class="head-exit">退出登录</a>
            <a a href="/user/home" class="head-user-info"> <img src="<%=basePath%>img/photo.jpg"><span
                    class="head-name">${cur_user.username}</span></a>
        </div>
    </div>
    <!--描述：左侧个人中心栏-->
    <div class="user-center-container">
        <div id="user_nav">
            <div class="user_info">
                <div class="head_img">
                    <img src="<%=basePath%>img/photo.jpg">
                </div>
                <div class="big_headimg">
                    <img src="">
                </div>
                <span class="name">${cur_user.username}</span>
                <hr>
                <!--   <span class="school">莆田学院</span> -->
                <a class="btn" style="width: 98%;background-color: #cde3a5;color:rgba(255, 255, 255, 1);"
                   href="<%=basePath%>user/myPurse">我的钱包：￥${myPurse.balance}</a>
                <input type="hidden" value="${myPurse.recharge}" id="recharge"/>
                <input type="hidden" value="${myPurse.withdrawals}" id="withdrawals"/>
                <span class="btn" data-toggle="modal" data-target="#myModal"
                      style="width: 98%;background-color: #cde3a5; color:rgba(255, 255, 255, 1);margin-top:0.5cm;">我的信用积分：${cur_user.power}</span>

            </div>
            <div class="home_nav">
                <ul>
                    <a href="<%=basePath%>orders/myOrders">
                        <li class="notice">
                            <div></div>
                            <span>订单中心</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/allFocus">
                        <li class="fri">
                            <div></div>
                            <span>关注列表</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>goods/publishGoods">
                        <li class="store">
                            <div></div>
                            <span>发布物品</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/allGoods">
                        <li class="second">
                            <div></div>
                            <span>我的闲置</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/basic">
                        <li class="set">
                            <div></div>
                            <span>个人设置</span>
                            <strong></strong>
                        </li>
                    </a>
                </ul>
            </div>
        </div>
        <!--

        描述：右侧内容区域
    -->
        <div id="user_content">

            <div class="share">

                <!--

                描述：订单展示
            -->
                <h1 style="text-align: center">订单中心</h1>
                <hr/>
                <div class="order_share_content">
                    <c:if test="${empty orders and empty ordersOfSell}">
                        <div class="no_share">
                            <span>没有任何内容，去逛逛其它的吧！</span>
                        </div>
                    </c:if>
                    <c:if test="${!empty orders or !empty ordersOfSell}">
                        <div class="order_story">

                            <div class="order_container">
                                <!-- Nav tabs -->
                                <ul class="nav nav-tabs" role="tablist" style="width: 100%">
                                    <!-- <li class="nav-item"><a class="nav-link active"
                                        data-toggle="tab" href="#home">全部订单</a></li> -->
                                    <li class="nav-item"><a class="nav-link active" data-toggle="tab"
                                                            href="#orders_my">已购商品</a></li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab"
                                                            href="#orders_other">售出商品</a></li>
                                </ul>

                                <!-- Tab panes -->
                                <div class="tab-content" style="width: 100%">
                                    <!-- <div id="home" class="container tab-pane active"
                                        style="width: 100%">
                                        <br>
                                        <from>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing
                                            elit, sed do eiusmod tempor incididunt ut labore et dolore
                                            magna aliqua.</p>
                                        </from>
                                    </div> -->
                                    <!-- 买家订单中心 -->
                                    <div id="orders_my" class="container tab-pane active"
                                         style="width: 100%">
                                        <br>
                                        <form class="form-horizontal" role="form">
                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                    <tr>
                                                    </tr>
                                                    <tr>
                                                        <th>订单编号</th>
                                                        <th>名称</th>
                                                        <th>价格</th>
                                                        <th>备注</th>
                                                        <th>操作</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach var="items" items="${orders}">
                                                        <tr>
                                                            <td>${items.orderNum}</td>
                                                            <td>${items.goods.name}</td>
                                                            <td>${items.goods.price}</td>
                                                            <td>${items.orderInformation}</td>
                                                            <td>
                                                                <c:if test="${items.orderState==1}"><input type="button"
                                                                                                           value="待发货"
                                                                                                           class="btn btn-info"/></c:if>
                                                                <c:if test="${items.orderState==2}"><input type="button"
                                                                                                           value="收&nbsp&nbsp&nbsp&nbsp货"
                                                                                                           onclick="ordersReceipt(${items.orderNum},${items.orderPrice},${items.goods.id})"
                                                                                                           class="btn btn-info"/></c:if>
                                                                <c:if test="${items.orderState==3}"><input type="button"
                                                                                                           value="已完成"
                                                                                                           class="btn btn-info"/></c:if>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>

                                        </form>
                                    </div>
                                    <!-- 卖家订单中心 -->
                                    <div id="orders_other" class="container tab-pane fade"
                                         style="width: 100%">
                                        <br>
                                        <form class="form-horizontal" role="form">
                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                    <tr>
                                                    </tr>
                                                    <tr class="text-center">
                                                        <th>订单编号</th>
                                                        <th>名称</th>
                                                        <th>价格</th>
                                                        <th>备注</th>
                                                        <th>操作</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach var="items" items="${ordersOfSell}">
                                                        <tr>
                                                            <td>${items.orderNum}</td>
                                                            <td>
                                                                    ${items.goods.name}
                                                            </td>
                                                            <td>${items.goods.price}</td>
                                                            <td>${items.orderInformation}</td>
                                                            <td>

                                                                <c:if test="${items.orderState==1}"><input type="button"
                                                                                                           value="发&nbsp&nbsp&nbsp&nbsp货"
                                                                                                           onclick="ordersDeliver(${items.orderNum})"
                                                                                                           class="btn btn-info"/></c:if>
                                                                <c:if test="${items.orderState==2}"><input type="button"
                                                                                                           value="待收货"
                                                                                                           class="btn btn-info"/></c:if>
                                                                <c:if test="${items.orderState==3}"><input type="button"
                                                                                                           value="已完成"
                                                                                                           class="btn btn-info"/></c:if>


                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>

                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>