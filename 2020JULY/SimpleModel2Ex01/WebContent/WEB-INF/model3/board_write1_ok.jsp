<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 언박싱
	int flag = (Integer)request.getAttribute("flag");

	out.println("<script type='text/javascript'>");
	if( flag == 0) {
		out.println("alert('글쓰기에 성공 했습니다.')");
		out.println("location.href='./list.do';");
	} else {
		out.println("alert('글쓰기에 실패 했습니다.')");
		out.println("history.back();");
	}	
	out.println("</script>");
%>