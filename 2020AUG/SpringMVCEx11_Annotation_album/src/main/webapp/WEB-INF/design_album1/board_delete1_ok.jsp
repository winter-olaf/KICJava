<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute("flag");
	String seq = (String)request.getAttribute("seq");
	String cpage = (String)request.getAttribute("cpage");
	
	System.out.println("OK에선 : " + flag);
	
	out.println("<script type='text/javascript'>");
	if (flag == 0) {
		out.println("alert('글 삭제에 성공했습니다.');");
		out.println("location.href='list.do?cpage=" + cpage + "';");	
	} else if (flag == 1){
		out.println("alert('비밀번호가 잘못되었습니다.');");
		out.println("history.back();");
	} else {
		out.println("alert('글삭제에 실패했습니다.');");
		out.println("history.back();");
	}
	out.println("</script>");
%>