<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	HttpServletRequest httpRequest = (HttpServletRequest)pageContext.getRequest();
%>
request 기본 객체외 pageContext.getRequest()의 동일여부 : 
<%= request==httpRequest %>
<br>
pageContext.getOut() 메서드를 사용한 데이터 출력:
<% pageContext.getOut().println("안녕하세요!"); %>
</body>
</html>