<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="ch" uri="http://www.chanhong.com" %>
<html>
<head>
    <title>电梯广告资源管理平台</title><meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
    <c:import url="/WEB-INF/decorators/csspart.jsp"/>
    <c:import url="/WEB-INF/decorators/jspart.jsp"/>
    <link href="${pageContext.request.contextPath}/css/other.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/css/htmlstyle.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">

        function userDeleteConfirm(userUuid, filterName, current) {
            jQuery("#userenable-dialog-confirm").css("visibility", "visible");
            jQuery("#userenable-dialog-confirm").dialog({
                    resizable: false,
                    height:160,
                    width:300,
                    modal: true,
                    buttons: {
                        "确认": function() {
                            jQuery("#userenable-dialog-confirm").css("visibility", "hidden");
                            jQuery(this).dialog("close");
                            window.location.href = '${pageContext.request.contextPath}/backend/userstatus.html?userUuid=' + userUuid + '&filterName=' + filterName + '&current=' + current;
                        },
                        "取消": function() {
                            jQuery("#userenable-dialog-confirm").css("visibility", "hidden");
                            jQuery(this).dialog("close");
                        }
                    }
                });
        }

        function userEnableConfirm(userUuid, filterName, current) {
            jQuery("#userdisable-dialog-confirm").css("visibility", "visible");
            jQuery("#userdisable-dialog-confirm").dialog({
                    resizable: false,
                    height:160,
                    width:300,
                    modal: true,
                    buttons: {
                        "确认": function() {
                            jQuery("#userdisable-dialog-confirm").css("visibility", "hidden");
                            jQuery(this).dialog("close");
                            window.location.href = '${pageContext.request.contextPath}/backend/userstatus.html?userUuid=' + userUuid + '&filterName=' + filterName + '&current=' + current;
                        },
                        "取消": function() {
                            jQuery("#userdisable-dialog-confirm").css("visibility", "hidden");
                            jQuery(this).dialog("close");
                        }
                    }
                });
        }
    </script>
</head>

<body>

<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/left.jsp"/>

<%--内容部分***********************************************************--%>

<div id="rightSide">

    <%--开头部分*******************************************************--%>
    <jsp:include page="/WEB-INF/decorators/head.jsp"/>

    <%--页面按钮部分*******************************************************--%>

    <div class="nNote nInformation hideit">
        <p><strong>系统用户管理: </strong>对系统用户进行添加，编辑和删除操作</p>
    </div>

    <div class="wrapper">
        <!-- Note -->


        <div class="widget">
            <div class="title">
                <img src="${pageContext.request.contextPath}/images/icons/dark/frames.png" alt="" class="titleIcon" />
                <h6>姓名:</h6>
                <form action="${pageContext.request.contextPath}/backend/usermanagement.html" method="POST" style="padding-top:4px;">
                    <input type="text" name="filterName" value="${paging.filterName}" style="width: 200px; height: 25px"/>&nbsp;
                    <input type="submit" value=" " name="find"/>
                </form>
                <a class="button greyishB" title="" href="#" style="position: absolute; top: 5px; right: 5px;"
                   onclick="window.location.href = '${pageContext.request.contextPath}/backend/userform.html'">
                    <img class="icon" alt="" src="${pageContext.request.contextPath}/images/icons/light/add.png">
                    <span>添加系统用户</span>
                </a>
            </div>
            <table cellpadding="0" cellspacing="0" width="100%" class="sTable">
                <thead>
                    <tr>
                        <td width="5%">#</td>
                        <td width="15%">姓名</td>
                        <td width="15%">电话号码（用户名）</td>
                        <td width="15%">密码</td>
                        <td width="25%">邮箱</td>
                        <td width="10%">状态</td>
                        <td >操作</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${users}" var="user" varStatus="counter">
                    <tr class="gradeX">
                        <td>${counter.count}</td>
                        <td>${user.xingMing}</td>
                        <td>${user.username}</td>
                        <td>${user.password}</td>
                        <td>${user.contactWay}</td>
                        <td style="text-align: center;">
                            <c:if test="${user.enabled}">
                                在用
                            </c:if>
                            <c:if test="${!user.enabled}">
                                停用
                            </c:if>
                        </td>
                        <td style="text-align: center;">
                            <a class="button blueB" title="" href="#"
                               onclick="window.location.href='${pageContext.request.contextPath}/backend/userform.html?userUuid=${user.uuid}&filterName=${filterName}&current=${current}'">
                                <span>编辑</span>
                            </a>
                            <c:if test="${user.username != 'chadadmin'}">
                                <c:if test="${user.enabled}">
                                    <a class="button redB" title="" href="#" onclick="return userDeleteConfirm('${user.uuid}', '${filterName}', '${current}');">
                                        <span>停用</span>
                                    </a>
                                </c:if>
                                <c:if test="${!user.enabled}">
                                    <a class="button greenB" title="" href="#" onclick="return userEnableConfirm('${user.uuid}', '${filterName}', '${current}');">
                                        <span>激活</span>
                                    </a>
                                </c:if>
                            </c:if>
                      </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="tPagination" style="text-align: center;">
                <ul style="box-shadow: 0px 0px 0px;">
                    <ch:numberpaging urlMapping="${pageContext.request.contextPath}/backend/usermanagement.html" paging="${paging}"/>
                </ul>
            </div>
        </div>
    </div>

    <%--开头部分*******************************************************--%>
    <jsp:include page="/WEB-INF/decorators/footer.jsp"/>

</div>

<div id="userenable-dialog-confirm" title="系统对话框" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        请确认你是否要停用该系统用户？
    </p>
</div>

<div id="userdisable-dialog-confirm" title="系统对话框" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        请确认你是否要激活改系统用户?
    </p>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/leftmenu.js"></script>
</body>
</html>