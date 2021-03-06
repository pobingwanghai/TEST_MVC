<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="web.mvc.bean.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="web.mvc.util.*,web.mvc.bean.*"%>
<%@ page import="web.mvc.dao.iface.*,web.mvc.dao.impl.*"%>
<%@ page import="web.mvc.business.iface.*,web.mvc.business.impl.*"%>
<%

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"
		+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'deleteUser.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
   <center>
   <p>你好！</p>
			<h3>下列是将要被删除的用户，请点击删除</h3>
			
				<table width=100% border="1" bgcolor="#22ff00">
					<tr bgcolor="#ee7733" bordercolor="blue">
						<td align="center">登陆ID</td><td align="center">密码</td>
						<td align="center">用户名</td><td align="center">性别</td>
						<td align="center">所在地</td><td align="center">电话</td>
					 	<td align="center">邮箱</td><td align="center">权限等级</td>
						<td align="center">删除</td>
					</tr>
					<%
					Connection con = DataBaseConnManager.getConnection();
					String sql = "select * from USER_INFOR_TAB";
					UserDaoIface userDao = new UserDaoImpl();
					UserBusinessIface ub = new UserBusinessImpl(userDao);
					List<UserBean> list = ub.getAllUsers(con, sql);
					session = request.getSession();
					session.setAttribute("user",list);
					List<UserBean> users = (List<UserBean>)session.getAttribute("user");
					if(users!=null)
					{
					Iterator<UserBean> it=users.iterator();
					while(it.hasNext())
					{
					    UserBean temp=it.next();
					    String uid = temp.getLogin_id();
					%>
					<form action="/TEST_MVC/deleteUser_do.mis" method=post>
						<tr bordercolor=#990066>
							<td><%=uid%></td>
							<td><%=temp.getPwd()%></td>
							<td><%=temp.getName()%></td>
							<td><%=temp.getSex()%></td>
							<td><%=temp.getLocation()%></td>
							<td><%=temp.getPhone()%></td>
							<td><%=temp.getEmail()%></td>
							<td><%=temp.getUser_right()%></td>
							
							<input type="hidden" name="login_ID" value="<%=uid%>"/>
							<td><input type=submit name="submit" value="删除"></td>
						</tr>
					</form>
					<%
					}
					}

					%>
				</table>
			
			<a href="page_jsp/adminMain.jsp">返回</a>
		</center>
  </body>
</html>