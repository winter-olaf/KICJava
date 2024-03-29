<%@page import="sun.nio.cs.HistoricallyNamedCharset"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>

<%@ page import="javax.sql.DataSource" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String seq = request.getParameter("seq");
	String password = request.getParameter("password");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	// 데이터 입력 성공, 실패 구분
	int flag = 2;
	
	try{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource dataSource = (DataSource)envCtx.lookup("jdbc/mariadb1");
		
		conn = dataSource.getConnection();
		
		String sql = String.format("delete from board1 where seq= ? and password=?");
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, seq);
		pstmt.setString(2, password);

		int result = pstmt.executeUpdate();
		if(result == 0) {
			// 비밀 번호를 잘못 기입한 경우
			flag = 1;
		} else if( result == 1) {
			// 정상
			flag = 0;
		}
		
	} catch( NamingException e) {
		System.out.println( "[에러] : " + e.getMessage() );
	} catch( SQLException e) {
		System.out.println( "[에러] : " + e.getMessage() );		
	} finally{
		if( pstmt != null ) pstmt.close();
		if( conn != null ) conn.close();
	}
	out.println("<script type='text/javascript'>");
	if( flag == 0) {
		out.println("alert('글삭제에 성공 했습니다.')");
		out.println("location.href='./board_list1.jsp';");
	} else if( flag == 1 ) {
		out.println("alert('비밀번호가 잘못되었습니다.')");
		out.println("history.back();");
	} else {
		out.println("alert('글삭제에 실패했습니다.')");
		out.println("history.back();");
	}	
	out.println("</script>");
%>